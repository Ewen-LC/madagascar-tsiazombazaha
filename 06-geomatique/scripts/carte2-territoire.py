"""Carte 2 : territoire de Tsiazombazaha (noir et blanc).

Lancement :
  QT_QPA_PLATFORM=offscreen PYTHONPATH=/usr/share/qgis/python python3 carte2-territoire.py
Sorties : cartes/carte2-territoire.png (300 dpi),
          cartes/carte2-territoire.svg,
          projets-qgis/carte2-territoire.qgz
Contenu : périmètre de transfert de gestion (VOI Maharitra) et zones de droit d'usage,
massif forestier (classification Sentinel-2 du 6 mai 2026, dans le périmètre), fokontany concernés (limites OCHA/BNGRC 2018),
communes,.

Gabarit : 170 mm de large = largeur du texte du rapport (A4, marges de 2 cm).
"""
import os
import subprocess

from qgis.core import (
    Qgis, QgsApplication, QgsCoordinateReferenceSystem, QgsCoordinateTransform,
    QgsFeature, QgsFillSymbol, QgsGeometry, QgsLineSymbol, QgsLayoutExporter, QgsLayoutItemLabel,
    QgsLayoutItemMap, QgsLayoutItemMapGrid, QgsLayoutItemPicture, QgsLayoutItemScaleBar,
    QgsLayoutItemShape, QgsLayoutMeasurement, QgsLayoutPoint, QgsLayoutSize,
    QgsLinePatternFillSymbolLayer, QgsMarkerSymbol, QgsPalLayerSettings, QgsPrintLayout,
    QgsProject, QgsRectangle, QgsRuleBasedRenderer, QgsSimpleFillSymbolLayer, QgsSimpleLineSymbolLayer, QgsSingleSymbolRenderer,
    QgsTextBufferSettings, QgsTextFormat, QgsVectorLayer, QgsVectorLayerSimpleLabeling,
)
from qgis.PyQt.QtCore import Qt
from qgis.PyQt.QtGui import QColor, QFont, QFontMetricsF

BASE = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
EXT = os.path.join(BASE, "donnees-brutes", "sources-externes", "limites-admin")
IA = os.path.join(BASE, "donnees-brutes", "inter-aide")
VECTEUR = os.path.join(BASE, "donnees-traitees", "couches")
OUT_PNG = os.path.join(BASE, "cartes", "carte2-territoire.png")
OUT_SVG = os.path.join(BASE, "cartes", "carte2-territoire.svg")
OUT_PDF = os.path.join(BASE, "cartes", "carte2-territoire.pdf")
OUT_QGZ = os.path.join(BASE, "projets-qgis", "carte2-territoire.qgz")

# fokontany à représenter : ceux qui recoupent le périmètre transféré (limites OCHA/BNGRC 2018)
FOKONTANY = [
    ("Mizilo Gara", "Mizilo Gara"), ("Ambahatrazo", "Mahatsara"), ("Ambahatrazo", "Ambahatrazo"),
    ("Ambahatrazo", "Vohitrandriana"), ("Ambahatrazo", "Ambalavolo"), ("Ambila", "Andriana"),
    ("Ambila", "Mandrosovelo"), ("Vohimasina Sud", "Tsararano"),
]
COMMUNES = ["Mizilo Gara", "Ambahatrazo", "Ambila", "Vohimasina Sud"]

app = QgsApplication([], False)
app.initQgis()
UTM = QgsCoordinateReferenceSystem("EPSG:32738")
WGS = QgsCoordinateReferenceSystem("EPSG:4326")
project = QgsProject()
project.setCrs(UTM)

NOIR = "0,0,0,255"
GRIS_FONCE = "90,90,90,255"
GRIS_CLAIR = "225,225,225,255"
GRIS_FORET = "140,140,140,255"
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


def etiqueter(couche, champ, fmt, expression=False):
    s = QgsPalLayerSettings()
    s.fieldName = champ
    s.isExpression = expression
    s.setFormat(fmt)
    s.placement = QgsPalLayerSettings.Placement.Horizontal
    couche.setLabeling(QgsVectorLayerSimpleLabeling(s))
    couche.setLabelsEnabled(True)


