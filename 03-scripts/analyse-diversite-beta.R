# Ewen Le Coeur
# 2026
# Objectif : diversite beta (§3.4 du document d'etape) — dissimilarites
# entre placettes (Jaccard), beta de Whittaker, NMDS, figure et exports.
# Arbitrage auteur du 04/11/2026 : Jaccard seul (Bray-Curtis apporte peu
# avec une majorite d'especes a une tige par placette), test de
# permutation des communes retire.
#
# Structure du code :
#   - fonctions-diversite.R   : calculer_abondances (partage avec l'alpha)
#   - fonctions-diversite-beta.R : fonctions de calcul (matrices, paires)
#   - analyse-diversite-beta.R : CE SCRIPT — orchestration, figure, sorties
#
# Utilisation :
#   source("03-scripts/analyse-diversite-beta.R")

source("03-scripts/fonctions/fonctions-diversite.R")
source("03-scripts/fonctions/fonctions-diversite-beta.R")

if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
if (!requireNamespace("scales", quietly = TRUE)) install.packages("scales")
if (!requireNamespace("vegan", quietly = TRUE)) install.packages("vegan")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("tidyr", quietly = TRUE)) install.packages("tidyr")
if (!requireNamespace("readr", quietly = TRUE)) install.packages("readr")
if (!requireNamespace("stringr", quietly = TRUE)) install.packages("stringr")
if (!requireNamespace("tibble", quietly = TRUE)) install.packages("tibble")

library(ggplot2)
library(scales)
library(vegan)
library(dplyr)
library(tidyr)
library(readr)
library(stringr)
library(tibble)

### Import des donnees CSV ###

dossierDonnees <- "02-donnees/ecologie"
dossierReferentiels <- "02-donnees/referentiels"

# Reconciliation taxonomique
reconciliation <- read_csv(
  file.path(dossierReferentiels, "reconciliation-taxonomique.csv"),
  show_col_types = FALSE
)

# Correspondances : nom brut → nom reconcilie
correspondances <- reconciliation |>
  distinct(`nom-vernaculaire-brut`, `nom-vernaculaire-reconcilie`)
correspondances <- stats::setNames(
  correspondances$`nom-vernaculaire-reconcilie`,
  correspondances$`nom-vernaculaire-brut`
)

# Flore : observations (gaulis + tiges mesurees en circonference)
flore_brut <- read_csv(
  file.path(dossierDonnees, "flore.csv"),
  show_col_types = FALSE
)

# d$flore : une ligne par observation
d_flore <- flore_brut |>
  rename(
    cdPlacette = placette,
    cdObs = `code-observation-flore`,
    nomVernaculaire = `nom-vernaculaire-brut`,
    gaulis = `nombre-gaulis`
  ) |>
  mutate(gaulis = suppressWarnings(as.numeric(gaulis)))

# d$floreTiges : format long des circonferences mesurees
cols_circ <- c("Circ1", "Circ2", "Circ3", "Circ4", "Circ5", "Circ6",
               "Cir7", "Circ8", "Circ9", "Cir10")
cols_circ_present <- intersect(cols_circ, names(flore_brut))

d_floreTiges <- flore_brut |>
  select(placette, `code-observation-flore`, `nom-vernaculaire-brut`,
         all_of(cols_circ_present)) |>
  pivot_longer(
    cols = all_of(cols_circ_present),
    names_to = "numTige",
    values_to = "circ_cm"
  ) |>
  filter(!is.na(circ_cm)) |>
  mutate(circ_cm = suppressWarnings(as.numeric(circ_cm))) |>
  filter(!is.na(circ_cm)) |>
  rename(
    cdPlacette = placette,
    cdObs = `code-observation-flore`,
    nomVernaculaire = `nom-vernaculaire-brut`
  ) |>
  select(cdPlacette, cdObs, nomVernaculaire, circ_cm, numTige)

# Placettes
d_placettes <- read_csv(
  file.path(dossierDonnees, "placettes.csv"),
  show_col_types = FALSE,
  col_types = cols(
    `surface-horizontale` = col_character(),
    `surface-corrigee` = col_character()
  )
) |>
  rename(
    cdPlacette = placette,
    cdTransect = transect,
    surfaceHorizontale_m2 = `surface-horizontale`
  ) |>
  mutate(
    surfaceHorizontale_m2 = as.numeric(gsub(",", ".", surfaceHorizontale_m2))
  )

