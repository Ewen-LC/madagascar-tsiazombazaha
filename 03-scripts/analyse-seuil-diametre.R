# analyse-seuil-diametre.R
# Ewen Le Coeur
# 2026
# Objectif : mesurer l'apport de l'abaissement du seuil de mesure (DBH de 5 a
# 2,5 cm) et des autres sources a la liste des especes. Les especes sont
# ajoutees dans un ordre fixe, chaque etape ne comptant que les especes
# absentes des etapes precedentes :
#   1. tiges des placettes de DBH >= 5 cm (seuil d'Armstrong et al., 2011) ;
#   2. tiges des placettes de 2,5 <= DBH < 5 cm (seuil de l'etude) ;
#   3. gaulis des placettes (plus de 1,30 m de haut, DBH < 2,5 cm, non mesures) ;
#   4. hors placettes : grands arbres des transects, observations hors releve
#      (autres-observations-flore.csv) et releves phenologiques.
# DBH = CBH / pi. Especes : identites reconciliees (rapprochement des noms
# bruts sans tenir compte de la casse) ; especes indeterminees exclues.
#
# Sorties :
#   - sorties/seuil-diametre-resume.csv : nombre total de tiges mesurees ;
#   - sorties/seuil-diametre-especes-nouvelles.csv : par etape, nombre de
#     tiges (ou d'observations), nombre d'especes presentes, d'especes
#     nouvelles et cumul.
#
# Utilisation :
#   source("03-scripts/analyse-seuil-diametre.R")

### Modules ###

library(dplyr)
library(tidyr)
library(stringr)
library(readr)

### Import des donnees ###

dossierDonnees <- "02-donnees/ecologie"
dossierReferentiels <- "02-donnees/referentiels"
dossierSorties <- "04-sorties"

lireCsv <- function(fichier) {
  read_csv(file.path(dossierDonnees, fichier),
           col_types = cols(.default = col_character()))
}

reconciliation <- read_csv(
  file.path(dossierReferentiels, "reconciliation-taxonomique.csv"),
  col_types = cols(.default = col_character())
) |>
  transmute(cle = str_to_lower(str_trim(`nom-vernaculaire-brut`)),
            espece = str_trim(`nom-vernaculaire-reconcilie`)) |>
  distinct(cle, .keep_all = TRUE)

flore <- lireCsv("flore.csv")

### Observations par etape ###

colsCirc <- intersect(c("Circ1", "Circ2", "Circ3", "Circ4", "Circ5", "Circ6",
                        "Cir7", "Circ8", "Circ9", "Cir10"), names(flore))

tiges <- flore |>
  select(nomBrut = `nom-vernaculaire-brut`, all_of(colsCirc)) |>
  pivot_longer(all_of(colsCirc), values_to = "circ_cm") |>
  mutate(circ_cm = suppressWarnings(as.numeric(circ_cm))) |>
  filter(!is.na(circ_cm)) |>
  mutate(dbh_cm = circ_cm / pi,
         etape = if_else(dbh_cm >= 5, "1. Tiges des placettes, DBH >= 5 cm",
                         "2. Tiges des placettes, 2,5 <= DBH < 5 cm"))

gaulis <- flore |>
  transmute(nomBrut = `nom-vernaculaire-brut`,
            nbGaulis = suppressWarnings(as.numeric(`nombre-gaulis`))) |>
  filter(!is.na(nbGaulis), nbGaulis > 0) |>
  mutate(etape = "3. Gaulis des placettes (DBH < 2,5 cm)")

horsPlacettes <- bind_rows(
  lireCsv("grands-arbres.csv") |> select(nomBrut = `nom-vernaculaire-brut`),
  lireCsv("autres-observations-flore.csv") |> select(nomBrut = `nom-vernaculaire-brut`),
  lireCsv("phenologie.csv") |> select(nomBrut = `nom-vernaculaire-brut`)
) |>
  mutate(etape = "4. Hors placettes (grands arbres, observations, phénologie)")

observations <- bind_rows(
  tiges |> select(nomBrut, etape) |> mutate(effectif = 1),
  gaulis |> select(nomBrut, etape, effectif = nbGaulis),
  horsPlacettes |> mutate(effectif = 1)
) |>
  mutate(cle = str_to_lower(str_trim(nomBrut))) |>
  left_join(reconciliation, by = "cle")

nomsNonReconcilies <- observations |>
  filter(is.na(espece), !is.na(nomBrut)) |>
  distinct(nomBrut)
if (nrow(nomsNonReconcilies) > 0) {
  message("⚠️ Noms bruts absents de la reconciliation (ignores) : ",
          paste(nomsNonReconcilies$nomBrut, collapse = ", "))
}

observations <- observations |>
  filter(!is.na(espece),
         str_to_lower(espece) != "espèce indéterminée",
         espece != "N/A")

### Especes nouvelles par etape ###

etapes <- sort(unique(observations$etape))
dejaVues <- character(0)
resultat <- lapply(etapes, function(e) {
  obsEtape <- observations |> filter(etape == e)
  especesEtape <- unique(obsEtape$espece)
  nouvelles <- setdiff(especesEtape, dejaVues)
  dejaVues <<- union(dejaVues, especesEtape)
  tibble(etape = e,
         effectif = sum(obsEtape$effectif),
         nbEspecesPresentes = length(especesEtape),
         nbEspecesNouvelles = length(nouvelles),
         nbEspecesCumul = length(dejaVues),
         especesNouvelles = paste(sort(nouvelles), collapse = " | "))
}) |>
  bind_rows()

### Export ###

write_csv(resultat, file.path(dossierSorties,
                              "seuil-diametre-especes-nouvelles.csv"))

# Nombre total de tiges mesurees (CBH >= 8 cm) dans les placettes, especes
# indeterminees comprises
write_csv(tibble(nbTigesMesurees = nrow(tiges)),
          file.path(dossierSorties, "seuil-diametre-resume.csv"))

message("✅ Especes nouvelles par etape :")
for (i in seq_len(nrow(resultat))) {
  message("   ", resultat$etape[i], " : ", resultat$nbEspecesNouvelles[i],
          " nouvelles (", resultat$nbEspecesPresentes[i], " presentes ; cumul ",
          resultat$nbEspecesCumul[i], ")")
}
