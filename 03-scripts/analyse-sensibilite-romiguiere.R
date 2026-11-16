# analyse-sensibilite-romiguiere.R
# Ewen Le Coeur
# 2026
# Objectif : analyse de sensibilite de la surface terriere G et du stock de
# carbone des tiges de placettes a l'ajout des 8 placettes de Romiguiere
# (2025) a Tsiazombazaha.
#
# Comparabilite : meme seuil de mesure (CBH >= 8 cm) ; placettes de 40 m²
# (10 x 4 m) NON corrigees de la pente (information de l'auteur, 02/11/2026),
# donc surface horizontale surestimee et valeurs a l'hectare legerement
# sous-estimees pour ces placettes. Pas de gaulis chez Romiguiere, mais les
# gaulis n'entrent ni dans G ni dans le carbone.
#
# Methodes reprises a l'identique :
#   - G : moyenne des G/ha par placette, ecart-type, erreur-type, IC 95 % de
#     Student (resumer() de fonctions-structure.R, comme
#     analyse-structure-forestiere.R) ;
#   - carbone des tiges : volume Chave et al. (2014) sans hauteur, densite
#     generique, estimateur par ratio (somme des volumes / somme des surfaces)
#     et IC 95 % bootstrap sur les placettes (1 000 tirages, graine 2026),
#     constantes de analyse-carbone.R. Les IC bootstrap de l'etude seule
#     peuvent differer legerement de carbone-stocks.csv (tirages differents) ;
#     l'estimation ponctuelle est identique.
#   - controle : AGB des tiges de Romiguiere avec sa hauteur mesuree (Chave et
#     al., 2014, equation 4) comparee a l'AGB sans hauteur.
#
# Sorties :
#   - sorties/sensibilite-romiguiere.csv : indice, jeu de placettes, nombre de
#     placettes, estimation, ecart-type, erreur-type, IC 95 % ;
#   - sorties/sensibilite-romiguiere-classes-n.csv et -classes-g.csv : densite
#     et surface terriere par classe de diametre, au format de
#     structure-classes-ic95.csv et structure-g-classes.csv (memes fonctions),
#     sur les 36 placettes pour les classes de DBH >= 2,5 cm ; la classe
#     0-2,5 cm (gaulis, non releves par Romiguiere) reste calculee sur les 28
#     placettes de l'etude ;
#   - sorties/classes-n-placettes-transects.csv et _G_ : memes classes,
#     placettes et grands arbres des transects additionnes, avec erreur-type
#     et IC 95 % combines (necessite les sorties de analyse-transects.R).
#
# Utilisation :
#   source("03-scripts/analyse-sensibilite-romiguiere.R")

### Modules ###

library(dplyr)
library(tidyr)
library(readr)
library(tibble)

source("03-scripts/fonctions/fonctions-structure.R")

### Constantes (identiques a analyse-carbone.R) ###

E_bioclimatique <- 0.1025
rho_bois <- 0.58
R <- 0.20
CF <- 0.47
M_CO2_C <- 3.67
SURFACE_PLACETTE_ROMIGUIERE <- 40   # m², sur la pente

agb_chave <- function(dhp_cm, rho = rho_bois, E = E_bioclimatique) {
  lnD <- log(dhp_cm)
  exp(-1.803 - 0.976 * E + 0.976 * log(rho) + 2.673 * lnD - 0.0299 * lnD^2)
}
volume_chave <- function(dhp_cm, rho = rho_bois, E = E_bioclimatique) {
  agb_chave(dhp_cm, rho, E) / (rho * 1000)
}
# Chave et al. (2014), equation 4 (avec hauteur), AGB en kg
agb_chave_hauteur <- function(dhp_cm, h_m, rho = rho_bois) {
  0.0673 * (rho * dhp_cm^2 * h_m)^0.976
}

### Import des donnees ###

dossierDonnees <- "02-donnees/ecologie"
dossierSorties <- "04-sorties"

flore <- read_csv(file.path(dossierDonnees, "flore.csv"),
                  col_types = cols(.default = col_character()))
colsCirc <- intersect(c("Circ1", "Circ2", "Circ3", "Circ4", "Circ5", "Circ6",
                        "Cir7", "Circ8", "Circ9", "Cir10"), names(flore))
