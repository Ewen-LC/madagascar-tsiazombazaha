"""Carte 1 : localisation de la forêt de Tsiazombazaha (noir et blanc).

Lancement :
  QT_QPA_PLATFORM=offscreen PYTHONPATH=/usr/share/qgis/python python3 carte1-localisation.py
Sorties : cartes/carte1-localisation.png (300 dpi),
          cartes/carte1-localisation.svg,
          projets-qgis/carte1-localisation.qgz
Couches créées : région Fitovinany, communes du périmètre EcoBois, fragments voisins
(dans donnees-traitees/couches/). Les fragments voisins se modifient dans
donnees-traitees/tables/fragments-forestiers-approx.csv.

Gabarit : 170 mm de large = largeur du texte du rapport (A4, marges de 2 cm), pour que
les étiquettes (12 pt) restent à 12 pt une fois la figure insérée à 100 % de largeur.
"""
import csv
import os
import subprocess

from qgis.core import (
    Qgis, QgsApplication, QgsCoordinateReferenceSystem, QgsCoordinateTransform,
    QgsCoordinateTransformContext, QgsFeature, QgsFillSymbol, QgsGeometry,
    QgsLayoutExporter, QgsLayoutItemLabel, QgsLayoutItemMap,
    QgsLayoutItemMapGrid, QgsLayoutItemMapOverview, QgsLayoutItemPicture,
    QgsLayoutItemScaleBar, QgsLayoutItemShape, QgsLayoutMeasurement, QgsLayoutPoint,
    QgsLayoutSize, QgsLinePatternFillSymbolLayer, QgsMarkerSymbol, QgsPalLayerSettings,
    QgsPointXY, QgsPrintLayout, QgsSimpleFillSymbolLayer, QgsProject, QgsRectangle, QgsSingleSymbolRenderer,
    QgsSvgMarkerSymbolLayer, QgsTextBufferSettings, QgsTextFormat, QgsVectorFileWriter,
    QgsVectorLayer, QgsVectorLayerSimpleLabeling,
)
from qgis.PyQt.QtCore import Qt
from qgis.PyQt.QtGui import QColor, QFont, QFontMetricsF

BASE = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
EXT = os.path.join(BASE, "donnees-brutes", "sources-externes", "limites-admin")
TRAITE = os.path.join(BASE, "donnees-traitees")
VECTEUR = os.path.join(TRAITE, "couches")
OUT_PNG = os.path.join(BASE, "cartes", "carte1-localisation.png")
OUT_SVG = os.path.join(BASE, "cartes", "carte1-localisation.svg")
OUT_QGZ = os.path.join(BASE, "projets-qgis", "carte1-localisation.qgz")

# districts de la région Fitovinany (créée en 2021 par scission de Vatovavy-Fitovinany)
DISTRICTS_FITOVINANY = ["Manakara Atsimo", "Vohipeno", "Ikongo"]
# communes du périmètre EcoBois : communes des fokontany d'intervention de la couche Inter Aide
# « Fokontany EcoBois 2025-2026 » (carte Inter Aide du 06/03/2026), plus Vohimasina Sud
# (fokontany de Tsararano, entré dans EcoBois en 2026 d'après l'auteur)
COMMUNES_ECOBOIS = [
    ("Mananjary", "Sandrohy"), ("Mananjary", "Anosimparihy"),
    ("Manakara Atsimo", "Mitanty"), ("Manakara Atsimo", "Analavory"),
    ("Manakara Atsimo", "Mahamaibe"), ("Manakara Atsimo", "Mizilo Gara"),
    ("Manakara Atsimo", "Ambahatrazo"), ("Manakara Atsimo", "Ambila"),
    ("Manakara Atsimo", "Vohimasina Sud"),
]

app = QgsApplication([], False)
app.initQgis()

UTM = QgsCoordinateReferenceSystem("EPSG:32738")
WGS = QgsCoordinateReferenceSystem("EPSG:4326")
project = QgsProject()
project.setCrs(UTM)

