"""Carte 4 : évolution du couvert forestier de Tsiazombazaha de 1973 à 2017, niveaux de gris.

Lancement :
  QT_QPA_PLATFORM=offscreen PYTHONPATH=/usr/share/qgis/python python3 carte4-couvert-forestier.py
Données : cartes de couvert forestier de Vieilledent et al. (2018), mise à jour 2017 (Cirad Dataverse,
doi:10.18167/DVN1/AUBRRC), 30 m, UTM 38S ; extraits de la zone d'étude dans
donnees-brutes/sources-externes/vieilledent-2018/for{1973,1990,2000,2010,2017}-tsiazombazaha.tif
(valeur 1 = forêt ; 1973 : 1 et 5 = forêt, 255 = hors forêt).
Périodes : perte 1973-1990, 1990-2000, 2000-2010, 2010-2017, 2017-2025 (Hansen et al., 2013, GFC-2025-v1.13) ; forêt en 2025.
Sorties : cartes/carte4-couvert-forestier.png (300 dpi),
          cartes/carte4-couvert-forestier.{svg,pdf},
          projets-qgis/carte4-couvert-forestier.qgz,
          donnees-traitees/couches/couvert-forestier-periodes.gpkg
Gabarit : 170 mm de large = largeur du texte du rapport.
"""
import os
import subprocess

import numpy as np
from osgeo import gdal, ogr, osr

from qgis.core import (
    Qgis, QgsApplication, QgsCoordinateReferenceSystem, QgsCoordinateTransform, QgsFeature,
    QgsFillSymbol, QgsGeometry, QgsLayoutExporter, QgsLayoutItemLabel, QgsLayoutItemMap,
    QgsLayoutItemMapGrid, QgsLayoutItemPicture, QgsLayoutItemScaleBar, QgsLayoutItemShape,
    QgsLayoutMeasurement, QgsLayoutPoint, QgsLayoutSize, QgsLineSymbol, QgsPalLayerSettings,
    QgsPrintLayout, QgsProject, QgsRectangle, QgsLinePatternFillSymbolLayer,
    QgsSimpleFillSymbolLayer, QgsSimpleLineSymbolLayer, QgsSingleSymbolRenderer,
    QgsTextBufferSettings, QgsTextFormat, QgsVectorLayer, QgsVectorLayerSimpleLabeling,
)
from qgis.PyQt.QtCore import Qt
from qgis.PyQt.QtGui import QColor, QFont

gdal.UseExceptions()
BASE = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
EXT = os.path.join(BASE, "donnees-brutes", "sources-externes", "limites-admin")
RASTERS = os.path.join(BASE, "donnees-brutes", "sources-externes", "vieilledent-2018")
VECTEUR = os.path.join(BASE, "donnees-traitees", "couches")
GPKG = os.path.join(VECTEUR, "couvert-forestier-periodes.gpkg")
OUT_PNG = os.path.join(BASE, "cartes", "carte4-couvert-forestier.png")
OUT_SVG = os.path.join(BASE, "cartes", "carte4-couvert-forestier.svg")
OUT_PDF = os.path.join(BASE, "cartes", "carte4-couvert-forestier.pdf")
OUT_QGZ = os.path.join(BASE, "projets-qgis", "carte4-couvert-forestier.qgz")

# --- Périodes : polygones issus des rasters ---------------------------------
def foret(annee):
    ds = gdal.Open(os.path.join(RASTERS, f"for{annee}-tsiazombazaha.tif"))
    a = ds.GetRasterBand(1).ReadAsArray()
    return ds, a == 1


