#import "TitresCourts.typ": titre-court

= Matériel et méthodes

== Site d'étude

// Ordre retenu (auteur, 31/10/2026) : la forêt (localisation, milieu physique, fragment), puis le territoire en entonnoir (communes, fokontany, périmètre transféré).

La forêt de Tsiazombazaha est située dans la région Fitovinany, district de Manakara Atsimo, entre 47,933~°E et 47,969~°E de longitude et entre 21,884~°S et 21,924~°S de latitude (degrés décimaux, datum WGS84) (CARTE DE LOCALISATION).
Son nom, formé de « _tsia_ » (négation), « _zo_ » (« l'action d'aller, marcher ») et « _basaha_ » (« étranger », en particulier blanc ou français), signifie « là où les étrangers ne peuvent pas aller ». Au moins quatre autres forêts de la côte Est portent ce nom, suggérant une histoire commune liée à la colonisation française.
// REP : au moins quatre identifiées par les homonimies lors de la revue PRISMA
// REP : source de l'étymologie : recherche personnelle à partir d'un dictionnaire malgache

[CARTE]
// TODO : carte 1 à réaliser sous QGIS, puis décommenter le bloc et remplacer « (CARTE DE LOCALISATION) » par « (@fig-carte-localisation) ».
// #figure(
//   image("images/carte_localisation.svg", width: 100%),
//   caption: [Localisation de la forêt de Tsiazombazaha : Madagascar (encart), région Fitovinany, et fragments de forêt naturelle voisins (Lakia, Vorovoka, Vatovavy). Système de coordonnées WGS84. Sources : // TODO (limites administratives, couvert forestier, fond de carte).],
// ) <fig-carte-localisation>
// Contenu attendu : encart Madagascar → région Fitovinany → forêt ; les trois fragments voisins avec leurs distances ; échelle, nord, sources. Niveaux de gris (critère du mémoire), sans titre dans l'image.

Les normales climatiques WorldClim 2.1 (période 1970-2000, résolution de 10 minutes d'arc) donnent une température moyenne annuelle de 22,9~°C, de 19,7~°C en juillet à 25,9~°C en janvier, et des précipitations annuelles de 2~531~mm (Fick et Hijmans, 2017). Les pluies sont maximales de janvier à mars (367 à 407~mm par mois) et minimales en septembre et octobre (93 et 86~mm) (@fig-ombrothermique). L'altitude varie d'environ 35 à 85~m.

#figure(
  image("images/diagramme_ombrothermique.svg",
    alt: "Diagramme ombrothermique : barres grises des précipitations mensuelles, de 86 mm en octobre à 407 mm en mars, toutes au-dessus de la courbe des températures, comprise entre 19,7 et 25,9 °C."),
  caption: [Diagramme ombrothermique de la forêt de Tsiazombazaha : précipitations mensuelles (barres) et température moyenne mensuelle (courbe), normales 1970-2000. Échelle de Gaussen (P = 2T) jusqu'à 100~mm, compressée au dixième au-delà (Walter et Lieth). D'après WorldClim 2.1, résolution de 10 minutes d'arc (Fick et Hijmans, 2017), valeurs lues au centre de la forêt.],
) <fig-ombrothermique>
#titre-court(<fig-ombrothermique>)[Diagramme ombrothermique de Tsiazombazaha]
// Données de la figure : images/climat_worldclim_tsiazombazaha.csv (extraction du 31/10/2026). Figure tracée hors R (Python, matplotlib) ; à refaire dans R si l'homogénéité graphique avec les autres figures est souhaitée.
// Walter et Lieth (1960) : non lu, à vérifier.
// Extraction (31/10/2026) : valeurs lues au centre de l'emprise (47,951 °E ; 21,904 °S) ; les quatre coins de l'emprise tombent dans la même maille de 10' (~18 km), la valeur vaut donc pour toute la forêt. Une extraction à 30 s (~1 km) préciserait les valeurs.
// TODO : valeur à valider — altitude lue sur cinq points de l'emprise (35 à 84 m) dans Copernicus DEM GLO-90, via l'API Open-Meteo (31/10/2026) ; à reprendre sur le périmètre réel de la forêt sous QGIS. // REF? Copernicus DEM, https://doi.org/10.5270/ESA-c5d3d65

La forêt appartient à l'écorégion des Forêts humides de l'Est, l'une des quatre écorégions forestières définies par l'administration malgache dans le cadre de la REDD+, et plus précisément au domaine de l'Est (0 à 800~m d'altitude), qui regroupe les forêts denses humides sempervirentes de basse altitude et les forêts littorales (BNC-REDD+, 2017). Elle repose sur le socle cristallin précambrien du bouclier malgache. Les sols sont des ferralsols, anciens, profonds, acides et pauvres en nutriments (Riquier, 1966) ; les cartes pédologiques disponibles, anciennes ou d'une petite échelle, ne permettent pas une caractérisation plus fine (Nishigaki et al., 2020).
// Note (BNC-REDD+, 2017) : §2.2, p. 13-15 ; les quatre écorégions y sont attribuées au R-PP et regroupent les domaines phytogéographiques de l'IEFN (1996).
// TODO : BNC-REDD+ et REDD+ à ajouter à la liste des abréviations. Socle précambrien : source à trouver (carte géologique du BRGM, selon l'auteur). Riquier (1966) et Nishigaki et al. (2020) : entrées provisoires dans hayagriva.yml, à compléter. 
// REP :  socle précambrien : carte géologique du BRGM