# Transects
d_transects <- read_csv(
  file.path(dossierDonnees, "transects.csv"),
  show_col_types = FALSE
) |>
  rename(cdTransect = transect)

# Assemblage de l'objet d
d <- list(
  flore = d_flore,
  floreTiges = d_floreTiges,
  placettes = d_placettes,
  transects = d_transects
)

dossierSorties <- "04-sorties"
if (!dir.exists(dossierSorties)) dir.create(dossierSorties, recursive = TRUE)

### Theme commun des figures ###

theme_axes <- theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.line = element_line(arrow = grid::arrow(length = grid::unit(0.25, "cm"),
                                                  type = "closed")),
    axis.ticks = element_line(linewidth = 0.4),
    axis.ticks.length = grid::unit(0.15, "cm"),
    axis.text = element_text(size = 9),
    plot.title = element_text(size = 11, face = "bold"),
    plot.subtitle = element_text(size = 9)
  )

### Matrice d'abondances ###

abondances <- calculer_abondances(d, correspondances)
matAbond <- matrice_abondances(abondances)

### Dissimilarites entre paires de placettes ###

paires <- table_paires(matAbond)

# Sorensen et Bray-Curtis restent calcules dans la table paires, mais
# ne sont ni resumes ni affiches (Jaccard seul, 04/11/2026).
resumeDissim <- bind_rows(
  tibble(indice = "Jaccard (presence-absence)",
         moyenne = mean(paires$jaccard), ecartType = sd(paires$jaccard))
)
# Valeurs brutes dans les CSV : l'arrondi se fait dans le rapport (05/11/2026)

### Beta de Whittaker ###

whit <- whittaker_beta(matAbond)

### Beta additif (richesse) ###

# beta_add = gamma - alpha_moyen : nombre moyen d'especes
# "supplementaires" gagnees en parcourant les placettes.
betaAdditif <- whit$gamma - whit$alphaMoyen

### NMDS sur Jaccard (ordination des placettes) ###

# binary = TRUE : Jaccard en presence-absence, identique a jaccard()
# de fonctions-diversite-beta.R. Graine fixee pour la reproductibilite
# des departs aleatoires de metaMDS.
distJac <- vegan::vegdist(matAbond, method = "jaccard", binary = TRUE)
set.seed(2026)
nmdsRes <- vegan::metaMDS(distJac, k = 2, trymax = 100, trace = 0)

correspTransects <- d$placettes |>
  dplyr::select(cdTransect, cdPlacette) |>
  dplyr::left_join(
    d$transects |> dplyr::select(cdTransect, polisnala, commune),
    by = "cdTransect")

pointsNMDS <- tibble::tibble(
  cdPlacette = rownames(nmdsRes$points),
  NMDS1 = nmdsRes$points[, 1],
  NMDS2 = nmdsRes$points[, 2]
) |>
  dplyr::left_join(correspTransects, by = "cdPlacette")

if (!requireNamespace("ggrepel", quietly = TRUE)) install.packages("ggrepel")
library(ggrepel)

nTransects <- length(unique(pointsNMDS$cdTransect))
formes <- c(0:25)[seq_len(nTransects)]

figNMDS <- ggplot(pointsNMDS, aes(x = NMDS1, y = NMDS2,
                                   shape = cdTransect)) +
  geom_point(size = 2.5, colour = "grey20") +
  scale_shape_manual(values = formes, name = "Transect") +
  scale_x_continuous(breaks = scales::breaks_pretty(n = 5),
                     expand = expansion(mult = 0.08)) +
  scale_y_continuous(breaks = scales::breaks_pretty(n = 5),
                     expand = expansion(mult = 0.08)) +
  labs(x = "NMDS 1", y = "NMDS 2") +
  theme_axes

ggsave(file.path(dossierSorties, "diversite-beta-nmds.svg"),
       figNMDS, width = 14, height = 12, units = "cm")

### Jaccard par niveau hierarchique (transect / polisn'ala / commune) ###