ds0, f73 = foret(1973)
# 1973 : valeur 5 = pixels non classés (nuages sur l'image Landsat MSS, 3,3 Mha à l'échelle de Madagascar ;
# Vieilledent et al., 2018, §2.1), laissés tels quels ; la forêt de 1973 est donc sous-estimée dans ces zones.
_r73 = gdal.Open(os.path.join(RASTERS, "for1973-tsiazombazaha.tif"))
nc73 = _r73.GetRasterBand(1).ReadAsArray() == 5
f90, f00, f10, f17 = (foret(a)[1] for a in (1990, 2000, 2010, 2017))
# 2018-2025 : même principe que Vieilledent et al. (2018) pour 2001-2014 : forêt de 2017 moins la perte annuelle de
# couvert de Hansen et al. (2013), version GFC-2025-v1.13 (années 18 à 25), appliquée seulement dans la forêt de 2017.
_ly = gdal.Open(os.path.join(BASE, "donnees-brutes", "sources-externes", "hansen-gfc2025", "lossyear-tsiazombazaha.tif"))
lossyear = _ly.GetRasterBand(1).ReadAsArray()
f25 = f17 & ~((lossyear >= 18) & (lossyear <= 25))
PERIODES = [
    ("Non classé en 1973", nc73),
    ("Forêt en 2025", f25),
    ("Perte 2017-2025", f17 & ~f25),
    ("Perte 2010-2017", f10 & ~f17),
    ("Perte 2000-2010", f00 & ~f10),
    ("Perte 1990-2000", f90 & ~f00),
    ("Perte 1973-1990", f73 & ~f90),
]
srs = osr.SpatialReference()
srs.ImportFromEPSG(32738)
srs.SetAxisMappingStrategy(osr.OAMS_TRADITIONAL_GIS_ORDER)

# Périmètre transféré au VOI Maharitra (UTM 38S), rastérisé sur la grille des cartes de couvert
IA = os.path.join(BASE, "donnees-brutes", "inter-aide", "limites-transfert-gestion.gpkg")
src = ogr.Open(IA)
src_lyr = src.GetLayer(0)
wgs = osr.SpatialReference()
wgs.ImportFromEPSG(4326)
wgs.SetAxisMappingStrategy(osr.OAMS_TRADITIONAL_GIS_ORDER)
conv = osr.CoordinateTransformation(wgs, srs)
mem_ds = gdal.GetDriverByName("MEM").Create("", 0, 0, 0, gdal.GDT_Unknown)
perim_lyr = mem_ds.CreateLayer("perim", srs, ogr.wkbMultiPolygon)
for ft in src_lyr:
    if str(ft.GetField("layer")).startswith("Délimitation"):
        g = ft.GetGeometryRef().Clone()
        g.Transform(conv)
        nf = ogr.Feature(perim_lyr.GetLayerDefn())
        nf.SetGeometry(g)
        perim_lyr.CreateFeature(nf)
mem_p = gdal.GetDriverByName("MEM").Create("", ds0.RasterXSize, ds0.RasterYSize, 1, gdal.GDT_Byte)
mem_p.SetGeoTransform(ds0.GetGeoTransform())
mem_p.SetProjection(ds0.GetProjection())
gdal.RasterizeLayer(mem_p, [1], perim_lyr, burn_values=[1])
dans_voi = mem_p.GetRasterBand(1).ReadAsArray() == 1
PX_HA = abs(ds0.GetGeoTransform()[1] * ds0.GetGeoTransform()[5]) / 10000

import csv
FKT = os.path.join(BASE, "donnees-brutes", "sources-externes", "limites-admin", "limites-admin-fokontany.gpkg")
FOKONTANY_VOI = [
    ("Mizilo Gara", "Mizilo Gara"), ("Ambahatrazo", "Mahatsara"), ("Ambahatrazo", "Ambahatrazo"),
    ("Ambahatrazo", "Vohitrandriana"), ("Ambahatrazo", "Ambalavolo"), ("Ambila", "Andriana"),
    ("Vohimasina Sud", "Tsararano"),
]
fkt_src = ogr.Open(FKT)
fkt_lyr = fkt_src.GetLayer(0)
fkt_conv = osr.CoordinateTransformation(fkt_lyr.GetSpatialRef(), srs)
fkt_lyr.GetSpatialRef().SetAxisMappingStrategy(osr.OAMS_TRADITIONAL_GIS_ORDER)