Le massif forestier couvre environ 500~ha (Inter Aide, 2025). Il constituait déjà un fragment isolé en 1973 (Romiguière, 2025, d'après les données de Vieilledent et al., 2018). Les fragments de forêt naturelle les plus proches sont ceux de Lakia, de Vorovoka et de Vatovavy, situés respectivement à environ 5, 10 et 15~km.
// REF? Inter Aide (2025) : document projet EcoBois, source de la surface donnée en Problématique (l. 31) ; à confirmer.
// TODO : valeur à valider — distances estimées à la main sous QGIS ; attribution 5 / 10 / 15 km à Lakia / Vorovoka / Vatovavy non confirmée (auteur : « normalement »). Préciser la mesure (de lisière à lisière ?).
// ATTENTION : le projet de stage situe la zone d'étude de Fabiani (2025), autour de Vorovoka, « à quelques dizaines de kilomètres au nord de Tsiazombazaha », ce qui s'accorde mal avec 10 km.
// TODO : carte 3 (couvert forestier 1973-2017) — à placer ici, ou en annexe ; ajouter un renvoi après « en 1973 » une fois réalisée.
// #figure(
//   image("images/carte_couvert_1973_2017.svg", width: 100%),
//   caption: [Évolution du couvert forestier autour de Tsiazombazaha entre 1973 et 2017. D'après Vieilledent et al. (2018), adapté de Romiguière (2025).],
// ) <fig-carte-couvert>
// Contenu attendu : couvert en 1973, 1990, 2000, 2010 et 2017 (ou les dates disponibles), en niveaux de gris du plus ancien au plus récent ; échelle, nord, sources. Reprise possible de la figure 2 du projet de stage.

Le fragment est entouré d'une matrice agricole. Fabiani (2025) y distingue, autour de Vorovoka, des collines non aménagées, des fourrés monospécifiques, des _tanimboly_ (« terres de culture »), des cultures de manioc, des rizières, des reboisements, des formations à ravenala, des forêts, des cours d'eau et des villages. Les mêmes unités ont été observées autour de Tsiazombazaha.

// TODO : le reste du contexte socio-économique et l'historique vont en annexe ou dans l'Introduction (guide, critères 30 et 31).
// Gouvernance (VOI Maharitra, transfert de gestion) en quelques lignes. Le reste va en annexe, ce n’est pas une monographie.
// Mentionné mais pas à garder :? //   - Contexte/aspects (géo)socioéconomiques : histoire de la zone ; fig. frise//     chronologique (?) TFG ; contexte pauvreté (Madagascar, Sud-Est de Madagascar) ;//     divisions administratives ; modes de gouvernance locale ; proximité à la RN,//     autres villages, accessibilité.

La forêt s'étend aujourd'hui sur les communes rurales d'Ambahatrazo et de Mizilo Gara ; une petite partie se trouve dans le fokontany de Tsararano (commune de Vohimasina Sud). Sa gestion a été transférée en 2004 au VOI Maharitra, dans le cadre de la GCF, pour une durée de trois ans. Le transfert a été renouvelé en 2025 par la direction régionale de l'Environnement et du Développement durable (DREDD) et les communes d'Ambahatrazo, de Mizilo Gara et d'Ambila, sur une surface transférée de 1~068~ha (VOI Maharitra, 2025). Le VOI réunit sept fokontany : Ambalavolo, Amborodra et Manakana dans la commune d'Ambahatrazo ; Ampasipotsy, Mizilo Gara et Tsiazombazaha dans celle de Mizilo Gara, issus de la division de l'ancien fokontany de Mizilo Gara ; Andriana dans celle d'Ambila. Le fokontany d'Ambahatrazo, chef-lieu de sa commune, et celui de Tsararano n'en font pas partie.
// Fokontany et communes : auteur, 31/10/2026. « Mahatsara » (projet de stage) désigne le fokontany de Manakana : retenir « Manakana » dans tout le mémoire.
// TODO : source de la division du fokontany de Mizilo Gara (date, acte).
// ATTENTION : le fokontany de Tsiazombazaha est homonyme de la forêt ; préciser « fokontany de Tsiazombazaha » à chaque occurrence pour éviter la confusion.
// TODO : DREDD à ajouter à la liste des abréviations.
// TODO : « la forêt ne couvre plus Ambila » d'après l'auteur ; les cartes disponibles sont peu fiables. Préciser la source (terrain, entretiens).
// check la superficie calculée selon limites données VS cité dans le document 2025 VS citée dans le doc de 2004
// ATTENTION : « Tsararano » retenu (auteur, Discussion.typ) contre « Tsarano » (projet de stage) ; « Fitovinany » contre « Fitonivavy » (Resume.typ).
// ATTENTION : Cooke (2007), anciennement cité ici pour le transfert de gestion, est cité par l'Introduction (l. 100) pour le rôle du bureau du VOI : usage à vérifier.
// ATTENTION : 450 ha (Résumé) contre ~500 ha (Problématique, texte ci-dessus) pour le massif forestier.
// TODO : carte 2 (territoire) — ajouter un renvoi « (@fig-carte-territoire) » dans le paragraphe ci-dessus une fois réalisée.
// #figure(
//   image("images/carte_territoire.svg", width: 100%),
//   caption: [Territoire de la forêt de Tsiazombazaha : massif forestier, périmètre transféré au VOI Maharitra en 2025 (1~068~ha), communes et fokontany membres du VOI, villages. Sources : VOI Maharitra (2025) ; // TODO (limites administratives, couvert forestier).],
// ) <fig-carte-territoire>
// Contenu attendu : distinguer clairement le massif (~500 ha) et le périmètre transféré (1 068 ha) ; communes d'Ambahatrazo, Mizilo Gara et Ambila ; sept fokontany du VOI ; Tsararano (hors transfert) ; villages riverains. Échelle, nord, sources.

== Revue de la littérature

Une recherche bibliographique visant l'exhaustivité a été menée sur la forêt de Tsiazombazaha. Elle s'inspire de la démarche de revue systématique de Pullin et Stewart (2006) et est présentée selon la déclaration PRISMA 2020 (Page et al., 2021). Le toponyme étant rare et la littérature sur la forêt malgache réduite, la requête porte sur le seul mot-clé « Tsiazombazaha », sans opérateur ni synonyme.

La requête a été lancée en avril 2026 dans trois bases bibliographiques : Google Scholar, Web of Science et Internet Archive Scholar. Elle a été complétée par le moteur de recherche Google et par les documents internes transmis par Inter Aide (équipe locale, siège, espace de stockage partagé et anciens stagiaires). D'autres moteurs de recherche, académiques (XXX) et généralistes (Brave, Qwant, DuckDuckGo), ainsi que deux assistants conversationnels fondés sur l'intelligence artificielle, Le Chat (Mistral AI) et Gemini (Google), ont été interrogés sans apporter de document nouveau.
// TODO : nommer les moteurs académiques complémentaires (XXX).

Les doublons ont été retirés au sein de chaque base et entre bases, Google Scholar servant de base de référence. Les documents restants ont été triés sur leur texte intégral. Sont exclus les documents portant sur une forêt homonyme, ceux dont la forêt n'est pas localisable et ceux qui traitent des communes riveraines sans mentionner la forêt. Le parcours des documents est présenté en Résultats sous la forme d'un diagramme PRISMA, avec la liste des documents retenus (@res-revue). Les occurrences du GBIF ont fait l'objet d'une recherche distincte, directement sur le site du GBIF (voir Données complémentaires).
// ATTENTION : « triés sur leur texte intégral » — le document d'Internet Archive Scholar retenu est introuvable (tableur PRISMA) ; préciser sur quelle base il a été jugé pertinent.

// ---- Pour la section Résultats (effectifs et diagramme, arbitrage auteur du 31/10/2026) ----
// Diagramme PRISMA 2020 et tableau des documents retenus : placés en Résultats (« Revue de littérature »), comme le prévoit PRISMA 2020 (résultats de la sélection).
// Données du tableur (documents-brouillons/PRISMA_resultats.ods ; // TODO : valeurs à valider) :
//   Google Scholar : 18 résultats, 4 doublons, 14 uniques, 11 autre forêt, 1 non localisée, 2 forêt d'étude ;
// WoS : 0 résultats
//   Internet Archive Scholar : 15 résultats, 6 doublons, 9 uniques, 5 autre forêt, 3 non localisées, 1 forêt d'étude (introuvable) ;
//   Google : 1 forêt d'étude ; documents internes : 3 (Romiguière 2025, transferts de gestion 2004 et 2025) ;
//   total : 7 retenus, dont 6 récupérés.
// ATTENTION : le document Internet Archive Scholar retenu est « introuvable » → case « documents non récupérés » du diagramme.
// Revue de la législation (FAOLEX) abandonnée (auteur, 31/10/2026) ; mention retirée de l'Introduction le 02/11/2026.

== Méthodologie du volet social

Le volet social répond aux sous-questions relatives aux usages, aux perceptions et aux pressions (SQ2) et à l'organisation de la gestion, à l'application de ses règles et à la façon dont elles sont perçues (SQ3). Il repose sur des entretiens semi-directifs et des sorties en forêt, complétés ponctuellement par les documents de transfert de gestion. La démarche s'inspire du _Guide de l'enquête de terrain_ de Beaud et Weber (2010). Le cadre d'analyse est présenté dans la Problématique.
// TODO : remplacer « SQ2 », « SQ3 » et « Problématique » par des références Typst une fois les étiquettes posées.
// Sous-section « Cadre d'analyse » supprimée (auteur, 31/10/2026) : le cadre est rédigé dans la Problématique.

=== Collecte des données

Entre mai et août 2026, 34 entretiens semi-directifs (E1 à E34) ont réuni 50 personnes, dont 14 entretiens collectifs de deux à cinq personnes. Les personnes ont été identifiées principalement par les chefs de fokontany et les membres du bureau du VOI ainsi que pour certaines par les techniciens d'Inter Aide. L'échantillon comprend des membres et d'anciens membres du VOI, dont des membres du bureau et des polisin'ala, des habitants sans lien avec le VOI, des autorités locales et des salariés d'Inter Aide (@annexe-echantillon-social). Les entretiens ont duré de 43~min à 6~h, avec une durée médiane de 1~h~52 (durée connue pour 26 entretiens).
// Source : metadonnees_enquete-de-terrain_1_entretiens.csv et _3_enquetes.csv (05_Sociologie/donnees, lus avec l'accord de l'auteur le 31/10/2026 ; seuls des effectifs ont été extraits, aucun nom).
// ATTENTION (hors section) : le Résumé (29 entretiens, 44 personnes) et le brouillon (32, 49) sont à mettre à jour.
// TODO : critères de choix des personnes (diversité de fokontany, de liens au VOI, de genre ?) ; le recrutement par le bureau du VOI et les chefs de fokontany est un biais à discuter dans la Discussion (« Limites méthodologiques »).
// TODO : tableau en annexe — description de l'échantillon sans élément identifiant : genre (43 hommes, 10 femmes sur les 53 personnes rencontrées en entretien ou en sortie), classe d'âge (âge connu pour 29 personnes, de 21 à 69 ans), lien au VOI, fokontany.

Vingt et une sorties en forêt ou en bordure de forêt (S1 à S21 ; @annexe-sorties) ont eu lieu de juin à septembre 2026, avec des habitants, des polisin'ala ou des membres du VOI. Elles comprennent les journées d'inventaire, des parcours de chemins, la prospection des sources, l'observation des cultures et des plantations, ainsi qu'une assemblée générale du VOI. Elles ont permis d'observer les usages et les pressions évoqués en entretien et de prolonger les échanges sur place.
// Source : metadonnees_enquete-de-terrain_2_sorties.csv (motifs regroupés). Une date de sortie est inconnue (« ? »).
// Neuf sorties comportent des placettes (25 placettes avant découpage de P2) : neuf journées de relevés retenues dans le dispositif (auteur, 31/10/2026).

Les documents de transfert de gestion de 2004 et de 2025, rédigés en malgache, n'ont été consultés que ponctuellement, par l'intermédiaire de l'interprète ; seule la liste des espèces, disponible en français, a été exploitée directement.

Les entretiens ont été conduits en malgache et traduits en direct par un interprète. Les échanges ont été notés à la main en français. Ces notes ont ensuite été lues à voix haute et enregistrées, puis transcrites localement avec whisper.cpp (modèle Large-v3 Turbo de Whisper ; Radford et al., 2023).
// whisper.cpp : https://github.com/ggml-org/whisper.cpp (version à indiquer).


Le consentement a été recueilli oralement, par l'intermédiaire de l'interprète, lors de la présentation du projet. Les entretiens et les sorties sont codés par ordre chronologique (E1 à E34, S1 à S21) et les personnes par un code anonyme. Le canevas d'entretien figure en @annexe-canevas.
// TODO : canevas à mettre au propre et à numéroter en annexe (guide, critère 35).

=== Analyse des entretiens

// TODO : analyse non encore réalisée (auteur, 31/10/2026). Ébauche à confirmer une fois l'analyse faite :
// « Les transcriptions ont fait l'objet d'une analyse thématique, sans grille de codage préétablie, sur papier puis avec l'aide d'un modèle de langage appliqué aux fichiers texte. »
// REF? piste : Braun, V., & Clarke, V. (2006). Using thematic analysis in psychology. Qualitative Research in Psychology, 3(2), 77-101. https://doi.org/10.1191/1478088706qp063oa
// Modèle de langage prévu : Claude (Anthropic), service en ligne, non local (auteur, 31/10/2026) — voir « Usage d'outils d'intelligence artificielle ».
// ATTENTION : les transcriptions seront transmises à un service en ligne : les anonymiser avant envoi (noms, lieux-dits identifiants) et le mentionner dans le texte.
// TODO : tableau de traitement des entretiens en annexe (critère 43) ; croisement entretiens / sorties / documents (critère 38) ; lien avec les catégories de la grille SES d'Ostrom (2009) si retenu.
// ATTENTION (hors section, Problematique.typ) : « l'exclusion des usagers est coûteuse et le bien est exclusif » — chez Ostrom, une ressource commune se définit plutôt par une exclusion difficile et des prélèvements qui diminuent la ressource pour les autres. À vérifier dans Ostrom (1990).

== Acquisition des données écologiques

=== Évolution du couvert forestier

L'évolution du couvert forestier, qui contribue à SQ1, n'a pas fait l'objet d'une analyse propre. Elle s'appuie sur l'analyse de Romiguière (2025), fondée sur les cartes de couvert forestier de Vieilledent et al. (2018), complétée par l'observation des données de perte de couvert de Global Forest Watch (Hansen et al., 2013). La littérature ne fournit pas d'estimation ni de carte à une échelle suffisamment fine pour la forêt. Les images satellites anciennes disponibles ne couvrent la zone qu'à partir de 1968 environ. Une classification supervisée ou non supervisée de ces images aurait permis de suivre l'évolution du couvert, mais n'a pu être réalisée faute de temps.
// Global Forest Watch : https://www.globalforestwatch.org (date de consultation à indiquer).
// TODO : valeur à valider — « 1968 » donné de mémoire par l'auteur ; préciser la source des images anciennes (programme, archive).
// TODO : renvoi vers la carte du couvert 1973-2017 du Site d'étude si elle est réalisée.

=== Dispositif d'échantillonnage

L'inventaire floristique répond à la première sous-question, relative à l'état écologique de la forêt (SQ1).
// TODO : remplacer « SQ1 » par une référence Typst vers la Problématique une fois l'étiquette posée.

L'échantillonnage systématique prévu au projet de stage a été écarté en raison de la faible accessibilité de la forêt. Les placettes ont été implantées le long de neuf itinéraires parcourus avec les guides locaux, patrouilleurs communautaires ou responsables du VOI, qui ont suivi les chemins de ronde ou les deux grands itinéraires de la forêt. Le centre de chaque placette était choisi sur place, de façon à couvrir la diversité des milieux rencontrés, à plus de 10~m du chemin et sans distance minimale entre placettes. Cette implantation est proche de celle d'Armstrong et al. (2011), qui placent leurs placettes à intervalles aléatoires le long de l'itinéraire du jour en forêt dense humide de basse altitude, et de celle de Hending et al. (2023), qui les installent à au moins 10~m de transects établis. Elle s'en distingue par le choix des points sur place, et non à intervalles aléatoires ou réguliers.
// Note (Armstrong et al., 2011) : méthodes lues (p. 430) : 100 placettes circulaires de 10 m de diamètre, « chosen at random intervals along the trail route followed on a given day ».
// Note (Hending et al., 2023) : méthodes lues (p. 3333) : 200 placettes de 20 × 20 m, à ~50 m d'intervalle le long de transects, « a minimum of 10 m from the transect line ».
// Conséquences de ce choix (sélection orientée, autocorrélation entre placettes voisines) : à traiter dans la Discussion (« Limites méthodologiques »).

Les placettes ont été relevées en neuf journées, du 18 août au 16 septembre 2026 (18, 20, 25 et 26 août ; 2, 4, 11, 15 et 16 septembre). Deux journées supplémentaires (19 et 27 août) ont été consacrées à des itinéraires sans placette, pour les seuls relevés le long des chemins. Le protocole initial visait six placettes par jour sur vingt journées, pour un minimum de 60 placettes. Le temps d'approche à la forêt, les conditions de logement et la disponibilité des guides ont considérablement réduit cet effort d'échantillonnage.
// Dates d'après transects.csv (11 itinéraires, T01 à T21) et metadonnees_enquete-de-terrain_2_sorties.csv (sorties S8 à S21), lus le 01/11/2026.
// ATTENTION : les deux fichiers inversent les 26 et 27 août — transects.csv : placettes P8 à P11 le 26/08 (T05), chemin seul le 27/08 (T06) ; métadonnées des sorties : chemin Manakana-Ambila le 26/08 (S12), quatre placettes le 27/08 (S13). Le texte suit transects.csv.
// 11 itinéraires dans transects.csv : 9 avec placettes, 2 sans (auteur, 01/11/2026).
// Projet de stage (p. 22) : au moins six placettes par jour, environ 100 placettes, trente journées au plus ; précisions de l'auteur (31/10/2026) : une vingtaine de journées prévues, au moins 64 placettes.

Le dispositif comprend 28 placettes circulaires de 2,5~m de rayon, soit environ 20~m² chacune. Cette petite surface répond au temps disponible et à la charge de travail acceptable pour l'équipe de terrain, après l'essai d'une placette de 10~m de diamètre (voir P2 ci-dessous). Elle reste compatible avec les recommandations du _Mémento du forestier tropical_ : en forêt naturelle, où la répartition spatiale des arbres est le plus souvent agrégée, des placettes petites et nombreuses réduisent le coût de l'inventaire pour une précision donnée, et la forme de la placette n'influe que peu sur cette précision (Mille et Louppe, 2015).
// Note (Mille et Louppe, 2015) : §6.2 « Inventaires forestiers », p. 483 (lu). ATTENTION : le raisonnement y est établi pour l'estimation du volume ou de la biomasse ; sa transposition à la richesse spécifique est à assumer (ou à nuancer) en Discussion.

Le diamètre de 5 m a été tendu au ruban le long du sol, sans correction de pente. Chaque placette couvre donc 19,63~m² sur la pente, et sa surface horizontale vaut :

$ s_j = pi r^2 cos alpha_j $

où $r = 2,5$~m et $alpha_j = arctan(p_j / 100)$, $p_j$ étant la plus grande pente de la placette $j$, mesurée en pourcentage au clisimètre. Les indices sont rapportés à la surface horizontale cumulée $sum_j s_j$.
La surface horizontale cumulée des 28 placettes est de 531,1~m², pour 549,4~m² mesurés sur la pente.
// Correction appliquée le 31/10/2026 (accord de l'auteur) : placettes.csv, colonne « surface-horizontale » = surface sur la pente × cos(arctan(p/100)) ; colonne « surface-corrigee » = surface sur la pente (π r², 19,24 m² pour P27). Ancienne convention inversée (surface horizontale divisée par cos α). Sauvegarde de l'ancien fichier conservée hors dépôt. ATTENTION : si placettes.csv est régénéré depuis le fichier de saisie ODS, y reporter la même formule.
// P01 : comptage en plein sur un quart d'une placette de 10 m de diamètre (même surface, 19,63 m²) ; traité comme équivalent sans mention dans le texte (auteur, 31/10/2026).
// TODO : une décimale pour les surfaces (au lieu de deux par défaut) ; à valider.
// Anciennes valeurs retirées : 569 m² (document d'étape §2.1), 29 placettes (document d'étape §2.1).

La première placette complète, P2, a été inventoriée sur 10~m de diamètre, comme chez Armstrong et al. (2011). Cette surface s'étant révélée incompatible avec les contraintes du terrain, le diamètre a été ramené à 5~m pour les placettes suivantes. Pour homogénéiser le dispositif, les tiges de P2 ont été réparties par tirage aléatoire entre quatre placettes de surface standard, P02 à P05.
// Tirage reproductible (graine 20261009, note P2 du 09/10/2026) ; contrôle par Monte-Carlo sur 10 000 tirages : p = 0,114 (// TODO : valeur à valider, non vérifiée dans P2_decoupage_4_placettes.csv, hors 08_rapport). Correspondance des anciens et nouveaux codes en annexe.

Le centre de chaque placette a été géolocalisé au GPS (Garmin eTrex SE) et photographié. La placette a été matérialisé à l'aide de deux rubans métriques de 15~m, la pente mesurée en pourcentage au clisimètre (Suunto) et les circonférences relevées au ruban métrique, arrondies au centimètre le plus proche. Une paire de jumelles a servi à observer le feuillage en hauteur pour l'identification.
// Source : protocole_inventaire_forestier.odt (06_ecologie/methodologie, lu avec l'accord de l'auteur le 31/10/2026), annexe « Liste du matériel » et § « Mesures de placette ». Liste complète du matériel et fiches de relevés à placer en annexe.
// Le protocole fixe encore le seuil à une CBH de 15,5 cm (DBH de 5 cm, Armstrong et al., 2011) ; le texte retient 8 cm (auteur, 31/10/2026). Vérifié dans flore.csv le 31/10/2026 : seuil de 8 cm appliqué sur les 28 placettes.
// TODO : figure — carte des placettes sur la forêt (coordonnées GPS issues du nettoyage des données géographiques, encore à réaliser).

=== Relevés par placette

Le protocole de relevé, la liste du matériel et la fiche de relevé figurent en @annexe-protocole. Le centre de chaque placette a été géolocalisé et photographié. Sur chaque placette ont été relevés : la situation topographique, la pente, le recouvrement de la canopée, les strates de végétation présentes, le type d'humus, l'humidité du sol, l'abondance des épiphytes, des mousses, des lichens, des lianes et des champignons, et la présence de fleurs ou de fruits. Le recouvrement de la canopée est estimé visuellement depuis le centre de la placette, pour chacun des quatre quadrants (nord, sud, est, ouest), en classes de 25~%. Les strates présentes sont notées sans mesure de hauteur parmi quatre : herbacée (0 à 2~m), sous-bois ou arbustive (2 à 10~m), canopée inférieure (10 à 20~m) et canopée supérieure (plus de 20~m). L'humus est identifié selon la clé de Jabiol et al. (2016). L'humidité du sol est appréciée au toucher sur une poignée de terre prélevée en surface au centre de la placette, en trois classes : sèche (la terre s'effrite), humide (elle colle légèrement) ou saturée (elle est boueuse). L'abondance des épiphytes, mousses, lichens, lianes et champignons est notée par le nombre d'arbres porteurs, en trois classes (0 à 2, 2 à 10, plus de 10). Les fleurs et les fruits observés dans la placette, au sol ou encore sur la plante, sont notés avec le nom vernaculaire de l'espèce, le type d'organe et une abondance en trois classes ; ces observations, trop peu nombreuses, ne sont pas analysées ; les espèces notées complètent seulement la liste de la flore.
// Source : protocole_inventaire_forestier.odt (§ « Mesures de placette ») et en-têtes de placettes.csv et phenologie.csv (06_ecologie/analyse/donnees, vérifiés le 31/10/2026).
// TODO (Jabiol et al., 2016) : le protocole cite « Jabiol et al. (2016) » : identifier l'ouvrage réellement utilisé (clé de terrain ?) avant de figer l'année. Piste : Jabiol et al. (2013), Geoderma, 192, 286-294, https://doi.org/10.1016/j.geoderma.2012.08.002.

