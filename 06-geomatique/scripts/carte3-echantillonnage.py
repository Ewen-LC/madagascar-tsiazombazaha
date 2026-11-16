"""Carte 3 : dispositif d'échantillonnage (28 placettes et itinéraires), noir et blanc.

Lancement :
  QT_QPA_PLATFORM=offscreen PYTHONPATH=/usr/share/qgis/python python3 carte3-echantillonnage.py
Sorties : cartes/carte3-echantillonnage.png (300 dpi),
          cartes/carte3-echantillonnage.{svg,pdf},
          projets-qgis/carte3-echantillonnage.qgz,
          donnees-traitees/tables/placettes-coordonnees.csv

Coordonnées des placettes : points GPS (waypoints-2026-09-18.gpx, étiquettes P1 à P25 de
l'appareil) rattachés aux placettes du rapport (P01 à P28) d'après la date et l'ordre de
passage sur les traces GPX ; correspondance CORRESPONDANCE ci-dessous, à valider.
Itinéraires : traces GPX, une par journée de terrain (dates de transects.csv).

Gabarit : 170 mm de large = largeur du texte du rapport (A4, marges de 2 cm).
"""
import csv
import glob
import math
import os
import re
import subprocess
from collections import defaultdict

from qgis.core import (
    Qgis, QgsApplication, QgsCategorizedSymbolRenderer, QgsCoordinateReferenceSystem,
    QgsCoordinateTransform, QgsFeature, QgsFillSymbol, QgsGeometry, QgsLayoutExporter,
    QgsLayoutItemLabel, QgsLayoutItemLegend, QgsLayoutItemMap, QgsLayoutItemMapGrid,
    QgsLayoutItemPicture, QgsLayoutItemScaleBar, QgsLayoutItemShape, QgsLayoutMeasurement, QgsLegendRenderer,
    QgsLayoutPoint, QgsLayoutSize, QgsLegendStyle, QgsLineSymbol, QgsMarkerSymbol, QgsPalLayerSettings,
    QgsPointXY, QgsPrintLayout, QgsProject, QgsRectangle, QgsRendererCategory,
    QgsLinePatternFillSymbolLayer, QgsSimpleFillSymbolLayer, QgsSimpleLineSymbolLayer, QgsSimpleMarkerSymbolLayer, QgsSingleSymbolRenderer,
    QgsTextBufferSettings, QgsTextFormat, QgsVectorLayer, QgsVectorLayerSimpleLabeling,
)
from qgis.PyQt.QtCore import Qt
from qgis.PyQt.QtGui import QColor, QFont

BASE = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
EXT = os.path.join(BASE, "donnees-brutes", "sources-externes", "limites-admin")
IA = os.path.join(BASE, "donnees-brutes", "inter-aide")
TERRAIN = os.path.join(BASE, "donnees-brutes", "terrain")
VECTEUR = os.path.join(BASE, "donnees-traitees", "couches")
OUT_PNG = os.path.join(BASE, "cartes", "carte3-echantillonnage.png")
OUT_SVG = os.path.join(BASE, "cartes", "carte3-echantillonnage.svg")
OUT_PDF = os.path.join(BASE, "cartes", "carte3-echantillonnage.pdf")
OUT_QGZ = os.path.join(BASE, "projets-qgis", "carte3-echantillonnage.qgz")
OUT_CSV = os.path.join(BASE, "donnees-traitees", "tables", "placettes-coordonnees.csv")

# itinéraires (transects.csv) : code -> (date des traces GPX, placettes, avec placettes ?)
ITINERAIRES = {
    "T01": ("2026-08-18", "P01", True),
    "T02": ("2026-08-19", "", False),
    "T03": ("2026-08-20", "P02 à P05", True),
    "T04": ("2026-08-25", "P06, P07", True),
    "T05": ("2026-08-26", "P08 à P11", True),
    "T06": ("2026-08-27", "", False),
    "T14": ("2026-09-02", "P12 à P15", True),
    "T16": ("2026-09-04", "P16", True),
    "T19": ("2026-09-11", "P17 à P20", True),
    "T20": ("2026-09-15", "P21 à P24", True),
    "T21": ("2026-09-16", "P25 à P28", True),
}
# placette du rapport -> (itinéraire, étiquette GPS de l'appareil ; None = point non enregistré)
CORRESPONDANCE = {
    "P01": ("T01", "P1"),
    "P02": ("T03", "P2"), "P03": ("T03", "P2"), "P04": ("T03", "P2"), "P05": ("T03", "P2"),
    "P06": ("T04", "P3"), "P07": ("T04", "P4"),
    "P08": ("T05", "P5"), "P09": ("T05", "P6"), "P10": ("T05", "P7"), "P11": ("T05", "P8"),
    "P12": ("T14", "P9"), "P13": ("T14", "P10"), "P14": ("T14", None), "P15": ("T14", "P12"),
    "P16": ("T16", "P13"),
    "P17": ("T19", "P14"), "P18": ("T19", "P15"), "P19": ("T19", "P16"), "P20": ("T19", None),
    "P21": ("T20", "P18"), "P22": ("T20", "P19"), "P23": ("T20", "P20"), "P24": ("T20", "P21"),
    "P25": ("T21", "P22"), "P26": ("T21", "P23"), "P27": ("T21", "P24"), "P28": ("T21", "P25"),
}
# coordonnées fournies par l'auteur (UTM 38 S, 03/11/2026) pour les placettes sans point GPS
MANUELLES = {"P14": (803635.37, 7575670.27), "P20": (804147.5, 7575287.2)}
# symboles identiques à ceux de l'ordination NMDS (formes 0 à 8 de R, dans l'ordre des itinéraires)
AVEC_PLACETTES = [c for c, v in ITINERAIRES.items() if v[2]]
FORMES = dict(zip(AVEC_PLACETTES, range(9)))