def rasteriser(geoms):
    m_ds = gdal.GetDriverByName("MEM").Create("", 0, 0, 0, gdal.GDT_Unknown)
    lyr_m = m_ds.CreateLayer("m", srs, ogr.wkbMultiPolygon)
    for g in geoms:
        nf = ogr.Feature(lyr_m.GetLayerDefn())
        nf.SetGeometry(g)
        lyr_m.CreateFeature(nf)
    r = gdal.GetDriverByName("MEM").Create("", ds0.RasterXSize, ds0.RasterYSize, 1, gdal.GDT_Byte)
    r.SetGeoTransform(ds0.GetGeoTransform())
    r.SetProjection(ds0.GetProjection())
    gdal.RasterizeLayer(r, [1], lyr_m, burn_values=[1])
    return r.GetRasterBand(1).ReadAsArray() == 1


masques_fkt = {}
for f in fkt_lyr:
    cle = (f["ADM3_EN"], f["ADM4_EN"])
    if cle in FOKONTANY_VOI:
        g = f.GetGeometryRef().Clone()
        g.Transform(fkt_conv)
        masques_fkt[cle] = rasteriser([g])
assert len(masques_fkt) == len(FOKONTANY_VOI)
CSV_FKT = os.path.join(BASE, "donnees-traitees", "tables", "couvert-forestier-fokontany.csv")
dates = [("1973", f73), ("1990", f90), ("2000", f00), ("2010", f10), ("2017", f17), ("2025", f25)]
with open(CSV_FKT, "w", newline="", encoding="utf-8") as fh:
    w = csv.writer(fh)
    w.writerow(["commune", "fokontany", "surface_ha", "non_classe_1973_ha"] + [f"foret_{a}_ha" for a, _ in dates])
    total = np.zeros_like(f73)
    for (com, fk), m in masques_fkt.items():
        total |= m
        w.writerow([com, fk, round(m.sum() * PX_HA), round((m & nc73).sum() * PX_HA)] + [round((m & d).sum() * PX_HA) for _, d in dates])
    w.writerow(["", "Ensemble des 7 fokontany", round(total.sum() * PX_HA), round((total & nc73).sum() * PX_HA)] + [round((total & d).sum() * PX_HA) for _, d in dates])
    w.writerow(["", "dont périmètre du VOI", round(dans_voi.sum() * PX_HA), round((dans_voi & nc73).sum() * PX_HA)] + [round((dans_voi & d).sum() * PX_HA) for _, d in dates])
    hors = total & ~dans_voi
    w.writerow(["", "dont hors périmètre du VOI", round(hors.sum() * PX_HA), round((hors & nc73).sum() * PX_HA)] + [round((hors & d).sum() * PX_HA) for _, d in dates])
# Regroupement par commune (fokontany concernés seulement ; sommes sur les surfaces non arrondies)
CSV_COM = os.path.join(BASE, "donnees-traitees", "tables", "couvert-forestier-communes.csv")
par_commune = {}
for (com, fk), m in masques_fkt.items():
    par_commune[com] = par_commune.get(com, np.zeros_like(f73)) | m
with open(CSV_COM, "w", newline="", encoding="utf-8") as fh:
    w = csv.writer(fh)
    w.writerow(["commune", "fokontany_concernes", "surface_ha", "non_classe_1973_ha"] + [f"foret_{a}_ha" for a, _ in dates])
    for com, m in par_commune.items():
        noms = ", ".join(fk for (c, fk) in masques_fkt if c == com)
        w.writerow([com, noms, round(m.sum() * PX_HA), round((m & nc73).sum() * PX_HA)] + [round((m & d).sum() * PX_HA) for _, d in dates])
