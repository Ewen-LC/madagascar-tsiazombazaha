# analyse_usages_cook.R
# Ewen Le Coeur
# 2026
# Objectif : nombre d'especes par categorie d'usage de premier niveau de la
# classification de Cook (1995), a partir de la liste des especes
# reconciliees et de la correspondance usages normalises -> codes Cook.
#
# Entrees :
#   - donnees/flore.csv et donnees/grands-arbres.csv (colonne « usages »,
#     usages cites par le polisin'ala, saisie brute) ;
#   - referentiels/reconciliation-taxonomique.csv (nom brut -> espece
#     reconciliee) et referentiels/normalisation-usages.csv (usage brut ->
#     usage(s) normalise(s)) ;
#   - referentiels/liste-especes-usages-types.csv (une ligne par espece
#     reconciliee ; usages normalises separes par « | ») : usages d'autres
#     sources, ajoutes a ceux de flore.csv ;
#   - referentiels/correspondance-usages-cook.csv (encodage ISO-8859-1)
#
# Correction du 01/11/2026 : le referentiel des especes (12/10/2026) ne
# reprenait pas les usages saisis ensuite (placettes P21 a P28 notamment) ;
# les usages sont donc tires directement de flore.csv puis reunis avec
# ceux du referentiel. Les usages des grands arbres, d'abord notes en
# remarque libre, ont ete reportes dans une colonne « usages » de
# grands-arbres.csv (01/11/2026) et sont lus de la meme facon.
#
# Sorties :
#   - sorties/usages_cook_categories.csv : par categorie de premier niveau,
#     nombre d'especes et usages normalises cites ;
#   - sorties/usages_cook_resume.csv : nombre d'especes avec au moins un
#     usage classe, avec la seule mention « aucun », sans mention (NA) ;
#   - sorties/liste_flore.csv et liste_flore_resume.csv : liste de la flore
#     (une ligne par espece) et ses effectifs, pour l'annexe du rapport.
#
# Utilisation :
#   source("06_ecologie/analyse/scripts/analyse_usages_cook.R")

### Modules ###

library(dplyr)
library(tidyr)
library(stringr)
library(readr)

### Import des donnees ###

dossierReferentiels <- "06_ecologie/analyse/referentiels"
dossierSorties <- "06_ecologie/analyse/sorties"

especes <- read_csv(
  file.path(dossierReferentiels, "liste-especes-usages-types.csv"),
  show_col_types = FALSE
) |>
  rename(espece = `nom-vernaculaire-reconcilie`)

reconciliation <- read_csv(
  file.path(dossierReferentiels, "reconciliation-taxonomique.csv"),
  show_col_types = FALSE
) |>
  transmute(nomBrut = str_trim(`nom-vernaculaire-brut`),
            espece = str_trim(`nom-vernaculaire-reconcilie`)) |>
  distinct(nomBrut, .keep_all = TRUE)

normalisation <- read_csv(
  file.path(dossierReferentiels, "normalisation-usages.csv"),
  show_col_types = FALSE
) |>
  transmute(usageBrut = str_trim(`usage-brut`),
            usage = str_trim(`usage-normalise`))

flore <- read_csv(
  file.path("06_ecologie/analyse/donnees", "flore.csv"),
  col_types = cols(.default = col_character())
) |>
  transmute(nomBrut = str_trim(`nom-vernaculaire-brut`),
            usageBrut = str_trim(usages)) |>
  filter(!is.na(usageBrut), usageBrut != "", usageBrut != "NA")

grandsArbres <- read_csv(
  file.path("06_ecologie/analyse/donnees", "grands-arbres.csv"),
  col_types = cols(.default = col_character())
) |>
  transmute(nomBrut = str_trim(`nom-vernaculaire-brut`),
            usageBrut = str_trim(usages)) |>
  filter(!is.na(usageBrut), usageBrut != "", usageBrut != "NA")

# Usages saisis sur le terrain : placettes et grands arbres
flore <- bind_rows(flore, grandsArbres)

