# description_echantillon_social.R
# Ewen Le Coeur
# 2026
# Objectif : decrire l'echantillon social (personnes rencontrees en entretien
# ou en sortie) sans element identifiant : effectifs par classe d'age et par
# genre, par activite principale et par lien au VOI.
#
# Entree : 08_rapport/donnees/metadonnees_enquete-de-terrain_3_enquetes.csv
# (copie du fichier de 05_Sociologie/donnees). La colonne « Nom » n'est jamais
# lue (col_select).
#
# Echantillon : personnes ayant un code d'entretien ou un code de sortie.
#
# Regroupements (une seule categorie par personne) :
#   - activite : « Agriculteur ou agricultrice » des que l'agriculture est
#     citee, quelles que soient les autres activites ; sinon « Responsable de
#     fokontany ou de commune », « Personnel d'Inter Aide », « Autre » ;
#     « ? » et vide = « Non renseignée » ;
#   - autres activites ou fonctions, en plus de l'agriculture (toutes les
#     personnes sauf une se sont presentees comme mpamboly, cultivateurs,
#     auteur, 02/11/2026) : comptees a part sur les 53 personnes (une personne
#     peut en avoir plusieurs) ; ampazaka = chef de lignage (graphie retenue
#     par l'auteur ; « mpanzaka » dans les metadonnees) ;
#   - lien au VOI, par ordre de priorite : membre du bureau (president,
#     vice-president, tresorier, secretaire, conseiller), polisin'ala, autre
#     fonction (pepinieriste, comite feu, observateur), membre (y compris par
#     le conjoint), ancien membre, aucun, non renseigne (vide, « ? », « N/A »).
#
# Sorties (08_rapport/redaction-typst/analyse-tables/) :
#   - echantillon_social_age_genre.csv : classe d'age x genre ;
#   - echantillon_social_activites.csv : activite principale x genre ;
#   - echantillon_social_activites_secondaires.csv : autres activites ou
#     fonctions, sur l'ensemble des personnes ;
#   - echantillon_social_lien_voi.csv : lien au VOI x genre.
#
# Utilisation (depuis la racine du depot) :
#   source("08_rapport/donnees/description_echantillon_social.R")

### Modules ###

library(dplyr)
library(tidyr)
library(stringr)
library(readr)

### Import des donnees ###

dossierSorties <- "08_rapport/redaction-typst/analyse-tables"

enquetes <- read_delim(
  "08_rapport/donnees/metadonnees_enquete-de-terrain_3_enquetes.csv",
  delim = ";", col_types = cols(.default = col_character()),
  col_select = c("Code enquêté", "Genre", "Âge", "Professions", "Lien au VOI",
                 "Code entretien", "Code sortie")
) |>
  filter(!is.na(`Code entretien`) | !is.na(`Code sortie`)) |>
  mutate(genre = recode(Genre, H = "Hommes", F = "Femmes"),
         age = suppressWarnings(as.numeric(`Âge`)),
         profession = str_to_lower(coalesce(Professions, "")),
         lien = str_to_lower(coalesce(`Lien au VOI`, "")))

### Regroupements ###

enquetes <- enquetes |>
  mutate(
    classeAge = if_else(is.na(age), "Âge inconnu",
                        paste0(floor(age / 10) * 10, "-", floor(age / 10) * 10 + 9, " ans")),
    activite = case_when(
      str_detect(profession, "agricult") ~ "Agriculteur ou agricultrice",
      str_detect(profession, "fokontany|maire") ~ "Responsable de fokontany ou de commune",
      str_detect(profession, "inter aide") ~ "Personnel d'Inter Aide",
      profession %in% c("", "?") ~ "Non renseignée",
      TRUE ~ "Autre"
    ),
    lienVoi = case_when(
      str_detect(lien, "président|trésorier|secrétaire|conseiller") ~ "Membre du bureau",
      str_detect(lien, "polisn") ~ "Polisin'ala",
      str_detect(lien, "pépiniériste|comité feu|observateur") ~ "Autre fonction (pépiniériste, comité feu, observateur)",
      str_detect(lien, "ancien") ~ "Ancien membre",
      str_detect(lien, "membre") ~ "Membre",
      str_detect(lien, "aucun") ~ "Aucun",
      TRUE ~ "Non renseigné"
    )
  )

tableauGenre <- function(d, var, niveaux = NULL) {
  t <- d |>
    count({{ var }}, genre) |>
    pivot_wider(names_from = genre, values_from = n, values_fill = 0) |>
    mutate(Total = Hommes + Femmes)
  if (!is.null(niveaux)) t <- t |> arrange(match({{ var }}, niveaux))
  total <- t |> summarise(across(c(Hommes, Femmes, Total), sum)) |>
    mutate(categorie = "Total")
  t |> rename(categorie = {{ var }}) |>
    select(categorie, Hommes, Femmes, Total) |>
    bind_rows(total)
}

ordreAge <- c(sort(unique(enquetes$classeAge[enquetes$classeAge != "Âge inconnu"])), "Âge inconnu")
ageGenre <- tableauGenre(enquetes, classeAge, ordreAge)

ordreActivite <- c("Agriculteur ou agricultrice", "Responsable de fokontany ou de commune",
                   "Personnel d'Inter Aide", "Autre", "Non renseignée")
activites <- tableauGenre(enquetes, activite, ordreActivite)

secondaires <- enquetes |>
  summarise(
    `Vannerie` = sum(str_detect(profession, "vanni")),
    `Responsabilité de fokontany ou de commune` = sum(str_detect(profession, "fokontany|maire")),
    `Ampazaka (chef de lignage)` = sum(str_detect(profession, "ampazaka|mpanzaka")),
    `Agent communautaire` = sum(str_detect(profession, "agent communautaire")),
    `Commerce` = sum(str_detect(profession, "commer")),
    `Élevage` = sum(str_detect(profession, "éleveur")),
    `Menuiserie` = sum(str_detect(profession, "menuisier")),
    `Polisin'ala` = sum(str_detect(profession, "polisn"))
  ) |>
  pivot_longer(everything(), names_to = "activiteSecondaire", values_to = "nbPersonnes")

ordreLien <- c("Membre du bureau", "Polisin'ala",
               "Autre fonction (pépiniériste, comité feu, observateur)", "Membre",
               "Ancien membre", "Aucun", "Non renseigné")
lienVoi <- tableauGenre(enquetes, lienVoi, ordreLien)

### Export ###

write_csv(ageGenre, file.path(dossierSorties, "echantillon_social_age_genre.csv"))
write_csv(activites, file.path(dossierSorties, "echantillon_social_activites.csv"))
write_csv(secondaires, file.path(dossierSorties, "echantillon_social_activites_secondaires.csv"))
write_csv(lienVoi, file.path(dossierSorties, "echantillon_social_lien_voi.csv"))

message("✅ Echantillon social : ", nrow(enquetes), " personnes ; age connu pour ",
        sum(!is.na(enquetes$age)), " (", min(enquetes$age, na.rm = TRUE), " a ",
        max(enquetes$age, na.rm = TRUE), " ans)")
