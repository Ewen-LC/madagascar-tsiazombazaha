# Figure : estimations publiées de la surface forestière de Madagascar (1920-2014)
# Données : 02-donnees/estimations-surface-forestiere.csv (valeurs recopiées des publications, aucun calcul).
#   - Vieilledent et al. (2018) : tableaux 1 et 2 de la prépublication bioRxiv (doi:10.1101/147827),
#     à contrôler dans la version publiée (Biological Conservation, 222, 189-197).
#   - Green et Sussman (1990) : valeurs reprises du texte de l'Introduction.
#   - Autres estimations : compilées par Amelot (2017, p. 36-37).
# Sortie : 05-rapport/analyse-figures/estimations-surface-forestiere.svg
# Niveaux de gris, sans titre dans l'image (légende dans le mémoire).
# Lancer depuis la racine du dépôt : Rscript 03-scripts/figure-estimations-surface-forestiere.R

library(ggplot2)

d <- read.csv("02-donnees/estimations-surface-forestiere.csv", encoding = "UTF-8")

niveaux <- c("Vieilledent et al. (2018) - forêts naturelles",
             "Vieilledent et al. (2018) - forêts humides",
             "Green et Sussman (1990) - forêts humides",
             "Autres estimations (Amelot 2017)")
d$serie <- factor(d$serie, levels = niveaux)
series <- d[d$serie != niveaux[4], ]
autres <- d[d$serie == niveaux[4], ]

# Une seule légende : forme et type de trait partagent le même nom et les mêmes niveaux.
# Pour « Autres estimations », pas de trait ; la barre verticale donne la fourchette (Humbert, 1927).
p <- ggplot() +
  geom_line(data = series, aes(annee, surface_min_mha, linetype = serie, shape = serie), colour = "black") +
  geom_point(data = series, aes(annee, surface_min_mha, linetype = serie, shape = serie), size = 2) +
  geom_linerange(data = autres, aes(annee, ymin = surface_min_mha, ymax = surface_max_mha), colour = "grey45") +
  geom_point(data = autres, aes(annee, (surface_min_mha + surface_max_mha) / 2, linetype = serie, shape = serie),
             size = 2, colour = "grey45") +
  scale_shape_manual(values = c(15, 16, 1, 17), drop = FALSE, name = NULL) +
  scale_linetype_manual(values = c("solid", "dashed", "dotted", "blank"), drop = FALSE, name = NULL) +
  scale_x_continuous(breaks = seq(1920, 2020, 10)) +
  scale_y_continuous(limits = c(0, 20), breaks = seq(0, 20, 5)) +
  labs(x = "Année", y = "Surface forestière (millions d'hectares)") +
  theme_bw(base_size = 10) +
  theme(legend.position = "bottom", legend.direction = "vertical",
        legend.key.width = unit(1.2, "cm"),
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "white", colour = NA))

ggsave("05-rapport/analyse-figures/estimations-surface-forestiere.svg",
       p, width = 16, height = 11, units = "cm")