# Chaque paire de placettes est classee selon le niveau auquel les deux
# placettes appartiennent a la meme entite : meme transect > meme
# polisn'ala > meme commune > communes differentes.
metaPlacettes <- pointsNMDS |> dplyr::select(cdPlacette, cdTransect,
                                            polisnala, commune)

pairesNiveaux <- paires |>
  dplyr::left_join(metaPlacettes, by = c("placette1" = "cdPlacette")) |>
  dplyr::rename(transect1 = cdTransect, polisnala1 = polisnala,
                commune1 = commune) |>
  dplyr::left_join(metaPlacettes, by = c("placette2" = "cdPlacette")) |>
  dplyr::rename(transect2 = cdTransect, polisnala2 = polisnala,
                commune2 = commune) |>
  dplyr::mutate(
    niveau = dplyr::case_when(
      transect1 == transect2 ~ "Même transect",
      polisnala1 == polisnala2 ~ "Même polisn'ala",
      commune1 == commune2 ~ "Même commune",
      TRUE ~ "Entre communes"
    ),
    niveau = factor(niveau, levels = c(
      "Même transect", "Même polisn'ala", "Même commune",
      "Entre communes"))
  )

resumeNiveaux <- pairesNiveaux |>
  dplyr::group_by(niveau) |>
  dplyr::summarise(
    nbPaires = dplyr::n(),
    moyenne = mean(jaccard),
    ecartType = sd(jaccard),
    .groups = "drop"
  )

# (figure remplacee par le gradient Jaccard : voir plus bas)

# Regroupement Ambila/Mizilo vs Ambahatrazo retire (arbitrage auteur du
# 31/10/2026) : contraste nord/sud non concluant et sans apport.

# (figure remplacee par le gradient Jaccard : voir plus bas)

### Gradient transect -> polisn'ala -> commune (Jaccard, presence-absence) ###

# Objectif : savoir si un polisn'ala (ou une commune) voit/nomme des
# especes differentes des autres, independamment des abondances. La
# dissimilarite de Jaccard compare les listes d'especes (reconciliees)
# sans ponderation d'abondance.
# Tests : Kruskal-Wallis global puis Wilcoxon deux a deux (correction
# de Holm). Les paires ne sont pas independantes (une placette apparait
# dans plusieurs paires) : p-values non valides (pseudo-replication).
# Arbitrage auteur du 31/10/2026 : tests conserves pour tracabilite dans
# le CSV *_tests_niveaux_jaccard, absents du rapport.
testKWJac <- stats::kruskal.test(jaccard ~ niveau, data = pairesNiveaux)
testsPairsJac <- stats::pairwise.wilcox.test(pairesNiveaux$jaccard,
                                            pairesNiveaux$niveau,
                                            p.adjust.method = "holm")
tableTestsJac <- as.data.frame(as.table(testsPairsJac$p.value))
names(tableTestsJac) <- c("niveau1", "niveau2", "p")
tableTestsJac <- tableTestsJac |>
  dplyr::filter(!is.na(p)) |>
  dplyr::mutate(p = round(p, 4))

niveauxOrdres <- levels(pairesNiveaux$niveau)
posNiveau <- stats::setNames(seq_along(niveauxOrdres), niveauxOrdres)
combis <- utils::combn(niveauxOrdres, 2, simplify = FALSE)

# etoiles de significativite (convention usuelle)
etoile <- function(p) {
  dplyr::case_when(
    is.na(p) ~ "",
    p < 0.001 ~ "***",
    p < 0.01 ~ "**",
    p < 0.05 ~ "*",
    TRUE ~ "ns"
  )
}

# p-value exacte d'une paire de niveaux, par reunion robuste (plus de cle texte)
p_de <- function(nA, nB) {
  hit <- tableTestsJac |>
    dplyr::filter((niveau1 == nA & niveau2 == nB) |
                  (niveau1 == nB & niveau2 == nA))
  if (nrow(hit) == 0) return(NA_real_)
  hit$p[1]
}