correspondance <- read_csv(
  file.path(dossierReferentiels, "correspondance-usages-cook.csv"),
  locale = locale(encoding = "ISO-8859-1"),
  show_col_types = FALSE
) |>
  rename(usage = `usage-normalise`, cookN1 = `cook-n1`,
         cookN1Libelle = `cook-n1-libelle`)

### Usages par espece ###

# Usages de flore.csv : nom brut -> espece reconciliee, usage brut ->
# usage(s) normalise(s)
nomsNonReconcilies <- flore |>
  anti_join(reconciliation, by = "nomBrut") |>
  distinct(nomBrut)
if (nrow(nomsNonReconcilies) > 0) {
  message("⚠️ Noms bruts absents de la reconciliation (ignores) : ",
          paste(nomsNonReconcilies$nomBrut, collapse = ", "))
}
usagesNonNormalises <- flore |>
  anti_join(normalisation, by = "usageBrut") |>
  distinct(usageBrut)
if (nrow(usagesNonNormalises) > 0) {
  message("⚠️ Usages bruts absents de la normalisation (ignores) : ",
          paste(usagesNonNormalises$usageBrut, collapse = ", "))
}
usagesFlore <- flore |>
  inner_join(reconciliation, by = "nomBrut") |>
  inner_join(normalisation, by = "usageBrut",
             relationship = "many-to-many") |>
  select(espece, usage)

# Usages du referentiel des especes
usagesReferentiel <- especes |>
  select(espece, usages) |>
  separate_rows(usages, sep = "\\|") |>
  mutate(usage = str_trim(usages)) |>
  select(-usages)

# Usages notes par Romiguiere (2025) sur les tiges de Tsiazombazaha : noms
# rattaches aux especes de l'etude par la correspondance validee par l'auteur,
# libelles ramenes au referentiel par normalisation-usages-romiguiere.csv
# (02/11/2026). Toutes les especes de Romiguiere sont reprises, avec un usage
# NA quand aucun n'est note.
correspondanceRom <- read_csv(
  file.path(dossierReferentiels, "correspondance-romiguiere-2025.csv"),
  col_types = cols(.default = col_character())
) |>
  transmute(nomRom = str_trim(`nom-vernaculaire-romiguiere`),
            espece = str_trim(`nom-vernaculaire-reconcilie`)) |>
  filter(!is.na(espece), espece != "")

normalisationRom <- read_csv(
  file.path(dossierReferentiels, "normalisation-usages-romiguiere.csv"),
  col_types = cols(.default = col_character())
) |>
  transmute(usageBrut = str_to_lower(str_trim(`usage-brut-romiguiere`)),
            usage = str_trim(`usage-normalise`))

usagesRomBruts <- read_csv(
  file.path("06_ecologie/analyse/donnees", "romiguiere-2025-tiges.csv"),
  col_types = cols(.default = col_character())
) |>
  transmute(nomRom = str_trim(`nom-vernaculaire-brut`), usageBrut = usages) |>
  separate_rows(usageBrut, sep = ",| et ") |>
  mutate(usageBrut = str_to_lower(str_trim(usageBrut))) |>
  filter(!is.na(usageBrut), usageBrut != "")

usagesRomNonNormalises <- usagesRomBruts |>
  filter(usageBrut != "na") |>
  anti_join(normalisationRom |> filter(!is.na(usage)), by = "usageBrut") |>
  distinct(usageBrut)
if (nrow(usagesRomNonNormalises) > 0) {
  message("⚠️ Usages de Romiguiere non classes (ignores) : ",
          paste(usagesRomNonNormalises$usageBrut, collapse = ", "))
}

usagesRom <- bind_rows(
  usagesRomBruts |>
    inner_join(correspondanceRom, by = "nomRom") |>
    inner_join(normalisationRom |> filter(!is.na(usage)), by = "usageBrut") |>
    select(espece, usage),
  correspondanceRom |> distinct(espece) |> mutate(usage = NA_character_)
)

