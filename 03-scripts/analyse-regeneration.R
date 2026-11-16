# analyse-regeneration.R
# Ewen Le Coeur
# 2026
# Objectif : densite de la regeneration de moins de 1,30 m de haut (tiges/m2),
# en deux classes de hauteur (moins de 30 cm ; de 30 a 130 cm), avec son
# erreur-type.
#
# La regeneration a ete denombree en plein, toutes especes confondues, sur
# les seules placettes P21 a P28 (hors P27) ; les placettes sans comptage
# (valeur manquante) sont exclues. La densite de chaque placette est rapportee
# a sa surface horizontale ; la moyenne est donnee entre placettes, avec
# l'ecart-type et l'erreur-type de la moyenne (meme approche par placette que
# la densite N du script de structure).
#
# Sorties :
#   - sorties/regeneration-placettes.csv : effectifs et densites par placette ;
#   - sorties/regeneration-resume.csv : moyenne, ecart-type et erreur-type
#     par classe de hauteur.
#
# Utilisation :
#   source("03-scripts/analyse-regeneration.R")

### Modules ###

library(dplyr)
library(tidyr)
library(readr)

### Import des donnees ###

dossierDonnees <- "02-donnees/ecologie"
dossierSorties <- "04-sorties"

placettes <- read_csv(file.path(dossierDonnees, "placettes.csv"),
                      col_types = cols(.default = col_character())) |>
  transmute(
    cdPlacette = placette,
    surfaceHorizontale_m2 = as.numeric(gsub(",", ".", `surface-horizontale`)),
    inf30 = suppressWarnings(as.numeric(`regeneration-inf-30`)),
    de30a130 = suppressWarnings(as.numeric(`regeneration-30-a-130`))
  )

### Densite par placette ###

regenerationPlacettes <- placettes |>
  pivot_longer(c(inf30, de30a130), names_to = "classe",
               values_to = "nbTiges") |>
  filter(!is.na(nbTiges)) |>
  mutate(
    classe = recode(classe, inf30 = "Moins de 30 cm",
                    de30a130 = "De 30 a 130 cm"),
    densite_m2 = nbTiges / surfaceHorizontale_m2
  )

### Resume par classe de hauteur ###

regenerationResume <- regenerationPlacettes |>
  group_by(classe) |>
  summarise(
    nbPlacettes = n(),
    nbTiges = sum(nbTiges),
    moyenne_m2 = mean(densite_m2),
    ecartType_m2 = sd(densite_m2),
    erreurType_m2 = sd(densite_m2) / sqrt(n()),
    .groups = "drop"
  ) |>
  arrange(desc(classe == "Moins de 30 cm"))

### Exports ###

write_csv(regenerationPlacettes,
          file.path(dossierSorties, "regeneration-placettes.csv"))
write_csv(regenerationResume,
          file.path(dossierSorties, "regeneration-resume.csv"))

message("✅ Regeneration (", paste(unique(regenerationPlacettes$cdPlacette),
                                   collapse = ", "), ") :")
for (i in seq_len(nrow(regenerationResume))) {
  message("   ", regenerationResume$classe[i], " : ",
          round(regenerationResume$moyenne_m2[i], 2), " ± ",
          round(regenerationResume$erreurType_m2[i], 2),
          " tiges/m2 (erreur-type, n = ",
          regenerationResume$nbPlacettes[i], ")")
}
