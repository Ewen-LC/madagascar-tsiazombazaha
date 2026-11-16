"""Estimation indicative de la surface forestière 2026 dans le périmètre du VOI (Sentinel-2, 6 mai 2026).

Lancement : python3 estimation-foret-2026-sentinel2.py
Méthode : analyse discriminante linéaire (numpy) à deux classes sur les pixels 10 m (B02, B03, B04, B08, NDVI,
écart-type 3x3 du proche infrarouge). Apprentissage : forêt = cœur (érodé de 30 m) de la forêt 2025 de Vieilledent et al.
(2018, prolongée par Hansen et al., 2013) ; non-forêt = pixels à plus de 90 m de toute forêt 2025, non forestiers en 1990 et 2017.
Les scènes sont sans nuages sur la fenêtre (SCL). Le score dépend du seuil choisi : résultats donnés pour plusieurs seuils.
Sorties : donnees-traitees/tables/foret-2026-sentinel2-seuils.csv ; cartes/controle-sentinel2-2026.png
"""
import csv
import os
import numpy as np
from osgeo import gdal, ogr, osr
from PIL import Image

gdal.UseExceptions()
BASE = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
R = os.path.join(BASE, "donnees-brutes", "sources-externes")
S2 = os.path.join(R, "copernicus-2026-05-06", "t38kqa-20260506t070241-")
BOX = (801500, 7570500, 809900, 7579500)   # emprise des extraits Sentinel-2 fournis (copernicus-2026-05-06/*-extrait.tif)


def charger(f, res=10, alg="near"):
    d = gdal.Warp("", f, format="MEM", outputBounds=BOX, xRes=res, yRes=res, dstSRS="EPSG:32738", resampleAlg=alg)
    return d


bandes = {b: charger(S2 + b.lower() + "-10m-extrait.tif") for b in ("B02", "B03", "B04", "B08")}
ref = bandes["B04"]
gt = ref.GetGeoTransform()
B2, B3, B4, B8 = (bandes[b].ReadAsArray().astype(float) for b in ("B02", "B03", "B04", "B08"))
scl = charger(S2 + "scl-20m-extrait.tif").ReadAsArray()
f17 = charger(os.path.join(R, "vieilledent-2018", "for2017-tsiazombazaha.tif")).ReadAsArray() == 1
f90 = charger(os.path.join(R, "vieilledent-2018", "for1990-tsiazombazaha.tif")).ReadAsArray() == 1
ly = charger(os.path.join(R, "hansen-gfc2025", "lossyear-tsiazombazaha.tif")).ReadAsArray()
f25 = f17 & ~((ly >= 18) & (ly <= 25))
valid = np.isin(scl, [4, 5])


def voisins(a, k, fn):
    p = k // 2
    pa = np.pad(a, p, mode="edge")
    return fn(np.stack([pa[i:i + a.shape[0], j:j + a.shape[1]] for i in range(k) for j in range(k)]), axis=0)


ndvi = (B8 - B4) / (B8 + B4 + 1e-9)
X = np.stack([B2, B3, B4, B8, ndvi, voisins(B8, 3, np.std)], -1)


def dilater(m, n):
    for _ in range(n):
        p = np.pad(m, 1)
        m = m | p[:-2, 1:-1] | p[2:, 1:-1] | p[1:-1, :-2] | p[1:-1, 2:] | p[:-2, :-2] | p[2:, 2:] | p[:-2, 2:] | p[2:, :-2]
    return m


def eroder(m, n):
    for _ in range(n):
        p = np.pad(m, 1, constant_values=True)
        m = m & p[:-2, 1:-1] & p[2:, 1:-1] & p[1:-1, :-2] & p[1:-1, 2:]
    return m