# Inventaire d'especes du transfert de gestion (2004), section 7 : noms
# vernaculaires rattaches aux especes par la reconciliation (variantes
# orthographiques comprises) ; noms scientifiques et usages donnes par le document.
tfgInventaire <- read_csv(
  file.path(dossierReferentiels, "transfert-gestion-2004-inventaire.csv"),
  col_types = cols(.default = col_character())
) |>
  transmute(nomTfg = str_trim(`nom-vernaculaire-tfg`),
            binomTfg = na_if(str_trim(`nom-binomial-tfg`), ""),
            usageBrut = na_if(str_trim(`usage-tfg-brut`), ""),
            espece = coalesce(reconciliation$espece[match(nomTfg, reconciliation$nomBrut)],
                              nomTfg))
normalisationTfg <- read_csv(
  file.path(dossierReferentiels, "normalisation-usages-tfg.csv"),
  col_types = cols(.default = col_character())
) |>
  transmute(usageBrut = str_trim(`usage-brut-tfg`),
            usage = str_trim(`usage-normalise`))
tfgUsages <- tfgInventaire |>
  filter(!is.na(usageBrut)) |>
  inner_join(normalisationTfg, by = "usageBrut") |>
  select(espece, usage)

# Une ligne par espece x usage normalise (toutes sources)
# (especes indeterminees exclues, comme dans les autres analyses)
usagesEspeces <- bind_rows(usagesReferentiel, usagesFlore, usagesRom, tfgUsages) |>
  mutate(usage = na_if(usage, "NA")) |>
  filter(str_to_lower(str_trim(espece)) != "espèce indéterminée",
         espece != "N/A") |>
  distinct()

usagesClasses <- usagesEspeces |>
  inner_join(correspondance |> filter(!is.na(cookN1)), by = "usage")

# Usages normalises absents de la correspondance (controle)
nonClasses <- usagesEspeces |>
  filter(!is.na(usage), usage != "aucun", usage != "NA") |>
  anti_join(correspondance, by = "usage") |>
  distinct(usage)
if (nrow(nonClasses) > 0) {
  message("⚠️ Usages sans correspondance Cook : ",
          paste(nonClasses$usage, collapse = ", "))
}

### Comptages ###

categories <- usagesClasses |>
  group_by(cookN1, cookN1Libelle) |>
  summarise(
    nbEspeces = n_distinct(espece),
    usagesCites = paste(sort(unique(usage)), collapse = " | "),
    .groups = "drop"
  ) |>
  arrange(desc(nbEspeces), cookN1)

especesAvecUsage <- n_distinct(usagesClasses$espece)
especesAucun <- usagesEspeces |>
  group_by(espece) |>
  summarise(
    aucun = any(usage %in% "aucun"),
    classe = any(usage %in% correspondance$usage[!is.na(correspondance$cookN1)]),
    .groups = "drop"
  ) |>
  filter(aucun, !classe) |>
  nrow()
especesNA <- usagesEspeces |>
  group_by(espece) |>
  summarise(sansMention = all(is.na(usage)), .groups = "drop") |>
  filter(sansMention) |>
  nrow()


### Liste de la flore (annexe du rapport) ###

# Une ligne par espece reconciliee (especes indeterminees exclues) : nom
# binomial, nombre de types decrits (maximum des valeurs saisies), categories
# Cook de premier niveau et source de la mention (02/11/2026) :
#   - « Relevé » : placettes (flore.csv) et grands arbres des transects ;
#   - « Observation » : observations hors releve (autres-observations-flore.csv,
#     phenologie.csv) ;
#   - « Romiguière (2025) » : tiges et regeneration relevees a Tsiazombazaha
#     (donnees/romiguiere-2025-*.csv), rattachees aux especes de l'etude par
#     referentiels/correspondance-romiguiere-2025.csv (decisions de l'auteur,
#     02/11/2026) ;
#   - « Transfert de gestion (2004) » : a ajouter quand la liste sera saisie.
# Les noms bruts sont rapproches de la reconciliation sans tenir compte de la
# casse (« Ambilazo / Fagnotavahatra » dans autres-observations-flore.csv).
libellesCookFr <- c(
  alimentaire = "Alimentation", materiaux = "Matériaux",
  combustible = "Combustibles", poison = "Poisons des non-vertébrés",
  sociale_culturelle = "Usages sociaux", medicinale = "Médicaments",
  environnementale = "Usages environnementaux"
)

