#import "TitresCourts.typ": titre-court

#pagebreak(weak: true)
= Matériel et méthodes

== Site d'étude

// Ordre retenu (auteur, 31/10/2026) : la forêt (localisation, milieu physique, fragment), puis le territoire en entonnoir (communes, fokontany, périmètre transféré). Découpage en trois sous-parties (auteur, 03/11/2026).

=== Localisation et milieu physique

La forêt de Tsiazombazaha est située dans la région Fitovinany, district de Manakara Atsimo, entre 47,933~°E et 47,969~°E de longitude et entre 21,884~°S et 21,924~°S de latitude (degrés décimaux, datum WGS84) (@fig-carte-localisation). L'altitude y varie d'environ 35 à 85~m.
Son nom, formé de « _tsia_ » (négation), « _zo_ » (« l'action d'aller, marcher ») et « _basaha_ » (« étranger », en particulier blanc ou français), signifie « là où les étrangers ne peuvent pas aller ». Au moins quatre autres forêts de la côte Est portent ce nom (voir Revue de la littérature), ce qui pourrait refléter une histoire commune liée à la colonisation française. La forêt est aussi homonyme d'un _fokontany_ de la commune de Mizilo Gara et d'un village ; dans la suite du texte, « Tsiazombazaha » seul désigne la forêt, et le _fokontany_ ou le village sont toujours nommés comme tels.
// ATTENTION (relecture 03/11/2026) : « étranger » s'écrit d'ordinaire _vazaha_ (v → b après m : Tsiazom-bazaha) et « _azo_ » signifie aussi « pouvoir, être obtenu » ; vérifier la décomposition et la graphie dans le dictionnaire utilisé. « Suggérant » adouci en « ce qui pourrait refléter » (hypothèse non sourcée).
// REP : au moins quatre identifiées par les homonimies lors de la revue PRISMA
// REP : source de l'étymologie : recherche personnelle à partir d'un dictionnaire malgache

// Carte provisoire insérée le 03/11/2026 à la demande de l'auteur (« ajouter la carte carte_zoom_tsiazombazaha_site-detude-TEMP-fausse-carte.png »).
// ATTENTION : carte TEMPORAIRE, en couleur, avec titre et légende dans l'image ; c'est une carte des fokontany (Inter Aide, 2026) plutôt qu'une carte de localisation. Elle nomme « Mahatsara » (= Manakana, voir plus bas) et des fokontany (Vohitrandriana, Ambalavolo…) qui ne recoupent pas exactement la liste des sept fokontany du VOI donnée en commentaire du territoire. À remplacer par la carte 1, en conservant l'étiquette <fig-carte-localisation>.
#figure(
  image("images/carte_zoom_tsiazombazaha_site-detude-TEMP-fausse-carte.png", width: 100%,
    alt: "Carte des fokontany autour de la forêt de Tsiazombazaha, sur fond d'image satellite : forêt en vert au centre, fokontany d'intervention, hors forêt, prévus et sans intervention en couleurs, maisons des techniciens."),
  caption: [Carte provisoire de la forêt de Tsiazombazaha et des _fokontany_ riverains (_fokontany_ d'intervention, d'intervention hors forêt, d'intervention prévue et sans intervention liée à la forêt), sur fond d'image Google Satellite, échelle 1/150~000. Carte d'Inter Aide (2026).],
) <fig-carte-localisation>
#titre-court(<fig-carte-localisation>)[Carte provisoire du site d'étude]

// TODO : carte 1 à réaliser sous QGIS, puis remplacer la carte provisoire ci-dessus par ce bloc (même étiquette, un seul bloc actif à la fois).
// #figure(
//   image("images/carte_localisation.svg", width: 100%),
//   caption: [Localisation de la forêt de Tsiazombazaha : Madagascar (encart), région Fitovinany, et fragments de forêt naturelle voisins (Lakia, Vorovoka, Vatovavy). Système de coordonnées WGS84. Sources : // TODO (limites administratives, couvert forestier, fond de carte).],
// ) <fig-carte-localisation>
// Contenu attendu : encart Madagascar → région Fitovinany → forêt ; les trois fragments voisins avec leurs distances ; échelle, nord, sources. Niveaux de gris (critère du mémoire), sans titre dans l'image.

Les normales climatiques WorldClim 2.1 (période 1970-2000, résolution de 10 minutes d'arc) donnent une température moyenne annuelle de 22,9~°C, de 19,7~°C en juillet à 25,9~°C en janvier, et des précipitations annuelles de 2~531~mm (Fick et Hijmans, 2017). Les pluies sont maximales de janvier à mars (367 à 407~mm par mois) et minimales en septembre et octobre (93 et 86~mm) (@fig-ombrothermique).

// TODO : données du diagramme ombrothermique à mettre en annexe (critère 80 du guide GEEFT : données ayant servi à construire les graphiques).
#figure(
  image("images/diagramme_ombrothermique.svg",
    alt: "Diagramme ombrothermique : barres grises des précipitations mensuelles, de 86 mm en octobre à 407 mm en mars, toutes au-dessus de la courbe des températures, comprise entre 19,7 et 25,9 °C."),
  caption: [Diagramme ombrothermique de la forêt de Tsiazombazaha : précipitations mensuelles (barres) et température moyenne mensuelle (courbe), normales 1970-2000. Échelle de Gaussen (P = 2T) jusqu'à 100~mm, compressée au dixième au-delà (Walter et Lieth, 1960). D'après WorldClim 2.1, résolution de 10 minutes d'arc (Fick et Hijmans, 2017), valeurs lues au centre de la forêt.],
) <fig-ombrothermique>
#titre-court(<fig-ombrothermique>)[Diagramme ombrothermique de Tsiazombazaha]
// Données de la figure : images/climat_worldclim_tsiazombazaha.csv (extraction du 31/10/2026). Figure tracée hors R (Python, matplotlib) ; à refaire dans R si l'homogénéité graphique avec les autres figures est souhaitée.
// Walter et Lieth (1960) : non lu, à vérifier.
// Extraction (31/10/2026) : valeurs lues au centre de l'emprise (47,951 °E ; 21,904 °S) ; les quatre coins de l'emprise tombent dans la même maille de 10' (~18 km), la valeur vaut donc pour toute la forêt. Une extraction à 30 s (~1 km) préciserait les valeurs.
// TODO : valeur à valider — altitude lue sur cinq points de l'emprise (35 à 84 m) dans Copernicus DEM GLO-90, via l'API Open-Meteo (31/10/2026) ; à reprendre sur le périmètre réel de la forêt sous QGIS. // REF? Copernicus DEM, https://doi.org/10.5270/ESA-c5d3d65

// COR appliquée (03/11/2026) : sols ferrallitiques typiques jaune sur rouge (parfois tendance hydromoprhe) sur roches acides (VIII_10) de la carte pédologique de madagascar / office de la recherche scientifique et technique d'outre-mer / riquier1968-ORSTOM / échelle 1:1000000
// COR appliquée (03/11/2026) : carte géologique 1:1000000 Ministère des mines/BRGM/USGS J-Y Roig (BRGM) (?) carte illisible, définition trop faible // on maintient la mention au bouclier sans source, c'est connu
La forêt appartient à l'écorégion des Forêts humides de l'Est, l'une des quatre écorégions forestières définies par l'administration malgache dans le cadre de la REDD+, et plus précisément au domaine de l'Est (0 à 800~m d'altitude), qui regroupe les forêts denses humides sempervirentes de basse altitude et les forêts littorales (BNC-REDD+, 2017). Elle repose sur le socle cristallin précambrien du bouclier malgache. D'après la carte pédologique de Madagascar au 1/1~000~000 (Riquier, 1968), les sols sont des sols ferrallitiques typiques jaune sur rouge, parfois à tendance hydromorphe, développés sur roches acides (unité VIII_10). Les cartes pédologiques disponibles, anciennes ou d'une petite échelle, ne permettent pas une caractérisation plus fine (Nishigaki et al., 2020).
// Ancienne formulation retirée (03/11/2026) : « ferralsols, anciens, profonds, acides et pauvres en nutriments (Riquier, 1966) ». Entrée requier_1966 de hayagriva.yml remplacée par riquier_1968 d'après la COR (lieu d'édition et feuille à compléter).
// Note (BNC-REDD+, 2017) : §2.2, p. 13-15 ; les quatre écorégions y sont attribuées au R-PP et regroupent les domaines phytogéographiques de l'IEFN (1996).
// TODO : BNC-REDD+ à ajouter à la liste des abréviations (REDD+ et BNCCREDD+ y figurent, vérifié le 03/11/2026). Socle précambrien : mention sans source (COR). Nishigaki et al. (2020) : entrée provisoire dans hayagriva.yml, à compléter.
// REP :  socle précambrien : carte géologique du BRGM

=== Un fragment forestier

Le massif forestier couvre environ 640~ha (VOI Maharitra, 2025). Les fragments de forêt naturelle les plus proches sont ceux de Lakia, de Vorovoka et de Vatovavy, situés respectivement à environ 5, 10 et 15~km. Le massif formait déjà un fragment isolé en 1973 (@fig-carte-couvert). Romiguière (2025) a retracé son évolution à partir des cartes de couvert forestier de Vieilledent et al. (2018) et des images Google Earth de 1985, 2010 et 2024. Le cœur du massif est resté relativement stable, tandis que la plupart des lambeaux forestiers qui l'entouraient ont disparu entre 1973 et 1990, remplacés par des zones ouvertes, dégradées ou agricoles. Les pertes ultérieures sont faibles : quelques lambeaux au nord du massif, près du village de Tsiazombazaha, entre 1990 et 2000, puis des surfaces ponctuelles en lisière entre 2000 et 2017.
// Surface : 639,76 ha (zone protégée 583,88 ha + droits d'usage 55,88 ha), contrat du 19/06/2025, p. 3, art. 1 ; arrondie à 640 ha (auteur, 03/11/2026). La NEP (p. 16) donnait « environ 500 ha ».
// TODO : valeur à valider — distances estimées à la main sous QGIS ; attribution 5 / 10 / 15 km à Lakia / Vorovoka / Vatovavy non confirmée (auteur : « normalement »). Préciser la mesure (de lisière à lisière ?).
// ATTENTION : le projet de stage situe la zone d'étude de Fabiani (2025), autour de Vorovoka, « à quelques dizaines de kilomètres au nord de Tsiazombazaha », ce qui s'accorde mal avec 10 km.
// Carte 3 : carte de Romiguière (2025, figure 7 ; fichier transmis par l'auteur, images/tsiazombazaha90_Evo_Couv_Arbo.pdf), insérée le 02/11/2026. Commentaire fondé sur Romiguière (2025, § 2.2.1 et 3.1, lus le 02/11/2026) et sur la lecture de la carte.
// ATTENTION : carte en couleur (les figures du mémoire sont en niveaux de gris) ; reproduction d'une figure d'un autre auteur : vérifier l'accord de Romiguière ou la mention « reproduit de ».
// Ancien bloc conservé : figure prévue images/carte_couvert_1973_2017.svg (<fig-carte-couvert>), en niveaux de gris, couvert en 1973, 1990, 2000, 2010 et 2017.
#figure(
  image("images/tsiazombazaha90_Evo_Couv_Arbo.pdf", width: 100%,
    alt: "Carte de la forêt de Tsiazombazaha : un massif central de forêt en 2017, entouré de nombreux lambeaux déboisés entre 1973 et 1990 ; quelques lambeaux déboisés entre 1990 et 2000 au nord, près du village de Tsiazombazaha, et quelques pixels en lisière après 2000."),
  caption: [Évolution de la couverture arborée de la forêt de Tsiazombazaha entre 1973 et 2017 : surfaces déboisées par période (1973-1990, 1990-2000, 2000-2010, 2010-2017) et forêt en 2017, avec les terres agricoles, les chemins et les cours d'eau. Carte de Romiguière (2025), d'après les cartes de couvert forestier de Vieilledent et al. (2018).],
) <fig-carte-couvert>
#titre-court(<fig-carte-couvert>)[Évolution du couvert forestier de Tsiazombazaha]

