#import "TitresCourts.typ": titre-court


#show figure.where(kind: "annexe"): set figure.caption(position: top)
#set figure(numbering: "1")
#show figure.where(kind: "annexe"): set block(breakable: true)

// Formatage des valeurs importées des CSV (autorisé par l'auteur le 01/11/2026) :
// arrondi à `decimales`, virgule décimale, signe moins typographique ; les textes et « NA » sont rendus tels quels.
#let nombre(x, decimales: 2) = {
  if x.match(regex("^-?[0-9]+(\.[0-9]+)?([eE]-?[0-9]+)?$")) == none { return x }
  let v = calc.round(float(x), digits: decimales)
  let parties = str(calc.abs(v)).split(".")
  let dec = if parties.len() > 1 { parties.at(1) } else { "" }
  while dec.len() < decimales { dec += "0" }
  let signe = if v < 0 { "−" } else { "" }
  if decimales == 0 { signe + parties.at(0) } else { signe + parties.at(0) + "," + dec }
}

// Grands tableaux : import csv() depuis analyse-tables/ (copies des sorties R, 01/11/2026) ; petits tableaux : saisie manuelle.
#let placettesN = csv("analyse-tables/structure_N_placettes.csv").slice(1)
#let placettesG = csv("analyse-tables/structure_G_placettes.csv").slice(1)
#let placettesAlpha = csv("analyse-tables/diversite_alpha_placettes.csv").slice(1)
#let classesN = csv("analyse-tables/sensibilite_romiguiere_classes_N.csv").slice(1)
#let classesG = csv("analyse-tables/sensibilite_romiguiere_classes_G.csv").slice(1)
#let classesNGA = csv("analyse-tables/transects_grands_arbres_classes_N.csv").slice(1)
#let classesGGA = csv("analyse-tables/transects_grands_arbres_classes_G.csv").slice(1)
#let pointsNMDS = csv("analyse-tables/diversite_beta_nmds_points.csv").slice(1)
#let ivi = csv("analyse-tables/ivi_especes.csv").slice(1)
#let rarefaction = csv("analyse-tables/courbe_raréfaction_extrapolation.csv").slice(1)
// Annexe allégée : toutes les lignes de raréfaction, une ligne d'extrapolation sur quatre (jusqu'au point final, 112 placettes)
#let rarefactionExtrap = rarefaction.filter(r => r.at(2) == "Extrapolation")
#let rarefactionAnnexe = rarefaction.filter(r => r.at(2) != "Extrapolation") + rarefactionExtrap.enumerate().filter(((i, r)) => calc.rem(rarefactionExtrap.len() - 1 - i, 4) == 0).map(((i, r)) => r)
#let carbone = csv("analyse-tables/carbone_stocks.csv").slice(1)
#let libellesCarbone = ("Grands arbres (transects 10 m)": "Grands arbres des transects", "Tiges placettes (flore)": "Tiges des placettes", "Bois mort au sol (line intersect)": "Bois mort au sol", "Bois mort sur pied (chandelles)": "Bois mort sur pied")
// Ancien tableau saisi à la main retiré le 01/11/2026 : valeurs antérieures à la mise à jour des longueurs de transects (grands arbres 15,71 tC/ha) et ligne « Total » sommée à la main. TODO : stock total et stocks extrapolés à la forêt (colonnes *_total_* du CSV, 500 ha provisoires) à ajouter une fois la surface QGIS connue et le total exporté par le script.
#let methodes = (Rarefaction: "Interpolation", Observed: "Observé", Extrapolation: "Extrapolation")

= Table des annexes

#outline(title: none, target: figure.where(kind: "annexe"))


// Structure proposée le 01/11/2026 : une entrée par annexe, dans l'ordre de premier renvoi dans le texte (M&M puis Résultats).
// Les renvois du texte sont pour l'instant écrits « (ANNEXE : …) » en clair : Resultats.typ et MaterielMethodes.typ compilent seuls et ne voient pas ces étiquettes. Les remplacer par @annexe-… une fois les fichiers réunis dans main.typ.
// Tableaux tirés des CSV : saisie manuelle arrondie à deux décimales, ou import csv() — l'import brut affiche les décimales à point et non arrondies ; à arbitrer (pas de fonction personnalisée).

#pagebreak(weak: true)

