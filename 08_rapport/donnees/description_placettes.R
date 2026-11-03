# description_placettes.R
# Ewen Le Coeur
# 2026
# Objectif : decrire qualitativement les caracteristiques des 28 placettes
# (pente, recouvrement de la canopee, strates,
# humus, humidite du sol, epiphytes, mousses, lichens, lianes, champignons) :
# nombre de placettes par classe, et tableau par placette pour l'annexe.
#
# Entree : 06_ecologie/analyse/donnees/placettes.csv (la colonne « remarques »
# n'est pas reprise).
#
# Conventions :
#   - recouvrement de la canopee : classe notee dans chacun des quatre quadrants
#     (nord, est, sud, ouest) ; le resume compte les quadrants (28 x 4 = 112),
#     sans moyenne entre classes ;
#   - humus : graphies harmonisees (espaces autour de « / ») ; « ? » =
#     « Non déterminé » ; les formes doubles (ex. Dysmull / Oligomull) sont
#     gardees telles quelles ;
#   - epiphytes, mousses, lichens, lianes, champignons : nombre d'arbres porteurs
#     en trois classes (0-2, 3-10, > 10) ; non note = « NA » ;
#   - situation topographique : non reprise (notee sur 6 placettes seulement,
#     colonne retiree a la demande de l'auteur, 03/11/2026).
#
# Sorties (08_rapport/redaction-typst/analyse-tables/) :
#   - placettes_caracteristiques_resume.csv : variable, classe, nombre de
#     placettes (ou de quadrants pour la canopee) ;
#   - placettes_caracteristiques.csv : une ligne par placette.
#
# Utilisation (depuis la racine du depot) :
#   source("08_rapport/donnees/description_placettes.R")

### Modules ###

library(dplyr)
library(tidyr)
library(stringr)
library(readr)

### Import des donnees ###

dossierSorties <- "08_rapport/redaction-typst/analyse-tables"

placettes <- read_csv(
  "06_ecologie/analyse/donnees/placettes.csv",
  col_types = cols(.default = col_character()),
  col_select = -remarques
)

classesPorteurs <- c("0-2", "3-10", ">10", "NA")
classesCanopee <- c("0-25", "25-50", "50-75", "75-100")

### Preparation ###

placettes <- placettes |>
  mutate(
    pente = as.numeric(`pente-pourcent`),
    humus = str_squish(str_replace_all(humus, "\\s*/\\s*", " / ")),
    humus = if_else(humus %in% c("?", "") | is.na(humus), "Non déterminé", humus),
    humidite = if_else(is.na(`humidite-sol`), "Non notée", `humidite-sol`),
    across(c(`nb-epiphytes`, `nb-mousses`, `nb-lichens`, `nb-lianes`, `nb-champignons`),
           ~ if_else(is.na(.x), "NA", .x)),
    strates = str_remove(paste0(
      if_else(`presence-strate-herbacee` == "1", ", H", ""),
      if_else(`presence-strate-sous-etage` == "1", ", A", ""),
      if_else(`presence-strate-canopee-inf` == "1", ", Ci", ""),
      if_else(`presence-strate-canopee-sup` == "1", ", Cs", "")
    ), "^, ")
  )

### Resume (nombre de placettes par classe) ###

compter <- function(d, var, libelle, niveaux = NULL) {
  t <- d |> count(classe = {{ var }}, name = "nombre")
  if (!is.null(niveaux)) t <- t |> arrange(match(classe, niveaux)) else t <- t |> arrange(desc(nombre), classe)
  t |> mutate(variable = libelle, unite = "placettes", .before = 1)
}

canopee <- placettes |>
  select(placette, starts_with("recouvrement-canopee")) |>
  pivot_longer(-placette, values_to = "classe") |>
  count(classe, name = "nombre") |>
  arrange(match(classe, classesCanopee)) |>
  mutate(classe = paste(classe, "%"), variable = "Recouvrement de la canopée (quadrants)",
         unite = "quadrants", .before = 1)

strates <- tibble(
  variable = "Strates présentes", unite = "placettes",
  classe = c("Herbacée (0 à 2 m)", "Sous-bois ou arbustive (2 à 10 m)",
             "Canopée inférieure (10 à 20 m)", "Canopée supérieure (> 20 m)"),
  nombre = c(sum(placettes$`presence-strate-herbacee` == "1"),
             sum(placettes$`presence-strate-sous-etage` == "1"),
             sum(placettes$`presence-strate-canopee-inf` == "1"),
             sum(placettes$`presence-strate-canopee-sup` == "1"))
)

pente <- tibble(
  variable = "Pente (%)", unite = "placettes",
  classe = c("Minimum", "Médiane", "Maximum"),
  nombre = c(min(placettes$pente), median(placettes$pente), max(placettes$pente))
)

resume <- bind_rows(
  pente,
  canopee,
  strates,
  compter(placettes, humus, "Humus"),
  compter(placettes, humidite, "Humidité du sol"),
  compter(placettes, `nb-epiphytes`, "Épiphytes (arbres porteurs)", classesPorteurs),
  compter(placettes, `nb-mousses`, "Mousses (arbres porteurs)", classesPorteurs),
  compter(placettes, `nb-lichens`, "Lichens (arbres porteurs)", classesPorteurs),
  compter(placettes, `nb-lianes`, "Lianes (arbres porteurs)", classesPorteurs),
  compter(placettes, `nb-champignons`, "Champignons (arbres porteurs)", classesPorteurs)
)

### Tableau par placette ###

parPlacette <- placettes |>
  transmute(
    placette, transect, pente,
    canopee = paste(`recouvrement-canopee-quart-nord`, `recouvrement-canopee-quart-est`,
                    `recouvrement-canopee-sud`, `recouvrement-canopee-quart-ouest`, sep = " / "),
    strates, humus, humidite,
    epiphytes = `nb-epiphytes`, mousses = `nb-mousses`, lichens = `nb-lichens`,
    lianes = `nb-lianes`, champignons = `nb-champignons`
  )

### Export ###

write_csv(resume, file.path(dossierSorties, "placettes_caracteristiques_resume.csv"))
write_csv(parPlacette, file.path(dossierSorties, "placettes_caracteristiques.csv"))

message("✅ Caracteristiques des placettes : ", nrow(placettes), " placettes")
