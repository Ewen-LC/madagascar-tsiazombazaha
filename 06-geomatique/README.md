# Géomatique : cartes du rapport (forêt de Tsiazombazaha, 2026)

Cartes 1 à 4 du rapport et données qui les produisent. Projection de travail : UTM 38 S (EPSG:32738).

## Relancer

Depuis `scripts/` (PyQGIS ≥ 3.40, GDAL/Python avec `numpy` et `Pillow`, `pdftocairo`) :

```bash
QT_QPA_PLATFORM=offscreen PYTHONPATH=/usr/share/qgis/python python3 carte1-localisation.py
```

| Script | Produit | Entrées principales |
|---|---|---|
| `estimation-foret-2026-sentinel2.py` | `foret-2026-sentinel2-perimetre.gpkg`, `foret-2026-sentinel2-seuils.csv`, `controle-sentinel2-2026.png` | extraits Sentinel-2, Vieilledent, Hansen, périmètre du VOI |
| `carte1-localisation.py` | carte 1 (localisation) | limites administratives, `communes-ecobois`, `region-fitovinany`, `fragments-forestiers-approx`, forêt 2026 |
| `carte2-territoire.py` | carte 2 (territoire) | limites administratives (communes, fokontany), périmètre du VOI, forêt 2026 |
| `carte3-echantillonnage.py` | carte 3 (placettes et itinéraires) | traces et points GPS, périmètre du VOI, forêt 2026 ; écrit `placettes-coordonnees.csv` |
| `carte4-couvert-forestier.py` | carte 4 (couvert 1973-2025), tableaux de surfaces | extraits Vieilledent et Hansen, fokontany, périmètre du VOI ; écrit `couvert-forestier-*.csv` et `couvert-forestier-periodes.gpkg` |

Ordre : `estimation-foret-2026-sentinel2.py` avant les cartes 1 à 3 (elles lisent sa couche). Sorties : `cartes/` (PNG 300 dpi, SVG, PDF) et `projets-qgis/` (`.qgz` réouvrables). Les SVG utilisés par le mémoire sont écrits directement dans `05-rapport/images/`.

## Données (`donnees-brutes/`)

| Fichier | Origine | Utilisation |
|---|---|---|
| `inter-aide/limites-transfert-gestion.gpkg` | VOI Maharitra (2025), transmis par Inter Aide | périmètre transféré et zones de droit d'usage |
| `terrain/traces/*.gpx` | traces GPS de l'auteur, 2026 | itinéraires (carte 3) |
| `terrain/waypoints-2026-09-18.gpx` | points GPS de l'auteur | emplacement des placettes (correspondance points-placettes à valider) |
| `sources-externes/limites-admin/` | OCHA et BNGRC (2018) : pays, districts, communes, fokontany | cartes 1, 2, 4 |
| `sources-externes/vieilledent-2018/for{1973,1990,2000,2010,2017}-tsiazombazaha.tif` | Vieilledent et al. (2018), mise à jour 2017, [Cirad Dataverse](https://doi.org/10.18167/DVN1/AUBRRC) ; extrait 24 × 20 km, 30 m | carte 4. Valeur 1 = forêt ; en 1973, 5 = non classé (nuages) |
| `sources-externes/hansen-gfc2025/lossyear-tsiazombazaha.tif` | Hansen et al. (2013), version GFC-2025-v1.13, tuile 20S_040E, rééchantillonné à 30 m sur la grille de Vieilledent | pertes 2018-2025 |
| `sources-externes/copernicus-2026-05-06/*-extrait.tif` | Sentinel-2 L2A, tuile T38KQA, 6 mai 2026 (B02, B03, B04, B08 à 10 m, SCL à 20 m) ; extrait de 8,4 × 9 km (801500-809900 E, 7570500-7579500 N) | classification de la forêt 2026 |

## Données traitées (`donnees-traitees/`)

- `couches/foret-2026-sentinel2-perimetre.gpkg` : forêt classifiée sur l'image de 2026, découpée au périmètre du VOI (indicative : le seuil détermine la surface).
- `couches/couvert-forestier-periodes.gpkg` : forêt 2025 et pertes par période, 1973-2025.
- `couches/communes-ecobois.gpkg`, `region-fitovinany.gpkg`, `fragments-forestiers-approx.gpkg` : couches de la carte 1 (la région Fitovinany est reconstituée à partir des districts de Manakara Atsimo, Vohipeno et Ikongo ; positions des fragments fournies par l'auteur).
- `tables/couvert-forestier-{surfaces,fokontany,communes}.csv` : surfaces de forêt par date et par période, dans le périmètre, par fokontany et par commune.
- `tables/foret-2026-sentinel2-seuils.csv` : surface forestière 2026 dans le périmètre selon le seuil de classification.
- `tables/placettes-coordonnees.csv` : coordonnées des 28 placettes.
- `tables/fragments-forestiers-approx.csv` : positions approximatives de Vorovoka, Lakia et Vatovavy.

## Limites connues

- 1973 : 3,3 Mha non classés à l'échelle de Madagascar ; la forêt de 1973 est sous-estimée dans ces zones (près d'un tiers des fokontany étudiés).
- Hansen et al. (2013) ne détecte que les pertes de couvert et peut les sous-estimer.
- Le seuil de la classification Sentinel-2 n'est pas calé sur des points de non-forêt relevés au sol.
