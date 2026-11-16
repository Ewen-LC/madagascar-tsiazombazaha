# madagascar-tsiazombazaha

Dépôt du stage de fin d'études d'Ewen Le Coeur (ingénieur forestier, AgroParisTech) pour l'ONG Inter Aide, réalisé à Manakara (Madagascar) du 15/04/2026 au 14/10/2026 : diagnostic écologique et social de la forêt tropicale humide de Tsiazombazaha.

## Contenu

| Dossier | Contenu |
|---|---|
| `01-methodologie/` | Fiche de relevés de l'inventaire forestier et canevas d'entretien. |
| `02-donnees/ecologie/` | Données de terrain nettoyées, une table par type d'observation (placettes, flore, transects, grands arbres, chablis, bois mort, phénologie, observations hors placettes, faune et activités humaines), saisie d'origine et données de Romiguière (2025). |
| `02-donnees/referentiels/` | Tables de correspondance : réconciliation taxonomique, normalisation des usages, classification de Cook, listes issues du transfert de gestion de 2004 et de Rajaonson et al. (2010). |
| `02-donnees/social/` | Métadonnées anonymisées des personnes rencontrées. |
| `02-donnees/estimations-surface-forestiere.csv` | Estimations publiées de la surface forestière de Madagascar. |
| `03-scripts/` | Scripts R d'analyse (voir `03-scripts/README.md`). |
| `04-sorties/` | Tables et figures produites par les scripts. |
| `05-rapport/` | Sources Typst du mémoire, bibliographie (`bibliographie.yml`), images et mémoire au format PDF. |
| `06-geomatique/` | Projet SIG des cartes du mémoire : données brutes (traces GPS, limites administratives, extraits Sentinel-2, Vieilledent et al. 2018, Hansen et al. 2013), couches traitées, scripts PyQGIS, cartes exportées et projets QGIS (voir `06-geomatique/README.md`). |

## Reproduire les analyses

Les scripts R se lancent depuis la racine du dépôt (voir `03-scripts/README.md`).

Les cartes se régénèrent avec les scripts PyQGIS de `06-geomatique/03-analyses/scripts/` (voir `06-geomatique/README.md`).

## Compiler le mémoire

```bash
cd 05-rapport
typst compile main.typ
```

## Données exclues

Les transcriptions d'entretiens, les notes de sorties et les données nominatives ne sont pas diffusées, conformément à l'anonymat promis aux personnes rencontrées.

## Licence

Creative Commons Zero v1.0 Universal (voir `LICENSE`).