NOIR = "0,0,0,255"
GRIS_FONCE = "90,90,90,255"
GRIS_CLAIR = "222,222,222,255"
BLANC = "255,255,255,255"
TRANSPARENT = "255,255,255,0"
FONT = "Source Serif 4"
TAILLE = 12          # pt : taille des étiquettes et de la légende (texte du rapport : 11 pt, légendes : 10 pt)
TAILLE_GRATICULE = 9
SVG_ARBRE = "/usr/share/qgis/svg/gpsicons/tree.svg"


def charger(chemin, nom):
    couche = QgsVectorLayer(chemin, nom, "ogr")
    if not couche.isValid():
        raise RuntimeError(f"Couche invalide : {chemin}")
    project.addMapLayer(couche, False)
    return couche


def enregistrer(couche, chemin, nom):
    opt = QgsVectorFileWriter.SaveVectorOptions()
    opt.driverName = "GPKG"
    opt.layerName = nom
    opt.actionOnExistingFile = QgsVectorFileWriter.ActionOnExistingFile.CreateOrOverwriteFile
    QgsVectorFileWriter.writeAsVectorFormatV3(couche, chemin, QgsCoordinateTransformContext(), opt)


def fill(couleur, contour=NOIR, largeur="0.2", style_contour="solid"):
    return QgsFillSymbol.createSimple({
        "color": couleur, "style": "solid", "outline_color": contour,
        "outline_width": largeur, "outline_style": style_contour,
    })


def hachures(angle=45, ecart=1.3):
    """Hachures noires sur fond blanc (lisibles en noir et blanc, même sur le gris de la région)."""
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
        b.setSize(0.5)
        b.setColor(QColor(255, 255, 255))
        f.setBuffer(b)
    return f


def en_haut_a_droite(s, decalage):
    """Étiquette posée en haut à droite du point, décalée de `decalage` mm."""
    s.placement = QgsPalLayerSettings.Placement.OverPoint
    s.quadOffset = QgsPalLayerSettings.QuadrantPosition.QuadrantAboveRight
    s.xOffset = decalage
    s.yOffset = -decalage  # y positif vers le bas
    s.offsetUnits = Qgis.RenderUnit.Millimeters


def etiqueter(couche, champ, fmt, decalage, expression=False):
    s = QgsPalLayerSettings()
    s.fieldName = champ
    s.isExpression = expression
    s.setFormat(fmt)
    en_haut_a_droite(s, decalage)
    couche.setLabeling(QgsVectorLayerSimpleLabeling(s))
    couche.setLabelsEnabled(True)


# --- Couches --------------------------------------------------------------
pays = charger(os.path.join(EXT, "limites-admin-pays.gpkg"), "Madagascar")
districts = charger(os.path.join(EXT, "limites-admin-districts.gpkg"), "Districts")
communes = charger(os.path.join(EXT, "limites-admin-communes.gpkg"), "Communes")
foret = charger(os.path.join(VECTEUR, "foret-2026-sentinel2-perimetre.gpkg"), "Forêt")

# styles embarqués dans les gpkg : on repart de zéro (pas d'étiquettes héritées)
for couche in (pays, districts, communes):
    couche.setLabeling(None)
    couche.setLabelsEnabled(False)

# région Fitovinany = union de ses trois districts
region = QgsVectorLayer("MultiPolygon?crs=EPSG:4326&field=nom:string", "Région Fitovinany", "memory")
geoms = [ft.geometry() for ft in districts.getFeatures() if ft["ADM2_EN"] in DISTRICTS_FITOVINANY]
assert len(geoms) == len(DISTRICTS_FITOVINANY), "district manquant"
ft = QgsFeature(region.fields())
ft.setGeometry(QgsGeometry.unaryUnion(geoms))
ft.setAttributes(["Fitovinany"])
region.dataProvider().addFeature(ft)
region.updateExtents()
project.addMapLayer(region, False)
enregistrer(region, os.path.join(VECTEUR, "region-fitovinany.gpkg"), "region_fitovinany")

# contour de la région, dessiné au-dessus des communes EcoBois (fond blanc)
region_contour = QgsVectorLayer("MultiPolygon?crs=EPSG:4326&field=nom:string", "Contour région", "memory")
region_contour.dataProvider().addFeatures([f for f in region.getFeatures()])
project.addMapLayer(region_contour, False)