Cette évolution, qui contribue à SQ1, n'a pas fait l'objet d'une analyse propre : elle repose sur l'analyse de Romiguière (2025) et sur l'observation des données de perte de couvert de Global Forest Watch, consultées en avril 2026 (Hansen et al., 2013). La littérature ne fournit ni estimation ni carte à une échelle suffisamment fine pour la forêt. Aucune image satellite antérieure à 1984 n'a été trouvée : les plus anciennes images gratuites, celles de Landsat 5 (USGS/NASA), datent de cette année. Ces images n'ont pas été traitées ; une classification supervisée ou non supervisée aurait permis de suivre l'évolution du couvert, mais n'a pu être réalisée faute de temps.
// Paragraphe déplacé depuis l'ancienne sous-section « Évolution du couvert forestier » de l'acquisition des données (auteur, 03/11/2026).
// Global Forest Watch : https://www.globalforestwatch.org, consulté en avril 2026 (auteur, 03/11/2026) ; séries de perte à partir de 2001 (projet de stage, p. 15).
// Date de la littérature retirée de la phrase (auteur, 03/11/2026 : article de 1968 fondé sur des cartes des années 1950, non cité ici). Auteur (03/11/2026) : aucune image de 1968 ; 1968 est une date traitée par la littérature (« cf. Introduction ») ; images les plus anciennes trouvées : 1984, non traitées. ATTENTION : l'Introduction ne cite pas 1968 (photographies aériennes des années 1950, cartes de 1973 de Vieilledent et al., 2018) : vérifier la date visée. Ancienne note : « 1968 » (donné de mémoire) remplacé par 1984 d'après le projet de stage (p. 14-15, tableau des images : Landsat 5/7/8/9 de 1984 à 2026, Sentinel-2 de 2017 à 2026, WorldView-2/3 de 2017 à 2024), auquel l'auteur renvoie (03/11/2026). Si une image de 1968 existe bien (autre programme), rétablir avec sa source.

Le fragment est entouré d'une matrice agricole. Autour de Vorovoka, Fabiani (2025) distingue dans cette matrice des collines non aménagées, des fourrés monospécifiques, des _tanimboly_ (« terres de culture »), des cultures de manioc, des rizières, des reboisements, des formations à _ravenala_, des forêts, des cours d'eau et des villages. Les mêmes unités ont été observées sur le terrain autour de Tsiazombazaha.

// TODO : le reste du contexte socio-économique et l'historique vont en annexe ou dans l'Introduction (guide, critères 30 et 31).
// Gouvernance (VOI Maharitra, transfert de gestion) en quelques lignes. Le reste va en annexe, ce n’est pas une monographie.
// Mentionné mais pas à garder :? //   - Contexte/aspects (géo)socioéconomiques : histoire de la zone ; fig. frise//     chronologique (?) TFG ; contexte pauvreté (Madagascar, Sud-Est de Madagascar) ;//     divisions administratives ; modes de gouvernance locale ; proximité à la RN,//     autres villages, accessibilité.

=== Gestion de la forêt

La forêt s'étend aujourd'hui sur les communes rurales d'Ambahatrazo et de Mizilo Gara ; une petite partie se trouve dans le _fokontany_ de Tsararano (commune de Vohimasina Sud). Le VOI Maharitra, qui la gère, réunit sept _fokontany_ : Ambalavolo, Amborodra et Manakana dans la commune d'Ambahatrazo ; Ampasipotsy, Mizilo Gara et Tsiazombazaha dans celle de Mizilo Gara ; Andriana dans celle d'Ambila. Le _fokontany_ d'Ambahatrazo, chef-lieu de sa commune, et celui de Tsararano n'en font pas partie. La gestion de la forêt lui a été transférée le 1#super[er] juillet 2004, dans le cadre de la GCF (voir Introduction), pour une durée de trois ans et sur 439~ha (VOI Maharitra, 2004). Ce contrat n'a pas été renouvelé à son terme (Romiguière, 2025)~: la gestion communautaire a officiellement cessé, mais elle s'est poursuivie de manière informelle d'après les entretiens (voir Résultats du volet social).

Le contrat signé le 19 juin 2025 avec la Direction régionale de l'environnement et du développement durable (DREDD) et les communes d'Ambahatrazo, de Mizilo Gara et d'Ambila se présente pourtant comme un renouvellement de celui de 2004, pour cinq ans. Il porte sur un périmètre de 1~068~ha, plus de deux fois plus étendu qu'en 2004, divisé en quatre zones (@tab-zonage-tdg). La zone protégée et la zone de droits d'usage, soit environ 640~ha, correspondent à la forêt (VOI Maharitra, 2025). Entre les deux contrats, la zone protégée s'est étendue et la zone de droits d'usage s'est réduite ; une large zone de cultures et de reboisement a été intégrée au périmètre.
// Relecture 03/11/2026 : « au détriment de » remplacé par une formulation descriptive (la forêt contractualisée passe aussi de 439 à environ 640 ha).

#figure(
  table(
    columns: (2fr, 1fr, 1fr),
    align: (left, right, right),
    inset: 8pt,
    table.header([*Zone*], [*2004 (ha)*], [*2025 (ha)*]),
    [Zone protégée], [275,684], [583,88],
    [Zone de droits d'usage traditionnels], [163,409], [55,88],
    [Zone de reboisement (2004), de cultures et de reboisement (2025)], [17,946], [356,9],
    [Zone à aménager en rizières (2004)], [50,499], [--],
    [Zone à améliorer et à mettre en valeur (2025)], [--], [71,46],
    [Surface transférée indiquée], [439], [1 068,12],
  ),
  caption: [Zonage de la forêt de Tsiazombazaha dans les contrats de transfert de gestion de 2004 et de 2025. Sources~: VOI Maharitra (2004~; 2025).],
) <tab-zonage-tdg>
#titre-court(<tab-zonage-tdg>)[Zonage des contrats de 2004 et 2025]
// Valeurs 2004 : rapport d'évaluation du TdG, p. 1, relues par l'auteur (03/11/2026) ; traduction des intitulés : faritra arovana, faritra hakana ny zo nentim-paharazana, faritra fambolen-kazo, faritra hajariana atao tanimbary. Valeurs 2025 : contrat du 19/06/2025, p. 3, art. 1 (« faritra fambolena sy fambolen-kazo » : cultures et reboisement).
// ATTENTION : en 2004, les quatre zones totalisent 507,538 ha, alors que la surface transférée indiquée est de 439 ha (438,793 ha dans le document de transfert, p. 43) ; zone protégée + droits d'usage = 439,093 ha. Non tranché.
// Phrase reprise dans le texte le 03/11/2026 (auteur) : Le VOI réunit sept fokontany : Ambalavolo, Amborodra et Manakana dans la commune d'Ambahatrazo ; Ampasipotsy, Mizilo Gara et Tsiazombazaha dans celle de Mizilo Gara, issus de la division de l'ancien fokontany de Mizilo Gara ; Andriana dans celle d'Ambila. Le fokontany d'Ambahatrazo, chef-lieu de sa commune, et celui de Tsararano n'en font pas partie.
// Fokontany et communes : auteur, 31/10/2026. « Mahatsara » (projet de stage) désigne le fokontany de Manakana : retenir « Manakana » dans tout le mémoire.
// TODO : source de la division du fokontany de Mizilo Gara (date, acte).
// Homonymie forêt / fokontany / village signalée dans le texte (Localisation, 03/11/2026) ; à appliquer aussi dans les autres chapitres (« fokontany de » ou « village de » à chaque occurrence).
// DREDD et GCF figurent dans la liste des abréviations (vérifié le 03/11/2026).
// TODO : « la forêt ne couvre plus Ambila » d'après l'auteur ; les cartes disponibles sont peu fiables. Préciser la source (terrain, entretiens).
// check la superficie calculée selon limites données VS cité dans le document 2025 VS citée dans le doc de 2004
// ATTENTION : « Tsararano » retenu (auteur, Discussion.typ) contre « Tsarano » (projet de stage) ; « Fitovinany » contre « Fitonivavy » (Resume.typ).
// ATTENTION : Cooke (2007), anciennement cité ici pour le transfert de gestion, est cité par l'Introduction (l. 100) pour le rôle du bureau du VOI : usage à vérifier.
// Sources du paragraphe (03/11/2026) : contrat de 2004, 438,793 ha (document de transfert, p. 43 du PDF) et 439 ha (rapport d'évaluation du TdG, p. 1) ; contrat du 19/06/2025, p. 2 (arrêté du 02/05/2025 : renouvellement pour cinq ans, rappel du contrat du 01/07/2004) et p. 3 (art. 1, zonage). Non-renouvellement : Romiguière (2025) ; gestion informelle : entretiens (E7, E18, Résultats sociaux).
// TODO : 439 ha (2004) à vérifier par l'auteur.
// TODO : carte 2 (territoire) — ajouter un renvoi « (@fig-carte-territoire) » dans le paragraphe ci-dessus une fois réalisée.
// #figure(
//   image("images/carte_territoire.svg", width: 100%),
//   caption: [Territoire de la forêt de Tsiazombazaha : massif forestier, périmètre transféré au VOI Maharitra en 2025 (1~068~ha), communes et fokontany membres du VOI, villages. Sources : VOI Maharitra (2025) ; // TODO (limites administratives, couvert forestier).],
// ) <fig-carte-territoire>
// Contenu attendu : distinguer clairement le massif (~640 ha) et le périmètre transféré (1 068 ha) ; communes d'Ambahatrazo, Mizilo Gara et Ambila ; sept fokontany du VOI ; Tsararano (hors transfert) ; villages riverains. Échelle, nord, sources.

== Revue de la littérature

Une recherche bibliographique visant l'exhaustivité a été menée sur la forêt de Tsiazombazaha. Elle s'inspire de la démarche de revue systématique de Pullin et Stewart (2006) et est présentée selon la déclaration PRISMA 2020 (Page et al., 2021). Le toponyme étant précis et peu de documents étant attendus sur cette forêt, la requête porte sur le seul mot-clé « Tsiazombazaha », sans opérateur ni synonyme.