Toutes les tiges ligneuses de la placette ont été identifiées par leur nom vernaculaire. La circonférence à hauteur de poitrine (CBH, à 1,30~m) a été mesurée au ruban métrique, au centimètre près, pour toute tige de CBH $>=$ 8~cm, soit un diamètre d'environ 2,5~cm. Ce seuil reprend celui de Romiguière (2025), afin de faciliter la comparaison avec ses relevés ; il est inférieur à celui d'Armstrong et al. (2011), qui mesurent les tiges de diamètre $>=$ 5~cm, soit une CBH d'environ 16~cm, seuil repris par Hending et al. (2023). Il correspond au seuil des jeunes arbres (DHP $>=$ 2,5~cm) de l'inventaire national des forêts humides de l'Est (BNCCREDD+ et al., 2020). L'abaissement du seuil de 16 à 8~cm n'a ajouté qu'environ deux minutes au relevé d'une placette, qui durait plus d'une heure. Le diamètre à hauteur de poitrine (DBH) est calculé à partir de la CBH. Les tiges de plus de 1,30~m de haut et de CBH inférieure à 8~cm (gaulis) ont été dénombrées en plein par espèce, sans être mesurées, comme les petites tiges de l'Inventaire écologique forestier national, relevées par nom vernaculaire de part et d'autre d'une hauteur de 1,30~m (DEF et al., 1996). Les tiges de moins de 1,30~m de haut n'ont pas été relevées, sauf sur sept placettes (P21 à P28, hors P27), où elles ont été dénombrées en plein, toutes espèces confondues, en deux classes de hauteur (moins de 30~cm ; de 30 à 130~cm), afin d'estimer une densité de régénération.
// ATTENTION : « > 8 cm » (document d'étape, M&M antérieur) vs « ≥ 8 cm » (arbitrage auteur) ; ici ≥ 8 cm. Données vérifiées le 31/10/2026 : CBH minimale de 8 cm sur les 28 placettes ; les deux tiges de 7 cm de P06 (codes 0604 et 0613) sont passées en gaulis (flore.csv et ODS, décision de l'auteur).
// Durée par placette : estimation de l'auteur. « Autres études » à 8 cm de CBH : inventaire national 2020 (seuil de 2,5 cm de DHP), ajouté le 01/11/2026.
// Note (BNCCREDD+ et al., 2020) : lu le 01/11/2026 dans 02_Bibliographie/articles/ : tableau 1 p. 3 (forêts humides : jeunes arbres 2,5 cm ≤ DHP < 15 cm sur 10 × 10 m, régénération DHP < 2,5 cm dénombrée) ; tableaux 10 à 12 p. 19-21 (méthode de la lame au couteau, trois classes sain / intermédiaire / pourri, facteurs 1 / 0,8 / 0,45 ; bois mort gisant > 2,5 cm de diamètre mesuré au point d'intersection ; arbres morts sur pied : facteur de réduction de biomasse 0,975 ou 0,8) ; § 3.7 p. 22-23 (faune : nom local, spécimen observé, nombre).
// Note (DEF et al., 1996) : lu le 01/11/2026 (p. 8) : placettes circulaires de 3,75 m de rayon (D 3,0 à 14,9 cm) et de 1,25 m de rayon (D < 3 cm, hauteur ≥ 20 cm) ; petites tiges relevées par nom vernaculaire et dénombrées, en distinguant les hauteurs inférieures et supérieures à 130 cm. année et lieu d'édition à vérifier.
// Source régénération : colonnes regeneration-inf-30 et regeneration-30-a-130 de placettes.csv ; comptage en plein (auteur, 31/10/2026). Le quadrat de 1 × 1 m prévu au protocole n'a pas été appliqué.
// Densité de régénération < 1,30 m : analyse_regeneration.R (01/11/2026), tiges/m² ± erreur-type par classe de hauteur (arbitrage auteur) ; méthode en « Structure forestière ».