# --- Couches --------------------------------------------------------------
fkt_all = charger(os.path.join(EXT, "limites-admin-fokontany.gpkg"), "Fokontany")
com_all = charger(os.path.join(EXT, "limites-admin-communes.gpkg"), "Communes")
transfert = charger(os.path.join(IA, "limites-transfert-gestion.gpkg"), "Transfert")
foret = charger(os.path.join(VECTEUR, "foret-2026-sentinel2-perimetre.gpkg"), "Forêt")

# sélection par expression (couches sources non modifiées)
cond_f = " OR ".join(f"(\"ADM3_EN\"='{c}' AND \"ADM4_EN\"='{f}')" for c, f in FOKONTANY)
fkt_all.setSubsetString(cond_f)
cond_c = " OR ".join(f"\"ADM3_EN\"='{c}'" for c in COMMUNES)
com_all.setSubsetString(f"\"ADM2_EN\"='Manakara Atsimo' AND ({cond_c})")
assert fkt_all.featureCount() == len(FOKONTANY), fkt_all.featureCount()

# périmètre de transfert = polygone « Délimitation » ; zones de droit d'usage = les 4 autres
transfert_perim = QgsVectorLayer("MultiPolygon?crs=EPSG:4326&field=nom:string", "Périmètre transféré", "memory")
zdu = QgsVectorLayer("MultiPolygon?crs=EPSG:4326&field=nom:string", "Zones de droit d'usage", "memory")
for ft in transfert.getFeatures():
    cible = transfert_perim if str(ft["layer"]).startswith("Délimitation") else zdu
    nv = QgsFeature(cible.fields())
    nv.setGeometry(ft.geometry())
    nv.setAttributes([ft["layer"]])
    cible.dataProvider().addFeature(nv)
for c in (transfert_perim, zdu):
    c.updateExtents()
    project.addMapLayer(c, False)

# --- Styles ---------------------------------------------------------------
com_all.setRenderer(QgsSingleSymbolRenderer(fill(TRANSPARENT, TRANSPARENT, "0")))
# fokontany adhérant au VOI (Mizilo Gara, qui englobe Amborodra, Ampasipotsy et Tsiazombazaha
# issus d'une scission récente ; Mahatsara = Manakana ; Vohitrandriana ; Ambalavolo ; Andriana)
ADHERENTS = ["Mizilo Gara", "Mahatsara", "Vohitrandriana", "Ambalavolo", "Andriana"]
rend = QgsRuleBasedRenderer(QgsFillSymbol.createSimple({"color": BLANC}))
racine = rend.rootRule()
racine.removeChildAt(0) if racine.children() else None
for nom_r, expr, sym in (
    ("adhérent", "\"ADM4_EN\" IN (" + ",".join(f"'{a}'" for a in ADHERENTS) + ")", fill(GRIS_CLAIR, GRIS_FONCE, "0.2", "dot")),
    ("autre", "ELSE", fill(BLANC, GRIS_FONCE, "0.2", "dot")),
):
    r = QgsRuleBasedRenderer.Rule(sym, 0, 0, expr, nom_r)
    racine.appendChild(r)
fkt_all.setRenderer(rend)
transfert_perim.setRenderer(QgsSingleSymbolRenderer(hachures()))
# contour épais par-dessus les hachures
# contour du transfert (trait plein fin), sans les tronçons qui longent une limite de commune :
# la limite communale (tirets) y est alors seule visible
transfert_contour = QgsVectorLayer("MultiLineString?crs=EPSG:32738&field=nom:string", "Contour transfert", "memory")
vers_utm = QgsCoordinateTransform(WGS, UTM, project)
limites_com = []
for ft in com_all.getFeatures():
    g = QgsGeometry(ft.geometry())
    g.transform(vers_utm)
    limites_com.append(QgsGeometry(g.constGet().boundary()))