print(open(CSV_FKT, encoding="utf-8").read())
print(open(CSV_COM, encoding="utf-8").read())
LIGNES = [
    ("Forêt en 1973", f73), ("Forêt en 1990", f90), ("Forêt en 2000", f00),
    ("Forêt en 2010", f10), ("Forêt en 2017", f17), ("Forêt en 2025", f25),
    ("Perte 1973-1990", f73 & ~f90), ("Perte 1990-2000", f90 & ~f00),
    ("Perte 2000-2010", f00 & ~f10), ("Perte 2010-2017", f10 & ~f17), ("Perte 2017-2025", f17 & ~f25),
]
CSV_SURF = os.path.join(BASE, "donnees-traitees", "tables", "couvert-forestier-surfaces.csv")
with open(CSV_SURF, "w", newline="", encoding="utf-8") as fh:
    w = csv.writer(fh)
    w.writerow(["indicateur", "fenetre_cartographiee_ha", "perimetre_VOI_ha"])
    for nom, m in LIGNES:
        w.writerow([nom, round(m.sum() * PX_HA), round((m & dans_voi).sum() * PX_HA)])
        print(f"{nom} : fenêtre {m.sum() * PX_HA:.0f} ha ; périmètre VOI {(m & dans_voi).sum() * PX_HA:.0f} ha")
print(f"Périmètre VOI : {dans_voi.sum() * PX_HA:.0f} ha (rastérisé à 30 m)")
if os.path.exists(GPKG):
    os.remove(GPKG)
out = ogr.GetDriverByName("GPKG").CreateDataSource(GPKG)
lyr = out.CreateLayer("couvert_periodes", srs, ogr.wkbMultiPolygon)
lyr.CreateField(ogr.FieldDefn("periode", ogr.OFTString))
lyr.CreateField(ogr.FieldDefn("surface_ha", ogr.OFTReal))
pixel_ha = abs(ds0.GetGeoTransform()[1] * ds0.GetGeoTransform()[5]) / 10000
for nom, masque in PERIODES:
    mem = gdal.GetDriverByName("MEM").Create("", ds0.RasterXSize, ds0.RasterYSize, 1, gdal.GDT_Byte)
    mem.SetGeoTransform(ds0.GetGeoTransform())
    mem.SetProjection(ds0.GetProjection())
    mem.GetRasterBand(1).WriteArray(masque.astype(np.uint8))
    tmp_ds = gdal.GetDriverByName("MEM").Create("", 0, 0, 0, gdal.GDT_Unknown)
    tmp = tmp_ds.CreateLayer("p", srs, ogr.wkbPolygon)
    tmp.CreateField(ogr.FieldDefn("v", ogr.OFTInteger))
    gdal.Polygonize(mem.GetRasterBand(1), mem.GetRasterBand(1), tmp, 0)
    multi = ogr.Geometry(ogr.wkbMultiPolygon)
    for f in tmp:
        if f["v"] == 1:
            multi.AddGeometry(f.GetGeometryRef())
    ft = ogr.Feature(lyr.GetLayerDefn())
    ft.SetField("periode", nom)
    ft.SetField("surface_ha", float(masque.sum() * pixel_ha))
    ft.SetGeometry(multi)
    lyr.CreateFeature(ft)
    print(f"{nom} : {masque.sum() * pixel_ha:.0f} ha (fenêtre complète)")
out = None

app = QgsApplication([], False)
app.initQgis()
UTM = QgsCoordinateReferenceSystem("EPSG:32738")
WGS = QgsCoordinateReferenceSystem("EPSG:4326")
project = QgsProject()
project.setCrs(UTM)

NOIR = "0,0,0,255"
BLANC = "255,255,255,255"
TRANSPARENT = "255,255,255,0"
FONT = "Source Serif 4"
TAILLE = 12
TAILLE_GRATICULE = 9


def charger(chemin, nom):
    couche = QgsVectorLayer(chemin, nom, "ogr")
    if not couche.isValid():
        raise RuntimeError(f"Couche invalide : {chemin}")
    couche.setLabeling(None)
    couche.setLabelsEnabled(False)
    project.addMapLayer(couche, False)
    return couche