lab = np.full(f25.shape, -1)
lab[eroder(f25, 3) & valid] = 1
lab[~dilater(f25, 9) & ~f90 & ~f17 & valid] = 0
rng = np.random.default_rng(1)
idx = np.argwhere(lab >= 0)
rng.shuffle(idx)
tr, te = idx[: len(idx) // 2], idx[len(idx) // 2:]
x, y = X[tr[:, 0], tr[:, 1]], lab[tr[:, 0], tr[:, 1]]
m1, m0 = x[y == 1].mean(0), x[y == 0].mean(0)
w = np.linalg.solve((np.cov(x[y == 1].T) + np.cov(x[y == 0].T)) / 2, m1 - m0)
score = X @ w - 0.5 * w @ (m1 + m0)
pred = score[te[:, 0], te[:, 1]] > 0
vrai = lab[te[:, 0], te[:, 1]] == 1
print(f"Test (pixels non utilisés à l'apprentissage) : sensibilité {pred[vrai].mean():.2f}, spécificité {(~pred[~vrai]).mean():.2f}")

# périmètre du VOI
t = osr.SpatialReference()
t.ImportFromEPSG(32738)
t.SetAxisMappingStrategy(osr.OAMS_TRADITIONAL_GIS_ORDER)
src = ogr.Open(os.path.join(R, "..", "inter-aide", "limites-transfert-gestion.gpkg"))
lyr = src.GetLayer(0)
s = lyr.GetSpatialRef()
s.SetAxisMappingStrategy(osr.OAMS_TRADITIONAL_GIS_ORDER)
conv = osr.CoordinateTransformation(s, t)
mem = gdal.GetDriverByName("MEM").Create("", 0, 0, 0, gdal.GDT_Unknown)
ml = mem.CreateLayer("m", t, ogr.wkbMultiPolygon)
for f in lyr:
    if str(f["layer"]).startswith("Délimitation"):
        g = f.GetGeometryRef().Clone()
        g.Transform(conv)
        nf = ogr.Feature(ml.GetLayerDefn())
        nf.SetGeometry(g)
        ml.CreateFeature(nf)
rr = gdal.GetDriverByName("MEM").Create("", ref.RasterXSize, ref.RasterYSize, 1, gdal.GDT_Byte)
rr.SetGeoTransform(gt)
rr.SetProjection(ref.GetProjection())
gdal.RasterizeLayer(rr, [1], ml, burn_values=[1])
pe = rr.GetRasterBand(1).ReadAsArray() == 1

pl = list(csv.DictReader(open(os.path.join(BASE, "donnees-traitees", "tables", "placettes-coordonnees.csv"))))
pts = [(int((float(q["y_utm38s"]) - gt[3]) / gt[5]), int((float(q["x_utm38s"]) - gt[0]) / gt[1])) for q in pl]
print(f"Placettes dans un pixel forestier Vieilledent 2025 (10 m) : {sum(f25[i, j] for i, j in pts)}/28")
out = os.path.join(BASE, "donnees-traitees", "tables", "foret-2026-sentinel2-seuils.csv")
with open(out, "w", newline="", encoding="utf-8") as fh:
    wr = csv.writer(fh)
    wr.writerow(["seuil_score", "foret_perimetre_ha", "dont_hors_foret_Vieilledent_ha", "placettes_dans_foret_3x3_sur_28"])
    for th in (0, 1, 2, 3):
        pr = (score > th) & valid
        hit = sum(pr[max(i - 1, 0):i + 2, max(j - 1, 0):j + 2].any() for i, j in pts)
        wr.writerow([th, round((pr & pe).sum() * 0.01), round((pr & pe & ~f25).sum() * 0.01), hit])
        print(th, round((pr & pe).sum() * 0.01), round((pr & pe & ~f25).sum() * 0.01), hit)

# image de contrôle
c0, c1, r0, r1 = int((803000 - BOX[0]) / 10), int((807300 - BOX[0]) / 10), int((BOX[3] - 7577600) / 10), int((BOX[3] - 7572400) / 10)


def etire(a):
    lo, hi = np.percentile(a, [2, 98])
    return np.clip((a - lo) / (hi - lo), 0, 1)


rgb = (np.stack([etire(B4), etire(B3), etire(B2)], -1)[r0:r1, c0:c1] * 255).astype(np.uint8)


def contour(m):
    m = m[r0:r1, c0:c1]
    p = np.pad(m, 1)
    return m & ~(p[:-2, 1:-1] & p[2:, 1:-1] & p[1:-1, :-2] & p[1:-1, 2:])


a = rgb.copy()
a[contour(f25)] = (255, 255, 0)
b = rgb.copy()
b[contour((score > 2) & valid)] = (255, 0, 0)
im = Image.fromarray(np.hstack([a, b]))
im.resize((im.width * 2, im.height * 2), Image.NEAREST).save(os.path.join(BASE, "cartes", "controle-sentinel2-2026.png"))

# --- Contour du massif dans le périmètre : classification (seuil 1), nettoyée et découpée -----------------------
SEUIL = 1
SEUIL_TAILLE_PX = 50   # 0,5 ha : îlots forestiers et trous plus petits supprimés (filtre de tamisage, 8 voisins)
brut = ((score > SEUIL) & valid).astype(np.uint8)
m_src = gdal.GetDriverByName("MEM").Create("", ref.RasterXSize, ref.RasterYSize, 1, gdal.GDT_Byte)
m_src.SetGeoTransform(gt)
m_src.SetProjection(ref.GetProjection())
m_src.GetRasterBand(1).WriteArray(brut)
m_dst = gdal.GetDriverByName("MEM").Create("", ref.RasterXSize, ref.RasterYSize, 1, gdal.GDT_Byte)
m_dst.SetGeoTransform(gt)
m_dst.SetProjection(ref.GetProjection())
gdal.SieveFilter(m_src.GetRasterBand(1), None, m_dst.GetRasterBand(1), SEUIL_TAILLE_PX, 8)
propre = m_dst.GetRasterBand(1).ReadAsArray() == 1
print(f"Seuil {SEUIL} nettoyé : {round((propre & pe).sum() * 0.01)} ha dans le périmètre (brut : {round((brut.astype(bool) & pe).sum() * 0.01)} ha)")

poly_ds = gdal.GetDriverByName("MEM").Create("", 0, 0, 0, gdal.GDT_Unknown)
poly = poly_ds.CreateLayer("p", t, ogr.wkbPolygon)
poly.CreateField(ogr.FieldDefn("v", ogr.OFTInteger))
gdal.Polygonize(m_dst.GetRasterBand(1), m_dst.GetRasterBand(1), poly, 0)
limite = None
for f in ml:
    limite = f.GetGeometryRef().Clone() if limite is None else limite.Union(f.GetGeometryRef())
ml.ResetReading()
GPKG = os.path.join(BASE, "donnees-traitees", "couches", "foret-2026-sentinel2-perimetre.gpkg")
if os.path.exists(GPKG):
    os.remove(GPKG)
sortie = ogr.GetDriverByName("GPKG").CreateDataSource(GPKG)
lo = sortie.CreateLayer("foret_2026", t, ogr.wkbMultiPolygon)
lo.CreateField(ogr.FieldDefn("surface_ha", ogr.OFTReal))
tout = ogr.Geometry(ogr.wkbMultiPolygon)
for f in poly:
    if f["v"] == 1:
        g = f.GetGeometryRef().Intersection(limite)
        if g is not None and not g.IsEmpty():
            for k in range(g.GetGeometryCount()) if g.GetGeometryType() in (ogr.wkbMultiPolygon, ogr.wkbGeometryCollection) else [None]:
                part = g if k is None else g.GetGeometryRef(k)
                if part.GetGeometryType() == ogr.wkbPolygon:
                    tout.AddGeometry(part)
unie = tout.UnionCascaded()
if unie.GetGeometryType() == ogr.wkbPolygon:
    m = ogr.Geometry(ogr.wkbMultiPolygon)
    m.AddGeometry(unie)
    unie = m
nf = ogr.Feature(lo.GetLayerDefn())
nf.SetField("surface_ha", unie.Area() / 10000)
nf.SetGeometry(unie)
lo.CreateFeature(nf)
print(f"Couche {os.path.basename(GPKG)} : {unie.Area() / 10000:.0f} ha")
sortie = None