lireNoms <- function(fichier, source) {
  read_csv(file.path("06_ecologie/analyse/donnees", fichier),
           col_types = cols(.default = col_character())) |>
    transmute(nomBrut = str_trim(`nom-vernaculaire-brut`), source = source)
}
sourcesEspeces <- bind_rows(
  lireNoms("flore.csv", "Placettes"),
  lireNoms("grands-arbres.csv", "Transects (grands arbres)"),
  lireNoms("autres-observations-flore.csv", "Hors placettes"),
  lireNoms("phenologie.csv", "Phénologie")
) |>
  mutate(cle = str_to_lower(nomBrut)) |>
  inner_join(reconciliation |>
               transmute(cle = str_to_lower(nomBrut), espece) |>
               distinct(cle, .keep_all = TRUE),
             by = "cle") |>
  distinct(espece, source)

# Nom scientifique d'apres Romiguiere (2025), pour les especes sans nom dans
# l'etude : identifications de ses deux sites (Tsiazombazaha et Vorovoka) pour
# les noms rattaches a l'espece. Regle (auteur, 02/11/2026) : une seule espece
# -> l'espece ; un seul genre -> le genre ; plusieurs genres d'une meme famille
# -> la famille ; sinon, aucun nom. Coquilles de Romiguiere corrigees avant
# comparaison.
corrigerGenre <- c(Cinamonum = "Cinnamomum", Dracanea = "Dracaena",
                   Phyllarthon = "Phyllarthron", Sizygium = "Syzygium",
                   Zanthoxyllum = "Zanthoxylum", Tricalyia = "Tricalysia",
                   Berteria = "Bertiera")
corrigerFamille <- c(Cunnoniaceae = "Cunoniaceae")

idsRom <- read_csv(
  file.path("06_ecologie/analyse/donnees", "romiguiere-2025-noms-latins.csv"),
  col_types = cols(.default = col_character())
) |>
  transmute(cle = str_to_lower(str_trim(`nom-vernaculaire-brut`)),
            nomLatin = na_if(str_squish(`nom-latin`), ""),
            famille = na_if(str_trim(famille), "")) |>
  mutate(genre = word(nomLatin, 1),
         genre = coalesce(unname(corrigerGenre[genre]), genre),
         epithete = str_to_lower(word(nomLatin, 2)),
         epithete = if_else(epithete %in% c("sp", "sp.", "spp", "spp."),
                            NA_character_, epithete),
         famille = coalesce(unname(corrigerFamille[famille]), famille))

# Famille d'un genre : la plus frequente chez Romiguiere (une ligne isolee
# donne par exemple Dracaena reflexa dans les Strelitziaceae) ; elle remplace
# la famille de la ligne quand le genre est connu.
familleGenre <- idsRom |>
  filter(!is.na(genre), !is.na(famille)) |>
  count(genre, famille) |>
  group_by(genre) |>
  slice_max(n, n = 1, with_ties = FALSE) |>
  ungroup() |>
  select(genre, familleDuGenre = famille)
idsRom <- idsRom |>
  left_join(familleGenre, by = "genre") |>
  mutate(famille = coalesce(familleDuGenre, famille))

taxonConsensus <- function(genre, epithete, famille) {
  g <- unique(na.omit(genre))
  f <- unique(na.omit(famille))
  if (length(f) > 1 && length(g) <= 1) return(NA_character_)
  if (length(g) == 1) {
    e <- unique(epithete[!is.na(genre)])
    if (length(e) == 1 && !is.na(e)) return(paste(g, e))
    return(g)
  }
  if (length(f) == 1) return(f)
  NA_character_
}