limites_uniques = QgsGeometry.unaryUnion(limites_com)   # chaque limite partagée une seule fois
masque = limites_uniques.buffer(30, 8)   # 30 m
for ft in transfert_perim.getFeatures():
    g = QgsGeometry(ft.geometry())
    g.transform(vers_utm)
    contour = QgsGeometry(g.constGet().boundary()).difference(masque)
    nv = QgsFeature(transfert_contour.fields())
    nv.setGeometry(contour)
    nv.setAttributes([ft["nom"]])
    transfert_contour.dataProvider().addFeature(nv)
project.addMapLayer(transfert_contour, False)
# limites communales dissoutes en une seule ligne : une limite partagée par deux communes
# ne doit pas être tracée deux fois (les tirets se superposeraient en trait plein)
com_lignes = QgsVectorLayer("MultiLineString?crs=EPSG:32738&field=nom:string", "Limites communales", "memory")
nv = QgsFeature(com_lignes.fields())
nv.setGeometry(limites_uniques)
nv.setAttributes(["limites"])
com_lignes.dataProvider().addFeature(nv)
project.addMapLayer(com_lignes, False)
ligne_tirets = QgsSimpleLineSymbolLayer(QColor(0, 0, 0), 0.8)
ligne_tirets.setUseCustomDashPattern(True)
ligne_tirets.setCustomDashVector([3.0, 2.5])
com_lignes.setRenderer(QgsSingleSymbolRenderer(QgsLineSymbol([ligne_tirets])))
transfert_contour.setRenderer(QgsSingleSymbolRenderer(QgsLineSymbol.createSimple({"line_color": NOIR, "line_width": "0.35"})))
zdu.setRenderer(QgsSingleSymbolRenderer(quadrillage()))
foret.setRenderer(QgsSingleSymbolRenderer(fill(GRIS_FORET, NOIR, "0.2")))

fmt_com = texte(TAILLE, gras=True)
fmt_com.setCapitalization(Qgis.Capitalization.AllUppercase)
etiqueter(com_all, "ADM3_EN", fmt_com)
etiqueter(fkt_all, "CASE WHEN \"ADM4_EN\"='Mahatsara' THEN 'Mahatsara (Manakana)' WHEN \"ADM4_EN\"='Vohitrandriana' THEN 'Vohitrandriana (Amborodra)' ELSE \"ADM4_EN\" END", texte(TAILLE, italique=True), expression=True)

# --- Mise en page ---------------------------------------------------------
LARGEUR_PAGE, HAUTEUR_PAGE = 170, 170
X_CARTE, Y_CARTE, L_CARTE, H_CARTE = 8, 8, 154, 130
ECHELLE = 60000

layout = QgsPrintLayout(project)
layout.initializeDefaults()
layout.setName("Carte 2 - territoire")
project.layoutManager().addLayout(layout)
layout.pageCollection().page(0).setPageSize(
    QgsLayoutSize(LARGEUR_PAGE, HAUTEUR_PAGE, Qgis.LayoutUnit.Millimeters))


def mm(x, y):
    return QgsLayoutPoint(x, y, Qgis.LayoutUnit.Millimeters)


def taille(w, h):
    return QgsLayoutSize(w, h, Qgis.LayoutUnit.Millimeters)


def etiquette(txt, x, y, w, h, taille_pt=TAILLE, gras=False):
    it = QgsLayoutItemLabel(layout)
    it.setText(txt)
    f = QgsTextFormat()
    f.setFont(QFont(FONT, 8, QFont.Weight.Bold if gras else QFont.Weight.Normal))
    f.setSize(taille_pt)
    f.setColor(QColor(0, 0, 0))
    it.setTextFormat(f)
    it.attemptMove(mm(x, y))
    it.attemptResize(taille(w, h))
    it.setVAlign(Qt.AlignmentFlag.AlignVCenter)
    layout.addLayoutItem(it)
    return it


# emprise : centrée sur le périmètre transféré (+ habitations), en UTM
t = QgsCoordinateTransform(WGS, UTM, project)
emprise = t.transformBoundingBox(transfert_perim.extent())
emprise.combineExtentWith(foret.extent())   # couche déjà en UTM 38 S
centre = emprise.center()