Les bois morts debout (chandelles) et au sol de CBH $>=$ 8~cm ont été mesurés. Le bois mort au sol est relevé par la méthode des transects linéaires (Van Wagner, 1968) le long des deux bandes délimitant la placette : chaque pièce qui croise la ligne est mesurée en circonférence au point d'intersection. La longueur de ligne varie selon les placettes (5 à 30~m), pour une longueur cumulée de 290~m. Le degré de décomposition des pièces au sol est apprécié en trois classes, selon la pénétration d'une lame de couteau : sain (la lame ne pénètre pas), intermédiaire (elle pénètre en partie, avec une perte de bois) et pourri (elle reste plantée dans un bois friable). Ces classes regroupent les cinq classes de décomposition de Harmon et Sexton (1996) (1-2, 3-4, 5) et reprennent les trois classes de densité du protocole de mesure du carbone de Walker et al. (2018), où le test est fait à la machette ; le protocole de l'inventaire national les note, comme ici, au couteau, et y relève le bois mort gisant à partir de 2,5~cm de diamètre, au point d'intersection (BNCCREDD+ et al., 2020). Trois classes bien distinctes se notent plus vite et se reproduisent mieux d'un observateur à l'autre que cinq classes fines.
// Source : bois-mort.csv (110 pièces : 75 au sol, 35 chandelles) et longueur-transect-bois-mort de placettes.csv (P01 : 20 m ; P02 à P05 : 5 m ; P06 : 30 m ; P07 à P28 : 10 m ; somme 290 m, valeurs réelles selon l'auteur). L = 290 m du document d'étape confirmé (recompté le 01/11/2026).
// « Mesurée au point d'intersection » : confirmé par l'auteur (01/11/2026), comme dans le protocole national (BNCCREDD+ et al., 2020, p. 20).
// Note (Walker et al., 2018) : vérifié le 01/11/2026 : SOP « Measurement of lying dead wood » (p. 54-56 : transects linéaires selon Harmon et Sexton, 1996 ; trois classes sound / intermediate / rotten) et « Dead wood density classes » (p. 57 : test de la machette). Seuil de ce protocole : diamètre > 10 cm (ici CBH ≥ 8 cm).
// ATTENTION : définitions des classes reprises de Walker et al. (2018), adaptées au couteau — vérifier qu'elles correspondent aux critères réellement appliqués sur le terrain.
// Argument non repris dans le texte, à placer en Discussion si sourcé : pour un stock de carbone, l'incertitude dominante viendrait de la densité du bois et de la longueur de ligne plutôt que de la finesse de l'échelle.