# communes du périmètre EcoBois
ecobois = QgsVectorLayer("MultiPolygon?crs=EPSG:4326&field=district:string&field=commune:string",
                         "Communes EcoBois", "memory")
for ft in communes.getFeatures():
    if (ft["ADM2_EN"], ft["ADM3_EN"]) in COMMUNES_ECOBOIS:
        nv = QgsFeature(ecobois.fields())
        nv.setGeometry(ft.geometry())
        nv.setAttributes([ft["ADM2_EN"], ft["ADM3_EN"]])
        ecobois.dataProvider().addFeature(nv)
assert ecobois.featureCount() == len(COMMUNES_ECOBOIS), "commune EcoBois manquante"
ecobois.updateExtents()
project.addMapLayer(ecobois, False)
enregistrer(ecobois, os.path.join(VECTEUR, "communes-ecobois.gpkg"), "communes_ecobois")

# fragments voisins : points créés depuis le CSV
frag = QgsVectorLayer("Point?crs=EPSG:32738&field=nom:string&field=statut:string", "Fragments", "memory")
with open(os.path.join(TRAITE, "tables", "fragments-forestiers-approx.csv"), encoding="utf-8") as fh:
    for ligne in csv.DictReader(fh):
        nv = QgsFeature(frag.fields())
        nv.setGeometry(QgsGeometry.fromPointXY(QgsPointXY(float(ligne["x_utm38s"]), float(ligne["y_utm38s"]))))
        nv.setAttributes([ligne["nom"], ligne["statut"]])
        frag.dataProvider().addFeature(nv)
frag.updateExtents()
project.addMapLayer(frag, False)
enregistrer(frag, os.path.join(VECTEUR, "fragments-forestiers-approx.gpkg"), "fragments_forestiers_approx")

# ville : centre de la commune de Manakara
ville = QgsVectorLayer("Point?crs=EPSG:4326&field=nom:string", "Ville", "memory")
for ft in communes.getFeatures():
    if ft["ADM3_EN"] == "Manakara" and ft["ADM2_EN"] == "Manakara Atsimo":
        nv = QgsFeature(ville.fields())
        nv.setGeometry(ft.geometry().centroid())
        nv.setAttributes(["Manakara"])
        ville.dataProvider().addFeature(nv)
project.addMapLayer(ville, False)

# --- Styles ---------------------------------------------------------------
pays.setRenderer(QgsSingleSymbolRenderer(fill(BLANC, NOIR, "0.3")))
region.setRenderer(QgsSingleSymbolRenderer(fill(GRIS_CLAIR, NOIR, "0.6")))
region_contour.setRenderer(QgsSingleSymbolRenderer(fill(TRANSPARENT, NOIR, "0.6")))
ecobois.setRenderer(QgsSingleSymbolRenderer(hachures()))
districts.setRenderer(QgsSingleSymbolRenderer(fill(TRANSPARENT, NOIR, "0.35", "dash")))
communes.setRenderer(QgsSingleSymbolRenderer(fill(TRANSPARENT, GRIS_FONCE, "0.1", "dot")))
fmt_district = texte(TAILLE, italique=True)
fmt_district.setCapitalization(Qgis.Capitalization.AllUppercase)
etiq_d = QgsPalLayerSettings()
etiq_d.fieldName = "ADM2_EN"
etiq_d.setFormat(fmt_district)
etiq_d.placement = QgsPalLayerSettings.Placement.Horizontal
districts.setLabeling(QgsVectorLayerSimpleLabeling(etiq_d))
districts.setLabelsEnabled(True)
foret.setRenderer(QgsSingleSymbolRenderer(fill(NOIR, NOIR, "0.2")))

# la forêt a 5 polygones : n'étiqueter que le plus grand
etiqueter(foret, "CASE WHEN \"aire_ha_de\" > 400 THEN 'Tsiazombazaha' END",
          texte(TAILLE, gras=True), 1.5, expression=True)
foret.labeling().settings().centroidWhole = True