def memoire(geom, nom, champs="nom:string"):
    c = QgsVectorLayer(f"{geom}?crs=EPSG:32738&field={champs}", nom, "memory")
    project.addMapLayer(c, False)
    return c


def fill(couleur, contour=NOIR, largeur="0.2", style_contour="solid"):
    return QgsFillSymbol.createSimple({
        "color": couleur, "style": "solid", "outline_color": contour,
        "outline_width": largeur, "outline_style": style_contour,
    })


def quadrillage(ecart=0.9):
    """Double hachure croisée noire, fond transparent : la forêt reste visible dessous."""
    couches = [QgsSimpleFillSymbolLayer(QColor(255, 255, 255, 0))]
    couches[0].setStrokeColor(QColor(0, 0, 0))
    couches[0].setStrokeWidth(0.4)
    for angle in (45, 135):
        m = QgsLinePatternFillSymbolLayer()
        m.setLineAngle(angle)
        m.setDistance(ecart)
        m.setDistanceUnit(Qgis.RenderUnit.Millimeters)
        m.setLineWidth(0.15)
        m.setColor(QColor(0, 0, 0))
        couches.append(m)
    return QgsFillSymbol(couches)


def fill_tirets(largeur=0.8):
    """Contour en tirets nets (couche « contour : ligne simple », motif en multiples de la largeur)."""
    ligne = QgsSimpleLineSymbolLayer(QColor(0, 0, 0), largeur)
    ligne.setUseCustomDashPattern(True)
    ligne.setCustomDashVector([3.0, 2.5])
    return QgsFillSymbol([ligne])


def hachures(angle=45, ecart=1.3):
    fond = QgsSimpleFillSymbolLayer(QColor(255, 255, 255))
    fond.setStrokeStyle(Qt.PenStyle.NoPen)
    motif = QgsLinePatternFillSymbolLayer()
    motif.setLineAngle(angle)
    motif.setDistance(ecart)
    motif.setDistanceUnit(Qgis.RenderUnit.Millimeters)
    motif.setLineWidth(0.2)
    motif.setColor(QColor(0, 0, 0))
    return QgsFillSymbol([fond, motif])


def texte(taille, gras=False, italique=False, halo=True):
    f = QgsTextFormat()
    f.setFont(QFont(FONT, 8, QFont.Weight.Bold if gras else QFont.Weight.Normal, italique))
    f.setSize(taille)
    f.setColor(QColor(0, 0, 0))
    if halo:
        b = QgsTextBufferSettings()
        b.setEnabled(True)
        b.setSize(0.6)
        b.setColor(QColor(255, 255, 255))
        f.setBuffer(b)
    return f


def etiqueter(couche, champ, fmt, placement=QgsPalLayerSettings.Placement.Horizontal, distance=0):
    s = QgsPalLayerSettings()
    s.fieldName = champ
    s.setFormat(fmt)
    s.placement = placement
    s.dist = distance
    couche.setLabeling(QgsVectorLayerSimpleLabeling(s))
    couche.setLabelsEnabled(True)



def fill_tirets(largeur=0.8):
    ligne = QgsSimpleLineSymbolLayer(QColor(0, 0, 0), largeur)
    ligne.setUseCustomDashPattern(True)
    ligne.setCustomDashVector([3.0, 2.5])
    return QgsFillSymbol([ligne])


def motif(angles, ecart, fond="255,255,255,255", largeur_motif=0.2, contour="0,0,0,255", largeur_contour="0.2"):
    c = QgsSimpleFillSymbolLayer(QColor(*[int(v) for v in fond.split(",")]))
    c.setStrokeColor(QColor(*[int(v) for v in contour.split(",")]))
    c.setStrokeWidth(float(largeur_contour))
    couches = [c]
    for angle in angles:
        m = QgsLinePatternFillSymbolLayer()
        m.setLineAngle(angle)
        m.setDistance(ecart)
        m.setDistanceUnit(Qgis.RenderUnit.Millimeters)
        m.setLineWidth(largeur_motif)
        m.setColor(QColor(0, 0, 0))
        couches.append(m)
    return QgsFillSymbol(couches)