app = QgsApplication([], False)
app.initQgis()
UTM = QgsCoordinateReferenceSystem("EPSG:32738")
WGS = QgsCoordinateReferenceSystem("EPSG:4326")
project = QgsProject()
project.setCrs(UTM)
vers_utm = QgsCoordinateTransform(WGS, UTM, project)

NOIR = "0,0,0,255"
GRIS_FONCE = "90,90,90,255"
GRIS_FORET = "215,215,215,255"
BLANC = "255,255,255,255"
TRANSPARENT = "255,255,255,0"
FONT = "Source Serif 4"
TAILLE = 12
TAILLE_PLACETTE = 10
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


def marqueur():
    """Symbole unique de placette : cercle blanc à contour noir."""
    c = QgsSimpleMarkerSymbolLayer(Qgis.MarkerShape.Circle, 3.2)
    c.setColor(QColor(255, 255, 255))
    c.setStrokeColor(QColor(0, 0, 0))
    c.setStrokeWidth(0.5)
    return QgsMarkerSymbol([c])


# --- Points GPS (waypoints) et traces GPX -----------------------------------
gpx_wpt = open(os.path.join(TERRAIN, "waypoints-2026-09-18.gpx"), encoding="utf-8").read()
wpt = {}
for lat, lon, nom in re.findall(r'<wpt lat="([^"]+)" lon="([^"]+)">.*?<name>(.*?)</name>', gpx_wpt, re.S):
    wpt.setdefault(nom, (float(lat), float(lon)))
wpt["P25"] = wpt.pop("P25;()", wpt.get("P25"))   # nom saisi « P25;() » sur l'appareil


def vers_point_utm(lat, lon):
    return vers_utm.transform(QgsPointXY(lon, lat))


points_par_jour = defaultdict(list)
for f in sorted(glob.glob(os.path.join(TERRAIN, "traces", "*.gpx"))):
    txt = open(f, encoding="utf-8").read()
    for lat, lon, jour, heure in re.findall(
            r'<trkpt lat="([^"]+)" lon="([^"]+)">.*?<time>(\d{4}-\d\d-\d\d)T([\d:]+)Z', txt, re.S):
        points_par_jour[jour].append((heure, float(lat), float(lon)))

# les traces de certaines journées incluent les trajets motorisés jusqu'au terrain : on ne garde que
# les abords des placettes (emprise des placettes + 1,5 km)
pl_utm = [vers_point_utm(*wpt[g]) for _, g in CORRESPONDANCE.values() if g] + [QgsPointXY(*v) for v in MANUELLES.values()]
FENETRE = QgsRectangle(min(p.x() for p in pl_utm) - 1500, min(p.y() for p in pl_utm) - 1500,
                       max(p.x() for p in pl_utm) + 1500, max(p.y() for p in pl_utm) + 1500)
itin = memoire("MultiLineString", "Itinéraires", "code:string")
for code, (jour, _, avec) in ITINERAIRES.items():
    pts = sorted(set(points_par_jour[jour]))
    troncons, courant, prec = [], [], None
    for h, lat, lon in pts:
        p = vers_point_utm(lat, lon)
        if not FENETRE.contains(p):
            prec = None
            if courant:
                troncons.append(courant)
                courant = []
            continue
        sec = int(h[:2]) * 3600 + int(h[3:5]) * 60 + int(h[6:8])
        if prec and (sec - prec[0] > 900 or math.hypot(p.x() - prec[1].x(), p.y() - prec[1].y()) > 400):
            troncons.append(courant)
            courant = []
        courant.append(p)
        prec = (sec, p)
    troncons.append(courant)
    lignes = [QgsGeometry.fromPolylineXY(t).simplify(4) for t in troncons if len(t) > 1]
    geom = QgsGeometry.collectGeometry(lignes)
    ft = QgsFeature(itin.fields())
    ft.setGeometry(geom)
    ft.setAttributes([code])
    itin.dataProvider().addFeature(ft)
    print(code, jour, f"{len(pts)} points, {geom.length() / 1000:.1f} km")