frag.setRenderer(QgsSingleSymbolRenderer(QgsMarkerSymbol.createSimple({
    "name": "circle", "color": "0,0,0,0", "outline_style": "no", "size": "1"})))
arbre = QgsSvgMarkerSymbolLayer(SVG_ARBRE, 5.0)
arbre.setFillColor(QColor(0, 0, 0))
arbre.setStrokeColor(QColor(255, 255, 255))
arbre.setStrokeWidth(0.3)
frag.renderer().symbol().changeSymbolLayer(0, arbre)
etiqueter(frag, "nom", texte(TAILLE, italique=True), 2.0)

ville.setRenderer(QgsSingleSymbolRenderer(QgsMarkerSymbol.createSimple({
    "name": "circle", "color": NOIR, "outline_color": BLANC, "outline_width": "0.3", "size": "2.4"})))
etiqueter(ville, "nom", texte(TAILLE), 1.5)

# --- Mise en page ---------------------------------------------------------
LARGEUR_PAGE, HAUTEUR_PAGE = 170, 200      # mm ; 170 mm = largeur du texte du rapport
X_CARTE, Y_CARTE, L_CARTE, H_CARTE = 8, 8, 100, 184
X0 = 114                                    # colonne de droite : 114 -> 166 mm
L_COL = 52
XC = X0 + L_COL / 2                         # axe de la colonne
ECHELLE = 550000

manager = project.layoutManager()
layout = QgsPrintLayout(project)
layout.initializeDefaults()
layout.setName("Carte 1 - localisation")
manager.addLayout(layout)
layout.pageCollection().page(0).setPageSize(
    QgsLayoutSize(LARGEUR_PAGE, HAUTEUR_PAGE, Qgis.LayoutUnit.Millimeters))


def rect_utm(lon0, lat0, lon1, lat1):
    t = QgsCoordinateTransform(WGS, UTM, project)
    return t.transformBoundingBox(QgsRectangle(lon0, lat0, lon1, lat1))


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


# carte principale
carte = QgsLayoutItemMap(layout)
carte.attemptMove(mm(X_CARTE, Y_CARTE))
carte.attemptResize(taille(L_CARTE, H_CARTE))
carte.setCrs(UTM)
carte.setLayers([frag, ville, foret, region_contour, districts, communes, ecobois, region, pays])
carte.setBackgroundColor(QColor(235, 235, 235))      # mer en gris très clair
carte.setFrameEnabled(True)
carte.setFrameStrokeWidth(QgsLayoutMeasurement(0.4))
carte.zoomToExtent(QgsRectangle(797000 - 30000, 7589000 - 50000, 797000 + 30000, 7589000 + 50000))
carte.setScale(ECHELLE)
layout.addLayoutItem(carte)

# graticule en degrés (WGS84)
grille = QgsLayoutItemMapGrid("Graticule", carte)
grille.setCrs(WGS)
grille.setIntervalX(0.1)
grille.setIntervalY(0.1)
grille.setStyle(QgsLayoutItemMapGrid.GridStyle.FrameAnnotationsOnly)
grille.setFrameStyle(QgsLayoutItemMapGrid.FrameStyle.Zebra)
grille.setFrameWidth(1.6)
grille.setFramePenSize(0.2)
grille.setFrameFillColor1(QColor(0, 0, 0))
grille.setFrameFillColor2(QColor(255, 255, 255))
grille.setAnnotationEnabled(True)
grille.setAnnotationTextFormat(texte(TAILLE_GRATICULE, halo=False))
grille.setAnnotationPrecision(1)
grille.setAnnotationFormat(QgsLayoutItemMapGrid.AnnotationFormat.DecimalWithSuffix)
grille.setAnnotationPosition(QgsLayoutItemMapGrid.AnnotationPosition.OutsideMapFrame, QgsLayoutItemMapGrid.BorderSide.Left)
grille.setAnnotationPosition(QgsLayoutItemMapGrid.AnnotationPosition.OutsideMapFrame, QgsLayoutItemMapGrid.BorderSide.Bottom)
grille.setAnnotationDisplay(QgsLayoutItemMapGrid.DisplayMode.LatitudeOnly, QgsLayoutItemMapGrid.BorderSide.Left)
grille.setAnnotationDisplay(QgsLayoutItemMapGrid.DisplayMode.LongitudeOnly, QgsLayoutItemMapGrid.BorderSide.Bottom)
grille.setAnnotationDisplay(QgsLayoutItemMapGrid.DisplayMode.HideAll, QgsLayoutItemMapGrid.BorderSide.Right)
grille.setAnnotationDisplay(QgsLayoutItemMapGrid.DisplayMode.HideAll, QgsLayoutItemMapGrid.BorderSide.Top)
grille.setAnnotationDirection(QgsLayoutItemMapGrid.AnnotationDirection.Vertical, QgsLayoutItemMapGrid.BorderSide.Left)
grille.setAnnotationFrameDistance(1.2)
carte.grids().addGrid(grille)