STYLES = {
    "Forêt en 2025": fill(NOIR, NOIR, "0.1"),
    "Perte 2017-2025": fill("85,85,85,255", "85,85,85,255", "0.1"),
    "Perte 2010-2017": fill("115,115,115,255", "115,115,115,255", "0.1"),
    "Perte 2000-2010": fill("150,150,150,255", "150,150,150,255", "0.1"),
    "Perte 1990-2000": fill("185,185,185,255", "185,185,185,255", "0.1"),
    "Perte 1973-1990": fill("220,220,220,255", "195,195,195,255", "0.1"),
    "Non classé en 1973": motif((45,), 1.6, largeur_motif=0.15, contour="150,150,150,255", largeur_contour="0.1"),
}
periodes = {}
for nom, _ in PERIODES:
    c = charger(GPKG + f"|layername=couvert_periodes", nom)
    c.setSubsetString(f"\"periode\"='{nom}'")
    c.setRenderer(QgsSingleSymbolRenderer(STYLES[nom]))
    periodes[nom] = c

com_all = charger(os.path.join(EXT, "limites-admin-communes.gpkg"), "Communes")
com_all.setSubsetString("\"ADM2_EN\"='Manakara Atsimo'")
com_all.setRenderer(QgsSingleSymbolRenderer(fill(TRANSPARENT, TRANSPARENT, "0")))
vers_utm = QgsCoordinateTransform(com_all.crs(), UTM, project)
limites = []
for ft in com_all.getFeatures():
    g = QgsGeometry(ft.geometry())
    g.transform(vers_utm)
    limites.append(QgsGeometry(g.constGet().boundary()))
com_lignes = memoire("MultiLineString", "Limites communales")
nv = QgsFeature(com_lignes.fields())
nv.setGeometry(QgsGeometry.unaryUnion(limites))
nv.setAttributes(["limites"])
com_lignes.dataProvider().addFeature(nv)
tirets = QgsSimpleLineSymbolLayer(QColor(0, 0, 0), 0.8)
tirets.setUseCustomDashPattern(True)
tirets.setCustomDashVector([3.0, 2.5])
com_lignes.setRenderer(QgsSingleSymbolRenderer(QgsLineSymbol([tirets])))
transfert = charger(IA, "Transfert")
perim_lignes = memoire("MultiLineString", "Périmètre VOI")
vers_utm_ia = QgsCoordinateTransform(transfert.crs(), UTM, project)
masque_com = QgsGeometry.unaryUnion(limites).buffer(30, 8)
for ft in transfert.getFeatures():
    if str(ft["layer"]).startswith("Délimitation"):
        g = QgsGeometry(ft.geometry())
        g.transform(vers_utm_ia)
        nv = QgsFeature(perim_lignes.fields())
        nv.setGeometry(QgsGeometry(g.constGet().boundary()))
        perim_lignes.dataProvider().addFeature(nv)
contour = QgsSimpleLineSymbolLayer(QColor(0, 0, 0), 0.7)
liseré = QgsSimpleLineSymbolLayer(QColor(255, 255, 255), 1.7)
perim_lignes.setRenderer(QgsSingleSymbolRenderer(QgsLineSymbol([liseré, contour])))
fmt_com = texte(TAILLE, gras=True)
fmt_com.setCapitalization(Qgis.Capitalization.AllUppercase)
etiqueter(com_all, "ADM3_EN", fmt_com)

# --- Mise en page ----------------------------------------------------------
LARGEUR_PAGE, HAUTEUR_PAGE = 170, 203
X_CARTE, Y_CARTE, L_CARTE, H_CARTE = 8, 8, 154, 150
ECHELLE = 35000
CENTRE = (805131, 7574978)   # centre du périmètre transféré (tout le périmètre visible)

