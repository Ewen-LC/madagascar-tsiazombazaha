// Glossaire et abréviations : mots à définir en colonne de gauche, définitions alignées sur une même colonne à droite (auteur, 04/11/2026).
#show terms: it => {
  set par(justify: false, leading: 0.5em)
  grid(
    columns: (auto, 1fr),
    column-gutter: 1.2em,
    row-gutter: 0.9em,
    ..it.children.map(c => (strong(c.term), c.description)).flatten(),
  )
}

#pagebreak(weak: true)
= Glossaire
/ _Ampazaka_ : chef de lignage.
/ Chablis : arbre ou tronc tombé naturellement au sol, qui ouvre une trouée dans la canopée.
/ Chandelle : arbre mort resté sur pied.
/ _Dina_ : règle locale de gestion, adoptée par la communauté, qui encadre l'accès et l'usage de la forêt.
/ _Fokonolona_ : communauté des habitants d'un _fokontany_.
/ _Fokontany_ : plus petite subdivision administrative de Madagascar, dirigée par un président.
/ Gaulis : jeunes tiges de plus de 1,30~m de haut dont la circonférence à hauteur de poitrine est inférieure à 8~cm.
/ _Lohatrano_ : subdivision du lignage, formée du ménage d'un père et de ses fils.
/ _Polisinala_ : patrouilleur communautaire du VOI.
/ Sauvageon : jeune plant issu de la régénération naturelle, prélevé en forêt pour être replanté.
/ Soudure : période précédant la récolte, pendant laquelle les réserves alimentaires des ménages sont épuisées.
/ _Tanety_ : colline dégradée, souvent reboisée.
/ _Tanimboly_ : terre de culture.
/ _Tavy_ : culture sur brûlis en forêt~: la parcelle est défrichée, brûlée puis plantée en riz de montagne, avant d'être abandonnée à la régénération naturelle.
/ _Tranobe_ : chez les Antemoro, à la fois le lignage, la grande maison sacrée où il accomplit les rituels ancestraux et son grand tombeau.
/ Transfert de gestion : contrat par lequel l'État confie la gestion d'une forêt à une communauté locale.

#pagebreak(weak: true)
= Liste des abréviations
/ ACE : _Abundance-based Coverage Estimator_, estimateur de la couverture d'échantillonnage fondé sur l'abondance.
/ ADRA : _Adventist Development and Relief Agency_, organisation non gouvernementale humanitaire.
/ AFD : Agence française de développement.
/ AGB : _Above-Ground Biomass_, biomasse aérienne.
/ ASGE : analyse stratégique de la gestion environnementale.
/ ASOS : Action socio-sanitaire organisation secours, organisation non gouvernementale malgache.
/ BNC-REDD+ : Bureau national de coordination REDD+, devenu le BNCCREDD+.
/ BNCCREDD+ : Bureau national des changements climatiques et de la REDD+.
/ BNGRC : Bureau national de gestion des risques et des catastrophes.
/ CBH : _Circumference at Breast Height_, circonférence à hauteur de poitrine.
/ CCNUCC : Convention-cadre des Nations unies sur les changements climatiques.
/ CEPF : _Critical Ecosystem Partnership Fund_ (Fonds de partenariat pour les écosystèmes critiques).
/ CF : fraction de carbone.
/ CIRAD : Centre de coopération internationale en recherche agronomique pour le développement.
/ CO₂ : dioxyde de carbone.
/ COBA : communauté de base.
/ CSV : _Comma-Separated Values_, format de fichier de données tabulaires.
/ DBH : _Diameter at Breast Height_, diamètre à hauteur de poitrine.
/ DoR : dominance relative (%).
/ DR : densité relative (%).
/ DREDD : Direction régionale de l'environnement et du développement durable.
/ EcoBois : projet mis en œuvre par Inter Aide à Madagascar.
/ EPSG : _European Petroleum Survey Group_, registre de référence des systèmes de coordonnées.
/ ESSA : École supérieure des sciences agronomiques (université d'Antananarivo).
/ ET : erreur-type.
/ FAO : Organisation des Nations unies pour l'alimentation et l'agriculture (_Food and Agriculture Organization_).
/ FFEM : Fonds français pour l'environnement mondial.
/ FID : Fonds d'intervention pour le développement.
/ FOLUR : _Food Systems, Land Use and Restoration_, programme du Fonds pour l'environnement mondial.
/ FORMAPROD : Programme de formation professionnelle et d'amélioration de la productivité agricole.
/ FR : fréquence relative (%).
/ GBIF : _Global Biodiversity Information Facility_.
/ GCF : gestion contractualisée des forêts.
/ GELOSE : gestion locale sécurisée des ressources naturelles renouvelables (loi GELOSE).
/ GFC : _Global Forest Change_, jeu de données mondial de perte de couvert forestier (Hansen et al., 2013).
/ GPS : _Global Positioning System_, système de positionnement par satellites.
/ IC : intervalle de confiance.
/ ICE : _Incidence-based Coverage Estimator_, estimateur de la couverture d'échantillonnage fondé sur l'incidence.
/ IVI : indice de valeur d'importance.
/ MEDD : Ministère de l'environnement et du développement durable.
/ MEFT : Ministère de l'environnement, des forêts et du tourisme.
/ NDVI : _Normalized Difference Vegetation Index_, indice de végétation par différence normalisée.
/ NMDS : _Non-metric Multidimensional Scaling_, positionnement multidimensionnel non métrique.
/ OCHA : _Office for the Coordination of Humanitarian Affairs_ (Bureau de la coordination des affaires humanitaires des Nations unies).
/ ONE : Office national pour l'environnement.
/ ONG : organisation non gouvernementale.
/ PAM : Programme alimentaire mondial.
/ PDF : _Portable Document Format_, format de document.
/ PRISMA : _Preferred Reporting Items for Systematic Reviews and Meta-Analyses_.
/ PROSPERER : Programme de soutien aux pôles de micro-entreprises rurales et aux économies régionales.
/ PSDR : Projet de soutien au développement rural.
/ REDD+ : réduction des émissions dues à la déforestation et à la dégradation des forêts.
/ SENS : Savoirs, environnement et sociétés (unité mixte de recherche).
/ SQ : sous-question.
/ TGRN : transfert de gestion des ressources naturelles.
/ UFR : unité de formation et de recherche.
/ UICN : Union internationale pour la conservation de la nature.
/ UMR : unité mixte de recherche.
/ UTM : _Universal Transverse Mercator_, système de projection cartographique.
/ VOI : _Vondron'Olona Ifotony_, communauté de base chargée de la gestion forestière.
/ WGS84 : _World Geodetic System 1984_.
/ WWF : _World Wide Fund for Nature_ (Fonds mondial pour la nature).

#pagebreak(weak: true)
= Table des tableaux
#outline(title: none, target: figure.where(kind: table))

#pagebreak(weak: true)
= Table des figures
#outline(title: none, target: figure.where(kind: image))