nomsLatinsRom <- correspondanceRom |>
  mutate(cle = str_to_lower(nomRom)) |>
  inner_join(idsRom, by = "cle", relationship = "many-to-many") |>
  group_by(espece) |>
  summarise(nomLatinRom = taxonConsensus(genre, epithete, famille),
            .groups = "drop")
nomsRomSansDecision <- setdiff(
  c(read_csv(file.path("06_ecologie/analyse/donnees", "romiguiere-2025-tiges.csv"),
             col_types = cols(.default = col_character()))$`nom-vernaculaire-brut`,
    read_csv(file.path("06_ecologie/analyse/donnees", "romiguiere-2025-regeneration.csv"),
             col_types = cols(.default = col_character()))$`nom-vernaculaire-brut`) |>
    str_trim() |> unique(),
  correspondanceRom$nomRom)
if (length(nomsRomSansDecision) > 0) {
  message("⚠️ Noms de Romiguiere sans decision de correspondance : ",
          paste(nomsRomSansDecision, collapse = ", "))
}
sourcesEspeces <- bind_rows(
  sourcesEspeces,
  correspondanceRom |> distinct(espece) |> mutate(source = "Romiguière (2025)")
)

sourcesEspeces <- bind_rows(
  sourcesEspeces,
  tfgInventaire |> distinct(espece) |> mutate(source = "Transfert de gestion (2004)")
)

# Base : especes du referentiel, des releves et des usages reunies (une espece
# relevee ou citee peut manquer du referentiel du 12/10/2026)
# Numeros des types distincts, separes par « / » (ex. « 1/2 ») ; « NA » et « ++ » ignores
typesDistincts <- function(x) {
  v <- suppressWarnings(as.numeric(str_split_1(x, "\\|")))
  v <- sort(unique(v[!is.na(v)]))
  if (length(v) == 0) NA_character_ else paste(v, collapse = "/")
}
listeFlore <- tibble(espece = unique(c(especes$espece, sourcesEspeces$espece,
                                       usagesEspeces$espece))) |>
  filter(!is.na(espece), espece != "N/A",
         str_to_lower(str_trim(espece)) != "espèce indéterminée") |>
  left_join(especes |> transmute(espece, nomBinomial = `nom-binomial`,
                                 typesBruts = `nb-types`), by = "espece") |>
  mutate(types = vapply(coalesce(typesBruts, "NA"), typesDistincts, character(1)),
         nomBinomial = na_if(na_if(nomBinomial, "NA"), "?")) |>
  select(-typesBruts) |>
  left_join(nomsLatinsRom, by = "espece") |>
  left_join(
    usagesClasses |>
      distinct(espece, cookN1, cookN1Libelle) |>
      arrange(cookN1) |>
      group_by(espece) |>
      summarise(usagesCook = paste(unique(libellesCookFr[cookN1Libelle]),
                                   collapse = ", "), .groups = "drop"),
    by = "espece"
  ) |>
  left_join(
    sourcesEspeces |>
      group_by(espece) |>
      summarise(
        enPlacettes = any(source == "Placettes"),
        enEtude = any(!source %in% c("Romiguière (2025)", "Transfert de gestion (2004)")),
        sources = paste(c("Relevé", "Observation", "Romiguière (2025)", "Transfert de gestion (2004)")[c(
          any(source %in% c("Placettes", "Transects (grands arbres)")),
          any(source %in% c("Hors placettes", "Phénologie")),
          any(source == "Romiguière (2025)"),
          any(source == "Transfert de gestion (2004)"))],
          collapse = ", "),
        .groups = "drop"),
    by = "espece"
  ) |>
  left_join(tfgInventaire |> filter(!is.na(binomTfg)) |> distinct(espece, .keep_all = TRUE) |>
              transmute(espece, nomTfgCand = binomTfg), by = "espece") |>
  mutate(enPlacettes = coalesce(enPlacettes, FALSE),
         enEtude = coalesce(enEtude, FALSE),
         # Nom scientifique : TFG (2004) > Romiguiere (2025) > personnel. Un nom de
         # famille de Romiguiere ne remplace pas un nom personnel.
         # Nom TFG (2004) retenu en premier
         nomTfg = nomTfgCand,
         nomRomiguiere = !is.na(nomLatinRom) & is.na(nomTfg) &
           ((is.na(nomBinomial) | nomBinomial == "++") |
              (!str_detect(nomLatinRom, "aceae$") &
                 !str_detect(coalesce(nomBinomial, ""), fixed(nomLatinRom)))),
         origineNom = case_when(!is.na(nomTfg) ~ "Transfert de gestion (2004)",
                                nomRomiguiere ~ "Romiguière (2025)",
                                !is.na(nomBinomial) & nomBinomial != "++" ~ "Personnel",
                                TRUE ~ NA_character_),
         nomBinomial = coalesce(nomTfg, if_else(nomRomiguiere, nomLatinRom, nomBinomial))) |>
  select(-nomLatinRom, -nomTfg, -nomTfgCand) |>
  left_join(
    usagesEspeces |>
      filter(!is.na(usage), usage != "aucun") |>
      distinct(espece, usage) |>
      group_by(espece) |>
      summarise(usages = paste(sort(usage), collapse = " | "), .groups = "drop"),
    by = "espece"
  ) |>
  arrange(espece)