layout = QgsPrintLayout(project)
layout.initializeDefaults()
layout.setName("Carte 4 - couvert forestier")
project.layoutManager().addLayout(layout)
layout.pageCollection().page(0).setPageSize(QgsLayoutSize(LARGEUR_PAGE, HAUTEUR_PAGE, Qgis.LayoutUnit.Millimeters))


def mm(x, y):
    return QgsLayoutPoint(x, y, Qgis.LayoutUnit.Millimeters)


def taille(w, h):
    return QgsLayoutSize(w, h, Qgis.LayoutUnit.Millimeters)


def etiquette(txt, x, y, w, h, taille_pt=TAILLE, gras=False):
    it = QgsLayoutItemLabel(layout)
    it.setText(txt)
    it.setTextFormat(texte(taille_pt, gras=gras, halo=False))
    it.attemptMove(mm(x, y))
    it.attemptResize(taille(w, h))
    it.setVAlign(Qt.AlignmentFlag.AlignVCenter)
    layout.addLayoutItem(it)


carte = QgsLayoutItemMap(layout)
carte.attemptMove(mm(X_CARTE, Y_CARTE))
carte.attemptResize(taille(L_CARTE, H_CARTE))
carte.setCrs(UTM)
ordre = ["Perte 2017-2025", "Perte 2010-2017", "Perte 2000-2010", "Perte 1990-2000"]
carte.setLayers([perim_lignes] + [periodes[n] for n in ordre] + [com_lignes, periodes["Forêt en 2025"], periodes["Perte 1973-1990"], periodes["Non classé en 1973"], com_all])
carte.setBackgroundColor(QColor(255, 255, 255))
carte.setFrameEnabled(True)
carte.setFrameStrokeWidth(QgsLayoutMeasurement(0.4))
carte.zoomToExtent(QgsRectangle(CENTRE[0] - 3000, CENTRE[1] - 3000, CENTRE[0] + 3000, CENTRE[1] + 3000))
carte.setScale(ECHELLE)
layout.addLayoutItem(carte)

grille = QgsLayoutItemMapGrid("Graticule", carte)
grille.setCrs(WGS)
grille.setIntervalX(0.01)
grille.setIntervalY(0.01)
grille.setStyle(QgsLayoutItemMapGrid.GridStyle.FrameAnnotationsOnly)
grille.setFrameStyle(QgsLayoutItemMapGrid.FrameStyle.Zebra)
grille.setFrameWidth(1.6)
grille.setFramePenSize(0.2)
grille.setFrameFillColor1(QColor(0, 0, 0))
grille.setFrameFillColor2(QColor(255, 255, 255))
grille.setAnnotationEnabled(True)
grille.setAnnotationTextFormat(texte(TAILLE_GRATICULE, halo=False))
grille.setAnnotationPrecision(2)
grille.setAnnotationFormat(QgsLayoutItemMapGrid.AnnotationFormat.DecimalWithSuffix)
B = QgsLayoutItemMapGrid.BorderSide
for cote in (B.Left, B.Bottom):
    grille.setAnnotationPosition(QgsLayoutItemMapGrid.AnnotationPosition.OutsideMapFrame, cote)
grille.setAnnotationDisplay(QgsLayoutItemMapGrid.DisplayMode.LatitudeOnly, B.Left)
grille.setAnnotationDisplay(QgsLayoutItemMapGrid.DisplayMode.LongitudeOnly, B.Bottom)
grille.setAnnotationDisplay(QgsLayoutItemMapGrid.DisplayMode.HideAll, B.Right)
grille.setAnnotationDisplay(QgsLayoutItemMapGrid.DisplayMode.HideAll, B.Top)
grille.setAnnotationDirection(QgsLayoutItemMapGrid.AnnotationDirection.Vertical, B.Left)
grille.setAnnotationFrameDistance(1.2)
carte.grids().addGrid(grille)

