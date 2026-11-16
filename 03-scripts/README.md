# Scripts R

Tous les scripts se lancent depuis la racine du dépôt, par exemple :

```r
source("03-scripts/analyse-structure-forestiere.R")
```

Ils lisent les données de `02-donnees/` et écrivent leurs résultats dans `04-sorties/`, sauf mention contraire. Paquets utilisés : dplyr, ggplot2, ggrepel, iNEXT, readr, scales, stringr, svglite, tibble, tidyr, vegan.

## Ordre de lancement conseillé

| Script | Rôle |
|---|---|
| `analyse-structure-forestiere.R` | Densité, surface terrière et distribution par classes de diamètre, avec intervalles de confiance. |
| `analyse-transects.R` | Grands arbres et chablis relevés le long des transects. |
| `analyse-carbone.R` | Stocks de carbone par compartiment (tiges vivantes, grands arbres, bois mort). |
| `analyse-diversite-alpha.R` | Richesse, Shannon, Simpson inverse et alpha de Fisher par placette. |
| `analyse-diversite-beta.R` | Dissimilarités entre placettes (Jaccard), bêta de Whittaker, NMDS. |
| `estimation-richesse-specifique.R` | Courbe de raréfaction-extrapolation (iNEXT) et estimateurs de richesse totale. |
| `analyse-ivi.R` | Indice de valeur d'importance des espèces. |
| `analyse-regeneration.R` | Densité de la régénération de moins de 1,30 m. |
| `analyse-seuil-diametre.R` | Apport de l'abaissement du seuil de mesure du diamètre. |
| `analyse-usages-cook.R` | Nombre d'espèces par catégorie d'usage (classification de Cook, 1995). |
| `analyse-sensibilite-romiguiere.R` | Sensibilité de G et du stock de carbone à l'ajout des tiges de Romiguière (2025). À lancer après `analyse-transects.R` et `analyse-carbone.R`, dont il lit les sorties. |

## Scripts du rapport

| Script | Rôle |
|---|---|
| `description-placettes.R` | Caractéristiques qualitatives des placettes ; écrit dans `05-rapport/analyse-tables/`. |
| `description-echantillon-social.R` | Description anonyme de l'échantillon social ; lit `02-donnees/social/` et écrit dans `05-rapport/analyse-tables/`. |
| `figure-estimations-surface-forestiere.R` | Figure des estimations publiées de la surface forestière de Madagascar ; écrit dans `05-rapport/analyse-figures/`. |

## Sous-dossiers

- `fonctions/` : fonctions partagées (diversité, structure, aire-espèce), sourcées par les scripts, jamais lancées seules.
- `scripts-a-ne-pas-relancer/` : script de consolidation de la liste des espèces, conservé pour référence. Il dépend d'un arbitrage taxonomique manuel déjà reporté dans `02-donnees/referentiels/reconciliation-taxonomique.csv`.
- `proposer-correspondance-romiguiere.R` : outil d'aide à la correspondance entre les noms relevés par Romiguière (2025) et ceux de l'étude ; ses propositions ont été arbitrées à la main dans `02-donnees/referentiels/`.