tigesEtude <- flore |>
  select(cdPlacette = placette, all_of(colsCirc)) |>
  pivot_longer(all_of(colsCirc), values_to = "circ_cm") |>
  mutate(circ_cm = suppressWarnings(as.numeric(circ_cm))) |>
  filter(!is.na(circ_cm)) |>
  select(cdPlacette, circ_cm)

placettesEtude <- read_csv(file.path(dossierDonnees, "placettes.csv"),
                           col_types = cols(.default = col_character())) |>
  transmute(cdPlacette = placette,
            surface_m2 = as.numeric(gsub(",", ".", `surface-horizontale`)),
            jeu = "Étude")

tigesRom <- read_csv(file.path(dossierDonnees, "romiguiere-2025-tiges.csv"),
                     col_types = cols(.default = col_character())) |>
  transmute(cdPlacette = paste0("R", transect),
            circ_cm = as.numeric(circonference),
            hauteur_m = as.numeric(hauteur))

placettesRom <- tibble(cdPlacette = unique(tigesRom$cdPlacette),
                       surface_m2 = SURFACE_PLACETTE_ROMIGUIERE,
                       jeu = "Romiguière (2025)")

tiges <- bind_rows(tigesEtude, tigesRom |> select(cdPlacette, circ_cm)) |>
  mutate(dbh_cm = circ_cm / pi)
placettes <- bind_rows(placettesEtude, placettesRom)

### Valeurs par placette ###

parPlacette <- tiges |>
  group_by(cdPlacette) |>
  summarise(G_m2 = sum(pi / 4 * (dbh_cm / 100)^2),
            volume_m3 = sum(volume_chave(dbh_cm)), .groups = "drop") |>
  right_join(placettes, by = "cdPlacette") |>
  mutate(G_m2 = replace_na(G_m2, 0), volume_m3 = replace_na(volume_m3, 0),
         G_ha = G_m2 / surface_m2 * 10000)

### Estimations par jeu de placettes ###

# Conversions par m³ de bois vivant (comme analyse-carbone.R) : volume
# aerien (m³, ajoute a la demande de l'auteur le 05/11/2026), biomasse
# aerienne (tMS), carbone (tC) et CO2 (tCO2), racines comprises pour C et CO2
conv <- c(1, rho_bois, rho_bois * (1 + R) * CF, rho_bois * (1 + R) * CF * M_CO2_C)

jeux <- list(
  "Étude seule" = parPlacette |> filter(jeu == "Étude"),
  "Romiguière (2025) seul" = parPlacette |> filter(jeu == "Romiguière (2025)"),
  "Étude + Romiguière (2025)" = parPlacette
)

set.seed(2026)
resultats <- bind_rows(lapply(names(jeux), function(nom) {
  p <- jeux[[nom]]
  g <- resumer(p$G_ha)
  ratio <- sum(p$volume_m3) / sum(p$surface_m2) * 10000
  boot <- replicate(1000, {
    bs <- p[sample(nrow(p), replace = TRUE), ]
    sum(bs$volume_m3) / sum(bs$surface_m2) * 10000
  })
  icBoot <- quantile(boot, c(0.025, 0.975), names = FALSE)
  bind_rows(
    tibble(indice = "G (m2/ha)", jeu = nom, nbPlacettes = nrow(p),
           estimation = g[["moyenne"]], ecartType = g[["ecartType"]],
           erreurType = g[["erreurType"]],
           ic95_bas = g[["ic95_bas"]], ic95_haut = g[["ic95_haut"]]),
    tibble(indice = c("Volume des tiges (m3/ha)",
                      "Biomasse des tiges (tMS/ha)", "Carbone des tiges (tC/ha)",
                      "CO2 des tiges (tCO2/ha)"),
           jeu = nom, nbPlacettes = nrow(p),
           estimation = ratio * conv,
           ecartType = NA_real_, erreurType = NA_real_,
           ic95_bas = icBoot[1] * conv,
           ic95_haut = icBoot[2] * conv)
  )
}))

### Controle de l'allometrie sans hauteur (tiges de Romiguiere) ###

controleHauteur <- tigesRom |>
  mutate(dbh_cm = circ_cm / pi) |>
  summarise(agbSansHauteur_kg = sum(agb_chave(dbh_cm)),
            agbAvecHauteur_kg = sum(agb_chave_hauteur(dbh_cm, hauteur_m)))
resultats <- bind_rows(resultats, tibble(
  indice = "Rapport AGB avec hauteur / sans hauteur (tiges de Romiguière)",
  jeu = "Romiguière (2025) seul", nbPlacettes = nrow(placettesRom),
  estimation = controleHauteur$agbAvecHauteur_kg /
    controleHauteur$agbSansHauteur_kg
))