# --- Placettes -------------------------------------------------------------
placettes = memoire("Point", "Placettes", "etiquette:string")
DECALAGE = {"P02": (-48, 48), "P03": (48, 48), "P04": (-48, -48), "P05": (48, -48), "P06": (-40, 0), "P07": (40, 0)}
lignes_csv = []
for pl, (tr, gps) in CORRESPONDANCE.items():
    if gps is None:
        p = QgsPointXY(*MANUELLES[pl])
        ll = QgsCoordinateTransform(UTM, WGS, project).transform(p)
        lignes_csv.append([pl, tr, "", f"{ll.x():.6f}", f"{ll.y():.6f}", f"{p.x():.1f}", f"{p.y():.1f}",
                           "coordonnées fournies par l'auteur (03/11/2026)"])
    else:
        lat, lon = wpt[gps]
        p = vers_point_utm(lat, lon)
        lignes_csv.append([pl, tr, gps, f"{lon:.6f}", f"{lat:.6f}", f"{p.x():.1f}", f"{p.y():.1f}",
                           "point GPS de la placette P2 d'origine, commun à P02-P05 ; symboles décalés sur la carte"
                           if pl in DECALAGE else "rattaché par date et ordre de passage"])
    dx, dy = DECALAGE.get(pl, (0, 0))
    ft = QgsFeature(placettes.fields())
    ft.setGeometry(QgsGeometry.fromPointXY(QgsPointXY(p.x() + dx, p.y() + dy)))
    ft.setAttributes([pl])
    placettes.dataProvider().addFeature(ft)

os.makedirs(os.path.dirname(OUT_CSV), exist_ok=True)
with open(OUT_CSV, "w", newline="", encoding="utf-8") as fh:
    w = csv.writer(fh)
    w.writerow(["placette", "itineraire", "point_gps", "lon_wgs84", "lat_wgs84", "x_utm38s", "y_utm38s", "remarque"])
    w.writerows(sorted(lignes_csv))

# --- Contexte : massif, périmètre, communes ---------------------------------
foret = charger(os.path.join(VECTEUR, "foret-2026-sentinel2-perimetre.gpkg"), "Forêt")
transfert = charger(os.path.join(IA, "limites-transfert-gestion.gpkg"), "Transfert")
com_all = charger(os.path.join(EXT, "limites-admin-communes.gpkg"), "Communes")
com_all.setSubsetString("\"ADM2_EN\"='Manakara Atsimo' AND (" + " OR ".join(
    f"\"ADM3_EN\"='{c}'" for c in ["Mizilo Gara", "Ambahatrazo", "Ambila", "Vohimasina Sud"]) + ")")
perim = memoire("MultiPolygon", "Périmètre transféré")
zdu = memoire("MultiPolygon", "Zones de droit d'usage")
vers_utm_ia = QgsCoordinateTransform(transfert.crs(), UTM, project)
for ft in transfert.getFeatures():
    cible = perim if str(ft["layer"]).startswith("Délimitation") else zdu
    g = QgsGeometry(ft.geometry())
    g.transform(vers_utm_ia)
    nv = QgsFeature(cible.fields())
    nv.setGeometry(g)
    nv.setAttributes([ft["layer"]])
    cible.dataProvider().addFeature(nv)

limites_com = []
for ft in com_all.getFeatures():
    g = QgsGeometry(ft.geometry())
    g.transform(vers_utm)
    limites_com.append(QgsGeometry(g.constGet().boundary()))
limites_uniques = QgsGeometry.unaryUnion(limites_com)
masque = limites_uniques.buffer(30, 8)
perim_contour = memoire("MultiLineString", "Contour transfert")
for ft in perim.getFeatures():
    nv = QgsFeature(perim_contour.fields())
    nv.setGeometry(QgsGeometry(ft.geometry().constGet().boundary()).difference(masque))
    perim_contour.dataProvider().addFeature(nv)
com_lignes = memoire("MultiLineString", "Limites communales")
nv = QgsFeature(com_lignes.fields())
nv.setGeometry(limites_uniques)
nv.setAttributes(["limites"])
com_lignes.dataProvider().addFeature(nv)