# Hauteur d'accolade selon la "portee" de la comparaison : les
# comparaisons adjacentes (1-2, 2-3, 3-4) sont basses, les
# comparaisons larges (1-3, 2-4, 1-4) sont plus hautes, sans
# chevauchement possible (une accolade ne croise jamais une autre).
portee <- function(nA, nB) {
  abs(posNiveau[[nB]] - posNiveau[[nA]])
}
# Hauteurs par position exacte (degre de liberte : aucune accolade
# ne partage un point d'ancrage a la meme hauteur) :
#   1-2 : 1,06   2-3 : 1,12   3-4 : 1,06
#   1-3 : 1,18   2-4 : 1,18
#   1-4 : 1,24
hautPosition <- c(
  "1 2" = 1.06, "2 3" = 1.12, "3 4" = 1.06,
  "1 3" = 1.18, "2 4" = 1.18,
  "1 4" = 1.24
)

pairesGrad <- dplyr::bind_rows(lapply(seq_along(combis), function(k) {
  cc <- combis[[k]]
  pv <- p_de(cc[1], cc[2])
  xi <- min(posNiveau[cc[1]], posNiveau[cc[2]])
  xj <- max(posNiveau[cc[1]], posNiveau[cc[2]])
  tibble(
    niveauA = cc[1], niveauB = cc[2],
    x = xi, xend = xj,
    y = hautPosition[[paste(xi, xj)]],
    p = pv,
    etoile = etoile(pv)
  )
}))

# Figure descriptive : pas d'etoiles de significativite (tests non
# valides sur des paires non independantes, cf. ci-dessus).

figGradient <- ggplot(pairesNiveaux,
                      aes(x = niveau, y = jaccard, group = niveau)) +
  geom_boxplot(show.legend = FALSE, linewidth = 0.3, outlier.size = 0.8,
               fill = "grey85", colour = "grey20",
               outlier.colour = "grey20") +
  coord_cartesian(ylim = c(0, 1.02)) +
  scale_x_discrete(labels = function(l) paste0(l, "\n(n = ",
    as.integer(table(pairesNiveaux$niveau)[l]), ")")) +
  scale_y_continuous(breaks = seq(0, 1, by = 0.2),
                     expand = expansion(mult = c(0.02, 0.02))) +
  labs(x = NULL, y = "Jaccard (présence-absence)") +
  theme_axes +
  theme(axis.text.x = element_text(size = 8))

ggsave(file.path(dossierSorties, "diversite-beta-gradient.svg"),
       figGradient, width = 18, height = 13, units = "cm")

### Especes par commune ###

# Test de permutation des communes retire (arbitrage auteur du
# 04/11/2026) : il recoupait la comparaison par niveau et se confondait
# avec l'effet de l'observateur (un polisn'ala par itineraire). Le
# nombre de communes par espece reste exporte, sans test.
placettesCommunes <- metaPlacettes |>
  dplyr::filter(!is.na(commune)) |>
  dplyr::select(cdPlacette, commune)

communesPlacettes <- stats::setNames(placettesCommunes$commune,
                                     placettesCommunes$cdPlacette)

especesParCommune <- abondances |>
  dplyr::filter(cdPlacette %in% placettesCommunes$cdPlacette) |>
  dplyr::distinct(cdPlacette, espece) |>
  dplyr::mutate(commune = communesPlacettes[cdPlacette]) |>
  dplyr::distinct(espece, commune) |>
  dplyr::count(espece, name = "nbCommunes") |>
  dplyr::arrange(dplyr::desc(nbCommunes), espece) |>
  dplyr::mutate(monoCommune = nbCommunes == 1)

### Exports ###

readr::write_csv(paires,
                 file.path(dossierSorties, "diversite-beta-paires.csv"))
readr::write_csv(resumeDissim,
                 file.path(dossierSorties, "diversite-beta-resume.csv"))
readr::write_csv(tibble::tibble(
  alphaMoyen = whit$alphaMoyen,
  gamma = whit$gamma,
  betaMultiplicatif = whit$beta,
  betaAdditif = betaAdditif
),
file.path(dossierSorties, "diversite-beta-whittaker.csv"))
readr::write_csv(pointsNMDS,
                 file.path(dossierSorties, "diversite-beta-nmds-points.csv"))
readr::write_csv(pairesNiveaux |>
                   dplyr::select(placette1, placette2, niveau, jaccard),
                 file.path(dossierSorties, "diversite-beta-paires-niveaux.csv"))
readr::write_csv(resumeNiveaux,
                 file.path(dossierSorties, "diversite-beta-jaccard-niveaux.csv"))