### Classes de diametre (etude + Romiguiere) ###

gaulisEtude <- flore |>
  transmute(cdPlacette = placette,
            nbGaulis = suppressWarnings(as.numeric(`nombre-gaulis`))) |>
  filter(!is.na(nbGaulis)) |>
  group_by(cdPlacette) |>
  summarise(nbGaulis = sum(nbGaulis), .groups = "drop")

tigesClasses <- tiges |> mutate(classeDiam = floor(dbh_cm / 2.5) * 2.5)
placettesClasses <- placettes |> rename(surfaceHorizontale_m2 = surface_m2)

classesN <- calculer_classes_IC95(
  list(placettes = placettesClasses), tigesClasses, gaulisEtude
) |>
  filter(classeDiam > 0)
classeN0 <- calculer_classes_IC95(
  list(placettes = placettesClasses |> filter(jeu == "Étude")),
  tigesClasses |> filter(cdPlacette %in% placettesEtude$cdPlacette),
  gaulisEtude
) |>
  filter(classeDiam == 0)
classesN <- bind_rows(classeN0, classesN) |> arrange(classeDiam)

classesG <- calculer_G_par_classe(
  tigesClasses, placettesClasses |> select(cdPlacette, surfaceHorizontale_m2),
  largeur = 5, origine = 2.5,
  surfaceTotale = sum(placettesClasses$surfaceHorizontale_m2)
)

### Export ###

write_csv(resultats, file.path(dossierSorties, "sensibilite-romiguiere.csv"))

# Total de carbone avec les tiges de l'etude et de Romiguiere (2025)
# (demande de l'auteur, 04/11/2026) : les trois autres compartiments (grands
# arbres, bois mort au sol et sur pied) sont repris de carbone-stocks.csv
# (analyse-carbone.R) ; IC 95 % du total par la meme propagation que
# analyse-carbone.R (compartiments supposes independants).
stocksEtude <- read_csv(file.path(dossierSorties, "carbone-stocks.csv"), show_col_types = FALSE)
surfaceForet <- read_csv(file.path(dossierSorties, "carbone-total-foret.csv"),
                         show_col_types = FALSE)$surface_ha
tigesCombinees <- resultats |> filter(jeu == "Étude + Romiguière (2025)")
autresCompartiments <- stocksEtude |> filter(compartiment != "Tiges placettes (flore)")
icSomme <- function(est, bas, haut) {
  c(bas = sum(est) - sqrt(sum((est - bas)^2)),
    haut = sum(est) + sqrt(sum((haut - est)^2)))
}
ligneTiges <- function(nom) tigesCombinees |> filter(indice == nom)
carboneTiges <- ligneTiges("Carbone des tiges (tC/ha)")
co2Tiges <- ligneTiges("CO2 des tiges (tCO2/ha)")
estC <- c(carboneTiges$estimation, autresCompartiments$carbone_tC_ha)
estCO2 <- c(co2Tiges$estimation, autresCompartiments$co2_tCO2_ha)
icC <- icSomme(estC, c(carboneTiges$ic95_bas, autresCompartiments$carbone_ic95_bas),
               c(carboneTiges$ic95_haut, autresCompartiments$carbone_ic95_haut))
icCO2 <- icSomme(estCO2, c(co2Tiges$ic95_bas, autresCompartiments$co2_ic95_bas),
                 c(co2Tiges$ic95_haut, autresCompartiments$co2_ic95_haut))
totalRomiguiere <- tibble(
  surface_ha = surfaceForet,
  carbone_tC_ha = sum(estC), carbone_ic95_bas = icC[["bas"]], carbone_ic95_haut = icC[["haut"]],
  co2_tCO2_ha = sum(estCO2), co2_ic95_bas = icCO2[["bas"]], co2_ic95_haut = icCO2[["haut"]],
  carbone_total_tC = sum(estC) * surfaceForet,
  carbone_total_ic95_bas = icC[["bas"]] * surfaceForet,
  carbone_total_ic95_haut = icC[["haut"]] * surfaceForet,
  co2_total_tCO2 = sum(estCO2) * surfaceForet,
  co2_total_ic95_bas = icCO2[["bas"]] * surfaceForet,
  co2_total_ic95_haut = icCO2[["haut"]] * surfaceForet
)
write_csv(totalRomiguiere, file.path(dossierSorties, "carbone-total-foret-romiguiere.csv"))
write_csv(classesN, file.path(dossierSorties, "sensibilite-romiguiere-classes-n.csv"))
write_csv(classesG, file.path(dossierSorties, "sensibilite-romiguiere-classes-g.csv"))