# --- Styles ----------------------------------------------------------------
GRIS_CLAIR = "225,225,225,255"
GRIS_FORET_2 = "140,140,140,255"
foret.setRenderer(QgsSingleSymbolRenderer(fill(GRIS_FORET_2, NOIR, "0.2")))
perim.setRenderer(QgsSingleSymbolRenderer(fill(TRANSPARENT, TRANSPARENT, "0")))
perim_contour.setRenderer(QgsSingleSymbolRenderer(QgsLineSymbol.createSimple({"line_color": NOIR, "line_width": "0.5"})))
zdu.setRenderer(QgsSingleSymbolRenderer(quadrillage()))
com_all.setRenderer(QgsSingleSymbolRenderer(fill(TRANSPARENT, TRANSPARENT, "0")))
tirets = QgsSimpleLineSymbolLayer(QColor(0, 0, 0), 0.8)
tirets.setUseCustomDashPattern(True)
tirets.setCustomDashVector([3.0, 2.5])
com_lignes.setRenderer(QgsSingleSymbolRenderer(QgsLineSymbol([tirets])))
itin.setRenderer(QgsSingleSymbolRenderer(QgsLineSymbol.createSimple({"line_color": NOIR, "line_width": "0.3"})))
placettes.setRenderer(QgsSingleSymbolRenderer(marqueur()))

fmt_com = texte(TAILLE, gras=True)
fmt_com.setCapitalization(Qgis.Capitalization.AllUppercase)
etiqueter(com_all, "ADM3_EN", fmt_com)

# --- Mise en page ----------------------------------------------------------
LARGEUR_PAGE, HAUTEUR_PAGE = 170, 182
X_CARTE, Y_CARTE, L_CARTE, H_CARTE = 8, 8, 154, 150
ECHELLE = 30000

layout = QgsPrintLayout(project)
layout.initializeDefaults()
layout.setName("Carte 3 - échantillonnage")
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


# emprise : placettes + itinéraires, centrée
emprise = QgsRectangle(placettes.extent())
centre = emprise.center()
print(f"Emprise des données : {emprise.width() / 1000:.1f} × {emprise.height() / 1000:.1f} km")
print(f"Taille nécessaire à l'échelle 1/{ECHELLE} : {emprise.width() / ECHELLE * 1000:.0f} × {emprise.height() / ECHELLE * 1000:.0f} mm "
      f"(carte : {L_CARTE} × {H_CARTE} mm)")

carte = QgsLayoutItemMap(layout)
carte.attemptMove(mm(X_CARTE, Y_CARTE))
carte.attemptResize(taille(L_CARTE, H_CARTE))
carte.setCrs(UTM)
carte.setLayers([placettes, itin, com_lignes, foret, com_all])
carte.setBackgroundColor(QColor(255, 255, 255))
carte.setFrameEnabled(True)
carte.setFrameStrokeWidth(QgsLayoutMeasurement(0.4))
carte.zoomToExtent(QgsRectangle(centre.x() - 3000, centre.y() - 3000, centre.x() + 3000, centre.y() + 3000))
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


def trait(x, yy, longueur, symbole):
    forme(Shape.Rectangle, x, yy, longueur, 0.01, symbole)


y0 = Y_CARTE + H_CARTE + 6
col = [X_CARTE, X_CARTE + 85]
PAS = 7.0
for c, r, nom, kind in [
    (0, 0, "Massif forestier", "foret"),
    (0, 1, "Limite de commune", "commune"),
    (1, 0, "Placette", "placette"),
    (1, 1, "Itinéraire parcouru", "itin"),
]:
    x, yy = col[c], y0 + r * PAS
    if kind == "foret":
        forme(Shape.Rectangle, x, yy + 0.8, 7, 4, fill(GRIS_FORET_2, NOIR, "0.2"))
    elif kind == "perim":
        forme(Shape.Rectangle, x, yy + 0.8, 7, 4, fill(TRANSPARENT, NOIR, "0.5"))
    elif kind == "zdu":
        forme(Shape.Rectangle, x, yy + 0.8, 7, 4, quadrillage())
    elif kind == "commune":
        trait(x, yy + 2.8, 7.5, fill_tirets())
    elif kind == "placette":
        forme(Shape.Ellipse, x + 2, yy + 1.4, 3.2, 3.2, fill(BLANC, NOIR, "0.5"))
    else:
        trait(x, yy + 2.8, 7.5, QgsFillSymbol([QgsSimpleLineSymbolLayer(QColor(0, 0, 0), 0.3)]))
    etiquette(nom, x + 9, yy, 74, 6.6)

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
subprocess.run(["pdftocairo", "-svg", OUT_PDF, os.path.join(BASE, "..", "05-rapport", "images", "carte-echantillonnage.svg")], check=True)