readr::write_csv(tableTestsJac,
                 file.path(dossierSorties, "diversite-beta-tests-niveaux-jaccard.csv"))
readr::write_csv(especesParCommune,
                 file.path(dossierSorties, "diversite-beta-especes-par-commune.csv"))
### Resume synthetique pour le rapport ###

resumeRapport <- dplyr::bind_rows(
  # Beta multiplicatif (Whittaker)
  tibble(
    section = "Beta multiplicatif (Whittaker)",
    indice = "Beta = gamma / alpha moyen",
    valeur = whit$beta,
    ic95_bas = NA_real_, ic95_haut = NA_real_,
    p_value = NA_real_, n = NA_integer_,
    details = paste0("alpha moyen = ", round(whit$alphaMoyen, 1),
                     ", gamma = ", whit$gamma)
  ),
  # Beta additif
  tibble(
    section = "Beta additif",
    indice = "Beta additif = gamma - alpha moyen",
    valeur = betaAdditif,
    ic95_bas = NA_real_, ic95_haut = NA_real_,
    p_value = NA_real_, n = NA_integer_,
    details = paste0("alpha moyen = ", round(whit$alphaMoyen, 1),
                     ", gamma = ", whit$gamma)
  ),
  # NMDS
  tibble(
    section = "NMDS (Jaccard)",
    indice = "Stress",
    valeur = nmdsRes$stress,
    ic95_bas = NA_real_, ic95_haut = NA_real_,
    p_value = NA_real_, n = nrow(matAbond),
    details = "k = 2, Jaccard presence-absence"
  ),
  # Jaccard moyen sur toutes les paires
  tibble(
    section = "Jaccard (toutes paires)",
    indice = "Moyenne",
    valeur = resumeDissim$moyenne,
    ic95_bas = NA_real_, ic95_haut = NA_real_,
    p_value = NA_real_, n = nrow(paires),
    details = paste0("moyenne ± ecart-type = ", round(resumeDissim$moyenne, 3),
                     " ± ", round(resumeDissim$ecartType, 3))
  ),
  # Jaccard par niveau : moyennes (descriptif)
  resumeNiveaux |>
    dplyr::transmute(
      section = "Jaccard par niveau",
      indice = as.character(niveau),
      valeur = moyenne,
      ic95_bas = NA_real_, ic95_haut = NA_real_,
      p_value = NA_real_,
      n = nbPaires,
      details = paste0("moyenne ± ecart-type = ", round(moyenne, 3), " ± ",
                       round(ecartType, 3))
    )
)

readr::write_csv(resumeRapport,
                 file.path(dossierSorties, "diversite-beta-resume-rapport.csv"))

### Messages ###

message("✅ Diversité beta (§3.4) — ", nrow(matAbond),
        " placettes, ", ncol(matAbond), " espèces :")
for (i in seq_len(nrow(resumeDissim))) {
  r <- resumeDissim[i, ]
  message("   ", r$indice, " : ", r$moyenne, " ± ", r$ecartType)
}
message("   Beta multiplicatif (Whittaker) : ", round(whit$beta, 2),
        " (alpha moyen ", round(whit$alphaMoyen, 1),
        ", gamma ", whit$gamma, ")")
message("   Beta additif : ", round(betaAdditif, 1),
        " especes (gamma - alpha moyen)")
message("   NMDS Jaccard : stress = ", round(nmdsRes$stress, 3))
message("   Jaccard par niveau :")
for (i in seq_len(nrow(resumeNiveaux))) {
  r <- resumeNiveaux[i, ]
  message("     ", r$niveau, " : ", r$moyenne, " ± ", r$ecartType,
          " (n = ", r$nbPaires, " paires)")
}
message("   Especes vues dans une seule commune : ",
        round(mean(especesParCommune$monoCommune), 3))

list(
  donnees = d,
  abondances = abondances,
  matAbond = matAbond,
  paires = paires,
  resumeDissim = resumeDissim,
  whittaker = whit,
  betaAdditif = betaAdditif,
  nmds = nmdsRes,
  pointsNMDS = pointsNMDS,
  pairesNiveaux = pairesNiveaux,
  resumeNiveaux = resumeNiveaux,
  tableTestsJac = tableTestsJac,
  especesParCommune = especesParCommune
)