La requête a été lancée en avril 2026 dans trois bases bibliographiques, Google Scholar, Web of Science et Internet Archive Scholar, et dans le moteur de recherche académique RefSeek. Elle a été complétée par le moteur de recherche Google et par les documents internes transmis par Inter Aide (équipe locale, siège, espace de stockage partagé et anciens stagiaires). D'autres moteurs de recherche, académiques (Semantic Scholar, CORE, ResearchGate) et généralistes (Brave, Qwant, DuckDuckGo), ainsi que deux assistants conversationnels fondés sur l'intelligence artificielle, Le Chat (Mistral AI) et Gemini (Google), ont été interrogés sans apporter de document nouveau.
// Moteurs académiques et résultats de RefSeek : auteur, 03/11/2026. RefSeek : 8 résultats, 6 doublons, 1 autre forêt, 1 document pertinent (Banque mondiale, 2021), d'où son traitement à part des autres moteurs. Requête RefSeek d'avril 2026 (confirmé par l'auteur, 03/11/2026).
// Relecture 03/11/2026 : ancienne formulation « Le toponyme étant rare et la littérature sur la forêt malgache réduite » ; « rare » s'accordait mal avec les quatre forêts homonymes citées au site d'étude.

Les doublons ont été retirés au sein de chaque base et entre bases, Google Scholar servant de base de référence. Les documents restants ont été triés sur leur titre et leur résumé, puis sur leur texte intégral lorsqu'il était disponible. Un mémoire introuvable a été retenu sur son titre, consacré au développement du tourisme à Tsiazombazaha ; le mémoire sur le foncier des communes riveraines (Müller et Evers, s. d.), qui le cite, confirme qu'il porte sur cette forêt. Est retenu tout document qui mentionne la forêt d'étude, quelle que soit la place qu'il lui consacre. Sont exclus les documents portant sur une forêt homonyme et ceux dont la forêt n'est pas localisable.
// Critère « communes riveraines sans mention de la forêt » retiré (auteur, 03/11/2026) : aucun document écarté à ce titre. Le parcours des documents est présenté en Résultats sous la forme d'un diagramme PRISMA, avec la liste des documents retenus (@res-revue). Les occurrences du Global Biodiversity Information Facility (GBIF) ont fait l'objet d'une recherche distincte, directement sur son site (voir Données complémentaires).
// Tri et document introuvable : auteur, 03/11/2026.

// ---- Pour la section Résultats (effectifs et diagramme, arbitrage auteur du 31/10/2026) ----
// Diagramme PRISMA 2020 et tableau des documents retenus : placés en Résultats (« Revue de la littérature »), comme le prévoit PRISMA 2020 (résultats de la sélection).
// Données du tableur (documents-brouillons/PRISMA_resultats.ods ; // TODO : valeurs à valider) :
//   Google Scholar : 18 résultats, 4 doublons, 14 uniques, 11 autre forêt, 1 non localisée, 2 forêt d'étude ;
// WoS : 0 résultats
//   RefSeek : 8 résultats, 6 doublons, 2 uniques, 1 autre forêt, 1 forêt d'étude (Banque mondiale, 2021 ; auteur, 03/11/2026) ;
//   Internet Archive Scholar : 15 résultats, 6 doublons, 9 uniques, 5 autre forêt, 3 non localisées, 1 forêt d'étude (introuvable) ;
//   Google : 1 forêt d'étude ; documents internes : 3 (Romiguière 2025, transferts de gestion 2004 et 2025) ;
//   total : 8 retenus, dont 7 récupérés (7 et 6 avant l'ajout de RefSeek).
// ATTENTION : le document Internet Archive Scholar retenu est « introuvable » → case « documents non récupérés » du diagramme.
// Revue de la législation (FAOLEX) abandonnée (auteur, 31/10/2026) ; mention retirée de l'Introduction le 02/11/2026.

== Acquisition des données écologiques

=== Dispositif d'échantillonnage

L'inventaire floristique répond à la première sous-question, relative à l'état écologique de la forêt (SQ1). L'échantillonnage systématique prévu au projet de stage a été écarté en raison de la faible accessibilité de la forêt. Les placettes ont été implantées le long de neuf itinéraires (@fig-plan-echantillonnage), parcourus avec des guides locaux, _polisinala_ (patrouilleurs communautaires du VOI) ou responsables du VOI, qui ont suivi les chemins de ronde ou les deux grands itinéraires de la forêt. Le centre de chaque placette était choisi sur place, de façon à couvrir la diversité des milieux rencontrés, à plus de 10~m du chemin et sans distance minimale entre placettes. Cette implantation est proche de celle d'Armstrong et al. (2011), qui placent leurs placettes à intervalles aléatoires le long de l'itinéraire du jour en forêt dense humide de basse altitude, et de celle de Hending et al. (2023), qui les installent à au moins 10~m de transects établis. Elle s'en distingue par le choix des points sur place, et non à intervalles aléatoires ou réguliers.
// TODO : remplacer « SQ1 » par une référence Typst vers la Problématique une fois l'étiquette posée.
// « polisinala » (graphie de l'auteur, glossaire : « gardien de la forêt ») : défini ici comme patrouilleur communautaire du VOI et, dans « Identification des espèces », comme patrouilleur reconnu pour sa connaissance de la forêt (définitions réunies le 03/11/2026).
// Note (Armstrong et al., 2011) : méthodes lues (p. 430) : 100 placettes circulaires de 10 m de diamètre, « chosen at random intervals along the trail route followed on a given day ».
// Note (Hending et al., 2023) : méthodes lues (p. 3333) : 200 placettes de 20 × 20 m, à ~50 m d'intervalle le long de transects, « a minimum of 10 m from the transect line ».
// Conséquences de ce choix (sélection orientée, autocorrélation entre placettes voisines) : à traiter dans la Discussion (« Limites méthodologiques »).

// TODO : figure — carte des placettes sur la forêt (coordonnées GPS issues du nettoyage des données géographiques, encore à réaliser).
// ATTENTION : carte TEMPORAIRE (auteur, 02/11/2026) — placettes de Romiguière (2025), et non les placettes de l'étude ; à remplacer par la carte des 28 placettes et des itinéraires, en conservant l'étiquette <fig-plan-echantillonnage>. Carte en couleur.
#figure(
  image("images/plan-echantillon-Tziazombazaha-romiguire-temp.png", width: 100%,
    alt: "Image satellite de la forêt de Tsiazombazaha avec huit points colorés figurant les placettes de Romiguière, groupées par deux dans quatre zones."),
  caption: [Carte provisoire du dispositif d'échantillonnage : emplacement des huit placettes de Romiguière (2025) à Tsiazombazaha, par zone (Ambalavolo, Andasy Vazaha, Bevoatavy et forêt protégée), sur fond d'image Google Satellite. Carte de Romiguière (2025).],
) <fig-plan-echantillonnage>
#titre-court(<fig-plan-echantillonnage>)[Carte provisoire du dispositif d'échantillonnage]

Les placettes ont été relevées en neuf journées, du 18 août au 16 septembre 2026 (18, 20, 25 et 26 août ; 2, 4, 11, 15 et 16 septembre). Deux journées supplémentaires (19 et 27 août) ont été consacrées à des itinéraires sans placette, pour les seuls relevés le long des chemins. Le protocole initial visait six placettes par jour sur une vingtaine de journées, soit plus de 100 placettes, avec un minimum acceptable de 60 placettes. Le temps d'accès à la forêt, les conditions de logement et la disponibilité des guides ont considérablement réduit cet effort d'échantillonnage.
// Dates d'après transects.csv (11 itinéraires, T01 à T21) et metadonnees_enquete-de-terrain_2_sorties.csv (sorties S8 à S21), lus le 01/11/2026.
// ATTENTION : les deux fichiers inversent les 26 et 27 août — transects.csv : placettes P8 à P11 le 26/08 (T05), chemin seul le 27/08 (T06) ; métadonnées des sorties : chemin Manakana-Ambila le 26/08 (S12), quatre placettes le 27/08 (S13). Le texte suit transects.csv.
// 11 itinéraires dans transects.csv : 9 avec placettes, 2 sans (auteur, 01/11/2026).
// Projet de stage (p. 22) : au moins six placettes par jour, environ 100 placettes, trente journées au plus ; précisions de l'auteur (31/10/2026) : une vingtaine de journées prévues, au moins 64 placettes ; formulation retenue (auteur, 03/11/2026) : six par jour, une vingtaine de journées, plus de 100 visées, minimum acceptable de 60.

Le dispositif comprend 28 placettes circulaires de 2,5~m de rayon, soit environ 20~m² chacune. Cette petite surface répond au temps disponible et à la charge de travail acceptable pour l'équipe de terrain, après l'essai d'une placette de 10~m de diamètre (voir P2 ci-dessous). Elle reste compatible avec les recommandations du _Mémento du forestier tropical_ : en forêt naturelle, où la répartition spatiale des arbres est le plus souvent agrégée, des placettes petites et nombreuses réduisent le coût de l'inventaire pour une précision donnée, et la forme de la placette n'influe que peu sur cette précision (Mille et Louppe, 2015).
// Note (Mille et Louppe, 2015) : §6.2 « Inventaires forestiers », p. 483 (lu). ATTENTION : le raisonnement y est établi pour l'estimation du volume ou de la biomasse ; sa transposition à la richesse spécifique est à assumer (ou à nuancer) en Discussion.

La première placette complète, P2, a été inventoriée sur 10~m de diamètre, comme chez Armstrong et al. (2011). Cette surface s'étant révélée incompatible avec les contraintes du terrain, le diamètre a été ramené à 5~m pour les placettes suivantes. Pour homogénéiser le dispositif, les tiges de P2 ont été réparties par tirage aléatoire entre quatre placettes de surface standard, P02 à P05.
// Tirage reproductible (graine 20261009, note P2 du 09/10/2026) ; contrôle par Monte-Carlo sur 10 000 tirages : p = 0,114 (// TODO : valeur à valider, non vérifiée dans P2_decoupage_4_placettes.csv, hors 08_rapport). Correspondance des anciens et nouveaux codes en annexe.

Le diamètre de 5~m a été tendu au ruban le long du sol, sans correction de pente. Chaque placette couvre donc 19,63~m² sur la pente, et sa surface horizontale vaut :

$ s_j = pi r^2 cos alpha_j $

où $r = 2,5$~m et $alpha_j = arctan(p_j / 100)$, $p_j$ étant la plus grande pente de la placette $j$, mesurée en pourcentage au clisimètre. Les indices sont rapportés à cette surface horizontale (voir Conventions).
La surface horizontale cumulée des 28 placettes est de 531,1~m², pour 549,4~m² mesurés sur la pente.
// Correction appliquée le 31/10/2026 (accord de l'auteur) : placettes.csv, colonne « surface-horizontale » = surface sur la pente × cos(arctan(p/100)) ; colonne « surface-corrigee » = surface sur la pente (π r², 19,24 m² pour P27). Ancienne convention inversée (surface horizontale divisée par cos α). Sauvegarde de l'ancien fichier conservée hors dépôt. ATTENTION : si placettes.csv est régénéré depuis le fichier de saisie ODS, y reporter la même formule.
// P01 : comptage en plein sur un quart d'une placette de 10 m de diamètre (même surface, 19,63 m²) ; traité comme équivalent sans mention dans le texte (auteur, 31/10/2026).
// TODO : une décimale pour les surfaces (au lieu de deux par défaut) ; à valider.
// Anciennes valeurs retirées : 569 m² (document d'étape §2.1), 29 placettes (document d'étape §2.1).