# encart Madagascar : même région grise que sur la carte principale
H_ENCART = 58
inset = QgsLayoutItemMap(layout)
inset.attemptMove(mm(X0, Y_CARTE))
inset.attemptResize(taille(L_COL, H_ENCART))
inset.setCrs(UTM)
inset.setLayers([region, pays])
inset.setBackgroundColor(QColor(255, 255, 255))
inset.setFrameEnabled(True)
inset.zoomToExtent(rect_utm(42.4, -26.0, 51.2, -11.6))
layout.addLayoutItem(inset)
vue = QgsLayoutItemMapOverview("emprise", inset)
vue.setLinkedMap(carte)
vue.setFrameSymbol(QgsFillSymbol.createSimple({"color": TRANSPARENT, "outline_color": NOIR, "outline_width": "0.5"}))
inset.overviews().addOverview(vue)

# flèche du nord et barre d'échelle : centrées sur l'axe de la colonne
# (décalages mesurés sur l'export : marge interne des éléments)
Y_NORD = Y_CARTE + H_ENCART + 10
nord = QgsLayoutItemPicture(layout)
nord.setPicturePath(":/images/north_arrows/layout_default_north_arrow.svg")
nord.attemptMove(mm(XC - 6 + 1.6, Y_NORD))
nord.attemptResize(taille(12, 12))
nord.setLinkedMap(carte)
layout.addLayoutItem(nord)

Y_ECHELLE = Y_NORD + 12 + 12
LONGUEUR_BARRE_KM = 20
largeur_barre_mm = LONGUEUR_BARRE_KM * 1000 / ECHELLE * 1000
echelle = QgsLayoutItemScaleBar(layout)
echelle.setLinkedMap(carte)
echelle.setStyle("Single Box")
echelle.setUnits(Qgis.DistanceUnit.Kilometers)
echelle.setNumberOfSegments(2)
echelle.setNumberOfSegmentsLeft(0)
echelle.setUnitsPerSegment(LONGUEUR_BARRE_KM / 2)
echelle.setUnitLabel("km")
echelle.setFont(QFont(FONT, TAILLE))
echelle.setBackgroundEnabled(False)
DECALAGE_BARRE = float(os.environ.get("DECALAGE_BARRE", "1.9"))
echelle.attemptMove(mm(XC - largeur_barre_mm / 2 - DECALAGE_BARRE, Y_ECHELLE))
layout.addLayoutItem(echelle)

# --- Légende manuelle ----------------------------------------------------
y = Y_ECHELLE + 11 + 6

Shape = QgsLayoutItemShape.Shape


def forme(kind, x, yy, w, h, symbole):
    it = QgsLayoutItemShape(layout)
    it.setShapeType(kind)
    it.attemptMove(mm(x, yy))
    it.attemptResize(taille(w, h))
    it.setSymbol(symbole)
    layout.addLayoutItem(it)


def trait(x, yy, longueur, style, epaisseur):
    forme(Shape.Rectangle, x, yy, longueur, 0.01,
          fill(TRANSPARENT, NOIR, epaisseur, style))