carte = QgsLayoutItemMap(layout)
carte.attemptMove(mm(X_CARTE, Y_CARTE))
carte.attemptResize(taille(L_CARTE, H_CARTE))
carte.setCrs(UTM)
carte.setLayers([com_all, com_lignes, zdu, foret, transfert_contour, transfert_perim, fkt_all])
carte.setBackgroundColor(QColor(255, 255, 255))
carte.setFrameEnabled(True)
carte.setFrameStrokeWidth(QgsLayoutMeasurement(0.4))
carte.zoomToExtent(QgsRectangle(centre.x() - 5000, centre.y() - 4000, centre.x() + 5000, centre.y() + 4000))
carte.setScale(ECHELLE)
layout.addLayoutItem(carte)

grille = QgsLayoutItemMapGrid("Graticule", carte)
grille.setCrs(WGS)
grille.setIntervalX(0.02)
grille.setIntervalY(0.02)
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

# flèche du nord (coin haut droit, dans la carte) et barre d'échelle (bas droite)
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
echelle.attemptMove(mm(X_CARTE + L_CARTE - 48, Y_CARTE + H_CARTE - 14))
layout.addLayoutItem(echelle)

# --- Légende (deux colonnes sous la carte) ---------------------------------
Shape = QgsLayoutItemShape.Shape


def forme(kind, x, yy, w, h, symbole):
    it = QgsLayoutItemShape(layout)
    it.setShapeType(kind)
    it.attemptMove(mm(x, yy))
    it.attemptResize(taille(w, h))
    it.setSymbol(symbole)
    layout.addLayoutItem(it)


def trait(x, yy, longueur, style, epaisseur):
    forme(Shape.Rectangle, x, yy, longueur, 0.01, fill_tirets())


y0 = Y_CARTE + H_CARTE + 6
col = [X_CARTE, X_CARTE + 85]
# (colonne, rang, texte, type)
entrees = [
    (0, 0, "Massif forestier", "foret"),
    (0, 1, "Périmètre transféré (VOI)", "perim"),
    (0, 2, "Zone de droit d'usage", "zdu"),
    (1, 0, "Limite de commune", "commune"),
    (1, 1, "Fokontany adhérant au VOI", "fkt"),
]
PAS = 7.0
for c, r, nom, kind in entrees:
    x, yy = col[c], y0 + r * PAS
    if kind == "foret":
        forme(Shape.Rectangle, x, yy + 0.8, 7, 4, fill(GRIS_FORET, NOIR, "0.2"))
    elif kind == "perim":
        forme(Shape.Rectangle, x, yy + 0.8, 7, 4, hachures())
        forme(Shape.Rectangle, x, yy + 0.8, 7, 4, fill(TRANSPARENT, NOIR, "0.35"))
    elif kind == "zdu":
        forme(Shape.Rectangle, x, yy + 0.8, 7, 4, quadrillage())
    elif kind == "commune":
        trait(x, yy + 2.8, 7.5, "", "")
    elif kind == "fkt":
        forme(Shape.Rectangle, x, yy + 0.8, 7, 4, fill(GRIS_CLAIR, GRIS_FONCE, "0.2", "dot"))
    etiquette(nom, x + 9, yy, 74, 6.6)

# surfaces (m² -> ha) en UTM 38 S pour le texte de légende
def surface_ha(couche):
    tr = QgsCoordinateTransform(couche.crs(), UTM, project)
    tot = 0
    for ft in couche.getFeatures():
        g = QgsGeometry(ft.geometry())
        g.transform(tr)
        tot += g.area()
    return tot / 1e4


print(f"Périmètre transféré : {surface_ha(transfert_perim):.0f} ha ; zones de droit d'usage : {surface_ha(zdu):.0f} ha ; forêt (classification Sentinel-2 2026) : {surface_ha(foret):.0f} ha")
print("Fokontany sélectionnés :", sorted(f["ADM4_EN"] for f in fkt_all.getFeatures()))

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
# SVG pour Typst : le SVG de QGIS rend mal les hachures, on convertit le PDF
subprocess.run(["pdftocairo", "-svg", OUT_PDF, os.path.join(BASE, "..", "05-rapport", "images", "carte-territoire.svg")], check=True)