# Classes de diametre, placettes et grands arbres des transects additionnes
# (demande de l'auteur, 05/11/2026). Les deux echantillons sont independants :
# erreur-type de la somme = racine de la somme des carres ; IC 95 % de Student
# avec les degres de liberte de Welch-Satterthwaite. L'erreur-type des
# placettes est deduite de leur IC (demi-largeur / t a n - 1 ddl) ; celle des
# transects vient de analyse-transects.R (a lancer avant ce script).
# Classes sans transect : IC des placettes inchange.
combinerAvecTransects <- function(placettesClasses, transectsClasses, colClasse,
                                  colValeurT, nbPlacettes) {
  nbTransects <- nrow(read_csv(file.path(dossierSorties, "transects-grands-arbres.csv"),
                               show_col_types = FALSE))
  full_join(
    placettesClasses |>
      transmute(classe = .data[[colClasse]], moyP = moyenne_ha,
                etP = (ic95_haut - moyenne_ha) / qt(0.975, nbPlacettes - 1),
                basP = ic95_bas, hautP = ic95_haut),
    transectsClasses |>
      transmute(classe = .data[[colClasse]], moyT = .data[[colValeurT]],
                etT = erreurType_ha),
    by = "classe") |>
    mutate(
      avecTransect = !is.na(moyT),
      across(c(moyP, etP, moyT, etT), ~ coalesce(.x, 0)),
      moyenne_ha = moyP + moyT,
      erreurType_ha = sqrt(etP^2 + etT^2),
      ddl = erreurType_ha^4 /
        (etP^4 / (nbPlacettes - 1) + etT^4 / (nbTransects - 1)),
      ic95_bas = if_else(avecTransect,
                         moyenne_ha - qt(0.975, ddl) * erreurType_ha, basP),
      ic95_haut = if_else(avecTransect,
                          moyenne_ha + qt(0.975, ddl) * erreurType_ha, hautP)
    ) |>
    arrange(classe) |>
    select(classe, moyenne_placettes_ha = moyP, moyenne_transects_ha = moyT,
           moyenne_ha, erreurType_ha, ddl, ic95_bas, ic95_haut, avecTransect) |>
    rename(!!colClasse := classe)
}
transectsN <- read_csv(file.path(dossierSorties, "transects-grands-arbres-classes-n.csv"),
                       show_col_types = FALSE)
transectsG <- read_csv(file.path(dossierSorties, "transects-grands-arbres-classes-g.csv"),
                       show_col_types = FALSE)
classesNTransects <- combinerAvecTransects(
  classesN |> filter(classeDiam > 0), transectsN, "classeDiam", "N_ha",
  nrow(placettesClasses)) |>
  bind_rows(classeN0 |> transmute(classeDiam, moyenne_placettes_ha = moyenne_ha,
                                  moyenne_transects_ha = 0, moyenne_ha,
                                  ic95_bas, ic95_haut, avecTransect = FALSE)) |>
  arrange(classeDiam)
classesGTransects <- combinerAvecTransects(
  classesG |> select(-classeG, -borneSup), transectsG,
  "borneInf", "G_ha", nrow(placettesClasses)) |>
  mutate(borneSup = borneInf + 5, .after = borneInf)
write_csv(classesNTransects, file.path(dossierSorties,
                                       "classes-n-placettes-transects.csv"))
write_csv(classesGTransects, file.path(dossierSorties,
                                       "classes-g-placettes-transects.csv"))

message("✅ Sensibilite a l'ajout des placettes de Romiguiere :")
for (i in seq_len(nrow(resultats))) {
  r <- resultats[i, ]
  message("   ", r$indice, " | ", r$jeu, " (n = ", r$nbPlacettes, ") : ",
          round(r$estimation, 2),
          if (!is.na(r$ic95_bas)) paste0(" [", round(r$ic95_bas, 2), " ; ",
                                         round(r$ic95_haut, 2), "]") else "",
          if (!is.na(r$erreurType)) paste0(" ; erreur-type ",
                                           round(r$erreurType, 2)) else "")
}