=== Transects

Les itinéraires parcourus entre les placettes servent de transects. Les grands arbres (CBH $>=$ 126~cm, soit un DBH d'environ 40~cm) ont été relevés dans une bande de 5~m de part et d'autre du chemin, avec leur nom vernaculaire et leur circonférence. Les chablis (tiges renversées, vivantes ou mortes, dont le houppier au sol reste relié à la souche) ont été dénombrés le long des chemins, en trois classes de diamètre : petits bois (moins de 30~cm), bois moyens (30 à 60~cm) et gros bois (plus de 60~cm). Les espèces végétales remarquées hors des placettes au cours des cheminements ont été notées, à titre indicatif, pour compléter la liste des espèces.
// Source : grands-arbres.csv, chablis.csv, autres-observations-flore.csv, transects.csv (vérifiés le 31/10/2026) ; seuil et largeur de bande des grands arbres, classes de chablis : auteur, 31/10/2026.
// grands-arbres.csv contient aussi des arbres de CBH 92 à 126 cm (reliquats d'un seuil antérieur, ignorés selon l'auteur) : filtre CBH ≥ 126 cm ajouté dans 08_analyse_carbone.R le 01/11/2026 (78 grands arbres retenus, dont 77 sur les cinq transects de longueur connue, seuls utilisés par les scripts carbone et transects ; l'arbre restant est sur T21, hors transect).
// ATTENTION : classes de chablis — unité à confirmer (diamètre ou circonférence ? en cm).
// TODO (auteur) : chablis — définition à reprendre (chablis.csv indique « pas de vérification si le bois a ouvert la canopée »), transects prospectés (T01 et T02 saisis ; T19 et T20 prévus selon transects.csv), longueurs.
// Longueurs prospectées pour les grands arbres reportées dans transects.csv le 01/11/2026 (tableau de l'onglet grands-arbres de l'ODS) : T05 1 940 m ; T06 1 800 m ; T16 205 m (190 m auparavant) ; T19 300 m (« 300 ? », incertain) ; T20 1 060 m ; total 5 305 m. Arbres de T21 : hors transect, à titre indicatif.
// TODO : statut final des indicateurs chablis/ha et grands arbres/ha.

=== Observations de la faune et des activités humaines

Le polisin'ala devait noter, au cours des cheminements, les animaux observés et les indices de leur présence (fèces, empreintes, nids, terriers, cris, etc.), selon White et Edwards (2000) ; les trois paramètres notés (nom local, type d'observation, nombre) sont ceux du protocole faune de l'inventaire national (BNCCREDD+ et al., 2020). Ce relevé n'a pas été tenu de façon systématique. Il ne vise qu'à lister les espèces réellement observées et les indices rencontrés : aucun indice d'abondance n'est calculé. Les traces d'activités humaines (souches coupées, pièges, etc.) ont été relevées de la même façon, à titre indicatif, pour décrire les types de pressions rencontrés.
// Source : protocole (§ « Mesures de parcours ») ; auteur, 31/10/2026. Données : fichier « T1-T2-faune » et notes de sortie (non lus).

=== Données complémentaires

Huit placettes de 40~m² (diamètre de précomptage de 2,5~cm), comprenant des sous-placettes de 4~m² en comptage en plein, ont été relevées dans la forêt par Romiguière (2025), au cours d'une prospection exploratoire de deux semaines. Elles complètent la liste des espèces végétales et les usages ; elles sont aussi ajoutées aux placettes de l'étude pour la surface terrière, le stock de carbone des tiges et la répartition par classe de diamètre (voir Stock de carbone).
Pour la liste des espèces végétales, les occurrences du document de transfert de gestion du VOI Maharitra (2004) et les relevés de Romiguière (2025) sont utilisés en complément. Pour la liste des espèces animales, les occurrences du document de transfert de gestion de 2004, du Global Biodiversity Information Facility (GBIF, consulté en avril 2026) et de Rajaonson et al. (2010) sont mobilisées.
// Rajaonson et al. (2010), retenu par la revue de littérature (lu le 01/11/2026) : visite de la forêt de Tsiazombazaha le 25/01/2009 ; seuls Avahi laniger et Eulemur rufus y ont été trouvés (p. 37).
// TODO : GBIF — citer le téléchargement (DOI de la requête GBIF) si disponible.

=== Identification des espèces et des usages

L'équipe de terrain comprenait un forestier, un polisin'ala (personne reconnue par la communauté pour sa connaissance de la forêt) et un traducteur-interprète. Les tiges étaient désignées une à une : le polisin'ala donnait le nom vernaculaire, le forestier mesurait la circonférence et le traducteur notait les noms malgaches. Les relevés ont été réalisés sans contrôle indépendant de l'identification. Lorsqu'un nom recouvrait plusieurs formes, le polisin'ala devait préciser le « type » de la tige et le décrire ; cette description n'a pas été recueillie de façon systématique.

Les noms vernaculaires ont ensuite été réconciliés en « identités ». La réconciliation porte surtout sur les variantes orthographiques d'un même nom ; les types d'une même espèce ont été regroupés lorsque leur parenté était évidente. Aucun autre regroupement n'a été fait. Chaque identité a été rattachée à un nom scientifique lorsque c'était possible, à partir de Schatz (2001), de Romiguière (2025), de PlantNet, de Tropicos Madagascar et d'iNaturalist. Lorsque l'identification à l'espèce était impossible, l'observation a été rattachée au genre ou à la famille. Dans la suite du texte, le terme « espèce » désigne une identité réconciliée.
// TODO : dates d'accès des bases en ligne (Pl@ntNet, Tropicos, iNaturalist).
// Source : protocole (§ « Répartition des tâches ») ; rôles, absence de contrôle, types et règle de réconciliation confirmés par l'auteur le 31/10/2026.

Les usages des plantes ont été recueillis auprès du polisin'ala sur le terrain, pour chaque espèce relevée. D'autres usages ont été cités au cours des entretiens ; les deux sources restent à rapprocher. Les usages notés par Romiguière (2025) sur ses tiges de Tsiazombazaha sont ramenés aux mêmes libellés normalisés et réunis à ceux de l'étude. Les usages sont classés selon l'Economic Botany Data Collection Standard (Cook, 1995). Les libellés français sont utilisés dans le texte ; les codes de classification figurent en @annexe-codes-cook.
// TODO : rapprochement des usages terrain / entretiens.