nomsSansSource <- listeFlore$espece[is.na(listeFlore$sources)]
if (length(nomsSansSource) > 0) {
  message("⚠️ Especes du referentiel sans mention dans les releves ou observations : ",
          paste(nomsSansSource, collapse = ", "))
}

# Liste de reference : especes du referentiel, des releves, des usages et de
# l'inventaire du transfert de gestion (2004)
nbEspecesListe <- tibble(espece = c(especes$espece, sourcesEspeces$espece,
                                    usagesEspeces$espece)) |>
  filter(!is.na(espece), espece != "N/A",
         str_to_lower(str_trim(espece)) != "espèce indéterminée") |>
  distinct() |> nrow()
resume <- tibble(
  nbEspecesListe = nbEspecesListe,
  nbEspecesUsageClasse = especesAvecUsage,
  nbEspecesSeulementAucun = especesAucun,
  nbEspecesSansMention = nbEspecesListe - especesAvecUsage - especesAucun
)

### Exports ###

write_csv(categories, file.path(dossierSorties, "usages_cook_categories.csv"))
write_csv(resume, file.path(dossierSorties, "usages_cook_resume.csv"))
write_csv(listeFlore |> select(-enPlacettes, -enEtude) |>
            select(espece, nomBinomial, types, usagesCook, sources,
                   nomRomiguiere, usages, origineNom),
          file.path(dossierSorties, "liste_flore.csv"), na = "")

# Effectifs de la liste pour le texte
resumeFlore <- tibble(
  nbEspeces = nrow(listeFlore),
  nbPlacettes = sum(listeFlore$enPlacettes),
  nbHorsPlacettesSeulement = sum(!listeFlore$enPlacettes & listeFlore$enEtude),
  nbRomiguiere = sum(str_detect(coalesce(listeFlore$sources, ""), "Romiguière")),
  nbRomiguiereSeulement = sum(!listeFlore$enEtude &
                                str_detect(coalesce(listeFlore$sources, ""), "Romiguière")),
  nbNomScientifique = sum(!is.na(listeFlore$nomBinomial) &
                            listeFlore$nomBinomial != "++"),
  nbNomScientifiqueRomiguiere = sum(listeFlore$nomRomiguiere),
  nbPlusieursTypes = sum(str_detect(coalesce(listeFlore$types, ""), "/"))
)
write_csv(resumeFlore, file.path(dossierSorties, "liste_flore_resume.csv"))

message("✅ Usages (Cook, 1995) : ", especesAvecUsage,
        " especes avec au moins un usage classe sur ",
        resume$nbEspecesListe, " especes")
