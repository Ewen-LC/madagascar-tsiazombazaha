# analyse-transects.R
# Ewen Le Coeur
# 2026
# Objectif : indicateurs releves le long des transects — densite des grands
# arbres (CBH >= 126 cm) a l'hectare avec son erreur-type, et denombrement
# des chablis par classe.
#
# Grands arbres : bande de 10 m (5 m de part et d'autre du chemin) sur les
# transects dont la longueur prospectee est connue (transects.csv). Les
# arbres de CBH < 126 cm (reliquats d'un seuil anterieur) et les lignes
# sans circonference (arbre mort « hors calculs », lignes incompletes) sont
# exclus. La densite est un estimateur par le ratio (effectif total /
# surface totale) ; son erreur-type est celle de l'estimateur par le ratio
# entre transects (Cochran, 1977, chap. 6).
#
# Chablis : PROVISOIRE. Seuls les effectifs par transect et par classe
# (PB < 30, BM 30-60, GB > 60) sont exportes ; les longueurs prospectees
# ne sont pas encore connues, donc aucune densite n'est calculee.
#
# Sorties :
#   - sorties/transects-grands-arbres.csv : effectif, longueur et densite
#     par transect ;
#   - sorties/transects-grands-arbres-resume.csv : densite globale (arbres/ha)
#     et erreur-type ;
#   - sorties/transects-chablis.csv : effectifs par transect et par classe ;
#   - sorties/transects-grands-arbres-classes-n.csv : densite (arbres/ha) par
#     classe de diametre de 2,5 cm (memes classes que les placettes) ;
#   - sorties/transects-grands-arbres-classes-g.csv : surface terriere (m2/ha)
#     par classe de diametre de 5 cm a partir de 2,5 cm.
#   Densites et surfaces terrieres par classe : effectif (ou somme des g) de
#   tous les transects rapporte a la surface totale prospectee (approche du
#   dispositif, comme la densite globale), avec l'erreur-type de l'estimateur
#   par le ratio entre transects, classe par classe (05/11/2026).
#
# Utilisation :
#   source("03-scripts/analyse-transects.R")

### Modules ###

library(dplyr)
library(stringr)
library(readr)

### Import des donnees ###

dossierDonnees <- "02-donnees/ecologie"
dossierSorties <- "04-sorties"

transects <- read_csv(file.path(dossierDonnees, "transects.csv"),
                      col_types = cols(.default = col_character())) |>
  transmute(cdTransect = transect,
            longueur_m = suppressWarnings(
              as.numeric(`longueur-prospection-grands-arbres`))) |>
  filter(!is.na(longueur_m))

grandsArbres <- read_csv(file.path(dossierDonnees, "grands-arbres.csv"),
                         col_types = cols(.default = col_character())) |>
  transmute(cdTransect = transect,
            circ_cm = suppressWarnings(as.numeric(circonference))) |>
  filter(!is.na(cdTransect), !is.na(circ_cm), circ_cm >= 126)

chablis <- read_csv(file.path(dossierDonnees, "chablis.csv"),
                    col_types = cols(.default = col_character()))

### Grands arbres ###

largeurBande_m <- 10

parTransect <- transects |>
  left_join(grandsArbres |> count(cdTransect, name = "nbArbres"),
            by = "cdTransect") |>
  mutate(nbArbres = coalesce(nbArbres, 0L),
         surface_m2 = longueur_m * largeurBande_m,
         densite_ha = nbArbres / surface_m2 * 10000)

m <- nrow(parTransect)
ratio <- sum(parTransect$nbArbres) / sum(parTransect$surface_m2)
s2 <- sum((parTransect$nbArbres - ratio * parTransect$surface_m2)^2) / (m - 1)
erreurTypeRatio <- sqrt(s2 / m) / mean(parTransect$surface_m2)

resumeGA <- tibble(
  nbTransects = m,
  nbArbres = sum(parTransect$nbArbres),
  longueurTotale_m = sum(parTransect$longueur_m),
  surfaceTotale_m2 = sum(parTransect$surface_m2),
  densite_ha = ratio * 10000,
  erreurType_ha = erreurTypeRatio * 10000
)

### Grands arbres par classe de diametre ###

# DBH = CBH / pi ; g = pi / 4 * (DBH / 100)^2 (meme formule que fonctions-structure.R)
grandsArbresTransects <- grandsArbres |>
  filter(cdTransect %in% parTransect$cdTransect) |>
  mutate(dbh_cm = circ_cm / pi,
         g_m2 = pi / 4 * (dbh_cm / 100)^2)