nord = QgsLayoutItemPicture(layout)
nord.setPicturePath(":/images/north_arrows/layout_default_north_arrow.svg")
nord.attemptMove(mm(X_CARTE + L_CARTE - 14, Y_CARTE + 3))
nord.attemptResize(taille(11, 11))
nord.setLinkedMap(carte)
layout.addLayoutItem(nord)

echelle = QgsLayoutItemScaleBar(layout)
echelle.setLinkedMap(carte)
echelle.setStyle("Single Box")
echelle.setUnits(Qgis.DistanceUnit.Kilometers)
echelle.setNumberOfSegments(2)
echelle.setNumberOfSegmentsLeft(0)
echelle.setUnitsPerSegment(1)
echelle.setUnitLabel("km")
echelle.setFont(QFont(FONT, TAILLE))
echelle.setBackgroundEnabled(True)
echelle.setBackgroundColor(QColor(255, 255, 255))
echelle.attemptMove(mm(X_CARTE + L_CARTE - 75, Y_CARTE + H_CARTE - 14))
layout.addLayoutItem(echelle)

# --- Légende ---------------------------------------------------------------
Shape = QgsLayoutItemShape.Shape


def forme(kind, x, yy, w, h, symbole):
    it = QgsLayoutItemShape(layout)
    it.setShapeType(kind)
    it.attemptMove(mm(x, yy))
    it.attemptResize(taille(w, h))
    it.setSymbol(symbole)
    layout.addLayoutItem(it)


y0 = Y_CARTE + H_CARTE + 6
col = [X_CARTE, X_CARTE + 85]
PAS = 7.0
for c, r, nom, lib in [
    (0, 0, "Forêt en 2025", "Forêt en 2025"),
    (0, 1, "Non classé en 1973", "Non classé en 1973 (nuages)"),
    (0, 2, "perim", "Périmètre du VOI Maharitra"),
    (0, 3, "commune", "Limite de commune"),
    (1, 0, "Perte 1973-1990", "Forêt perdue de 1973 à 1990"),
    (1, 1, "Perte 1990-2000", "Forêt perdue de 1990 à 2000"),
    (1, 2, "Perte 2000-2010", "Forêt perdue de 2000 à 2010"),
    (1, 3, "Perte 2010-2017", "Forêt perdue de 2010 à 2017"),
    (1, 4, "Perte 2017-2025", "Forêt perdue de 2017 à 2025"),
]:
    x, yy = col[c], y0 + r * PAS
    if nom == "commune":
        forme(Shape.Rectangle, x, yy + 2.8, 7.5, 0.01, fill_tirets())
    elif nom == "perim":
        forme(Shape.Rectangle, x, yy + 2.8, 7.5, 0.01, QgsFillSymbol([QgsSimpleLineSymbolLayer(QColor(255, 255, 255), 1.7), QgsSimpleLineSymbolLayer(QColor(0, 0, 0), 0.7)]))
    else:
        forme(Shape.Rectangle, x, yy + 0.8, 7, 4, STYLES[nom])
    etiquette(lib, x + 9, yy, 74, 6.6)

for chemin in (OUT_PNG, OUT_SVG, OUT_QGZ):
    os.makedirs(os.path.dirname(chemin), exist_ok=True)
exp = QgsLayoutExporter(layout)
img = QgsLayoutExporter.ImageExportSettings()
img.dpi = 300
print("PNG", exp.exportToImage(OUT_PNG, img))
svg = QgsLayoutExporter.SvgExportSettings()
svg.dpi = 300
print("SVG", exp.exportToSvg(OUT_SVG, svg))
print("PDF", exp.exportToPdf(OUT_PDF, QgsLayoutExporter.PdfExportSettings()))
project.write(OUT_QGZ)
app.exitQgis()
subprocess.run(["pdftocairo", "-svg", OUT_PDF, os.path.join(BASE, "..", "05-rapport", "images", "carte-couvert-1973-2017.svg")], check=True)