=== Relevés par placette

Le protocole de relevé, la liste du matériel et la fiche de relevé figurent en @annexe-protocole. Le centre de chaque placette a été géolocalisé au GPS (Garmin eTrex SE) et photographié. La placette a été matérialisée à l'aide de deux rubans métriques de 15~m. Le clisimètre (Suunto) a servi à mesurer la pente, le ruban métrique les circonférences et une paire de jumelles à observer le feuillage en hauteur pour l'identification.
// Source : protocole_inventaire_forestier.odt (06_ecologie/methodologie, lu avec l'accord de l'auteur le 31/10/2026), annexe « Liste du matériel » et § « Mesures de placette ». Liste complète du matériel et fiches de relevés à placer en annexe.
// Le protocole fixe encore le seuil à une CBH de 15,5 cm (DBH de 5 cm, Armstrong et al., 2011) ; le texte retient 8 cm (auteur, 31/10/2026). Vérifié dans flore.csv le 31/10/2026 : seuil de 8 cm appliqué sur les 28 placettes.
// Paragraphe du matériel déplacé ici depuis « Dispositif d'échantillonnage » (03/11/2026) ; « arrondies au centimètre le plus proche » retiré (doublon du paragraphe des tiges).

Sur chaque placette ont été relevés : la pente, le recouvrement de la canopée, les strates de végétation présentes, le type d'humus, l'humidité du sol, l'abondance des épiphytes, des mousses, des lichens, des lianes et des champignons, et la présence de fleurs ou de fruits. Le recouvrement de la canopée est estimé visuellement depuis le centre de la placette, pour chacun des quatre quadrants (nord, est, sud, ouest), en classes de 25~%. Les strates présentes sont notées sans mesure de hauteur parmi quatre : herbacée (0 à 2~m), sous-bois ou arbustive (2 à 10~m), canopée inférieure (10 à 20~m) et canopée supérieure (plus de 20~m). L'humus est identifié selon la clé de Jabiol et al. (2016). L'humidité du sol est appréciée au toucher sur une poignée de terre prélevée en surface au centre de la placette, en trois classes : sèche (la terre s'effrite), humide (elle colle légèrement) ou saturée (elle est boueuse). L'abondance des épiphytes, mousses, lichens, lianes et champignons est notée par le nombre d'arbres porteurs, en trois classes (0 à 2, 3 à 10, plus de 10).
// Bornes des classes confirmées par l'auteur (03/11/2026) et conformes à placettes.csv (0-2, 3-10, >10).

Les fleurs et les fruits observés dans la placette, au sol ou encore sur la plante, sont notés avec le nom vernaculaire de l'espèce, le type d'organe et une abondance en trois classes. Trop peu nombreuses, ces observations ne sont pas analysées ; les espèces notées complètent seulement la liste de la flore.
// Source : protocole_inventaire_forestier.odt (§ « Mesures de placette ») et en-têtes de placettes.csv et phenologie.csv (06_ecologie/analyse/donnees, vérifiés le 31/10/2026).
// TODO (Jabiol et al., 2016) : le protocole cite « Jabiol et al. (2016) » : identifier l'ouvrage réellement utilisé (clé de terrain ?) avant de figer l'année. Piste : Jabiol et al. (2013), Geoderma, 192, 286-294, https://doi.org/10.1016/j.geoderma.2012.08.002.

Toutes les tiges ligneuses de la placette ont été relevées et, lorsque c'était possible, nommées par leur nom vernaculaire. La circonférence à hauteur de poitrine (CBH, à 1,30~m) a été mesurée au ruban métrique, au centimètre près, pour toute tige de CBH $>=$ 8~cm, soit un diamètre d'environ 2,5~cm ; le diamètre à hauteur de poitrine (DBH) en est déduit (DBH = CBH / π). Ce seuil reprend celui de Romiguière (2025), afin de faciliter la comparaison avec ses relevés ; il est inférieur à celui d'Armstrong et al. (2011), qui mesurent les tiges de diamètre $>=$ 5~cm, soit une CBH d'environ 16~cm, seuil repris par Hending et al. (2023). Il correspond au seuil des jeunes arbres (DBH $>=$ 2,5~cm) de l'inventaire national des forêts humides de l'Est (BNCCREDD+ et al., 2020). L'abaissement du seuil de CBH de 16 à 8~cm n'a ajouté qu'environ deux minutes au relevé d'une placette, qui durait plus d'une heure.

Les tiges de plus de 1,30~m de haut et de CBH inférieure à 8~cm (gaulis) ont été dénombrées en plein par espèce, sans être mesurées, comme les petites tiges de l'Inventaire écologique forestier national, relevées par nom vernaculaire de part et d'autre d'une hauteur de 1,30~m (DEF et al., 1996). Les tiges de moins de 1,30~m de haut n'ont pas été relevées, sauf sur sept placettes (P21 à P28, hors P27), où elles ont été dénombrées en plein, toutes espèces confondues, en deux classes de hauteur (moins de 30~cm ; de 30 à 130~cm), afin d'estimer une densité de régénération.
// ATTENTION : « > 8 cm » (document d'étape, M&M antérieur) vs « ≥ 8 cm » (arbitrage auteur) ; ici ≥ 8 cm. Données vérifiées le 31/10/2026 : CBH minimale de 8 cm sur les 28 placettes ; les deux tiges de 7 cm de P06 (codes 0604 et 0613) sont passées en gaulis (flore.csv et ODS, décision de l'auteur).
// Durée par placette : estimation de l'auteur. « Autres études » à 8 cm de CBH : inventaire national 2020 (seuil de 2,5 cm de DHP), ajouté le 01/11/2026.
// Note (BNCCREDD+ et al., 2020) : lu le 01/11/2026 dans 02_Bibliographie/articles/ : tableau 1 p. 3 (forêts humides : jeunes arbres 2,5 cm ≤ DHP < 15 cm sur 10 × 10 m, régénération DHP < 2,5 cm dénombrée) ; tableaux 10 à 12 p. 19-21 (méthode de la lame au couteau, trois classes sain / intermédiaire / pourri, facteurs 1 / 0,8 / 0,45 ; bois mort gisant > 2,5 cm de diamètre mesuré au point d'intersection ; arbres morts sur pied : facteur de réduction de biomasse 0,975 ou 0,8) ; § 3.7 p. 22-23 (faune : nom local, spécimen observé, nombre).
// Note (DEF et al., 1996) : lu le 01/11/2026 (p. 8) : placettes circulaires de 3,75 m de rayon (D 3,0 à 14,9 cm) et de 1,25 m de rayon (D < 3 cm, hauteur ≥ 20 cm) ; petites tiges relevées par nom vernaculaire et dénombrées, en distinguant les hauteurs inférieures et supérieures à 130 cm. année et lieu d'édition à vérifier.
// Source régénération : colonnes regeneration-inf-30 et regeneration-30-a-130 de placettes.csv ; comptage en plein (auteur, 31/10/2026). Le quadrat de 1 × 1 m prévu au protocole n'a pas été appliqué.
// Densité de régénération < 1,30 m : analyse_regeneration.R (01/11/2026), tiges/m² ± erreur-type par classe de hauteur (arbitrage auteur) ; méthode en « Structure forestière ».

Les bois morts debout (chandelles) et au sol de CBH $>=$ 8~cm ont été mesurés. Le bois mort au sol est relevé par la méthode des transects linéaires (Van Wagner, 1968) le long des deux rubans qui matérialisent la placette : chaque pièce qui croise la ligne est mesurée en circonférence au point d'intersection. La longueur de ligne varie selon les placettes (5 à 30~m), pour une longueur cumulée de 290~m. Le degré de décomposition des pièces au sol est apprécié en trois classes, selon la pénétration d'une lame de couteau : sain (la lame ne pénètre pas), intermédiaire (elle pénètre en partie, avec une perte de bois) et pourri (elle reste plantée dans un bois friable). Ces classes regroupent les cinq classes de décomposition de Harmon et Sexton (1996) (1-2, 3-4, 5) et reprennent les trois classes de densité du protocole de mesure du carbone de Walker et al. (2018), où le test est fait à la machette. Le protocole de l'inventaire national les note, comme ici, au couteau, et relève le bois mort gisant à partir de 2,5~cm de diamètre, au point d'intersection (BNCCREDD+ et al., 2020). Trois classes ont été retenues parce que ce protocole fournit un facteur de réduction de densité pour chacune d'elles, sain, intermédiaire et pourri (voir Stock de carbone).
// Justification remplacée le 03/11/2026 (auteur) : l'ancien argument non sourcé (« Trois classes bien distinctes se notent plus vite et se reproduisent mieux d'un observateur à l'autre que cinq classes fines ») est retiré. Facteurs 1 / 0,8 / 0,45 : BNCCREDD+ et al. (2020), tableaux 10 à 12, p. 19-21 (lu le 01/11/2026) ; mêmes valeurs dans CCNUCC (2010).
// Source : bois-mort.csv (110 pièces : 75 au sol, 35 chandelles) et longueur-transect-bois-mort de placettes.csv (P01 : 20 m ; P02 à P05 : 5 m ; P06 : 30 m ; P07 à P28 : 10 m ; somme 290 m, valeurs réelles selon l'auteur). L = 290 m du document d'étape confirmé (recompté le 01/11/2026).
// « Mesurée au point d'intersection » : confirmé par l'auteur (01/11/2026), comme dans le protocole national (BNCCREDD+ et al., 2020, p. 20).
// Note (Walker et al., 2018) : vérifié le 01/11/2026 : SOP « Measurement of lying dead wood » (p. 54-56 : transects linéaires selon Harmon et Sexton, 1996 ; trois classes sound / intermediate / rotten) et « Dead wood density classes » (p. 57 : test de la machette). Seuil de ce protocole : diamètre > 10 cm (ici CBH ≥ 8 cm).
// ATTENTION : définitions des classes reprises de Walker et al. (2018), adaptées au couteau — vérifier qu'elles correspondent aux critères réellement appliqués sur le terrain.
// Argument non repris dans le texte, à placer en Discussion si sourcé : pour un stock de carbone, l'incertitude dominante viendrait de la densité du bois et de la longueur de ligne plutôt que de la finesse de l'échelle.

=== Transects