surfaceTotaleGA_m2 <- sum(parTransect$surface_m2)

classesN_GA <- grandsArbresTransects |>
  mutate(classeDiam = floor(dbh_cm / 2.5) * 2.5) |>
  group_by(classeDiam) |>
  summarise(nbArbres = n(), .groups = "drop") |>
  mutate(N_ha = nbArbres / surfaceTotaleGA_m2 * 10000)

classesG_GA <- grandsArbresTransects |>
  mutate(borneInf = 2.5 + floor((dbh_cm - 2.5) / 5) * 5,
         borneSup = borneInf + 5) |>
  group_by(borneInf, borneSup) |>
  summarise(nbArbres = n(), G_m2 = sum(g_m2), .groups = "drop") |>
  mutate(G_ha = G_m2 / surfaceTotaleGA_m2 * 10000)

# Erreur-type par classe : meme estimateur par le ratio entre transects que
# pour la densite globale (Cochran, 1977, chap. 6), sur la grille complete
# transects x classes (0 pour un transect sans arbre de la classe)
# (demande de l'auteur, 05/11/2026)
erreurTypeRatioClasse <- function(y, x) {
  r <- sum(y) / sum(x)
  sqrt(sum((y - r * x)^2) / (length(y) - 1) / length(y)) / mean(x)
}
erreurTypeParClasse <- function(parTransectClasse, colClasse, colValeur) {
  tidyr::expand_grid(cdTransect = parTransect$cdTransect,
                     classe = unique(parTransectClasse[[colClasse]])) |>
    left_join(parTransectClasse |>
                rename(classe = all_of(colClasse), valeur = all_of(colValeur)),
              by = c("cdTransect", "classe")) |>
    mutate(valeur = coalesce(valeur, 0)) |>
    left_join(parTransect |> select(cdTransect, surface_m2), by = "cdTransect") |>
    group_by(classe) |>
    summarise(erreurType_ha = erreurTypeRatioClasse(valeur, surface_m2) * 10000,
              .groups = "drop") |>
    rename(!!colClasse := classe)
}
classesN_GA <- classesN_GA |>
  left_join(erreurTypeParClasse(
    grandsArbresTransects |>
      mutate(classeDiam = floor(dbh_cm / 2.5) * 2.5) |>
      count(cdTransect, classeDiam, name = "nbArbres"),
    "classeDiam", "nbArbres"), by = "classeDiam")
classesG_GA <- classesG_GA |>
  left_join(erreurTypeParClasse(
    grandsArbresTransects |>
      mutate(borneInf = 2.5 + floor((dbh_cm - 2.5) / 5) * 5) |>
      group_by(cdTransect, borneInf) |>
      summarise(G_m2 = sum(g_m2), .groups = "drop"),
    "borneInf", "G_m2"), by = "borneInf")

# Surface terriere cumulee des grands arbres, rapportee a la surface prospectee
# (demande de l'auteur, 04/11/2026)
resumeGA <- resumeGA |>
  mutate(G_m2_ha = sum(grandsArbresTransects$g_m2) / surfaceTotaleGA_m2 * 10000)

### Chablis (provisoire) ###

chablisEffectifs <- chablis |>
  transmute(
    cdTransect = transect,
    nombre = suppressWarnings(as.numeric(`nombre-chablis`)),
    classe = str_trim(str_remove(remarques, "/!\\\\.*$"))
  ) |>
  filter(!is.na(nombre))

### Exports ###

write_csv(parTransect, file.path(dossierSorties, "transects-grands-arbres.csv"))
write_csv(resumeGA, file.path(dossierSorties,
                              "transects-grands-arbres-resume.csv"))
write_csv(chablisEffectifs, file.path(dossierSorties, "transects-chablis.csv"))
write_csv(classesN_GA, file.path(dossierSorties,
                                 "transects-grands-arbres-classes-n.csv"))
write_csv(classesG_GA, file.path(dossierSorties,
                                 "transects-grands-arbres-classes-g.csv"))

message("✅ Grands arbres : ", resumeGA$nbArbres, " arbres sur ",
        resumeGA$longueurTotale_m, " m (", m, " transects) ; densite = ",
        round(resumeGA$densite_ha, 2), " ± ", round(resumeGA$erreurType_ha, 2),
        " arbres/ha (erreur-type)")
message("⚠️ Chablis : effectifs seulement (longueurs prospectees inconnues)")
