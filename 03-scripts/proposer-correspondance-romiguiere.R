# proposer-correspondance-romiguiere.R
# Ewen Le Coeur
# 2026
# Objectif : proposer, pour chaque nom vernaculaire releve par Romiguiere
# (2025) a Tsiazombazaha, les especes reconciliees de l'etude dont le nom est
# le plus proche, afin d'etablir a la main la table de correspondance.
#
# Rapprochement : noms mis en minuscules, sans accents, espaces ni tirets,
# « gn » ramene a « n » (Babogna / Babona) ; similarite = 1 - distance
# d'edition (Levenshtein) / longueur du nom le plus long. Les noms bruts de la
# reconciliation sont compares aussi, et rapportes a leur espece reconciliee.
# Le genre botanique est compare quand les deux sources en donnent un.
#
# Entrees :
#   - donnees/romiguiere-2025-tiges.csv et romiguiere-2025-regeneration.csv ;
#   - referentiels/reconciliation-taxonomique.csv ;
#   - sorties/liste-flore.csv (noms scientifiques de l'etude).
#
# Sortie :
#   - referentiels/correspondance-romiguiere-2025-propositions.csv : une ligne
#     par nom de Romiguiere, trois propositions classees, colonnes « decision »
#     et « remarque » a remplir a la main.
#
# Utilisation :
#   source("03-scripts/proposer-correspondance-romiguiere.R")

### Modules ###

library(dplyr)
library(tidyr)
library(stringr)
library(readr)

### Import des donnees ###

dossierDonnees <- "02-donnees/ecologie"
dossierReferentiels <- "02-donnees/referentiels"
dossierSorties <- "04-sorties"

lire <- function(chemin) read_csv(chemin, col_types = cols(.default = col_character()))

tigesRom <- lire(file.path(dossierDonnees, "romiguiere-2025-tiges.csv"))
regenRom <- lire(file.path(dossierDonnees, "romiguiere-2025-regeneration.csv"))

nomsRom <- bind_rows(
  tigesRom |> transmute(nom = str_trim(`nom-vernaculaire-brut`), nomLatin = str_trim(`nom-latin`),
                        famille = str_trim(famille), tige = 1L, regen = 0L),
  regenRom |> transmute(nom = str_trim(`nom-vernaculaire-brut`), nomLatin = str_trim(`nom-latin`),
                        famille = str_trim(famille), tige = 0L,
                        regen = suppressWarnings(as.integer(nombre)))
) |>
  filter(!is.na(nom), nom != "") |>
  group_by(nom) |>
  summarise(
    nomLatin = paste(sort(unique(na.omit(nomLatin))), collapse = " / "),
    famille = paste(sort(unique(na.omit(famille))), collapse = " / "),
    nbTiges = sum(tige),
    nbRegeneration = sum(regen, na.rm = TRUE),
    .groups = "drop"
  )

reconciliation <- lire(file.path(dossierReferentiels, "reconciliation-taxonomique.csv")) |>
  transmute(nomEtude = str_trim(`nom-vernaculaire-brut`),
            espece = str_trim(`nom-vernaculaire-reconcilie`))

listeFlore <- lire(file.path(dossierSorties, "liste-flore.csv")) |>
  select(espece, nomBinomial)

# Noms de l'etude : especes reconciliees et noms bruts (hors indeterminees)
nomsEtude <- bind_rows(
  listeFlore |> transmute(nomEtude = espece, espece),
  reconciliation
) |>
  filter(espece %in% listeFlore$espece) |>
  distinct()

### Similarite des noms ###

normaliser <- function(x) {
  x |>
    str_to_lower() |>
    iconv(to = "ASCII//TRANSLIT") |>
    str_replace_all("[^a-z]", "") |>
    str_replace_all("gn", "n")
}

a <- normaliser(nomsRom$nom)
b <- normaliser(nomsEtude$nomEtude)
distances <- adist(a, b)
longueurs <- outer(nchar(a), nchar(b), pmax)
similarite <- 1 - distances / longueurs

genre <- function(x) str_to_lower(word(coalesce(x, ""), 1))

propositions <- lapply(seq_len(nrow(nomsRom)), function(i) {
  tibble(espece = nomsEtude$espece, nomEtude = nomsEtude$nomEtude,
         similarite = similarite[i, ]) |>
    group_by(espece) |>
    slice_max(similarite, n = 1, with_ties = FALSE) |>
    ungroup() |>
    slice_max(similarite, n = 3, with_ties = FALSE) |>
    left_join(listeFlore, by = "espece") |>
    mutate(rang = row_number())
})

tableau <- bind_rows(lapply(seq_len(nrow(nomsRom)), function(i) {
  p <- propositions[[i]]
  ligne <- nomsRom[i, ]
  for (r in 1:3) {
    ligne[[paste0("proposition-", r)]] <- p$espece[r]
    ligne[[paste0("similarite-", r)]] <- round(p$similarite[r], 2)
    ligne[[paste0("nom-scientifique-", r)]] <- p$nomBinomial[r]
  }
  genreRom <- genre(ligne$nomLatin)
  genre1 <- genre(p$nomBinomial[1])
  ligne$`genre-identique-1` <- if (genreRom != "" && genre1 != "" && genre1 != "++") {
    if (genreRom == genre1) "oui" else "non"
  } else ""
  ligne
})) |>
  rename(`nom-romiguiere` = nom, `nom-latin-romiguiere` = nomLatin,
         `famille-romiguiere` = famille, `nb-tiges` = nbTiges,
         `nb-regeneration` = nbRegeneration) |>
  mutate(decision = "", remarque = "") |>
  arrange(desc(`similarite-1`), `nom-romiguiere`)

### Export ###

# Le fichier de propositions a ete complete a la main (decisions de l'auteur,
# 02/11/2026, reprises dans referentiels/correspondance-romiguiere-2025.csv) :
# il n'est jamais ecrase.
fichierPropositions <- file.path(dossierReferentiels,
                                 "correspondance-romiguiere-2025-propositions.csv")
if (file.exists(fichierPropositions)) {
  fichierPropositions <- sub("\\.csv$", "_nouveau.csv", fichierPropositions)
  message("⚠️ Propositions existantes conservees ; ecriture dans ", basename(fichierPropositions))
}
write_csv(tableau, fichierPropositions, na = "")

message("✅ ", nrow(tableau), " noms de Romiguiere ; similarite de la meilleure proposition : ",
        sum(tableau$`similarite-1` == 1), " identiques, ",
        sum(tableau$`similarite-1` >= 0.8 & tableau$`similarite-1` < 1), " >= 0,8, ",
        sum(tableau$`similarite-1` < 0.8), " < 0,8")