#figure(
  [
    // TODO : Carte d'intervention du projet (Inter Aide). Source et droits de reproduction à vérifier. Renvoi : Introduction ou M&M, Site d'étude.
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Zone d'intervention du projet EcoBois],
) <annexe-carte-ecobois>
#titre-court(<annexe-carte-ecobois>)[Zone d'intervention du projet EcoBois]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 1.5fr, 2fr, 3fr, 1fr),
    align: (center, center, center, left, center),
    table.header([*Code*], [*Date*], [*Fokontany*], [*Motif*], [*Trace GPS*]),
    // Données depuis metadonnees_enquete-de-terrain_2_sorties.csv
    ..("S1", "?", "Andriana", "Observation plantation tranobe IA", "Non"),
    ..("S2", "16/06/26", "Manakana", "Chantier de plantation Manakana", "Non"),
    ..("S3", "03/07/26", "Mizilo Gara", "Observation de Tsiazombazaha de loin et entretiens", "Non"),
    ..("S4", "24/07/26", "Manakana", "Prospection des sources", "Oui"),
    ..("S5", "06/08/26", "Mizilo Gara", "Tracé de la route de FIANTSO", "Oui"),
    ..("S6", "07/08/26", "Mizilo Gara", "Observation de la flore agricole", "Non"),
    ..("S7", "17/08/26", "Manakana", "Observation de la flore agricole", "Non"),
    ..("S8", "18/08/26", "Manakana", "Une placette", "Oui"),
    ..("S9", "19/08/26", "Manakana", "Chemin Manakana – Andriana", "Oui"),
    ..("S10", "20/08/26", "Manakana", "Une placette", "Oui"),
    ..("S11", "25/08/26", "Manakana", "Deux placettes", "Oui"),
    ..("S12", "26/08/26", "Manakana", "Chemin Manakana – Ambila", "Oui"),
    ..("S13", "27/08/26", "Manakana", "Quatre placettes", "Oui"),
    ..("S14", "02/09/26", "Mizilo Gara", "Quatre placettes", "Oui"),
    ..("S15", "03/09/26", "Mizilo Gara", "Assemblée générale du VOI", "Non"),
    ..("S16", "04/09/26", "Mizilo Gara", "Une placette, une piscine naturelle, échanges", "Oui"),
    ..("S17", "08/09/26", "Manakana", "Tournée Sarah – reboisement tranobe en natif", "Non"),
    ..("S18", "09/09/26", "Andriana", "Tournée Sarah – reboisement VOI", "Non"),
    ..("S19", "11/09/26", "Mizilo Gara", "Quatre placettes", "Oui"),
    ..("S20", "15/09/26", "Andriana", "Quatre placettes", "Oui"),
    ..("S21", "16/09/26", "Andriana", "Quatre placettes", "Oui"),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Liste des 21 sorties de terrain. Source : métadonnées enquête de terrain, fichier metadonnees_enquete-de-terrain_2_sorties.csv, n = 21, date de collecte : 15/05–16/09/2026.],
) <annexe-sorties>
#titre-court(<annexe-sorties>)[Liste des sorties de terrain]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1.5fr, 1fr, 1fr, 2.5fr, 2fr, 2fr),
    align: (center, center, center, left, left, left),
    table.header([*Code*], [*Genre*], [*Âge*], [*Profession*], [*Lien au VOI*], [*Fokontany*]),
    // Données anonymisées depuis metadonnees_enquete-de-terrain_3_enquetes.csv
    ..("ENQ01", "H", "?", "Responsable programme", "N/A", "Manakara"),
    ..("ENQ02", "H", "30", "Coordinateur socio-environnemental", "N/A", "Manakana"),
    ..("ENQ03", "H", "65", "Agriculteur", "Vice-président", "Mizilo Gara"),
    ..("ENQ04", "H", "57", "Agriculteur", "Polisn'ala", "Mizilo Gara"),
    ..("ENQ05", "H", "?", "Président fokontany", "?", "Mizilo Gara"),
    ..("ENQ06", "H", "?", "?", "Aucun", "Tsiazombazaha / Ampasipotsy"),
    ..("ENQ07", "F", "?", "?", "Aucun", "Tsiazombazaha / Ampasipotsy"),
    ..("ENQ08", "H", "36", "Agriculteur", "Aucun", "Mizilo Gara"),
    ..("ENQ09", "H", "40", "Agriculteur", "Aucun", "Mizilo Gara"),
    ..("ENQ10", "H", "62", "?", "Observateur", "Mizilo Gara"),
    ..("ENQ11", "H", "?", "Agriculteur, maire", "Membre", "Mizilo Gara"),
    ..("ENQ12", "H", "66", "Agriculteur", "Secrétaire", "Mizilo Gara"),
    ..("ENQ13", "H", "35", "Instituteur", "Membre", "Mizilo Gara"),
    ..("ENQ14", "F", "28", "Agricultrice, vannière", "Membre", "Mizilo Gara"),
    ..("ENQ15", "H", "47", "Agriculteur", "Ancien membre", "Mizilo Gara"),
    ..("ENQ16", "F", "37", "Agricultrice, vannière", "Ancienne membre", "Mizilo Gara"),
    ..("ENQ17", "H", "?", "Président fokontany", "", "Andriana"),
    ..("ENQ18", "H", "?", "Agriculteur, éleveur", "Président du VOI", "Andriana"),
    ..("ENQ19", "H", "?", "Agriculteur", "Pépiniériste, polisn'ala", "Andriana"),
    ..("ENQ20", "H", "?", "?", "Pépiniériste", "Andriana"),
    ..("ENQ21", "F", "54", "Agent communautaire", "Membre", "Andriana"),
    ..("ENQ22", "H", "26", "Agriculteur", "Polisn'ala", "Andriana"),
    ..("ENQ23", "H", "?", "?", "Conseiller, polisn'ala", "Andriana"),
    ..("ENQ24", "H", "?", "?", "Polisn'ala, comité feu", "Ampasipotsy"),
    ..("ENQ25", "F", "?", "?", "Membre", "Ampasipotsy"),
    ..("ENQ26", "H", "?", "Président fokontany", "Comité feu", "Ampasipotsy"),
    ..("ENQ27", "H", "?", "?", "Vice-président", "Ambahatrazo"),
    ..("ENQ28", "H", "?", "?", "Trésorier", "Manakana"),
    ..("ENQ29", "H", "?", "Président fokontany", "Polisn'ala", "Manakana"),
    ..("ENQ30", "H", "?", "Vice-président fokontany", "", "Manakana"),
    ..("ENQ31", "H", "?", "?", "", "Manakana"),
    ..("ENQ32", "H", "?", "?", "", "Manakana"),
    ..("ENQ33", "H", "50", "Agriculteur", "Polisn'ala", "Manakana"),
    ..("ENQ34", "F", "38", "Agent communautaire", "Aucun", "Ambalavolo"),
    ..("ENQ35", "H", "25", "Agriculteur", "Aucun", "Ambalavolo"),
    ..("ENQ36", "F", "21", "Agricultrice, commerçante", "Aucun", "Ambalavolo"),
    ..("ENQ37", "H", "51", "Agriculteur, polisn'ala", "Polisn'ala", "Ambalavolo"),
    ..("ENQ38", "H", "49", "Ampazaka, agriculteur", "Membre", "Amborodra"),
    ..("ENQ39", "H", "65", "Agriculteur", "Ancien membre", "Amborodra"),
    ..("ENQ40", "H", "55", "Agriculteur, président fokontany", "Membre", "Amborodra"),
    ..("ENQ41", "H", "40", "Agriculteur, adjoint", "Membre", "Amborodra"),
    ..("ENQ42", "H", "69", "Agriculteur", "Membre", "Amborodra"),
    ..("ENQ43", "H", "?", "Agriculteur", "Polisn'ala", "Manakana"),
    ..("ENQ44", "F", "?", "Technicienne", "Aucun", "Manakana"),
    ..("ENQ45", "H", "43", "Agriculteur", "Membre", "Manakana"),
    ..("ENQ46", "H", "35", "Agriculteur, mpanzaka", "Pépiniériste", "Manakana"),
    ..("ENQ47", "F", "30", "Agricultrice", "Aucun / Membre", "Manakana"),
    ..("ENQ48", "H", "47", "Agriculteur", "Membre", "Manakana"),
    ..("ENQ49", "F", "38", "", "Membre", "Manakana"),
    ..("ENQ50", "H", "?", "?", "Polisn'ala", "Andriana"),
    ..("ENQ51", "H", "?", "?", "Membre", "Andriana"),
    ..("ENQ52", "H", "?", "?", "Membre", "Andriana"),
    ..("ENQ100", "H", "54", "Agriculteur, ampazaka", "Polisn'ala", "Mizilo Gara"),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Description des personnes rencontrées en entretien ou en sortie (n = 53, dont 50 en entretien). Genre : H = homme, F = femme ; Âge : en années (2026) ; Lien au VOI : polisin'ala = gardien de la forêt. Source : métadonnées enquête de terrain, fichier metadonnees_enquete-de-terrain_3_enquetes.csv, date de collecte : 15/05–16/09/2026. /* TODO : valeurs d'âge à valider pour les cas manquants. */],
) <annexe-echantillon-social>
#titre-court(<annexe-echantillon-social>)[Personnes rencontrées en entretien ou en sortie]