=== Saisie des données

Les données de terrain ont été saisies par l'auteur sous LibreOffice Calc. Une première saisie par le traducteur, trop erronée, a été abandonnée et l'ensemble des fiches a été ressaisi. Le contrôle a porté sur la quasi-totalité des fiches, relues au moins une fois un autre jour que celui de la saisie. Les données ont ensuite été nettoyées et exportées en fichiers CSV, un par type d'observation, reliés par les codes de transect et de placette (@annexe-fichiers-donnees). Les fichiers déposés avec le mémoire sont décrits en @annexe-metadonnees.
// REF? LibreOffice Calc : https://www.libreoffice.org — version à préciser.
// Source : auteur, 01/11/2026.

// Tableau des fichiers de données déplacé en annexe (@annexe-fichiers-donnees) le 01/11/2026 (guide, critères 5 et 79).

== Analyse des données écologiques

Les indicateurs retenus décrivent l'état initial de la forêt (SQ1) et servent de point de référence pour un suivi ultérieur. Ils reprennent ceux des inventaires de forêts malgaches les plus proches de cette étude : densité, surface terrière, distribution par classes de diamètre, indice de valeur d'importance et indice de Shannon chez Armstrong et al. (2011), courbes de raréfaction et estimateur Chao1 de la richesse chez Hending et al. (2023).

=== Conventions

Les analyses ont été réalisées avec R 4.6.1 (R Core Team, 2026) sous RStudio, avec les packages dplyr 1.2.1, tidyr 1.3.2, readr 2.2.0, stringr 1.6.0 et tibble 3.3.1 pour la préparation des données, vegan 2.7.6 (Oksanen et al., 2026) pour les indices de diversité, les estimateurs de richesse et l'ordination, iNEXT 3.0.2 (Hsieh et al., 2016) pour la raréfaction-extrapolation et l'estimateur Chao2, SpadeR 0.1.1 pour le jackknife d'ordre 2 et l'ICE, // REF? SpadeR : référence du package à ajouter (citation("SpadeR") dans R)
 et ggplot2 4.0.3 (Wickham, 2016), scales 1.4.0, ggrepel 0.9.8 et svglite 2.2.2 pour les figures.
// Versions relevées le 31/10/2026 sur la machine de l'auteur (packageVersion) ; packages chargés par les six scripts d'analyse actifs. Les autres packages (dplyr, tidyr…) peuvent être cités par citation() si le référent le demande.