Les itinéraires parcourus entre les placettes servent de transects. Les grands arbres (CBH $>=$ 126~cm, soit un DBH d'environ 40~cm) ont été relevés dans une bande de 5~m de part et d'autre du chemin, avec leur nom vernaculaire et leur circonférence. Les chablis ont été dénombrés le long des chemins. Ce sont des tiges renversées, vivantes ou mortes, dont le houppier au sol reste relié à la souche et dont la chute ouvre la forêt dans tous ses étages, jusqu'à environ 2~m du sol, selon la définition de la trouée de chablis de Brokaw (1982). Ils sont répartis en trois classes de circonférence : petits bois (moins de 30~cm), bois moyens (30 à 60~cm) et gros bois (plus de 60~cm). Les espèces végétales remarquées hors des placettes au cours des cheminements ont été notées, à titre indicatif, pour compléter la liste des espèces.
// Source : grands-arbres.csv, chablis.csv, autres-observations-flore.csv, transects.csv (vérifiés le 31/10/2026) ; seuil et largeur de bande des grands arbres, classes de chablis : auteur, 31/10/2026.
// grands-arbres.csv contient aussi des arbres de CBH 92 à 126 cm (reliquats d'un seuil antérieur, ignorés selon l'auteur) : filtre CBH ≥ 126 cm ajouté dans 08_analyse_carbone.R le 01/11/2026 (78 grands arbres retenus, dont 77 sur les cinq transects de longueur connue, seuls utilisés par les scripts carbone et transects ; l'arbre restant est sur T21, hors transect).
// Classes de chablis en circonférence (auteur, 03/11/2026).
// Brokaw (1982), Biotropica 14, 158-160, doi 10.2307/2387750 : référence confirmée par l'auteur (03/11/2026). Ouverture systématique selon l'auteur, d'où l'absence de mention de limite ; chablis.csv porte encore « pas de vérification si le bois a ouvert la canopée ».
// TODO (auteur) : chablis — transects prospectés (T01 et T02 saisis ; T19 et T20 prévus selon transects.csv), longueurs.
// Longueurs prospectées pour les grands arbres reportées dans transects.csv le 01/11/2026 (tableau de l'onglet grands-arbres de l'ODS) : T05 1 940 m ; T06 1 800 m ; T16 205 m (190 m auparavant) ; T19 300 m (« 300 ? », incertain) ; T20 1 060 m ; total 5 305 m. Arbres de T21 : hors transect, à titre indicatif.
// TODO : statut final des indicateurs chablis/ha et grands arbres/ha.

=== Observations de la faune et des activités humaines

Le _polisinala_ devait noter, au cours des cheminements, les animaux observés et les indices de leur présence (fèces, empreintes, nids, terriers, cris, etc.), selon White et Edwards (2000) ; les trois paramètres notés (nom local, type d'observation, nombre) sont ceux du protocole faune de l'inventaire national (BNCCREDD+ et al., 2020). Ce relevé n'a pas été tenu de façon systématique. Il ne vise qu'à lister les espèces réellement observées et les indices rencontrés : aucun indice d'abondance n'est calculé. Les traces d'activités humaines (souches coupées, pièges, etc.) ont été relevées de la même façon, à titre indicatif, pour décrire les types de pressions rencontrés.
// Source : protocole (§ « Mesures de parcours ») ; auteur, 31/10/2026. Données : fichier « T1-T2-faune » et notes de sortie (non lus).

=== Identification des espèces et des usages

L'équipe de terrain comprenait un forestier, un _polisinala_ (patrouilleur communautaire du VOI, reconnu par la communauté pour sa connaissance de la forêt) et un traducteur-interprète. Les tiges étaient désignées une à une : le _polisinala_ donnait le nom vernaculaire, le forestier mesurait la circonférence et le traducteur notait les noms malgaches. Les relevés ont été réalisés sans contrôle indépendant de l'identification. Lorsqu'un nom recouvrait plusieurs formes, le _polisinala_ devait préciser le « type » de la tige et le décrire ; cette description n'a pas été recueillie de façon systématique.

Les noms vernaculaires ont ensuite été réconciliés à la main en « identités », dans une table de référence qui associe à chaque nom brut un nom normalisé, une identité et, le cas échéant, un type et un nom scientifique. Les variantes orthographiques d'un même nom sont d'abord unifiées (_Alompogna_ et _Alampogna_). Les types d'une même espèce sont ensuite regroupés sous une identité lorsque leur parenté est évidente, le type restant noté : formes « mâle » (_lahy_) et « femelle » (_vavy_) d'_Ambora_, à petites ou à grandes feuilles de _Hasina_. Aucun autre regroupement n'a été fait. Les tiges sans nom et les noms ambigus sont classés comme espèce indéterminée. Le nom scientifique est tiré de Schatz (2001), de Romiguière (2025) ou du _Dictionnaire des noms malgaches de végétaux_ (Boiteau et al., 1999), sans que la source de chaque nom soit notée ; il est donné au rang de l'espèce, sinon du genre ou de la famille, et omis lorsqu'au moins deux familles restent possibles. Dans la suite du texte, le terme « espèce » désigne une identité réconciliée, et non une espèce botanique~: une identité peut regrouper plusieurs espèces botaniques, et une même espèce peut porter plusieurs noms. La démarche est celle d'Armstrong et al. (2011) à Betampona, où un guide local donnait le nom malgache des arbres, rattaché ensuite à un nom scientifique, notamment à l'aide de Schatz (2001).
// Paragraphe condensé le 03/11/2026 (auteur : « condenser la règle de réconciliation de façon générale »), sans changement de règle.
// Boiteau et al. (1999) : référence relevée sur la page du dictionnaire en ligne (Motmalgache.org, 02/11/2026) ; entrée boiteau_et_al_1999 dans hayagriva.yml. Lieu d'édition non indiqué ; date de consultation à ajouter si exigée.
// Sources des noms scientifiques : Schatz, Romiguière et le dictionnaire seulement (auteur, 02/11/2026) ; Pl@ntNet, Tropicos et iNaturalist n'ont pas été utilisés (entrées retirées de hayagriva.yml le 03/11/2026).
// Table de référence : 06_ecologie/analyse/referentiels/reconciliation-taxonomique.csv (colonnes nom-vernaculaire-brut, -normalise, -reconcilie, type-reconcilie, nom-binominal).
// Colonne nom-binominal : « ++ » = au moins deux familles possibles, aucun nom donné (auteur, 02/11/2026). Source de chaque nom scientifique non notée dans la table (auteur, 02/11/2026).
// Source : protocole (§ « Répartition des tâches ») ; rôles, absence de contrôle, types et règle de réconciliation confirmés par l'auteur le 31/10/2026.

Les usages des plantes ont été recueillis auprès du _polisinala_ sur le terrain, pour chaque espèce relevée. D'autres usages ont été cités au cours des entretiens et des sorties. Les usages de ces trois origines sont réunis dans la liste de la flore, qui indique pour chacun s'il provient d'une placette, d'une sortie ou d'un entretien (@annexe-flore). Les usages notés par Romiguière (2025) sur ses tiges de Tsiazombazaha sont ramenés aux mêmes libellés normalisés et réunis à ceux de l'étude. Les usages sont classés selon l'Economic Botany Data Collection Standard (Cook, 1995). Les libellés français sont utilisés dans le texte ; les codes de classification figurent en @annexe-codes-cook.
// TODO : rapprochement des usages terrain / sorties / entretiens en attente (auteur, 03/11/2026) ; l'annexe de la flore en donnera directement le résultat, avec la colonne « source » (placette, sortie, entretien).

=== Saisie des données

Les données de terrain ont été saisies par l'auteur sous LibreOffice Calc (version 26.2.6.3). Une première saisie par le traducteur, trop erronée, a été abandonnée et l'ensemble des fiches a été ressaisi. Le contrôle a porté sur la quasi-totalité des fiches, relues au moins une fois un autre jour que celui de la saisie. Les données ont ensuite été nettoyées et exportées en fichiers CSV, un par type d'observation, reliés par les codes de transect et de placette ; le schéma et le contenu de ces fichiers figurent en @annexe-fichiers-donnees. Les métadonnées de l'enquête sont reliées entre elles par leurs codes d'entretien, d'enquêté et de sortie (schéma de @annexe-fichiers-donnees). L'arborescence du dépôt remis à Inter Aide est décrite en @annexe-arborescence.
// LibreOffice Calc 26.2.6.3 (auteur, 03/11/2026) : https://www.libreoffice.org
// Source : auteur, 01/11/2026.

// Tableau des fichiers de données déplacé en annexe (@annexe-fichiers-donnees) le 01/11/2026 (guide, critères 5 et 79).

=== Données complémentaires

Huit placettes rectangulaires de 40~m² (10 × 4~m, de part et d'autre d'un axe de 10~m ; diamètre de précomptage de 2,5~cm), comprenant des sous-placettes de 4~m² en comptage en plein, ont été relevées dans la forêt par Romiguière (2025), au cours d'une prospection exploratoire de deux semaines. Elles complètent la liste des espèces végétales et les usages, et sont aussi ajoutées aux placettes de l'étude pour la surface terrière, le stock de carbone des tiges et la répartition par classe de diamètre (voir Stock de carbone).
La liste des espèces végétales est aussi complétée par l'inventaire du document de transfert de gestion du VOI Maharitra (2004). Pour la liste des espèces animales, les occurrences du document de transfert de gestion de 2004, du GBIF (téléchargement du 3 novembre 2026 ; GBIF.org, 2026) et de Rajaonson et al. (2010) sont mobilisées.
// Citation @gbif_2026 remplacée par une citation en texte, comme ailleurs dans le mémoire (03/11/2026) ; l'entrée gbif_2026 reste dans hayagriva.yml.
// Rajaonson et al. (2010), retenu par la revue de littérature (lu le 01/11/2026) : visite de la forêt de Tsiazombazaha le 25/01/2009 ; seuls Avahi laniger et Eulemur rufus y ont été trouvés (p. 37).
// Sous-section déplacée en fin d'acquisition (auteur, 03/11/2026) : relevés de terrain d'abord, données extérieures ensuite.

== Analyse des données écologiques

Les indicateurs retenus décrivent l'état initial de la forêt (SQ1) et servent de point de référence pour un suivi ultérieur. Ils reprennent ceux des inventaires de forêts malgaches les plus proches de cette étude : densité, surface terrière, distribution par classes de diamètre, indice de valeur d'importance et indice de Shannon chez Armstrong et al. (2011), courbes de raréfaction et estimateur Chao1 de la richesse chez Hending et al. (2023).

=== Conventions

Les analyses ont été réalisées avec R 4.6.1 (R Core Team, 2026) sous RStudio, avec les packages dplyr 1.2.1, tidyr 1.3.2, readr 2.2.0, stringr 1.6.0 et tibble 3.3.1 pour la préparation des données, vegan 2.7.6 (Oksanen et al., 2026) pour les indices de diversité, les estimateurs de richesse et l'ordination, iNEXT 3.0.2 (Hsieh et al., 2016) pour la raréfaction-extrapolation et l'estimateur Chao2, SpadeR 0.1.1 pour le jackknife d'ordre 2 et l'ICE, ainsi que ggplot2 4.0.3 (Wickham, 2016), scales 1.4.0, ggrepel 0.9.8 et svglite 2.2.2 pour les figures.
// REF? SpadeR : référence du package à ajouter (citation("SpadeR") dans R).
// Versions relevées le 31/10/2026 sur la machine de l'auteur (packageVersion) ; packages chargés par les six scripts d'analyse actifs. Les autres packages (dplyr, tidyr…) peuvent être cités par citation() si le référent le demande.

Les indices sont rapportés à la surface horizontale des placettes (voir Dispositif d'échantillonnage). Les gaulis sont comptés dans la densité $N$ mais exclus de la surface terrière $G$ ; la classe de diamètre 0-2,5~cm inclut les gaulis. Les tiges d'espèce indéterminée sont exclues de tous les calculs de diversité, de richesse et d'IVI ; leur nombre est indiqué dans les résultats. Pour les indices calculés par placette, la moyenne est donnée entre placettes, avec l'écart-type lorsque la dispersion entre placettes est décrite (nombre de tiges par placette, indices de diversité) et l'erreur-type pour les estimations de densité ($N$, $G$, régénération) ; les intervalles de confiance à 95~% sont calculés par la loi de Student. Les dissimilarités entre paires de placettes sont décrites par leur écart-type. Font exception la densité de grands arbres, dont l'erreur-type est celle de l'estimateur par le ratio, et les stocks de carbone et la raréfaction, dont les intervalles de confiance sont obtenus par bootstrap. Deux approches coexistent : à l'échelle du dispositif (effectif total rapporté à la surface cumulée) et par placette (moyenne des rapports). Elles donnent des valeurs légèrement différentes et ne sont jamais mélangées dans les résultats.
// Ligne des niveaux de signification (*, **, ***) retirée (auteur, 03/11/2026) : un seul test (permutation), dont la valeur de p est donnée dans les Résultats.
// Scripts relancés le 31/10/2026 après correction de la surface horizontale (placettes.csv : π r² cos α, total 531,1 m² contre 549,4 m² sur la pente), exclusion des indéterminées (diversité, richesse, IVI), correction de flore.csv (Fenakaragna, codes d'observation) et retrait du regroupement de communes ; copies mises à jour dans analyse-tables/ et analyse-figures/.

=== Description de la forêt

// Regroupement de l'analyse en quatre parties (auteur, 03/11/2026) : Conventions ; Description de la forêt ; Structure et stock de carbone ; Diversité. Anciennes sous-parties en intertitres gras ; mêmes regroupements en Résultats.
*Caractéristiques des placettes.* Les caractéristiques relevées sur chaque placette (voir Relevés par placette) sont décrites par le nombre de placettes dans chaque classe, sans traitement statistique ; le recouvrement de la canopée l'est par le nombre de quadrants, chaque placette en comptant quatre. La pente est résumée par son minimum, sa médiane et son maximum.
// Source : 08_rapport/donnees/description_placettes.R (03/11/2026) → analyse-tables/placettes_caracteristiques_resume.csv et placettes_caracteristiques.csv.

*Listes d'espèces et usages.* Deux listes d'espèces sont établies. La liste de la flore réunit les espèces relevées dans les placettes et le long des transects, celles notées hors relevé au cours des cheminements et celles citées par Romiguière (2025) et par le document de transfert de gestion de 2004, en indiquant la source de chaque mention.
// Espèces du transfert de gestion de 2004 ajoutées (inventaire, section 7 : arbres de grande et de petite taille ; source TFG).
// ATTENTION : le texte ci-dessous (jusqu'à la liste de la faune) était passé par erreur dans la ligne de commentaire précédente et n'apparaissait plus dans le PDF ; rétabli le 03/11/2026 (version visible le 01/11/2026). TFG : abréviation absente de la liste des abréviations. L'ordre de fiabilité des noms scientifiques ci-dessous (TFG, Romiguière, identifications personnelles) est à rapprocher de « La source retenue pour chaque nom scientifique n'a pas été notée » (Identification des espèces).
Les noms de Romiguière (2025) sont rattachés à ceux de l'étude par une table de correspondance vérifiée à la main ; ses identifications sur ses deux sites (Tsiazombazaha et Vorovoka) fournissent un nom scientifique selon la même règle (espèce, sinon genre, sinon famille). Les espèces du transfert de gestion de 2004 absentes des relevés sont ajoutées avec la source « TFG » (transfert de gestion forestière), sans leurs usages. Lorsque plusieurs sources donnent un nom scientifique, celui du transfert de gestion est préféré, puis celui de Romiguière (2025), puis l'identification de l'étude.
// Condensé le 03/11/2026 : ancienne version « table de correspondance, proposée par similarité des graphies puis vérifiée à la main ; […] l'espèce si une seule est citée, sinon le genre s'il est unique, sinon la famille si elle est unique ; à défaut, aucun nom n'est donné ».

La liste n'est pas limitée aux ligneux : les observations hors relevé comprennent aussi des herbacées et des lianes. Pour chaque espèce sont donnés le nom vernaculaire, le rattachement botanique lorsqu'il existe, le nombre de types décrits par le _polisinala_ et les usages cités. Les usages sont dénombrés par catégorie de la classification de Cook (1995), en nombre d'espèces citées pour chaque catégorie. Pour mesurer l'apport de l'abaissement du seuil de mesure, les espèces sont ajoutées à la liste dans un ordre fixe : tiges des placettes de DBH $>=$ 5~cm (seuil d'Armstrong et al., 2011), tiges de 2,5 à 5~cm, gaulis, puis espèces notées hors placettes ; à chaque étape, seules les espèces absentes des étapes précédentes sont comptées.

La liste de la faune réunit les espèces observées directement ou par leurs indices de présence au cours des cheminements et celles citées par le document de transfert de gestion de 2004, par le GBIF et par Rajaonson et al. (2010) ; elle est purement qualitative. Les types de traces d'activités humaines rencontrés sont présentés à titre indicatif, sans traitement.
// Liste non limitée aux ligneux (02/11/2026) : liste_flore.csv contient par exemple Kasakasa (herbacée, phénologie), Typha angustifolia, Entada scandens et Clematis mauritiana (lianes).

=== Structure et stock de carbone

*Structure forestière.* Les indicateurs suivent les définitions du _Mémento du forestier tropical_ (Mille et Louppe, 2015) et sont ceux utilisés par Armstrong et al. (2011) en forêt dense humide de basse altitude malgache ; densité, surface terrière et biomasse sont aussi ceux du protocole de l'inventaire national (BNCCREDD+ et al., 2020). La densité $N$ (tiges/ha) est calculée par placette, puis moyennée entre les $n$ placettes :
// Mille et Louppe (2015), §6.2 « Inventaires forestiers » (lu le 03/11/2026) : densité, surface terrière, structure diamétrique, richesse, indices de Simpson et de Shannon, IVI des inventaires d'aménagement ; §6.6 « Mesures de la biodiversité » : diversités α, β, γ, alpha de Fisher (application de Slik et al., 2015), estimateur de Chao, Simpson et Shannon.

$ N = 1/n sum_j 10000 dot N_j / s_j $

où $N_j$ est le nombre de tiges de la placette $j$ et $s_j$ sa surface horizontale (m²). La surface terrière $G$ (m²/ha) est la somme des sections des troncs à hauteur de poitrine, $g_k = pi D_k^2 / 4$ pour la tige $k$ ($D_k$ en mètres), calculée et moyennée de la même façon. $N$ et $G$ sont donnés avec leur erreur-type et leur intervalle de confiance à 95~%.
// Corrigé le 01/11/2026 : l'ancienne formule (effectif total / surface cumulée, approche du dispositif) ne correspondait pas aux valeurs des Résultats, qui sont des moyennes de densités par placette (resumer() dans fonctionsStructure.R, structure_resume_indices.csv).
// ATTENTION : le paragraphe ci-dessous était passé par erreur dans la ligne de commentaire précédente et n'apparaissait plus dans le PDF ; rétabli le 03/11/2026 (version visible le 01/11/2026).

La distribution des effectifs est établie par classes de diamètre de 2,5~cm ; celle de la surface terrière par classes de 5~cm à partir de 2,5~cm, largeur de classe retenue par Hending et al. (2023). Les grands arbres des transects y sont ajoutés par classe, leur effectif et leur surface terrière étant rapportés à la surface totale prospectée le long des transects. La régénération de plus de 1,30~m de haut est décrite par l'effectif de la classe 0-2,5~cm, qui comprend les gaulis ; celle de moins de 1,30~m, par sa densité (tiges/m²) dans chacune des deux classes de hauteur, moyenne entre les placettes où elle a été dénombrée, avec son erreur-type.
// Formule de g vérifiée dans fonctionsStructure.R : G = π / 4 × (DBH/100)², avec DBH = CBH / π.
La densité de grands arbres (CBH $>=$ 126~cm) est estimée par le rapport entre leur effectif total et la surface prospectée le long des transects (longueur × 10~m) ; son erreur-type est celle de l'estimateur par le ratio, les transects étant les unités d'échantillonnage (Cochran, 1977). Les chablis sont dénombrés par classe de circonférence et par transect.
// Note (Cochran, 1977) : chapitre 6, estimateur par le ratio.
// TODO (auteur) : densité de chablis à l'hectare à ajouter une fois les longueurs prospectées connues (analyse_transects.R n'exporte que les effectifs).

// Analyse de la corrélation régénération / couvert retirée (auteur, 31/10/2026) : ne répond pas directement à SQ1 ; la régénération est décrite par la classe 0-2,5 cm de la structure diamétrique, qui inclut les gaulis.

*Stock de carbone.* Le stock de carbone est estimé pour quatre compartiments : les tiges vivantes des placettes, les grands arbres des transects, le bois mort au sol et le bois mort sur pied. Les grands arbres relevés le long des chemins et les tiges des placettes proviennent de deux dispositifs distincts, sans recouvrement : leurs stocks s'additionnent.
// ATTENTION : vrai pour les 28 placettes de l'étude (aucune tige de DBH ≥ 40 cm). Le jeu « Étude + Romiguière » compte des tiges de DBH ≥ 40 cm, déjà couvertes par les transects : pour un stock total avec ce jeu, ne retenir des placettes que les tiges de CBH < 126 cm (compartiments séparés par le diamètre), ou n'additionner que le stock de l'étude seule.

La biomasse aérienne $"AGB"_k$ (kg) de chaque tige vivante est estimée par l'équation sans hauteur de Chave et al. (2014) :

$ "AGB"_k = exp(-"1,803" - "0,976" E + "0,976" ln(rho) + "2,673" ln(D_k) - "0,0299" (ln D_k)^2) $

où $D_k$ est le DBH (cm), $rho$ la densité du bois (g/cm³) et $E$ l'indice de stress environnemental du site. $E$ vaut 0,10 : il est lu dans la grille de Chave et al. (2014), diffusée avec le package R BIOMASS (Réjou-Méchain et al., 2017), au centre de l'emprise de la forêt. Faute d'identités assez sûres, une densité générique $rho = "0,58"$~g/cm³, moyenne des espèces d'Afrique tropicale (Brown, 1997, d'après Reyes et al., 1992), est appliquée à toutes les tiges. L'équation est appliquée à toutes les tiges mesurées, dès 2,5~cm de DBH.
// Domaine de calibration de Chave et al. (2014) et densité unique : discutés en Discussion (« Estimation du stock de carbone ») ; justification retirée d'ici (03/11/2026).
// Source : 08_analyse_carbone.R (constantes, 01/11/2026). E = 0,1025 au centre de l'emprise (47,951 °E ; 21,904 °S), 0,102 à 0,109 aux quatre coins (grille E.zip du dépôt GitHub umr-amap/BIOMASS, résolution 2,5', lue avec GDAL). L'ancienne valeur provisoire E = −0,080 est abandonnée.
// ρ = 0,58 : Brown (1997), §3.1.2, tableau des densités moyennes par région (Afrique : 0,58, 282 espèces ; Amérique : 0,60 ; Asie : 0,57), qui recommande la moyenne régionale pour les espèces inconnues (lu le 01/11/2026). L'ancienne valeur 0,60 correspondait à la moyenne de l'Amérique tropicale.
// Note (Brown, 1997) : §3.1.2, moyenne régionale pour les espèces inconnues.
// Limite à reprendre en Discussion : densité unique (pas de variation entre espèces) et tiges de DBH < 5 cm hors du domaine de calibration ; un calcul de sensibilité (ρ = 0,50 et 0,70) peut encadrer le résultat si besoin.

La surface terrière, le stock de carbone des tiges et leur répartition par classe de diamètre sont aussi calculés en ajoutant les huit placettes de Romiguière (2025), relevées au même seuil (voir Données complémentaires) et non corrigées de la pente ; sans gaulis relevés, elles n'entrent ni dans la densité totale ni dans la classe 0-2,5~cm. Les hauteurs qu'elles comportent permettent de comparer, sur ces tiges, l'équation sans hauteur à celle avec hauteur de Chave et al. (2014).
// Source : analyse_sensibilite_romiguiere.R (02/11/2026), mêmes méthodes et constantes que analyse_structure_forestiere.R et 08_analyse_carbone.R.

La biomasse souterraine est extrapolée par un ratio racines/parties aériennes $R = "0,20"$ pour une forêt tropicale humide (Mokany et al., 2006 ; Gytarsky et al., 2019). Le stock de carbone est obtenu en appliquant à la biomasse une fraction de carbone de la matière sèche $"CF" = "0,47"$ (Eggleston et al., 2006), puis converti en CO₂ par le rapport des masses molaires ($"M"_("CO"_2) / "M"_C = "3,67"$) :

$ "Stock"_("CO"_2) = (1 + R) dot "AGB" dot "CF" dot "M"_("CO"_2) / "M"_C = "2,06988" dot "AGB" $

Le volume de bois mort au sol (m³/ha) est estimé par la méthode des transects linéaires (Van Wagner, 1968), en assimilant les pièces à des cylindres :

$ V_("bm,sol") = 10000 dot pi^2 / (8 L) sum_i d_i^2 f_i $

où $d_i$ est le diamètre (m) de la pièce $i$ au point d'intersection, $L$ la longueur cumulée des lignes (290~m) et $f_i$ un facteur de réduction de densité selon la classe de décomposition : 1,00 pour le bois sain, 0,80 pour le bois intermédiaire et 0,45 pour le bois pourri. Ces valeurs sont les valeurs par défaut de l'outil méthodologique du Mécanisme pour un développement propre pour le bois mort (CCNUCC, 2010), adaptées de Harmon et Sexton (1996), et celles du protocole de l'inventaire national (BNCCREDD+ et al., 2020). La biomasse du bois mort sur pied (chandelles) est estimée par l'équation de Chave et al. (2014), multipliée par un facteur de réduction de biomasse de 0,80 que le même outil et l'inventaire national appliquent aux arbres morts ayant perdu leurs feuilles, leurs rameaux et leurs petites branches , faute de hauteur mesurée pour calculer le volume du fût. La biomasse du bois mort au sol est le produit de ce volume par la densité $rho$. Le stock de carbone du bois mort, au sol et sur pied, est calculé avec la même fraction $"CF"$, sans biomasse souterraine.
// Note (CCNUCC, 2010) : lu le 01/11/2026 : facteurs de réduction de densité 1,00 / 0,80 / 0,45 (§21, p. 5, note 4 : adaptés de Harmon et Sexton, 1996) ; test de la machette (note 3, d'après IPCC GPG-LULUCF 2003) ; facteur de réduction de biomasse 0,80 pour les arbres morts sans petites branches (§11 b). Année de l'EB 58 (décembre 2010) à vérifier.
// Les anciens facteurs 0,9 / 0,6 / 0,4 (« adaptation conservative de Harmon et Sexton ») sont abandonnés faute de source ; la mesure de densité par classe de Walker et al. (2018) est impossible a posteriori.
// L'outil MDP applique la formule aux pièces de diamètre ≥ 10 cm ; le protocole national, à partir de 2,5 cm de diamètre, comme ici (CBH ≥ 8 cm).

Les stocks des placettes sont rapportés à leur surface horizontale cumulée, ceux des grands arbres à la surface prospectée le long des transects. Les intervalles de confiance à 95~% sont obtenus par bootstrap (1~000 rééchantillonnages des placettes ou des transects, graine 2026). Les stocks par hectare sont extrapolés à la surface totale de la forêt, soit 640~ha (VOI Maharitra, 2025). L'intervalle de confiance du stock total est obtenu en combinant ceux des compartiments, supposés indépendants~: l'écart entre chaque borne et l'estimation est la racine de la somme des carrés des écarts des compartiments, calculée séparément pour la borne basse et la borne haute.
// Grands arbres : 5 305 m prospectés (T05, T06, T16, T19, T20), soit 53 050 m² ; T19 incertain (« 300 ? » dans l'ODS).

=== Diversité

*Diversité alpha.* La diversité alpha, à l'échelle de la placette, est quantifiée par quatre indices calculés sur les effectifs de toutes les tiges comptées (tiges mesurées et gaulis). Ce sont la richesse spécifique $S$ ; l'indice de Shannon $H' = -sum_i p_i ln p_i$ (Shannon et Weaver, 1949), utilisé par Armstrong et al. (2011) ; l'inverse de l'indice de Simpson, $1 / sum_i p_i^2$ (Simpson, 1949), d'autant plus élevé que les tiges se répartissent également entre de nombreuses espèces. Les indices de Shannon et de Simpson sont les deux indices de diversité classiques des inventaires forestiers (Mille et Louppe, 2015). Le quatrième est l'indice alpha de Fisher, défini par $S = alpha ln(1 + N / alpha)$, où $N$ est ici le nombre de tiges de la placette (Fisher et al., 1943), peu sensible au nombre de tiges comptées ; Slik et al. (2015) l'ont utilisé pour estimer la richesse en arbres des forêts tropicales (cités par Mille et Louppe, 2015).
// Sources d'application vérifiées le 03/11/2026 : Shannon (Armstrong et al., 2011) ; Simpson et Shannon (Mille et Louppe, 2015, §6.2 et §6.6) ; alpha de Fisher (Slik et al., 2015, cités par Mille et Louppe, 2015, §6.6). Hending et al. (2023) n'utilisent Shannon que pour la diversité structurale. Cadre des nombres de Hill (Hill, 1973 ; Jost, 2006) et exponentielle de Shannon (¹D) mis de côté (auteur, 03/11/2026) : sans étude d'application ; ¹D reste dans diversite_alpha_*.csv, non présenté.

L'indice de Shannon et l'inverse de Simpson sont calculés sous leur forme brute, sans correction du biais d'échantillonnage (voir Discussion) ; ils décrivent les assemblages échantillonnés, et $H'$ reste comparable à celui d'Armstrong et al. (2011).
// Justification (proportion d'espèces à une tige, extrapolation des estimateurs corrigés de Chao et al., 2014) déplacée en Discussion, « Inventaire floristique » (03/11/2026).
// Arbitrage auteur (01/11/2026) : formes homogènes, corrigées si adaptées, sinon brutes. Contrôle hors scripts (Python, diversite_abondances.csv) : en moyenne 54 % d'espèces à une tige par placette, couverture d'échantillonnage moyenne de 0,75 (minimum 0,51) — valeurs non citées dans le texte.

*Diversité bêta.* La diversité bêta mesure la différence de composition entre placettes. Le bêta multiplicatif de Whittaker, $beta = gamma / macron(alpha)$ (Whittaker, 1960), où $gamma$ est le nombre d'espèces de l'ensemble des placettes et $macron(alpha)$ leur richesse moyenne, s'interprète comme le nombre effectif de communautés entièrement distinctes (Jost, 2007). Le bêta additif, $beta_"add" = gamma - macron(alpha)$ (Lande, 1996), est le nombre moyen d'espèces de la forêt absentes d'une placette moyenne ; rapporté à $gamma$, il donne la part de la richesse de la forêt absente d'une placette moyenne.
// Choix de γ / ᾱ plutôt que γ / ᾱ − 1 (auteur, 31/10/2026) : forme la plus courante et la plus parlante pour les décideurs ; script modifié (fonctionsDiversiteBeta.R) et relancé.

Une ordination par positionnement multidimensionnel non métrique (NMDS) en deux dimensions est réalisée sur les dissimilarités de Bray-Curtis (Bray et Curtis, 1957) calculées à partir des effectifs par placette ; la qualité de la représentation est mesurée par le stress (Kruskal, 1964). Les placettes sont représentées par un symbole propre à leur itinéraire, pour rendre visible une éventuelle autocorrélation spatiale.
// REF? études d'application : bêta de Whittaker et de Lande, NMDS, Bray-Curtis, Jaccard et test de permutation absents d'Armstrong et al. (2011), de Hending et al. (2023), du protocole national (BNCCREDD+ et al., 2020) et du Mémento (qui ne présente que le concept de diversité β, d'après Marcon, 2015) ; vérifiés le 03/11/2026.

Les dissimilarités entre paires de placettes, de Bray-Curtis sur les effectifs et de Jaccard (1912) en présence-absence, sont comparées selon le niveau auquel les deux placettes se rattachent à une même entité : même itinéraire, même _polisinala_, même commune, ou communes différentes. Cette comparaison vise à distinguer l'effet de la proximité spatiale de celui de l'observateur, chaque _polisinala_ nommant les espèces selon ses propres connaissances. Les paires de placettes n'étant pas indépendantes, une même placette entrant dans plusieurs paires, la comparaison est seulement descriptive (moyennes, écarts-types et boîtes à moustaches). Enfin, la proportion d'espèces observées dans une seule commune est comparée à sa distribution sous l'hypothèse nulle, obtenue en réattribuant au hasard les communes aux placettes (999 permutations, effectifs de placettes par commune conservés).
// Détails vérifiés dans analyse_diversite_beta.R (31/10/2026) : vegan::metaMDS(k = 2, trymax = 100) ; niveaux hiérarchiques transect > polisinala > commune ; permutation avec set.seed(2026), p = (1 + nb ≥ obs) / (nPerm + 1).
// Tests de Kruskal-Wallis et de Wilcoxon sur les paires retirés du rapport (pseudo-réplication, arbitrage auteur du 31/10/2026) ; ils restent dans les CSV *_tests_* pour traçabilité.
// Regroupement « Ambila et Mizilo contre Ambahatrazo » retiré du script (auteur, 31/10/2026). Les anciens fichiers diversite_beta_*groupes*.csv restent dans sorties/ mais sont obsolètes.

*Espèces dominantes.* L'indice de valeur d'importance (IVI) de l'espèce $i$ combine sa densité relative, sa dominance relative et sa fréquence relative (Curtis et McIntosh, 1951) ; les inventaires d'aménagement l'emploient pour identifier les principales essences d'un peuplement (Mille et Louppe, 2015). Il est présenté sur 100, c'est-à-dire divisé par 3 par rapport à la forme sur 300 utilisée par Armstrong et al. (2011) :

$ "IVI"_i = ("RD"_i + "RDo"_i + "RF"_i) / 3, quad "RD"_i = 100 dot n_i / (sum_j n_j), quad "RDo"_i = 100 dot G_i / (sum_j G_j), quad "RF"_i = 100 dot F_i / (sum_j F_j) $

avec $n_i$ le nombre de tiges mesurées, $G_i$ la surface terrière et $F_i$ le nombre de placettes où l'espèce $i$ est présente. Comme chez Armstrong et al. (2011), qui dénombrent à part la régénération, il est calculé sur les seules tiges mesurées, seules à disposer d'une surface terrière.
// Choix discuté le 31/10/2026 : un IVI partiel pour les espèces sans tige mesurée ne serait pas comparable, et attribuer une surface terrière fictive aux gaulis (CBH de 1 cm) serait arbitraire ; les gaulis, bien plus nombreux que les tiges mesurées, domineraient alors la densité et la fréquence relatives. La régénération par espèce peut être présentée à part si besoin.
// Kent (2011), Vegetation Description and Data Analysis (2e éd.), cité par le script pour la forme normalisée de l'IVI ; non cité dans le texte.
// Sortie du 01/11/2026 : 124 espèces, 28 placettes, 479 tiges mesurées (indéterminées exclues), après passage en gaulis des tiges de 7 cm de P06.

*Richesse spécifique totale.* La richesse observée $gamma_"obs"$ est le nombre d'espèces recensées dans l'ensemble des placettes. L'état d'avancement de l'inventaire est décrit par la courbe de raréfaction-extrapolation en fonction du nombre de placettes, extrapolée jusqu'à quatre fois l'effort réalisé (Chao et Jost, 2012 ; Hsieh et al., 2016), comme Hending et al. (2023) le font en fonction du nombre d'arbres. La richesse totale est estimée par des estimateurs asymptotiques dont la confrontation délimite une fourchette : Chao2, estimateur principal, et, en complément, les jackknifes d'ordre 1 et 2, ICE et bootstrap sur les incidences, ainsi que Chao1 et ACE sur les abondances (Burnham et Overton, 1979 ; Chao, 1984 ; 1987 ; Lee et Chao, 1994 ; Smith et van Belle, 1984).
// Portée des estimateurs (bornes inférieures, généralisation à la forêt) : déjà en Discussion (« Inventaire floristique ») ; phrase retirée d'ici (03/11/2026).
// Figures et tableaux des analyses : en Résultats ; tableau complet des estimateurs en annexe (estimateurs_richesse_gamma.csv).
// γ = 242 espèces depuis le 01/11/2026 (« Valotra / Voamalimpangady » rattaché à « Espèce indéterminée ») ; auparavant γ = 243 espèces dans les scripts de diversité bêta et de richesse (31/10/2026), après correction de l'observation de Fenakaragna (P07 : un gaulis saisi) et renumérotation des codes d'observation de flore.csv (419 codes alignés sur le numéro de placette, 917 codes uniques). ATTENTION : renumérotation faite dans flore.csv seulement ; à reporter dans le fichier de saisie ODS si les CSV en sont régénérés.

== Méthodologie du volet social

Le volet social répond aux sous-questions relatives aux usages, aux perceptions et aux pressions (SQ2) et à l'organisation de la gestion, à l'application de ses règles et à la façon dont elles sont perçues (SQ3). Il repose sur des entretiens semi-directifs et des sorties en forêt, complétés ponctuellement par les documents de transfert de gestion. La démarche s'inspire du _Guide de l'enquête de terrain_ de Beaud et Weber (2010). Le cadre d'analyse est présenté dans la Problématique.
// TODO : remplacer « SQ2 », « SQ3 » et « Problématique » par des références Typst une fois les étiquettes posées.
// Sous-section « Cadre d'analyse » supprimée (auteur, 31/10/2026) : le cadre est rédigé dans la Problématique.

=== Collecte des données

Entre mai et août 2026, 34 entretiens semi-directifs (E1 à E34, @annexe-entretiens) ont réuni 50 personnes, dont 14 entretiens collectifs de deux à cinq personnes. Les personnes ont été identifiées principalement par les chefs de _fokontany_ et les membres du bureau du VOI et, pour certaines, par les techniciens d'Inter Aide. L'échantillon comprend des membres et d'anciens membres du VOI, dont des membres du bureau et des _polisinala_, des habitants sans lien avec le VOI, des autorités locales et des salariés d'Inter Aide (@annexe-echantillon-social). Les entretiens ont duré de 43~min à 6~h, avec une durée médiane de 1~h~52 (durée connue pour 26 entretiens).
// Source : metadonnees_enquete-de-terrain_1_entretiens.csv et _3_enquetes.csv (05_Sociologie/donnees, lus avec l'accord de l'auteur le 31/10/2026 ; seuls des effectifs ont été extraits, aucun nom).
// ATTENTION (hors section) : le Résumé (29 entretiens, 44 personnes) et le brouillon (32, 49) sont à mettre à jour.
// TODO : critères de choix des personnes (diversité de fokontany, de liens au VOI, de genre ?) ; le recrutement par le bureau du VOI et les chefs de fokontany est un biais à discuter dans la Discussion (« Limites méthodologiques »).

Les entretiens ont été conduits en malgache et traduits en direct par un interprète. Les échanges ont été notés à la main en français. Ces notes ont ensuite été lues à voix haute et enregistrées, puis transcrites localement avec whisper.cpp (modèle Large-v3 Turbo de Whisper ; Radford et al., 2023).
// whisper.cpp : https://github.com/ggml-org/whisper.cpp (version à indiquer).

Vingt et une sorties en forêt ou en bordure de forêt (S1 à S21 ; @annexe-sorties) ont eu lieu de juin à septembre 2026, avec des habitants, des _polisinala_ ou des membres du VOI. Elles comprennent les journées d'inventaire, des parcours de chemins, la prospection des sources, l'observation des cultures et des plantations, ainsi qu'une assemblée générale du VOI. Elles ont permis d'observer les usages et les pressions évoqués en entretien et de prolonger les échanges sur place.
// Source : metadonnees_enquete-de-terrain_2_sorties.csv (motifs regroupés). Une date de sortie est inconnue (« ? »).
// Neuf sorties comportent des placettes (25 placettes avant découpage de P2) : neuf journées de relevés retenues dans le dispositif (auteur, 31/10/2026).


Le consentement a été recueilli oralement, par l'intermédiaire de l'interprète, lors de la présentation du projet. Les entretiens et les sorties sont codés par ordre chronologique (E1 à E34, S1 à S21) et les personnes par un code anonyme. Le canevas d'entretien figure en @annexe-canevas.
// TODO : canevas à mettre au propre et à numéroter en annexe (guide, critère 35).

Les 53 personnes rencontrées en entretien ou en sortie sont 43 hommes et 10 femmes ; leur âge, connu pour 29 d'entre elles, va de 21 à 69 ans (@tab-echantillon-age-genre). Toutes, sauf une, se sont présentées comme _mpamboly_ (cultivateurs). Certaines exercent en outre une responsabilité de _fokontany_ ou de commune (9 personnes), la vannerie (5) ou la fonction d'_ampazaka_, chef de lignage (3). Quant au lien au VOI, 15 personnes en sont membres, 6 sont membres du bureau, 10 sont _polisinala_ et 4 y exercent une autre fonction (pépiniériste, comité feu, observateur) ; 3 en sont d'anciens membres, 8 n'y ont aucun lien et le lien de 7 personnes n'est pas renseigné. Le détail par personne figure en @annexe-echantillon-social.
// Source : echantillon_social_*.csv (08_rapport/donnees/description_echantillon_social.R, 02/11/2026 ; colonne « Nom » jamais lue). Une seule catégorie d'activité et de lien au VOI par personne (règles de priorité dans le script) ; activités secondaires comptées à part.
// « Toutes, sauf une, se sont présentées comme mpamboly » : formulation confirmée par l'auteur (02/11/2026) ; la colonne « Professions » des métadonnées, qui ne cite l'agriculture que pour 28 personnes, sera complétée par l'auteur.
// Ampazaka = chef de lignage (graphie et définition de l'auteur, 02/11/2026). Graphie « ampazaka » retenue partout (auteur, 02/11/2026) : glossaire et commentaire de ResultatsSocio.typ harmonisés ; « mpanzaka » ne subsiste que dans les métadonnées.

#let ageGenre = csv("analyse-tables/echantillon_social_age_genre.csv").slice(1)
#figure(
  table(
    columns: (2fr, 1fr, 1fr, 1fr),
    align: (left, right, right, right),
    inset: 8pt,
    table.header([*Classe d'âge*], [*Hommes*], [*Femmes*], [*Total*]),
    ..ageGenre.flatten(),
  ),
  caption: [Personnes rencontrées en entretien ou en sortie (n = 53), par classe d'âge et par genre. Âge en 2026, d'après les métadonnées de l'enquête de terrain.],
) <tab-echantillon-age-genre>
#titre-court(<tab-echantillon-age-genre>)[Échantillon social par âge et par genre]

Les documents de transfert de gestion de 2004 et de 2025, rédigés en malgache, n'ont été consultés que ponctuellement, par l'intermédiaire de l'interprète ; seule la liste des espèces, disponible en français, a été exploitée directement.
// Ordre des paragraphes revu le 03/11/2026 : entretiens, conduite et transcription, sorties, consentement et codage, description de l'échantillon, documents.

=== Analyse des entretiens

// TODO : analyse non encore réalisée (auteur, 31/10/2026). Ébauche à confirmer une fois l'analyse faite :
// « Les transcriptions ont fait l'objet d'une analyse thématique, sans grille de codage préétablie, sur papier puis avec l'aide d'un modèle de langage appliqué aux fichiers texte. »
// REF? piste : Braun, V., & Clarke, V. (2006). Using thematic analysis in psychology. Qualitative Research in Psychology, 3(2), 77-101. https://doi.org/10.1191/1478088706qp063oa
// Modèle de langage prévu : Claude (Anthropic), service en ligne, non local (auteur, 31/10/2026) — voir « Usage d'outils d'intelligence artificielle ».
// ATTENTION : les transcriptions seront transmises à un service en ligne : les anonymiser avant envoi (noms, lieux-dits identifiants) et le mentionner dans le texte.
// TODO : tableau de traitement des entretiens en annexe (critère 43) ; croisement entretiens / sorties / documents (critère 38) ; lien avec les catégories de la grille SES d'Ostrom (2009) si retenu.
// ATTENTION (hors section, Problematique.typ) : « l'exclusion des usagers est coûteuse et le bien est exclusif » — chez Ostrom, une ressource commune se définit plutôt par une exclusion difficile et des prélèvements qui diminuent la ressource pour les autres. À vérifier dans Ostrom (1990).

== Utilisation des outils d'intelligence artificielle

Des assistants d'intelligence artificielle générative et agentique ont été utilisés tout au long du stage pour la recherche bibliographique, la réflexion, l'aide à la rédaction, la programmation et l'analyse des données : Le Chat et les assistants Vibe (Chat, Work, Code) de Mistral AI, fondés sur les modèles Mistral Small 4, Medium 3.5, Large 3 et 4, Magistral et GLM 5.2 et 5.3 de Z.ai hébergés par Mistral AI, ainsi que Claude (Anthropic), avec les modèles Opus 5.5, Sonnet 5.5 et Haiku 5.5. Les transcriptions des entretiens, anonymisées, sont analysées avec l'assistance de Claude. Les contenus produits ont été systématiquement relus et vérifiés par l'auteur, qui en assume la pleine responsabilité.