def retour_ligne(txt, largeur_mm, pt=TAILLE):
    """Coupe `txt` en lignes de `largeur_mm` au plus (mesure avec la police du rapport)."""
    f = QFont(FONT)
    f.setPointSizeF(pt)
    fm = QFontMetricsF(f)
    larg = lambda t: fm.horizontalAdvance(t) * 25.4 / 96
    lignes, courante = [], ""
    for mot in txt.split():
        essai = (courante + " " + mot).strip()
        if larg(essai) <= largeur_mm or not courante:
            courante = essai
        else:
            lignes.append(courante)
            courante = mot
    lignes.append(courante)
    return lignes


# (texte, type)
entrees = [
    ("Tsiazombazaha", "foret"),
    ("Région Fitovinany", "region"),
    ("Commune du périmètre EcoBois", "ecobois"),
    ("Autre forêt naturelle", "arbre"),
    ("Ville", "ville"),
    ("Limite de district", "district"),
    ("Limite de commune", "commune"),
]
for nom, kind in entrees:
    parts = retour_ligne(nom, L_COL - 9)
    nom = "\n".join(parts)
    h_txt = 5.3 * len(parts)
    if kind == "foret":
        forme(Shape.Rectangle, X0, y + 0.3, 7, 4, fill(NOIR, NOIR, "0.2"))
    elif kind == "region":
        forme(Shape.Rectangle, X0, y + 0.3, 7, 4, fill(GRIS_CLAIR, NOIR, "0.6"))
    elif kind == "ecobois":
        forme(Shape.Rectangle, X0, y + 0.3, 7, 4, hachures())
    elif kind == "arbre":
        pic = QgsLayoutItemPicture(layout)
        pic.setPicturePath(SVG_ARBRE)
        pic.setSvgFillColor(QColor(0, 0, 0))
        pic.setSvgStrokeColor(QColor(255, 255, 255))
        pic.setSvgStrokeWidth(0.3)
        pic.attemptMove(mm(X0 + 1.5, y + 0.2))
        pic.attemptResize(taille(4, 4.4))
        layout.addLayoutItem(pic)
    elif kind == "ville":
        forme(Shape.Ellipse, X0 + 2, y + 0.8, 3, 3, fill(NOIR, NOIR, "0.1"))
    elif kind == "district":
        trait(X0, y + 2.3, 7, "dash", "0.35")
    elif kind == "commune":
        trait(X0, y + 2.3, 7, "dot", "0.15")
    etiquette(nom, X0 + 9, y, L_COL - 8, h_txt + 0.6)
    y += h_txt + 2.4

# distances (km) entre le centre du massif et les autres forêts, en UTM 38 S
massif = max(next(foret.getFeatures()).geometry().asGeometryCollection(), key=lambda g: g.area()).centroid()
massif = QgsGeometry(massif)   # la couche du massif est déjà en UTM 38 S
for ft in frag.getFeatures():
    d = massif.distance(ft.geometry()) / 1000
    print(f"Distance Tsiazombazaha -> {ft['nom']} : {d:.1f} km")

# --- Exports --------------------------------------------------------------
for chemin in (OUT_PNG, OUT_SVG, OUT_QGZ):
    os.makedirs(os.path.dirname(chemin), exist_ok=True)
exp = QgsLayoutExporter(layout)
img = QgsLayoutExporter.ImageExportSettings()
img.dpi = 300
print("PNG", exp.exportToImage(OUT_PNG, img))
svg = QgsLayoutExporter.SvgExportSettings()
svg.dpi = 300
print("SVG", exp.exportToSvg(OUT_SVG, svg))
# PDF puis conversion en SVG aplati (poppler) : le SVG natif de QGIS est mal
# rendu par Typst (hachures débordantes), celui-ci non.
OUT_PDF = OUT_SVG.replace(".svg", ".pdf")
pdf = QgsLayoutExporter.PdfExportSettings()
pdf.dpi = 300
print("PDF", exp.exportToPdf(OUT_PDF, pdf))
OUT_SVG_TYPST = os.path.join(BASE, "..", "05-rapport", "images", "carte-localisation.svg")
subprocess.run(["pdftocairo", "-svg", OUT_PDF, OUT_SVG_TYPST], check=True)
project.write(OUT_QGZ)
print("Fin légende y =", round(y, 1), "mm (page", HAUTEUR_PAGE, ")")
app.exitQgis()