Les indices sont rapportés à la surface horizontale des placettes (voir Dispositif d'échantillonnage). Les gaulis sont comptés dans la densité $N$ mais exclus de la surface terrière $G$ ; la classe de diamètre 0-2,5~cm inclut les gaulis. Les tiges d'espèce indéterminée sont exclues de tous les calculs de diversité et de richesse ; leur nombre est indiqué dans les résultats. Pour les indices calculés par placette, la moyenne est donnée entre placettes, avec l'écart-type lorsque la dispersion entre placettes est décrite (nombre de tiges par placette, indices de diversité) et l'erreur-type pour les estimations de densité ($N$, $G$, régénération) ; les intervalles de confiance à 95~% sont calculés par la loi de Student. Les dissimilarités entre paires de placettes sont décrites par leur écart-type. Font exception la densité de grands arbres, dont l'erreur-type est celle de l'estimateur par le ratio, et les stocks de carbone et la raréfaction, dont les intervalles de confiance sont obtenus par bootstrap. Deux approches coexistent : à l'échelle du dispositif (effectif total rapporté à la surface cumulée) et par placette (moyenne des rapports). Elles donnent des valeurs légèrement différentes et ne sont jamais mélangées dans les résultats.
Les niveaux de probabilité sont notés \* $p$ (H0) $<$ 0,05 ; \*\* $p$ (H0) $<$ 0,01 ; \*\*\* $p$ (H0) $<$ 0,001.
// Scripts relancés le 31/10/2026 après correction de la surface horizontale (placettes.csv : π r² cos α, total 531,1 m² contre 549,4 m² sur la pente), exclusion des indéterminées (diversité, richesse, IVI), correction de flore.csv (Fenakaragna, codes d'observation) et retrait du regroupement de communes ; copies mises à jour dans analyse-tables/ et analyse-figures/.

=== Listes d'espèces et usages

Deux listes d'espèces sont établies. La liste de la flore réunit les espèces relevées dans les placettes et le long des transects, celles notées hors relevé au cours des cheminements et celles citées par Romiguière (2025) et par le document de transfert de gestion de 2004, en indiquant la source de chaque mention.
// ATTENTION : espèces du transfert de gestion de 2004 pas encore ajoutées à la liste (annexe : codes R, O et Rom seulement) ; ajout prévu par l'auteur. Les noms vernaculaires relevés par Romiguière (2025) à Tsiazombazaha sont rattachés à ceux de l'étude par une table de correspondance, proposée par similarité des graphies puis vérifiée à la main ; pour les espèces sans nom scientifique dans l'étude, le nom est déduit de ses identifications sur ses deux sites (Tsiazombazaha et Vorovoka) : l'espèce si une seule est citée, sinon le genre s'il est unique, sinon la famille si elle est unique ; à défaut, aucun nom n'est donné. La liste n'est pas limitée aux ligneux : les observations hors relevé comprennent aussi des herbacées et des lianes. Pour chaque espèce sont donnés le nom vernaculaire, le rattachement botanique lorsqu'il existe, le nombre de types décrits par le polisin'ala et les usages cités. Les usages sont dénombrés par catégorie de la classification de Cook (1995), en nombre d'espèces citées pour chaque catégorie. Pour mesurer l'apport de l'abaissement du seuil de mesure, les espèces sont ajoutées à la liste dans un ordre fixe : tiges des placettes de DBH $>=$ 5~cm (seuil d'Armstrong et al., 2011), tiges de 2,5 à 5~cm, gaulis, puis espèces notées hors placettes ; à chaque étape, seules les espèces absentes des étapes précédentes sont comptées. La liste de la faune réunit les espèces observées directement ou par leurs indices de présence au cours des cheminements et celles citées par le document de transfert de gestion de 2004, par le GBIF et par Rajaonson et al. (2010) ; elle est purement qualitative. Les types de traces d'activités humaines rencontrés sont présentés à titre indicatif, sans traitement.
// Liste non limitée aux ligneux (02/11/2026) : liste_flore.csv contient par exemple Kasakasa (herbacée, phénologie), Typha angustifolia, Entada scandens et Clematis mauritiana (lianes).

=== Structure forestière

Les indicateurs suivent les définitions du _Mémento du forestier tropical_ (Mille et Louppe, 2015) et sont ceux utilisés par Armstrong et al. (2011) en forêt dense humide de basse altitude malgache. La densité $N$ (tiges/ha) est calculée par placette, puis moyennée entre les $n$ placettes :

$ N = 1/n sum_j 10000 dot N_j / s_j $

où $N_j$ est le nombre de tiges de la placette $j$ et $s_j$ sa surface horizontale (m²). La surface terrière $G$ (m²/ha) est la somme des sections des troncs à hauteur de poitrine, $g_k = pi D_k^2 / 4$ pour la tige $k$, calculée et moyennée de la même façon. $N$ et $G$ sont donnés avec leur erreur-type et leur intervalle de confiance à 95~%.
// Corrigé le 01/11/2026 : l'ancienne formule (effectif total / surface cumulée, approche du dispositif) ne correspondait pas aux valeurs des Résultats, qui sont des moyennes de densités par placette (resumer() dans fonctionsStructure.R, structure_resume_indices.csv). La distribution des effectifs est établie par classes de diamètre de 2,5~cm ; celle de la surface terrière par classes de 5~cm à partir de 2,5~cm. Les grands arbres des transects y sont ajoutés par classe, leur effectif et leur surface terrière étant rapportés à la surface totale prospectée le long des transects. La régénération de plus de 1,30~m de haut est décrite par l'effectif de la classe 0-2,5~cm, qui comprend les gaulis ; celle de moins de 1,30~m, par sa densité (tiges/m²) dans chacune des deux classes de hauteur, moyenne entre les placettes où elle a été dénombrée, avec son erreur-type.
// Formule de g vérifiée dans fonctionsStructure.R : G = π / 4 × (DBH/100)², avec DBH = CBH / π.
La densité de grands arbres (CBH $>=$ 126~cm) est estimée par le rapport entre leur effectif total et la surface prospectée le long des transects (longueur × 10~m) ; son erreur-type est celle de l'estimateur par le ratio, les transects étant les unités d'échantillonnage (Cochran, 1977). Les chablis sont dénombrés par classe de diamètre et par transect.
// Note (Cochran, 1977) : chapitre 6, estimateur par le ratio.
// TODO (auteur) : densité de chablis à l'hectare à ajouter une fois les longueurs prospectées connues (analyse_transects.R n'exporte que les effectifs).

// Analyse de la corrélation régénération / couvert retirée (auteur, 31/10/2026) : ne répond pas directement à SQ1 ; la régénération est décrite par la classe 0-2,5 cm de la structure diamétrique, qui inclut les gaulis.

=== Stock de carbone

Le stock de carbone est estimé pour quatre compartiments : les tiges vivantes des placettes, les grands arbres des transects, le bois mort au sol et le bois mort sur pied. Les grands arbres relevés le long des chemins et les tiges des placettes proviennent de deux dispositifs distincts, sans recouvrement : leurs stocks s'additionnent.
// ATTENTION : vrai pour les 28 placettes de l'étude (aucune tige de DBH ≥ 40 cm). Le jeu « Étude + Romiguière » compte des tiges de DBH ≥ 40 cm, déjà couvertes par les transects : pour un stock total avec ce jeu, ne retenir des placettes que les tiges de CBH < 126 cm (compartiments séparés par le diamètre), ou n'additionner que le stock de l'étude seule.

La biomasse aérienne $"AGB"_k$ (kg) de chaque tige vivante est estimée par l'équation sans hauteur de Chave et al. (2014) :

$ "AGB"_k = exp(-"1,803" - "0,976" E + "0,976" ln(rho) + "2,673" ln(D_k) - "0,0299" (ln D_k)^2) $

où $D_k$ est le DBH (cm), $rho$ la densité du bois (g/cm³) et $E$ l'indice de stress environnemental du site. $E$ vaut 0,10 : il est lu dans la grille de Chave et al. (2014), diffusée avec le package R BIOMASS (Réjou-Méchain et al., 2017), au centre de l'emprise de la forêt. Le rattachement des noms vernaculaires aux genres et aux familles est trop incertain pour attribuer une densité à chaque espèce. Une densité générique $rho = "0,58"$~g/cm³ est donc appliquée à toutes les tiges ; c'est la moyenne des espèces d'Afrique tropicale (Brown, 1997, d'après Reyes et al., 1992). L'équation est appliquée à toutes les tiges mesurées, y compris celles dont le DBH est compris entre 2,5 et 5~cm, en deçà du domaine de calibration du modèle.
// Source : 08_analyse_carbone.R (constantes, 01/11/2026). E = 0,1025 au centre de l'emprise (47,951 °E ; 21,904 °S), 0,102 à 0,109 aux quatre coins (grille E.zip du dépôt GitHub umr-amap/BIOMASS, résolution 2,5', lue avec GDAL). L'ancienne valeur provisoire E = −0,080 est abandonnée.
// ρ = 0,58 : Brown (1997), §3.1.2, tableau des densités moyennes par région (Afrique : 0,58, 282 espèces ; Amérique : 0,60 ; Asie : 0,57), qui recommande la moyenne régionale pour les espèces inconnues (lu le 01/11/2026). L'ancienne valeur 0,60 correspondait à la moyenne de l'Amérique tropicale.
// Note (Brown, 1997) : §3.1.2, moyenne régionale pour les espèces inconnues.
// Limite à reprendre en Discussion : densité unique (pas de variation entre espèces) et tiges de DBH < 5 cm hors du domaine de calibration ; un calcul de sensibilité (ρ = 0,50 et 0,70) peut encadrer le résultat si besoin.

Pour renforcer l'échantillonnage des tiges mesurées, la surface terrière, le stock de carbone des tiges et la répartition de la densité et de la surface terrière par classe de diamètre (classes à partir de 2,5~cm) sont aussi calculés en ajoutant les huit placettes de 40~m² relevées par Romiguière (2025) à Tsiazombazaha, au même seuil de mesure (CBH $>=$ 8~cm). Ces placettes ne sont pas corrigées de la pente ; sans gaulis relevés, elles n'entrent ni dans la densité totale ni dans la classe 0-2,5~cm. Les hauteurs qu'il a mesurées permettent en outre de comparer, sur ses tiges, la biomasse obtenue par l'équation sans hauteur à celle de l'équation avec hauteur de Chave et al. (2014).
// Source : analyse_sensibilite_romiguiere.R (02/11/2026), mêmes méthodes et constantes que analyse_structure_forestiere.R et 08_analyse_carbone.R.

La biomasse souterraine est extrapolée par un ratio racines/parties aériennes $R = "0,20"$ pour une forêt tropicale humide (Mokany et al., 2006 ; Gytarsky et al., 2019). Le stock de carbone est obtenu par une fraction de carbone de la matière sèche $"CF" = "0,47"$ (Eggleston et al., 2006), converti en CO₂ par le rapport des masses molaires ($"M"_("CO"_2) / "M"_C = "3,67"$) :

$ "Stock"_("CO"_2) = (1 + R) dot "AGB" dot "CF" dot "M"_("CO"_2) / "M"_C = "2,06988" dot "AGB" $

Le volume de bois mort au sol (m³/ha) est estimé par la méthode des transects linéaires (Van Wagner, 1968), en assimilant les pièces à des cylindres :

$ V_("bm,sol") = 10000 dot pi^2 / (8 L) sum_i d_i^2 f_i $

où $d_i$ est le diamètre (m) de la pièce $i$ au point d'intersection, $L$ la longueur cumulée des lignes (290~m) et $f_i$ un facteur de réduction de densité selon la classe de décomposition : 1,00 pour le bois sain, 0,80 pour le bois intermédiaire et 0,45 pour le bois pourri. Ces valeurs sont les valeurs par défaut de l'outil méthodologique du Mécanisme pour un développement propre pour le bois mort (CCNUCC, 2010), adaptées de Harmon et Sexton (1996), et celles du protocole de l'inventaire national (BNCCREDD+ et al., 2020). La biomasse du bois mort sur pied (chandelles) est estimée par l'équation de Chave et al. (2014), multipliée par un facteur de réduction de biomasse de 0,80 que le même outil et l'inventaire national appliquent aux arbres morts ayant perdu leurs feuilles, leurs rameaux et leurs petites branches ; faute de hauteur mesurée, ce facteur remplace un calcul de volume du fût. La biomasse du bois mort est le produit du volume par la densité $rho$ ; son stock de carbone est calculé avec la même fraction $"CF"$, sans biomasse souterraine.
// Note (CCNUCC, 2010) : lu le 01/11/2026 : facteurs de réduction de densité 1,00 / 0,80 / 0,45 (§21, p. 5, note 4 : adaptés de Harmon et Sexton, 1996) ; test de la machette (note 3, d'après IPCC GPG-LULUCF 2003) ; facteur de réduction de biomasse 0,80 pour les arbres morts sans petites branches (§11 b). Année de l'EB 58 (décembre 2010) à vérifier.
// Les anciens facteurs 0,9 / 0,6 / 0,4 (« adaptation conservative de Harmon et Sexton ») sont abandonnés faute de source ; la mesure de densité par classe de Walker et al. (2018) est impossible a posteriori.
// L'outil MDP applique la formule aux pièces de diamètre ≥ 10 cm ; le protocole national, à partir de 2,5 cm de diamètre, comme ici (CBH ≥ 8 cm).

Les stocks des placettes sont rapportés à leur surface horizontale cumulée, ceux des grands arbres à la surface prospectée le long des transects (longueur × 10~m). Les intervalles de confiance à 95~% sont obtenus par bootstrap (1~000 rééchantillonnages des placettes ou des transects, graine 2026). Les stocks par hectare sont extrapolés à la surface totale de la forêt.
// TODO : surface de la forêt provisoire (500 ha, variable SURFACE_TSIAZOMBAZAHA du script) en attendant le calcul sous QGIS ; citer la valeur et sa source une fois calculée.
// Grands arbres : 5 305 m prospectés (T05, T06, T16, T19, T20), soit 53 050 m² ; T19 incertain (« 300 ? » dans l'ODS).

=== Diversité alpha

La diversité alpha, à l'échelle de la placette, est quantifiée par quatre indices calculés sur les effectifs de toutes les tiges comptées (tiges mesurées et gaulis). Les trois premiers relèvent du cadre unificateur des nombres de Hill $""^q D$ (Hill, 1973), où l'ordre $q$ règle la sensibilité à la rareté : la richesse spécifique $S = ""^0 D$ ; l'indice de Shannon $H' = -sum_i p_i ln p_i$ (Shannon et Weaver, 1949), utilisé par Armstrong et al. (2011), dont l'exponentielle $""^1 D$ s'interprète comme le nombre effectif d'espèces communes (Jost, 2006) ; l'inverse de l'indice de Simpson, $""^2 D = 1 / sum_i p_i^2$ (Simpson, 1949), nombre effectif d'espèces dominantes. Le quatrième est l'indice alpha de Fisher, défini par $S = alpha ln(1 + N / alpha)$ (Fisher et al., 1943), peu sensible au nombre de tiges comptées. ¹D et ²D sont calculés sous leur forme brute, sans correction du biais d'échantillonnage : les placettes, de petite surface, comptent une forte proportion d'espèces représentées par une seule tige, et les estimateurs corrigés (Chao et al., 2014) y extrapoleraient fortement. Les indices décrivent donc les assemblages échantillonnés, et $H'$ reste comparable à celui d'Armstrong et al. (2011).
// Arbitrage auteur (01/11/2026) : formes homogènes, corrigées si adaptées, sinon brutes. Contrôle hors scripts (Python, diversite_abondances.csv) : en moyenne 54 % d'espèces à une tige par placette, couverture d'échantillonnage moyenne de 0,75 (minimum 0,51) — valeurs non citées dans le texte.

=== Diversité bêta

La diversité bêta mesure la différence de composition entre placettes. Le bêta multiplicatif de Whittaker, $beta = gamma / macron(alpha)$ (Whittaker, 1960), où $gamma$ est le nombre d'espèces de l'ensemble des placettes et $macron(alpha)$ leur richesse moyenne, s'interprète comme le nombre effectif de communautés entièrement distinctes (Jost, 2007). Le bêta additif, $beta_"add" = gamma - macron(alpha)$ (Lande, 1996), est le nombre moyen d'espèces de la forêt absentes d'une placette moyenne ; rapporté à $gamma$, il donne la part de la richesse de la forêt absente d'une placette moyenne.
// Choix de γ / ᾱ plutôt que γ / ᾱ − 1 (auteur, 31/10/2026) : forme la plus courante et la plus parlante pour les décideurs ; script modifié (fonctionsDiversiteBeta.R) et relancé.

Une ordination par positionnement multidimensionnel non métrique (NMDS) en deux dimensions est réalisée sur les dissimilarités de Bray-Curtis (Bray et Curtis, 1957) calculées à partir des effectifs par placette ; la qualité de la représentation est mesurée par le stress (Kruskal, 1964). Les placettes sont représentées par un symbole propre à leur itinéraire, pour rendre visible une éventuelle autocorrélation spatiale.

Les dissimilarités entre paires de placettes, de Bray-Curtis sur les effectifs et de Jaccard en présence-absence, sont comparées selon le niveau auquel les deux placettes se rattachent à une même entité : même itinéraire, même polisin'ala, même commune, ou communes différentes. Cette comparaison vise à distinguer l'effet de la proximité spatiale de celui de l'observateur, chaque polisin'ala nommant les espèces selon ses propres connaissances. Les paires de placettes n'étant pas indépendantes, une même placette entrant dans plusieurs paires, la comparaison est seulement descriptive (moyennes, écarts-types et boîtes à moustaches). Enfin, la proportion d'espèces observées dans une seule commune est comparée à sa distribution sous l'hypothèse nulle, obtenue en réattribuant au hasard les communes aux placettes (999 permutations, effectifs de placettes par commune conservés).
// Détails vérifiés dans analyse_diversite_beta.R (31/10/2026) : vegan::metaMDS(k = 2, trymax = 100) ; niveaux hiérarchiques transect > polisin'ala > commune ; permutation avec set.seed(2026), p = (1 + nb ≥ obs) / (nPerm + 1).
// Tests de Kruskal-Wallis et de Wilcoxon sur les paires retirés du rapport (pseudo-réplication, arbitrage auteur du 31/10/2026) ; ils restent dans les CSV *_tests_* pour traçabilité.
// Regroupement « Ambila et Mizilo contre Ambahatrazo » retiré du script (auteur, 31/10/2026). Les anciens fichiers diversite_beta_*groupes*.csv restent dans sorties/ mais sont obsolètes.

=== Indice de valeur d'importance

L'indice de valeur d'importance (IVI) de l'espèce $i$ combine sa densité relative, sa dominance relative et sa fréquence relative (Curtis et McIntosh, 1951). Il est présenté sur 100, c'est-à-dire divisé par 3 par rapport à la forme sur 300 utilisée par Armstrong et al. (2011) :

$ "IVI"_i = ("RD"_i + "RDo"_i + "RF"_i) / 3, quad "RD"_i = 100 dot n_i / (sum_j n_j), quad "RDo"_i = 100 dot G_i / (sum_j G_j), quad "RF"_i = 100 dot F_i / (sum_j F_j) $

avec $n_i$ le nombre de tiges mesurées, $G_i$ la surface terrière et $F_i$ le nombre de placettes où l'espèce $i$ est présente. L'IVI est calculé sur les seules tiges mesurées, seules à disposer d'une surface terrière, comme chez Armstrong et al. (2011), qui le calculent pour les arbres mesurés (DBH $>=$ 5~cm) et dénombrent à part la régénération ; il exclut les tiges d'espèce indéterminée.
// Choix discuté le 31/10/2026 : un IVI partiel pour les espèces sans tige mesurée ne serait pas comparable, et attribuer une surface terrière fictive aux gaulis (CBH de 1 cm) serait arbitraire ; les gaulis, bien plus nombreux que les tiges mesurées, domineraient alors la densité et la fréquence relatives. La régénération par espèce peut être présentée à part si besoin.
// Kent (2011), Vegetation Description and Data Analysis (2e éd.), cité par le script pour la forme normalisée de l'IVI ; non cité dans le texte.
// Sortie du 01/11/2026 : 124 espèces, 28 placettes, 479 tiges mesurées (indéterminées exclues), après passage en gaulis des tiges de 7 cm de P06.

=== Richesse spécifique totale

La richesse observée $gamma_"obs"$ est le nombre d'espèces recensées dans l'ensemble des placettes. L'état d'avancement de l'inventaire est décrit par la courbe de raréfaction-extrapolation en fonction du nombre de placettes, extrapolée jusqu'à quatre fois l'effort réalisé (Chao et Jost, 2012 ; Hsieh et al., 2016), comme Hending et al. (2023) le font en fonction du nombre d'arbres. La richesse totale est estimée par des estimateurs asymptotiques dont la confrontation délimite une fourchette : Chao2, estimateur principal, et, en complément, les jackknifes d'ordre 1 et 2, ICE et bootstrap sur les incidences, ainsi que Chao1 et ACE sur les abondances (Burnham et Overton, 1979 ; Chao, 1984 ; 1987 ; Lee et Chao, 1994 ; Smith et van Belle, 1984). Le dispositif étant orienté par l'accessibilité, ces estimateurs visent la richesse des assemblages couverts ; ils constituent des bornes inférieures de la richesse de la forêt, et l'extrapolation à la forêt entière est une généralisation appuyée sur cette couverture, non une inférence statistique.
// Figures et tableaux des analyses : en Résultats ; tableau complet des estimateurs en annexe (estimateurs_richesse_gamma.csv).
// γ = 242 espèces depuis le 01/11/2026 (« Valotra / Voamalimpangady » rattaché à « Espèce indéterminée ») ; auparavant γ = 243 espèces dans les scripts de diversité bêta et de richesse (31/10/2026), après correction de l'observation de Fenakaragna (P07 : un gaulis saisi) et renumérotation des codes d'observation de flore.csv (419 codes alignés sur le numéro de placette, 917 codes uniques). ATTENTION : renumérotation faite dans flore.csv seulement ; à reporter dans le fichier de saisie ODS si les CSV en sont régénérés.

== Utilisation des outils d'intelligence artificielle

Des assistants d'intelligence artificielle générative et agentique ont été utilisés tout au long du stage pour la recherche bibliographique, la réflexion, l'aide à la rédaction, la programmation et l'analyse des données : Le Chat et les assistants Vibe (Chat, Work, Code) de Mistral AI, fondés sur les modèles Mistral Small 4, Medium 3.5, Large 3 et 4, Magistral et GLM 5.2 et 5.3 de Z.ai hébergés par Mistral AI, ainsi que Claude (Anthropic), avec les modèles Opus 5.5, Sonnet 5.5 et Haiku 5.5. Les transcriptions des entretiens, anonymisées, sont analysées avec l'assistance de Claude. Les contenus produits ont été systématiquement relus et vérifiés par l'auteur, qui en assume la pleine responsabilité.