#pagebreak(weak: true)

#figure(
  [
#lorem(150) // TODO : Insérer ici le canevas d'entretien mis au propre et numéroté. À fournir par l'auteur.
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Canevas d'entretien. /* TODO : Document à insérer. Renvoi : M&M, Collecte des données. */],
) <annexe-canevas>
#titre-court(<annexe-canevas>)[Canevas d'entretien]

#pagebreak(weak: true)

#figure(
  [
#lorem(150) // TODO : Insérer ici le protocole de relevé (seuils, variables, classes), la liste du matériel et la fiche de relevé vierge.
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Protocole de relevé et matériel. /* TODO : Documents à insérer. Renvoi : M&M, Dispositif d'échantillonnage et Relevés par placette. */],
) <annexe-protocole>
#titre-court(<annexe-protocole>)[Protocole de relevé et matériel]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 2fr, 1fr),
    align: left,
    table.header([*Fichier*], [*Contenu*], [*Clé et lien*]),
    [transects.csv], [Itinéraires : date, polisin'ala, placettes visitées, longueurs prospectées, commune], [transect],
    [placettes.csv], [Variables de placette, surface, régénération, longueur de ligne pour le bois mort], [placette ; lien : transect],
    [flore.csv], [Tiges mesurées (CBH) et gaulis par espèce, types, usages], [code d'observation ; lien : placette],
    [bois-mort.csv], [Chandelles et bois mort au sol : CBH, degré de décomposition], [lien : placette],
    [phenologie.csv], [Fleurs et fruits observés], [lien : placette],
    [grands-arbres.csv], [Grands arbres : nom vernaculaire, CBH, usages], [code de grand arbre ; lien : transect],
    [chablis.csv], [Chablis par classe de diamètre], [lien : transect],
    [autres-observations-flore.csv], [Espèces notées hors placettes], [lien : transect ou placette],
    [romiguiere-2025-\*.csv], [Relevés de Romiguière (2025) à Tsiazombazaha : tiges et régénération, transects, liste et usages de ses espèces, identifications latines de ses deux sites (extraits de son classeur)], [lien : transect de Romiguière ; correspondance des noms : correspondance-romiguiere-2025.csv],
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Fichiers de données issus de la saisie (un fichier CSV par type d'observation) et clés de correspondance entre fichiers.],
) <annexe-fichiers-donnees>
#titre-court(<annexe-fichiers-donnees>)[Fichiers de données et clés de correspondance]
// TODO : ajouter le fichier de faune (« T1-T2-faune ») une fois nettoyé.
// Ancien contenu de cette annexe (liste des sorties R, en partie redondante avec l'annexe des métadonnées), retiré le 01/11/2026 et conservé ci-dessous. ATTENTION : « 52 entretiens » contredit le M&M (34 entretiens, 50 personnes).
// #figure(
//   table(
//     columns: (3fr, 3.5fr, 1fr),
//     align: (left, left, left),
//     table.header([*Fichier*], [*Description*], [*Format*]),
//     ..("structure_N_placettes.csv", "Densité par placette (28 placettes)", "CSV"),
//     ..("structure_G_placettes.csv", "Surface terrière par placette (28 placettes)", "CSV"),
//     ..("diversite_alpha_placettes.csv", "Indices alpha par placette (richesse, Shannon, Simpson, Fisher)", "CSV"),
//     ..("structure_classes_ic95.csv", "Densité par classe de diamètre avec IC 95 %", "CSV"),
//     ..("structure_G_classes.csv", "Surface terrière par classe de diamètre", "CSV"),
//     ..("diversite_beta_nmds_points.csv", "Coordonnées NMDS des placettes", "CSV"),
//     ..("ivi_especes.csv", "Indice de valeur d'importance par espèce", "CSV"),
//     ..("courbe_rarefaction_extrapolation.csv", "Courbe de raretéfaction-extrapolation", "CSV"),
//     ..("carbone_stocks.csv", "Stocks de carbone par compartiment", "CSV"),
//     ..("metadonnees_enquete-de-terrain_1_entretiens.csv", "Métadonnées des 52 entretiens", "CSV"),
//     ..("metadonnees_enquete-de-terrain_2_sorties.csv", "Métadonnées des 21 sorties de terrain", "CSV"),
//     ..("metadonnees_enquete-de-terrain_3_enquetes.csv", "Métadonnées des personnes enquêtées", "CSV"),
//     ..("correspondance-usages-cook.csv", "Correspondance usages locaux – classification Cook (1995)", "CSV"),
//     ..("liste-especes-usages-types.csv", "Liste des espèces avec usages et types", "CSV"),
//     ..("phenologie.csv", "Observations phénologiques", "CSV"),
//     ..("autres-observations-flore.csv", "Autres observations floristiques hors placettes", "CSV"),
//     ..("animaux-T1-T2.csv", "Observations faunistiques (Observations)", "CSV"),
//   ),
//   kind: "annexe",
//   supplement: [Annexe],
//   caption: [Fichiers de données et clés de correspondance. Tous les fichiers sont disponibles en annexe numérique. Source : données de terrain 2026 et référentiels projet. /* REF? Critère 79 du guide GEEFT à vérifier. */],

#pagebreak(weak: true)

#figure(
  table(
    columns: (1.5fr, 1fr, 2fr, 1.5fr),
    align: (left, center, left, left),
    table.header([*Usage normalisé*], [*Cook N1*], [*Cook N1 (libellé)*], [*Cook N2 (libellé)*]),
    // Données depuis correspondance-usages-cook.csv
    ..("anti_foudre", "800", "sociale_culturelle", "Religious Uses"),
    ..("aucun", "", "", ""),
    ..("balai", "600", "materiaux", "Wood"),
    ..("batan", "600", "materiaux", "Wood"),
    ..("bois_chauffage", "700", "combustible", "Fuelwood"),
    ..("bois_construction", "600", "materiaux", "Wood"),
    ..("canaux_irrigation", "600", "materiaux", "Wood"),
    ..("construction_maison", "600", "materiaux", "Wood"),
    ..("corde", "600", "materiaux", "Fibres"),
    ..("douleurs_dentaires", "1100", "medicinale", "Pain"),
    ..("ecorce_sucree", "100", "alimentaire", "Bark"),
    ..("fatigue", "1100", "medicinale", "Ill-defined Symptoms"),
    ..("fixation_toiture", "600", "materiaux", "Fibres"),
    ..("fruit_comestible", "100", "alimentaire", "Infructescences"),
    ..("gonflements", "1100", "medicinale", "Inflammation"),
    ..("guitare", "600", "materiaux", "Wood"),
    ..("haie", "1200", "environnementale", "Boundaries/Barriers/Supports"),
    ..("insecticide", "1000", "poison", "Arthropoda"),
    ..("magie", "800", "sociale_culturelle", "Religious Uses"),
    ..("manche_beche", "600", "materiaux", "Wood"),
    ..("medicinale", "1100", "medicinale", "Unspecified Medicinal Disorders"),
    ..("menuiserie", "600", "materiaux", "Wood"),
    ..("panier", "600", "materiaux", "Cane etc."),
    ..("pilon", "600", "materiaux", "Wood"),
    ..("plancher", "600", "materiaux", "Wood"),
    ..("planche", "600", "materiaux", "Wood"),
    ..("pirogue", "600", "materiaux", "Wood"),
    ..("poutre", "600", "materiaux", "Wood"),
    ..("the", "100", "alimentaire", "Unspecified Parts"),
    ..("tressage", "600", "materiaux", "Cane etc."),
    ..("aphrodisiaque", "1100", "medicinale", "Genitourinary System Disorders"),
    // Usages de Romiguière (2025), ajoutés le 02/11/2026
    ..("charpente", "600", "materiaux", "Wood"),
    ..("cloture", "600", "materiaux", "Wood"),
    ..("colle", "600", "materiaux", ""),
    ..("outils", "600", "materiaux", "Wood"),
    ..("poteau", "600", "materiaux", "Wood"),
    ..("vertiges", "1100", "medicinale", "Ill-defined Symptoms"),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Correspondance entre usages locaux normalisés et classification Cook (1995). Niveau 1 : catégorie principale ; Niveau 2 : sous-catégorie. Source : référentiel projet, fichier correspondance-usages-cook.csv.],
) <annexe-codes-cook>
#titre-court(<annexe-codes-cook>)[Correspondance usages locaux et classification Cook]

#pagebreak(weak: true)

// Liste régénérée le 02/11/2026 par analyse_usages_cook.R (sorties/liste_flore.csv), en remplacement de l'extrait partiel saisi à la main (conservé dans sauvegardes/Annexes_2026-11-02c.typ).
// Romiguière (2025) ajouté le 02/11/2026. TODO (auteur) : espèces du transfert de gestion de 2004 à ajouter une fois la liste saisie (colonne « Source » : « Transfert de gestion (2004) »).
#let flore = csv("analyse-tables/liste_flore.csv").slice(1)
// Nom scientifique : genre et épithète en italique, autorité en romain
// (plusieurs noms séparés par « / » chez Romiguière ; « sp » et « sp. » en romain)
#let nomLatin1(n) = {
  let m = n.split(" ")
  if n.ends-with("aceae") { n }
  else if m.len() == 1 { emph(n) }
  else if m.at(1) in ("sp", "sp.", "spp", "spp.") or m.at(1).starts-with("(") { [#emph(m.at(0)) #m.slice(1).join(" ")] }
  else { [#emph(m.slice(0, 2).join(" ")) #m.slice(2).join(" ")] }
}
#let nomLatin(n) = {
  if n == "" or n == "++" { return [] }
  n.split(" / ").map(nomLatin1).join(" / ")
}
// Sources abrégées pour garder la colonne étroite
#let codesSources = ("Relevé": "R", "Observation": "O", "Romiguière (2025)": "Rom")
#let codeSources(x) = if x == "" { "" } else { x.split(", ").map(c => codesSources.at(c, default: c)).join(", ") }
#figure(
  table(
    columns: (3fr, 5fr, auto, 3fr, auto),
    align: (left, left, right, left, left),
    inset: (x: 4pt, y: 3pt),
    table.header([*Nom vernaculaire*], [*Nom scientifique*], [*Types*], [*Usages (Cook, niveau 1)*], [*Source*]),
    ..flore.map(r => (r.at(0), [#nomLatin(r.at(1))#if r.at(5) == "TRUE" [\*]], r.at(2), r.at(3), codeSources(r.at(4)))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Liste de la flore (#flore.len() espèces ; identités réconciliées, espèces indéterminées exclues). Nom scientifique : espèce, genre ou famille ; case vide si l'espèce n'est pas rattachée ; \* : nom déduit des identifications de Romiguière (2025) sur ses deux sites. Types : nombre de types distingués par le polisin'ala (maximum des valeurs saisies). Usages : catégories de premier niveau de la classification de Cook (1995). Source : R = relevé (placettes et grands arbres des transects) ; O = observation hors relevé (cheminements, phénologie) ; Rom = Romiguière (2025), tiges et régénération relevées à Tsiazombazaha en 2025, noms rattachés par une table de correspondance. Source des données : liste_flore.csv.],
) <annexe-flore>
#titre-court(<annexe-flore>)[Liste de la flore observée]

#pagebreak(weak: true)

#figure(
  table(
    columns: (2fr, 2fr, 2fr, 2fr),
    align: (left, left, center, left),
    table.header([*Nom vernaculaire*], [*Taxonomie*], [*Type d'observation*], [*Source*]),
    // Données depuis animaux-T1-T2.csv et autres-observations-flore.csv (faune)
    ..("Lambo", "Potamochoerus larvatus", "Recherche de nourriture, souille, coulées", "Observations"),
    ..("Vitsika", "Formicidae", "Fourmilière", "Observations"),
    ..("Toloho", "Cuculidae", "Vocalisation", "Observations"),
    ..("Tetso", "Accipitridae", "Vocalisation", "Observations"),
    ..("Kitreoka", "NA", "Vocalisation", "Observations"),
    ..("Leromba", "NA", "Vocalisation", "Observations"),
    ..("Boeza", "NA", "Vocalisation", "Observations"),
    ..("Vorondreo", "NA", "Vocalisation", "Observations"),
    ..("Anjay", "NA", "Vocalisation", "Observations"),
    ..("Boizo", "NA", "Vocalisation", "Observations"),
    ..("Papango", "Psittacidae", "Vocalisation", "Observations"),
    ..("Goaika", "NA", "Vocalisation", "Observations"),
    ..("Akoragna", "NA", "?", "Observations"),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Liste de la faune établie. Sources : Observations (2026), transfert 2004, GBIF, Rajaonson et al. (2010). /* TODO : Compléter avec les observations hors transects et valider les identifications taxonomiques. */],
) <annexe-faune>
#titre-court(<annexe-faune>)[Liste de la faune établie]

#pagebreak(weak: true)

// Annexe phénologie retirée (02/11/2026, choix de l'auteur) : sans lien avec la problématique ; données conservées dans phenologie.csv.
// #figure(
//   table(
//     columns: (1fr, 1fr, 2fr, 1fr, 3fr),
//     align: (center, left, left, left, left),
//     table.header([*Placette*], [*Type*], [*Espèce*], [*Nombre*], [*Remarque*]),
//     // Données depuis phenologie.csv
//     ..("P07", "Fruit", "Vayivayi", "0–2", "Baie rouge encore accrochée à la plante"),
//     ..("P14", "Fleur", "Kasakasa", ">10", "Herbacée"),
//     ..("P16", "Fruit", "Hazomainty", ">10", "Cauliflorie, fruits ronds déjà sec"),
//     ..("P18", "Fleur", "Fagnamohazo", "0–2", "Cauliflorie, une unique grappe"),
//     ..("P20", "Fleur", "Hazomainty", ">10", "Cauliflorie, sorte de petits bâtons en bas du tronc, en haut du même tronc déjà fruits"),
//     ..("P20", "Fruit", "Hazomainty", ">10", "Cauliflorie, fruits ronds déjà sec en hauteur"),
//     ..("P26", "Fruit", "Hasina (type à petites feuilles)", "3–10", "Trois grappes, cauliflorie"),
//     ..("P27", "Fleur", "Sp. inconnue", "3–10", "Un arbre, cauliflorie"),
//   ),
//   kind: "annexe",
//   supplement: [Annexe],
//   caption: [Observations phénologiques complémentaires. Type : Fleur ou Fruit ; Nombre : classes 0–2, 3–10, >10. Source : phenologie.csv, n = 8 observations, date de collecte : 2026.],
// ) <annexe-observations>
// #titre-court(<annexe-observations>)[Observations phénologiques complémentaires]
// 
// #pagebreak(weak: true)

#figure(
  [
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      align: (left, right, right, right, right, right),
      table.header([*Placette*], [*Surface (m²)*], [*Tiges mesurées*], [*Gaulis*], [*N (tiges/ha)*], [*G (m²/ha)*]),
      ..placettesN.zip(placettesG).map(((n, g)) => (n.at(0), nombre(n.at(1), decimales: 1), n.at(2), n.at(3), nombre(n.at(6), decimales: 0), nombre(g.at(4)))).flatten(),
    )
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      align: (left, right, right, right, right, right),
      table.header([*Placette*], [*S*], [*H′*], [*¹D*], [*²D*], [*α de Fisher*]),
      ..placettesAlpha.map(r => (r.at(0), r.at(1), nombre(r.at(2)), nombre(r.at(3)), nombre(r.at(4)), nombre(r.at(6)))).flatten(),
    )
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Indices par placette. Surface horizontale ; N : densité (tiges mesurées et gaulis) ; G : surface terrière (tiges mesurées). Indices alpha calculés sur toutes les tiges comptées, tiges indéterminées exclues ; ¹D et ²D sous leur forme brute. Sources : structure_N_placettes.csv, structure_G_placettes.csv, diversite_alpha_placettes.csv.],
) <annexe-indices-placettes>
#titre-court(<annexe-indices-placettes>)[Indices par placette]

#pagebreak(weak: true)

#figure(
  [
    #table(
      columns: (1fr, 1fr, 1fr),
      align: (left, right, right),
      table.header([*Classe de diamètre (cm)*], [*Densité (tiges/ha)*], [*IC 95 %*]),
      ..classesN.map(r => (nombre(r.at(0), decimales: 1) + " – " + nombre(str(float(r.at(0)) + 2.5), decimales: 1), nombre(r.at(1), decimales: 0), "[" + nombre(r.at(2), decimales: 0) + " ; " + nombre(r.at(3), decimales: 0) + "]")).flatten(),
    )
    #table(
      columns: (1fr, 1fr, 1fr),
      align: (left, right, right),
      table.header([*Classe de diamètre (cm)*], [*G (m²/ha)*], [*IC 95 %*]),
      ..classesG.map(r => (nombre(r.at(4), decimales: 1) + " – " + nombre(r.at(5), decimales: 1), nombre(r.at(1)), "[" + nombre(r.at(2)) + " ; " + nombre(r.at(3)) + "]")).flatten(),
    )
    // Grands arbres des transects : densités à deux décimales (valeurs inférieures à 4 arbres/ha, l'arrondi à l'unité les rendrait illisibles).
    #table(
      columns: (1fr, 1fr, 1fr),
      align: (left, right, right),
      table.header([*Classe de diamètre (cm), transects*], [*Arbres*], [*Densité (arbres/ha)*]),
      ..classesNGA.map(r => (nombre(r.at(0), decimales: 1) + " – " + nombre(str(float(r.at(0)) + 2.5), decimales: 1), r.at(1), nombre(r.at(2)))).flatten(),
    )
    #table(
      columns: (1fr, 1fr, 1fr),
      align: (left, right, right),
      table.header([*Classe de diamètre (cm), transects*], [*Arbres*], [*G (m²/ha)*]),
      ..classesGGA.map(r => (nombre(r.at(0), decimales: 1) + " – " + nombre(r.at(1), decimales: 1), r.at(2), nombre(r.at(4)))).flatten(),
    )
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Densité et surface terrière par classe de diamètre : moyenne entre placettes et IC 95 % par la loi de Student : 28 placettes de l'étude et 8 placettes de 40 m² de Romiguière (2025), sauf pour la classe 0 – 2,5 cm (28 placettes de l'étude) (bornes inférieures négatives non tronquées, contrairement aux figures). La classe 0 – 2,5 cm inclut les gaulis ; les classes sans tige sont absentes. Deux derniers tableaux : grands arbres des transects (CBH ≥ 126 cm, soit un DBH d'au moins 40 cm), effectif et surface terrière rapportés aux 53 050 m² de bande prospectée sur cinq transects, sans intervalle de confiance. Sources : sensibilite_romiguiere_classes_N.csv, sensibilite_romiguiere_classes_G.csv, transects_grands_arbres_classes_N.csv, transects_grands_arbres_classes_G.csv.],
) <annexe-classes-diametre>
#titre-court(<annexe-classes-diametre>)[Densité et surface terrière par classe de diamètre]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    align: (left, right, right, right, right),
    table.header([*Compartiment*], [*Volume (m³/ha)*], [*Biomasse (tMS/ha)*], [*Carbone (tC/ha)*], [*CO₂ (tCO₂/ha)*]),
    ..carbone.map(r => (
      libellesCarbone.at(r.at(0), default: r.at(0)),
      [#nombre(r.at(2)) \ [#nombre(r.at(3)) ; #nombre(r.at(4))]],
      [#nombre(r.at(5)) \ [#nombre(r.at(6)) ; #nombre(r.at(7))]],
      [#nombre(r.at(8)) \ [#nombre(r.at(9)) ; #nombre(r.at(10))]],
      [#nombre(r.at(11)) \ [#nombre(r.at(12)) ; #nombre(r.at(13))]],
    )).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Volume, biomasse, carbone et CO₂ par compartiment, à l'hectare ; entre crochets, IC 95 % par bootstrap (1~000 rééchantillonnages des placettes ou des transects, graine 2026). Volume et biomasse : parties aériennes ; carbone et CO₂ du vivant : biomasse souterraine incluse ($R = "0,20"$). Source : carbone_stocks.csv (sortie du 01/11/2026).],
) <annexe-carbone>
#titre-court(<annexe-carbone>)[Stocks de carbone par compartiment]

#pagebreak(weak: true)

#figure(
  table(
    columns: (3fr, 1fr, 1fr, 1.5fr, 1fr),
    align: (left, right, right, left, left),
    table.header([*Placette*], [*NMDS1*], [*NMDS2*], [*Itinéraire*], [*Commune*]),
    ..pointsNMDS.map(r => (r.at(0), nombre(r.at(1)), nombre(r.at(2)), r.at(3), r.at(5))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Coordonnées des 28 placettes dans l'ordination NMDS (dissimilarité de Bray-Curtis, deux dimensions, stress = 0,23), avec leur itinéraire et leur commune. Source : diversite_beta_nmds_points.csv.],
) <annexe-beta>
#titre-court(<annexe-beta>)[Coordonnées des placettes (NMDS)]
// ATTENTION : colonne polisin'ala retirée — le CSV contient des noms réels (Morafeno, Célestin, Claude JEAN, Séraphin) à côté de codes ENQ. Si la colonne est utile, la remplacer par des codes anonymes (polisin'ala A, B…) dans une copie du CSV pour le rapport.

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 2.5fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (right, left, right, right, right, right, right, right),
    table.header([*Rang*], [*Espèce*], [*Tiges*], [*Placettes*], [*DR (%)*], [*DoR (%)*], [*FR (%)*], [*IVI*]),
    ..ivi.map(r => (r.at(0), r.at(1), r.at(2), r.at(3), nombre(r.at(5)), nombre(r.at(6)), nombre(r.at(7)), nombre(r.at(8)))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Indice de valeur d'importance (IVI) des 124 espèces (28 placettes ; 479 tiges mesurées, gaulis et tiges indéterminées exclus). DR : densité relative ; DoR : dominance relative ; FR : fréquence relative ; IVI = (DR + DoR + FR) / 3, sur 100. Espèces : identités réconciliées. Source : ivi_especes.csv.],
) <annexe-ivi>
#titre-court(<annexe-ivi>)[Indice de valeur d'importance (IVI)]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 1.4fr, 1.2fr, 1.2fr, 2fr, 1.1fr),
    align: (right, left, right, right, right, right),
    table.header([*Placettes*], [*Méthode*], [*Surface (m²)*], [*Richesse (espèces)*], [*IC 95 %*], [*Couverture*]),
    ..rarefactionAnnexe.map(r => (r.at(1), methodes.at(r.at(2)), nombre(r.at(10), decimales: 1), nombre(r.at(4)), "[" + nombre(r.at(5)) + " ; " + nombre(r.at(6)) + "]", nombre(r.at(7)))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Courbe de raréfaction-extrapolation de la richesse spécifique (modèle d'incidence, ordre q = 0) : richesse et couverture d'échantillonnage selon le nombre de placettes et la surface horizontale cumulée ; IC 95 % par bootstrap. Extrapolation : un point sur quatre. Les estimateurs asymptotiques figurent dans le corps du texte. Source : courbe_raréfaction_extrapolation.csv.],
) <annexe-richesse>
#titre-court(<annexe-richesse>)[Courbe de raréfaction-extrapolation]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 2fr, 1fr),
    align: (left, left, left),
    table.header([*Fichier*], [*Description*], [*Conditions d'accès*]),
    // Dossiers nommés comme dans le dépôt de travail (02/11/2026) ; TODO (auteur) : adapter à l'arborescence du dépôt final.
    [06_ecologie/analyse/donnees/], [Données brutes des relevés écologiques : placettes, tiges, transects, grands arbres, bois mort (8 fichiers CSV, détail en @annexe-fichiers-donnees)], [Accès libre],
    [06_ecologie/analyse/referentiels/], [Réconciliation taxonomique des noms vernaculaires, normalisation des usages (étude et Romiguière, 2025), correspondance avec Cook (1995) et avec les noms de Romiguière (2025) (fichiers CSV)], [Accès libre],
    [06_ecologie/analyse/scripts/], [Scripts R des analyses et des figures], [Accès libre],
    [06_ecologie/analyse/sorties/], [Tableaux (CSV) et figures (SVG) produits par les scripts], [Accès libre],
    [05_Sociologie/donnees/], [Notes des 34 entretiens et des 21 sorties (texte)], [Accès restreint – demande motivée],
    [05_Sociologie/donnees/ (métadonnées)], [Métadonnées des entretiens, des sorties et des personnes rencontrées (CSV)], [Accès libre],
    // ATTENTION : metadonnees_enquete-de-terrain_3_enquetes.csv contient une colonne « Nom » : la vider avant tout dépôt en accès libre. Les notes d'entretien ne sont pas encore toutes présentes ni anonymisées.
    [05_Sociologie/canevas/], [Canevas d'entretien], [Accès libre],
    // TODO (auteur) : dossier des cartes (QGIS) à préciser.
    [cartes/], [Cartes de localisation et d'intervention (QGIS)], [Accès libre],
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Métadonnées des fichiers complémentaires déposés avec le mémoire. Formats : CSV, texte, SVG, scripts R. /* TODO : Préciser les modalités d'accès et le DOI ou lien de dépôt une fois disponibles. */],
) <annexe-metadonnees>
#titre-court(<annexe-metadonnees>)[Métadonnées des fichiers complémentaires]

#pagebreak(weak: true)

// Liste initiale de l'auteur (conservée pour mémoire) :
// - Carte d'intervention du projet EcoBois (?)
// - Canevas d'entretien
// - Liste des enquetes / sorties
// - Protocole des relevés de terrain (si besoin) / Matériel utilisé
// - Feuille de relevé
// - Liste des plantes établie (nom vernaculaire) avec IVI
// - Autres espèces de plantes observées/mentionnées en dehors des placettes
// - Liste des animaux
// - Table des logiciels et programmes utilisés
// - Métadonnées des fichiers complémentaires du rapport (données écologiques, transcription des entretiens)
// Non repris : « Table des logiciels » (versions déjà données en M&M, Conventions) ; « Autres espèces hors placettes » fusionné dans la liste de la flore (colonne source).
