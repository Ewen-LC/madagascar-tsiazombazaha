#import "TitresCourts.typ": titre-court
// Résultats — volet écologie (§3.1, §3.2, §3.4 validés).
// Règle (guide GEEFT, critère 49) : pas de comparaison avec la littérature ni
// d'interprétation ici — tout va en Discussion.
// Valeurs : issues des CSV à la date de rédaction. La saisie continue : chaque valeur
// citée porte son n et un // TODO date-jeu-de-données pour revalidation avant dépôt.
// Figures : importées depuis leur chemin canonique, jamais copiées.

= Résultats

== Revue de littérature <res-revue>

// Rédigé le 01/11/2026 à partir de documents-brouillons/PRISMA_resultats.ods (onglets « resultats-generaux » et « resultats-conserves », exportés en CSV). TODO : valeurs à valider (auteur).
// Les effectifs sont donnés par base, sans total calculé à la main ; le total de 7 documents retenus, dont 6 récupérés, est celui des notes de l'auteur (M&M, commentaire « Pour la section Résultats »).
La requête « Tsiazombazaha » a renvoyé 18 enregistrements dans Google Scholar, 15 dans Internet Archive Scholar et aucun dans Web of Science (@fig-prisma). Après retrait des doublons (4 et 6), 14 et 9 documents ont été examinés. Parmi eux, 11 et 5 portaient sur une forêt homonyme, 1 et 3 sur une forêt non localisable. Deux documents de Google Scholar et un d'Internet Archive Scholar portent sur la forêt d'étude ; ce dernier n'a pas pu être récupéré. Le moteur de recherche Google a fourni un document supplémentaire et les documents internes d'Inter Aide trois. Au total, sept documents ont été retenus, dont six ont été récupérés.
// ATTENTION : le M&M indique un tri « sur le texte intégral », mais le document d'Internet Archive Scholar retenu est introuvable : préciser sur quelle base il a été jugé pertinent (titre, résumé ?), ou nuancer la phrase du M&M.

// Diagramme PRISMA 2020 (Page et al., 2021), tracé en Typst ; effectifs par base, sans total.
#let boitePrisma(corps, largeur: 100%) = rect(width: largeur, inset: 6pt, stroke: 0.6pt + black, align(left, corps))
#let phasePrisma(corps) = grid.cell(fill: luma(220), inset: 4pt, align(center + horizon, corps))
#figure(
  {
    set text(size: 8pt)
    set par(justify: false, leading: 0.5em, first-line-indent: 0pt)
    grid(
      columns: (1.5cm, 1fr, 0.6cm, 1fr, 0.4cm, 0.9fr),
      row-gutter: 0.15cm,
      align: horizon,
      // Identification
      phasePrisma[Identi\-fication],
      boitePrisma[Enregistrements identifiés dans les bases bibliographiques :\ Google Scholar (n = 18)\ Web of Science (n = 0)\ Internet Archive Scholar (n = 15)],
      align(center)[→],
      boitePrisma[Doublons retirés :\ Google Scholar (n = 4)\ Internet Archive Scholar (n = 6)],
      [],
      boitePrisma[Documents identifiés par d'autres méthodes :\ moteur de recherche Google (n = 1)\ documents internes d'Inter Aide (n = 3)],
      // Sélection
      [], align(center)[↓], [], [], [], align(center)[↓],
      phasePrisma[Sélection],
      boitePrisma[Documents examinés :\ Google Scholar (n = 14)\ Internet Archive Scholar (n = 9)],
      align(center)[→],
      boitePrisma[Documents exclus :\ forêt homonyme (n = 11 ; 5)\ forêt non localisable (n = 1 ; 3)],
      [], [],
      [], align(center)[↓], [], [], [], align(center)[↓],
      phasePrisma[Éligibilité],
      boitePrisma[Documents portant sur la forêt d'étude :\ Google Scholar (n = 2)\ Internet Archive Scholar (n = 1)],
      align(center)[→],
      boitePrisma[Document non récupéré :\ Internet Archive Scholar (n = 1)],
      [],
      boitePrisma[Documents portant sur la forêt d'étude :\ Google (n = 1)\ documents internes (n = 3)],
      // Inclusion
      [], align(center)[↓], [], [], [], align(center)[↓],
      phasePrisma[Inclusion],
      grid.cell(colspan: 5, boitePrisma[Documents retenus : n = 7, dont 6 récupérés (@tab-revue-documents)]),
    )
  },
  caption: [Diagramme de sélection des documents portant sur la forêt de Tsiazombazaha, selon la déclaration PRISMA 2020 (Page et al., 2021). Requête : « Tsiazombazaha », avril 2026. Pour les exclusions, le premier effectif est celui de Google Scholar, le second celui d'Internet Archive Scholar.],
) <fig-prisma>
#titre-court(<fig-prisma>)[Diagramme PRISMA de la revue de littérature]

Les sept documents retenus comprennent trois mémoires, deux documents officiels, un article scientifique et un article de blog (@tab-revue-documents). Deux documents seulement rapportent des relevés naturalistes faits dans la forêt. Rajaonson et al. (2010) y ont recherché les lémuriens au cours d'une journée de prospection, le 25 janvier 2009, et n'y ont trouvé que deux espèces, _Avahi laniger_ et _Eulemur rufus_. Romiguière (2025), au cours d'une prospection exploratoire de deux semaines, y a relevé la flore ligneuse sur huit placettes de 40~m² ; son étude porte principalement sur la forêt de Vorovoka (trois mois de terrain). Les documents de transfert de gestion de 2004 et de 2025 portent sur la gestion de la forêt par le VOI Maharitra ; celui de 2004 contient des listes d'espèces végétales et animales. Les autres documents traitent du foncier dans les communes riveraines, du potentiel écotouristique de la forêt et d'un litige lié à son exploitation.
// Rajaonson et al. (2010), p. 37 (lu le 01/11/2026) : forêt visitée le 25/01/2009 (une journée), aucun bambou ; nomenclature de la source (« Eulemur rufus »).
// Romiguière (2025) : huit placettes de 40 m² (M&M, « Données complémentaires ») ; deux semaines exploratoires à Tsiazombazaha, trois mois à Vorovoka (auteur, 01/11/2026).
// TODO : nombre d'espèces citées par le transfert de gestion de 2004 et par Romiguière (2025), une fois les listes consolidées.
// GBIF : recherche à part, directement sur le site du GBIF, hors revue PRISMA (auteur, 01/11/2026) ; les occurrences sont présentées avec la liste de la faune. Le projet de stage mentionne 205 occurrences d'un inventaire d'octobre 2008 (« Mollusques (2008) » de l'ancienne esquisse ?) : TODO, à revérifier sur le GBIF avant de citer.
// Problematique.typ (l. 75) corrigée le 02/11/2026 : seule donnée disponible = stage de Romiguière (2025), deux semaines, 5 entretiens, 8 relevés.

#figure(
  table(
    columns: (3fr, 2fr, 2fr, 4fr, 1fr),
    align: (left, left, left, left, center),
    inset: 6pt,
    table.header([*Document*], [*Type*], [*Source*], [*Contenu relatif à la forêt*], [*Récupéré*]),
    [// TODO : auteur et année
      Mémoire (auteur à préciser)], [Mémoire], [Google Scholar], [Foncier dans les communes riveraines de la forêt], [Oui],
    [Rajaonson et al. (2010)], [Article scientifique], [Google Scholar], [Lémuriens : une journée de prospection dans la forêt], [Oui],
    [// TODO : auteur et année
      Mémoire (auteur à préciser)], [Mémoire], [Internet Archive Scholar], [Potentiel écotouristique de la forêt, pour l'association Fiantso], [Non],
    [« Contribution à l'ethnographie d'un village du sud-est malgache : sur le "choc des cultures" »], [Article de blog], [Google], [Mention d'un cas litigieux d'exploitation de la forêt], [Oui],
    [Romiguière (2025)], [Mémoire], [Documents internes], [Étude socio-écologique des fragments de Vorovoka et de Tsiazombazaha, pour Inter Aide], [Oui],
    [VOI Maharitra (2004)], [Document officiel], [Documents internes], [Transfert de gestion de la forêt au VOI Maharitra], [Oui],
    [VOI Maharitra (2025)], [Document officiel], [Documents internes], [Renouvellement du transfert de gestion], [Oui],
  ),
  caption: [Documents retenus par la revue de littérature sur la forêt de Tsiazombazaha.],
) <tab-revue-documents>
#titre-court(<tab-revue-documents>)[Documents retenus par la revue de littérature]
// Blog : https://www.anthropologieenligne.com/pages/zafimahavitaM.html — auteur et date à préciser ; entrée bibliographique à créer. Entrées VOI Maharitra (2004) et des deux mémoires à créer dans hayagriva.yml.

// Anciennes esquisses (brouillon « redaction-foresterie-brouillon »), conservées pour mémoire :
// Tableau 1 — sources ayant prospecté la faune/flore de la forêt :
//   [Source][Effort de prospection en jours][Espèces animales (vern/scie)][Espèces végétales (vern/sci)]
//   [Romiguière (2025)], [4], [], [], [],],
//   [Document de transfert de gestion (2004)], [?], [], [], [],],
//   [DREDD], [?], [], [], [],],
//   [Mollusques (200~8)], [2 ?], [0], [], [],
//   [Lémuriens — Rajaonson et al. (2010)], [1], [2 (A. laniger, E. rufus)], [], [],
// Tableau 2 — sources identifiées ayant réalisé des relevés écologiques dans la forêt
// de Tsiazombazaha :
//   [Source], [Nombre de tiges], [Nombre d'espèces],
//   [], [], [],
//   [], [], [],
// TODO : saisir ces tableaux quand les sources seront consolidées.

== Analyse des données écologiques

L'inventaire porte sur 1~999 tiges, tiges mesurées et gaulis, réparties dans 28 placettes, pour une surface horizontale cumulée de 531,1~m² après correction de pente. Cinquante et une tiges (7 tiges mesurées et 44 gaulis) réparties dans 10 placettes n'ont pas pu être nommées ; elles sont exclues des calculs de diversité, de richesse et d'IVI, qui portent sur 1~948 tiges, mais conservées dans les calculs de structure forestière et de stock de carbone.

// Rédigé le 01/11/2026 à partir des sorties R du 31/10/2026 (diversité, structure, IVI, richesse) et du 01/11/2026 (carbone), après passage en gaulis des deux tiges de 7 cm de P06.
// Sources : analyse-tables/ (copies de 06_ecologie/analyse/sorties/) et, pour les fichiers non copiés, 06_ecologie/analyse/sorties/ (nom indiqué à chaque paragraphe).
// Règle (guide, critère 49) : résultats seulement ; comparaisons avec la littérature et interprétations en Discussion.
// Figures et tableaux : activés le 01/11/2026 (valeurs revérifiées contre les CSV de sorties/) ; renvois Typst vers les figures, tableaux et entrées de Annexes.typ. Les versions R des deux histogrammes restent en réserve, commentées.

=== Listes d'espèces et usages

// Liste de la flore régénérée le 02/11/2026 (liste_flore.csv) ; ancien TODO : « TODO : valeurs à produire. La liste définitive de la flore n'a pas été régénérée depuis la réconciliation et les corrections de flore.csv (anciens chiffres du 08/10/2026 conservés en commentaire en fin de sous-section). Seule la richesse des placettes (242 espèces) vient d'une sortie à jour (estimateurs_richesse_gamma.csv). »
Les 28 placettes comptent 242 espèces. La liste de la flore réunit au total 283 espèces : 242 relevées dans les placettes, 18 notées seulement hors des placettes et 23 citées seulement par Romiguière (2025), qui en cite 91 au total (@annexe-flore). Parmi elles, 92 sont rattachées à un nom scientifique, dont 33 d'après les identifications de Romiguière (2025). Les polisin'ala ont décrit plusieurs types pour 95 espèces.
// Source : liste_flore_resume.csv (analyse_usages_cook.R, 02/11/2026). Romiguière (2025) : correspondance des noms validée par l'auteur (referentiels/correspondance-romiguiere-2025.csv). TODO (auteur) : espèces du transfert de gestion de 2004 à ajouter ; niveau de rattachement (espèce, genre, famille) à faire exporter si utile.
// Source : diversite_indeterminees.csv (export ajouté à analyse_diversite_alpha.R le 01/11/2026) ; 1 948 + 51 = 1 999 tiges (structure_resume.csv). Mise à jour du 01/11/2026 : « Valotra / Voamalimpangady » (P06, 2 gaulis) reconnu comme espèce indéterminée (auteur), d'où 51 tiges indéterminées et γ = 242.

Dans la liste de la flore, 64 espèces comptent au moins une tige de DBH $>=$ 5~cm. Les tiges de 2,5 à 5~cm en ajoutent 60, les gaulis 118 et les observations hors placettes 18 (@tab-seuil). Ces étapes portent sur des effectifs très différents, de 137 observations à 1~469 gaulis.
// Source : seuil_diametre_especes_nouvelles.csv (analyse_seuil_diametre.R, 02/11/2026) ; espèces indéterminées exclues.

// TABLEAU : espèces nouvelles par classe de diamètre puis hors placettes.
#figure(
  table(
    columns: (4fr, 1.5fr, 1.5fr, 1.5fr, 1fr),
    align: (left, right, right, right, right),
    inset: 8pt,
    table.header([*Étape (ordre d'ajout)*], [*Tiges ou observations*], [*Espèces présentes*], [*Espèces nouvelles*], [*Cumul*]),
    [Tiges des placettes, DBH $>=$ 5~cm], [154], [64], [64], [64],
    [Tiges des placettes, 2,5 $<=$ DBH < 5~cm], [325], [100], [60], [124],
    [Gaulis des placettes (DBH < 2,5~cm)], [1~469], [214], [118], [242],
    [Hors placettes (grands arbres, observations, phénologie)], [137], [59], [18], [260],
  ),
  caption: [Nombre d'espèces ajoutées à la liste à chaque étape, dans l'ordre indiqué : seules sont comptées comme nouvelles les espèces absentes des étapes précédentes. DBH = CBH / π. Gaulis : effectif compté. Espèces : identités réconciliées, espèces indéterminées exclues.],
) <tab-seuil>
#titre-court(<tab-seuil>)[Espèces nouvelles par classe de diamètre]

Les usages cités par les polisin'ala, au cours de l'étude et lors des relevés de Romiguière (2025), concernent 111 des 283 espèces de la liste ; 11 espèces n'ont que la mention « aucun » et 161 n'ont aucune mention d'usage. La catégorie d'usage de Cook (1995) la plus représentée est celle des matériaux, avec 90 espèces, suivie des médicaments (12 espèces) et des usages sociaux (9 espèces) (@tab-usages).
// Source : usages_cook_categories.csv et usages_cook_resume.csv (analyse_usages_cook.R, 01/11/2026) : usages de flore.csv (via reconciliation-taxonomique.csv et normalisation-usages.csv) réunis avec ceux de liste-especes-usages-types.csv, classés par correspondance-usages-cook.csv.
// Correction du 01/11/2026 : le référentiel du 12/10 seul donnait 52 espèces (36 lignes de flore.csv, surtout P21 à P28, absentes). L'ancien brouillon (08/10) donnait 70.
// Mise à jour du 01/11/2026 : « Hazodandy » ajouté à la réconciliation (espèce propre) et « Valotra / Voamalimpangady » rattaché à « Espèce indéterminée » (auteur) ; usages des grands arbres reportés dans une colonne « usages » de grands-arbres.csv et de l'ODS, et lus par le script ; espèces indéterminées exclues des usages.
// 260 espèces (02/11/2026) : référentiel, relevés et usages réunis, hors « Espèce indéterminée » et la ligne parasite « N/A » du référentiel (auparavant 261).

#figure(
  table(
    columns: (2.5fr, 1fr, 4fr),
    align: (left, right, left),
    inset: 8pt,
    table.header([*Catégorie d'usage (Cook, 1995)*], [*Nombre d'espèces*], [*Usages cités*]),
    [Matériaux], [90], [Balai, batan, bois de construction, canaux d'irrigation, charpente, clôture, colle, construction de maison, corde, fixation de toiture, guitare, manche de bêche, menuiserie, outils, panier, pilon, pirogue, planche, plancher, poteau, poutre, tressage],
    [Médicaments], [12], [Aphrodisiaque, douleurs dentaires, fatigue, gonflements, vertiges, usage médicinal non précisé],
    [Usages sociaux], [9], [Anti-foudre, magie],
    [Alimentation], [3], [Écorce sucrée, fruit comestible, thé],
    [Combustibles], [2], [Bois de chauffage],
    [Usages environnementaux], [2], [Haie],
    [Poisons des non-vertébrés], [1], [Insecticide],
  ),
  caption: [Nombre d'espèces citées pour chaque catégorie d'usage de premier niveau de la classification de Cook (1995) : 111 espèces à usage classé sur les 283 de la liste, d'après les usages recueillis au cours de l'étude et ceux notés par Romiguière (2025) sur ses tiges de Tsiazombazaha ; une espèce peut relever de plusieurs catégories. Les usages cités relèvent du second niveau ; leurs codes figurent en @annexe-codes-cook.],
) <tab-usages>
#titre-court(<tab-usages>)[Usages par catégorie de premier niveau]

Les espèces animales relevées sont au nombre de [X] : [X] observées directement ou indirectement au cours des cheminements, et [X] citées seulement par les sources complémentaires (@annexe-faune). Les traces d'activités humaines rencontrées sont données à titre indicatif : [X].
// TODO (auteur) : aucune annexe ne présente les traces d'activités humaines (l'ancienne annexe « observations » ne contenait que la phénologie, retirée le 02/11/2026) : les décrire ici en une phrase ou retirer la mention, ainsi qu'en M&M.
// TODO : valeurs à tirer de la liste de faune une fois nettoyée (« T1-T2-faune », notes de sortie, transfert de gestion 2004, GBIF, Rajaonson et al., 2010).

// --- Ancien brouillon (chiffres du 08/10/2026, antérieurs à la réconciliation : NE PAS CITER) ---
// Au total, 335 noms vernaculaires normalisés ; 230 identités ; 130 avec une identification botanique au sens large (61 avec un taxon proposé, 69 avec une correspondance vers au moins deux genres).
// Types : 1,60 ± 0,64 par identité (n = 180) ; 86 espèces à un type, 81 à deux, 12 à trois, une à quatre.
// Usages : 70 espèces à usage rapporté et classé (1,27 ± 0,51 usages par espèce) ; matériaux 48, médicaments 11, usages sociaux 9, alimentation 3, combustibles 2, usages environnementaux 2, poisons des non-vertébrés 1.
// #figure(
//   table(
//     columns: (auto, auto, auto),
//     align: (left, center, left),
//     inset: 8pt,
//     [*Catégorie d'usage (Cook, 1995)*], [*Nombre d'espèces*], [*Usages cités*],
//     [Matériaux], [48], [Balai, batan, bois de construction, canaux d'irrigation, construction de maison, corde, fixation de toiture, guitare, manche de bêche, menuiserie, panier, pilon, pirogue, planche, plancher, poutre, tressage],
//     [Médicaments], [11], [Aphrodisiaque, douleurs dentaires, fatigue, gonflements, usage médicinal],
//     [Usages sociaux], [9], [Anti-foudre, magie],
//     [Alimentation], [3], [Écorce sucrée, fruit comestible, thé],
//     [Combustibles], [2], [Bois de chauffage],
//     [Usages environnementaux], [2], [Haie],
//     [Poisons des non-vertébrés], [1], [Insecticide],
//   ),
//   caption: [Répartition des espèces à usage cité par catégorie de premier niveau de la classification de Cook (1995). Les usages cités relèvent du second niveau ; leurs codes figurent en annexe.],
// ) <tab-usages-ancien>

=== Structure forestière

// Source : structure_resume.csv (copie de structure_resume_indices.csv) ; surface : courbe_raréfaction_extrapolation.csv (531,09 m² à 28 placettes) et message du script de structure (531,1 m²).
// Arrondis : deux décimales ; densités à l'hectare arrondies à l'unité (arbitrage auteur, 15/10/2026).
La densité est estimée à 37~569~±~2~552 tiges/ha et la surface terrière à 37,30~±~5,30~m²/ha (moyenne ± erreur-type, n = 28 ; @tab-structure). Avec les huit placettes de Romiguière (2025), la surface terrière est de 41,77~±~4,78~m²/ha (n = 36).
// Source G (36 placettes) : sensibilite_romiguiere.csv (analyse_sensibilite_romiguiere.R, 02/11/2026).
// Écart-type pour la dispersion entre placettes (tiges par placette), erreur-type pour les estimations à l'hectare (N, G) : arbitrage auteur du 01/11/2026 ; erreurType ajouté à resumer() (fonctionsStructure.R) et exporté dans structure_resume_indices.csv.

// Tableau de structure : valeurs de structure_resume.csv (31/10/2026), saisies à la main.
#figure(
  table(
    columns: (2fr, 1.6fr, 1fr, 1fr, 1fr, 1.5fr),
    align: (left, left, right, right, right, right),
    inset: 8pt,
    table.header([*Indicateur (unité)*], [*Placettes*], [*Moyenne*], [*Écart-type*], [*Erreur-type*], [*IC 95 %*]),
    [Tiges par placette (tiges)], [Étude (28)], [71,39], [26,41], [4,99], [[61,15 ; 81,63]],
    [Densité N (tiges/ha)], [Étude (28)], [37~569], [13~506], [2~552], [[32~332 ; 42~806]],
    [Surface terrière G (m²/ha)], [Étude (28)], [37,30], [28,04], [5,30], [[26,43 ; 48,17]],
    [Surface terrière G (m²/ha)], [Étude + Romiguière (36)], [41,77], [28,71], [4,78], [[32,05 ; 51,48]],
  ),
  caption: [Indicateurs de structure forestière. Placettes : les 28 placettes de l'étude, et pour G ces mêmes placettes complétées des 8 placettes de 40 m² de Romiguière (2025), relevées au même seuil (CBH ≥ 8 cm) et non corrigées de la pente ; N n'est pas calculé avec ces dernières, faute de gaulis relevés. Moyenne entre placettes ; écart-type : dispersion entre placettes ; erreur-type de la moyenne ; IC 95 % : intervalle de confiance à 95 % par la loi de Student. Indicateurs rapportés à la surface horizontale. Les gaulis (tiges de plus de 1,30 m de haut et de CBH < 8 cm) sont inclus dans N et exclus de G. Valeurs par placette en @annexe-indices-placettes.],
) <tab-structure>
#titre-court(<tab-structure>)[Indicateurs de structure forestière]
// Ligne N (tiges/m²) non reprise : redondante avec N (tiges/ha) (guide, critère 52) ; CSV : 3,76 ± 1,35 [3,23 ; 4,28].

// Source : 06_ecologie/analyse/sorties/structure_classes_ic95.csv.
La densité décroît de 28~426 tiges/ha dans la classe de diamètre 0-2,5~cm, qui comprend les gaulis, à 528 tiges/ha dans la classe 7,5-10~cm. Au-delà de 10~cm, elle ne dépasse pas 305 tiges/ha et varie irrégulièrement d'une classe à l'autre. Les tiges les plus grosses des placettes, toutes relevées par Romiguière (2025) au-delà de 35~cm, atteignent la classe 45-47,5~cm. Le long des transects, les grands arbres (DBH d'au moins 40~cm) se répartissent de la classe 40-42,5~cm, la plus dense (3,58 arbres/ha), à la classe 95-97,5~cm ; chaque autre classe compte au plus 1,89 arbre/ha (@fig-hist-classes).
// La classe 27,5-30 cm est absente du CSV (aucune tige) : emplacement vide sur l'histogramme.

// FIGURE : histogramme empilé tracé en Typst (01/11/2026). Placettes : analyse-tables/structure_classes_ic95.csv (moyenne entre placettes, IC 95 % de Student) ; transects : analyse-tables/transects_grands_arbres_classes_N.csv (analyse_transects.R, effectif / surface totale prospectée, sans IC). Empilement demandé par l'auteur ; les deux dispositifs ne se recoupent pas (placettes < 35 cm, transects ≥ 40 cm). Échelle logarithmique ; niveaux de gris, sans titre dans l'image.
// Classes de DBH >= 2,5 cm : 28 placettes de l'étude et 8 de Romiguière (2025) ; classe 0-2,5 cm (gaulis) : 28 placettes (analyse_sensibilite_romiguiere.R, 02/11/2026)
#let classesDiam = csv("analyse-tables/sensibilite_romiguiere_classes_N.csv").slice(1).map(r => r.map(float))
#let classesDiamGA = csv("analyse-tables/transects_grands_arbres_classes_N.csv").slice(1).map(r => r.map(float))
#figure(
  {
    set text(size: 8pt)
    let largeur = 14cm
    let hauteur = 7cm
    let marge = 1.6cm
    let nbClasses = 40
    let pas = largeur / nbClasses
    // Échelle logarithmique de 0,1 à 100 000 tiges/ha (6 décades) ; valeurs ≤ 0,1 ramenées à l'axe
    let nbDecades = 6
    let y = v => if v <= 0.1 { 0pt } else { hauteur * (calc.log(v, base: 10) + 1) / nbDecades }
    let graduations = ("0,1", "1", "10", "100", "1\u{202F}000", "10\u{202F}000", "100\u{202F}000")
    let valeurPlacettes = c => {
      let r = classesDiam.find(r => calc.abs(r.at(0) - c) < 0.01)
      if r == none { 0 } else { r.at(1) }
    }
    pad(top: 0.6cm, box(width: largeur + marge + 0.3cm, height: hauteur + 1.4cm, {
      // Grille et graduations de l'axe des ordonnées
      for k in range(nbDecades + 1) {
        let dy = hauteur - hauteur * k / nbDecades
        place(dx: marge, dy: dy, line(length: largeur, stroke: (paint: luma(200), thickness: 0.4pt, dash: "dashed")))
        place(dx: 0pt, dy: dy - 0.5em, box(width: marge - 0.15cm, align(right, graduations.at(k))))
      }
      // Placettes : barres gris clair et IC 95 %
      for r in classesDiam {
        let i = int(calc.round(r.at(0) / 2.5))
        let x = marge + pas * i
        let h = y(r.at(1))
        place(dx: x + pas * 0.1, dy: hauteur - h, rect(width: pas * 0.8, height: h, fill: luma(210), stroke: 0.4pt + black))
        let bas = y(r.at(2))
        let haut = y(r.at(3))
        let cx = x + pas / 2
        place(dx: cx, dy: hauteur - haut, line(start: (0pt, 0pt), end: (0pt, haut - bas), stroke: 0.6pt + black))
        place(dx: cx - pas * 0.3, dy: hauteur - haut, line(length: pas * 0.6, stroke: 0.6pt + black))
        if r.at(2) > 0.1 {
          place(dx: cx - pas * 0.3, dy: hauteur - bas, line(length: pas * 0.6, stroke: 0.6pt + black))
        }
      }
      // Transects : barres gris foncé, empilées sur la valeur des placettes de la même classe
      for r in classesDiamGA {
        let i = int(calc.round(r.at(0) / 2.5))
        let x = marge + pas * i
        let base = valeurPlacettes(r.at(0))
        let h0 = y(base)
        let h1 = y(base + r.at(2))
        place(dx: x + pas * 0.1, dy: hauteur - h1, rect(width: pas * 0.8, height: h1 - h0, fill: luma(80), stroke: 0.4pt + black))
      }
      // Axes
      place(dx: marge, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, hauteur), stroke: 0.6pt + black))
      place(dx: marge, dy: hauteur, line(length: largeur, stroke: 0.6pt + black))
      // Graduations de l'axe des abscisses (tous les 10 cm)
      for k in range(11) {
        let x = marge + pas * 4 * k
        place(dx: x, dy: hauteur, line(start: (0pt, 0pt), end: (0pt, 3pt), stroke: 0.6pt + black))
        place(dx: x - 0.5cm, dy: hauteur + 5pt, box(width: 1cm, align(center, str(10 * k))))
      }
      place(dx: marge, dy: hauteur + 0.75cm, box(width: largeur, align(center)[Diamètre à hauteur de poitrine (cm)]))
      place(dx: 0pt, dy: -0.45cm, box(width: largeur, align(left)[Densité (tiges/ha, échelle logarithmique)]))
      // Légende
      place(dx: marge + largeur - 5.4cm, dy: 0.1cm, {
        set text(size: 7.5pt)
        grid(columns: (0.35cm, auto), column-gutter: 0.15cm, row-gutter: 0.15cm, align: horizon,
          rect(width: 0.35cm, height: 0.25cm, fill: luma(210), stroke: 0.4pt + black), [Placettes (étude et Romiguière, 2025)],
          rect(width: 0.35cm, height: 0.25cm, fill: luma(80), stroke: 0.4pt + black), [Transects (CBH $>=$ 126~cm)],
        )
      })
    }))
  },
  caption: [Densité de tiges par classe de diamètre de 2,5~cm. Gris clair : placettes (moyenne entre placettes ; barres d'erreur : IC 95~% par la loi de Student), soit les 28 placettes de l'étude et les 8 placettes de 40~m² de Romiguière (2025) pour les classes à partir de 2,5~cm, et les seules 28 placettes de l'étude pour la classe 0-2,5~cm, faute de gaulis relevés par Romiguière ; gris foncé : grands arbres des transects (CBH $>=$ 126~cm, soit un DBH d'au moins 40~cm ; effectif rapporté aux 53~050~m² de bande prospectée sur cinq transects, sans intervalle de confiance). Les dispositifs ne se recoupent que dans la classe 45-47,5~cm, où une tige des placettes de Romiguière s'ajoute aux grands arbres. Axe des ordonnées en échelle logarithmique ; les bornes inférieures négatives ou inférieures à 0,1~tige/ha sont ramenées à l'axe, sans trait horizontal. Les gaulis (tiges de plus de 1,30~m de haut et de CBH < 8~cm) sont inclus dans la classe 0-2,5~cm. Données en @annexe-classes-diametre.],
) <fig-hist-classes>
#titre-court(<fig-hist-classes>)[Densité de tiges par classe de diamètre]

// Version R (SVG, échelle symétrique-logarithmique), conservée en réserve :
// #figure(
//   image("analyse-figures/structure_histogramme_classes.svg",
//     alt: "Histogramme de la densité de tiges par classe de diamètre de 2,5 cm, en échelle symétrique-logarithmique : la classe 0-2,5 cm domine, puis la densité décroît vers les grandes classes."),
//   caption: [Densité de tiges par classe de diamètre de 2,5~cm (moyenne entre 28 placettes ; barres : IC 95 % par la loi de Student, tronquées à zéro). Axe des ordonnées en échelle symétrique-logarithmique : linéaire près de zéro, logarithmique au-delà. Les gaulis sont inclus dans la classe 0-2,5~cm. Données en annexe.],
// ) <fig-hist-classes>

// Source : 06_ecologie/analyse/sorties/structure_G_classes.csv.
La surface terrière la plus élevée est celle de la classe 2,5-7,5~cm (10,71~m²/ha), suivie de la classe 22,5-27,5~cm (8,48~m²/ha). Les classes de 27,5 à 47,5~cm ont chacune une surface terrière inférieure à 2,8~m²/ha. Le long des transects, la surface terrière des grands arbres ne dépasse pas 0,68~m²/ha par classe (classe 62,5-67,5~cm) (@fig-G-classes).

// FIGURE : histogramme empilé tracé en Typst (01/11/2026). Placettes : analyse-tables/structure_G_classes.csv (moyenne entre placettes, IC 95 % de Student) ; transects : analyse-tables/transects_grands_arbres_classes_G.csv (analyse_transects.R, somme des g / surface totale prospectée, sans IC). Échelle linéaire ; niveaux de gris, sans titre dans l'image.
// 36 placettes : étude et Romiguière (2025) (analyse_sensibilite_romiguiere.R, 02/11/2026)
#let classesG = csv("analyse-tables/sensibilite_romiguiere_classes_G.csv").slice(1).map(r => r.map(float))
#let classesGGA = csv("analyse-tables/transects_grands_arbres_classes_G.csv").slice(1).map(r => r.map(float))
#figure(
  {
    set text(size: 8pt)
    let largeur = 14cm
    let hauteur = 6cm
    let marge = 1.2cm
    let nbClasses = 19
    let pas = largeur / nbClasses
    let gMax = 16
    // Échelle linéaire de 0 à 16 m²/ha ; bornes négatives ramenées à zéro
    let y = v => if v <= 0 { 0pt } else { hauteur * v / gMax }
    let valeurPlacettes = b => {
      let r = classesG.find(r => calc.abs(r.at(4) - b) < 0.01)
      if r == none { 0 } else { r.at(1) }
    }
    pad(top: 0.6cm, box(width: largeur + marge + 0.3cm, height: hauteur + 1.4cm, {
      // Grille et graduations de l'axe des ordonnées
      for k in range(5) {
        let dy = hauteur - hauteur * k / 4
        place(dx: marge, dy: dy, line(length: largeur, stroke: (paint: luma(200), thickness: 0.4pt, dash: "dashed")))
        place(dx: 0pt, dy: dy - 0.5em, box(width: marge - 0.15cm, align(right, str(4 * k))))
      }
      // Placettes : barres gris clair et IC 95 %
      for r in classesG {
        let i = int(calc.round((r.at(4) - 2.5) / 5))
        let x = marge + pas * i
        let h = y(r.at(1))
        place(dx: x + pas * 0.1, dy: hauteur - h, rect(width: pas * 0.8, height: h, fill: luma(210), stroke: 0.4pt + black))
        let bas = y(r.at(2))
        let haut = y(r.at(3))
        let cx = x + pas / 2
        place(dx: cx, dy: hauteur - haut, line(start: (0pt, 0pt), end: (0pt, haut - bas), stroke: 0.6pt + black))
        place(dx: cx - pas * 0.15, dy: hauteur - haut, line(length: pas * 0.3, stroke: 0.6pt + black))
        if r.at(2) > 0 {
          place(dx: cx - pas * 0.15, dy: hauteur - bas, line(length: pas * 0.3, stroke: 0.6pt + black))
        }
      }
      // Transects : barres gris foncé, empilées sur la valeur des placettes de la même classe
      for r in classesGGA {
        let i = int(calc.round((r.at(0) - 2.5) / 5))
        let x = marge + pas * i
        let base = valeurPlacettes(r.at(0))
        let h0 = y(base)
        let h1 = y(base + r.at(4))
        place(dx: x + pas * 0.1, dy: hauteur - h1, rect(width: pas * 0.8, height: h1 - h0, fill: luma(80), stroke: 0.4pt + black))
      }
      // Axes
      place(dx: marge, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, hauteur), stroke: 0.6pt + black))
      place(dx: marge, dy: hauteur, line(length: largeur, stroke: 0.6pt + black))
      // Graduations de l'axe des abscisses (bornes de classes, une sur deux)
      for k in range(0, nbClasses + 1, step: 2) {
        let x = marge + pas * k
        place(dx: x, dy: hauteur, line(start: (0pt, 0pt), end: (0pt, 3pt), stroke: 0.6pt + black))
        place(dx: x - 0.5cm, dy: hauteur + 5pt, box(width: 1cm, align(center, str(2.5 + 5 * k).replace(".", ","))))
      }
      place(dx: marge, dy: hauteur + 0.75cm, box(width: largeur, align(center)[Diamètre à hauteur de poitrine (cm)]))
      place(dx: 0pt, dy: -0.45cm, box(width: largeur, align(left)[Surface terrière (m²/ha)]))
      // Légende
      place(dx: marge + largeur - 5.4cm, dy: 0.1cm, {
        set text(size: 7.5pt)
        grid(columns: (0.35cm, auto), column-gutter: 0.15cm, row-gutter: 0.15cm, align: horizon,
          rect(width: 0.35cm, height: 0.25cm, fill: luma(210), stroke: 0.4pt + black), [Placettes (étude et Romiguière, 2025)],
          rect(width: 0.35cm, height: 0.25cm, fill: luma(80), stroke: 0.4pt + black), [Transects (CBH $>=$ 126~cm)],
        )
      })
    }))
  },
  caption: [Surface terrière par classe de diamètre de 5~cm, à partir du seuil de mesure de 2,5~cm. Gris clair : placettes (moyenne entre les 28 placettes de l'étude et les 8 placettes de 40~m² de Romiguière, 2025 ; barres d'erreur : IC 95~% par la loi de Student) ; gris foncé : grands arbres des transects (CBH $>=$ 126~cm, soit un DBH d'au moins 40~cm ; surface terrière rapportée aux 53~050~m² de bande prospectée, sans intervalle de confiance). Les placettes de Romiguière ont des tiges dans les classes 37,5-42,5 et 42,5-47,5~cm, qui comptent aussi des grands arbres des transects. Les bornes inférieures négatives sont ramenées à zéro, sans trait horizontal. Les gaulis, non mesurés, sont exclus. Données en @annexe-classes-diametre.],
) <fig-G-classes>
#titre-court(<fig-G-classes>)[Surface terrière par classe de diamètre]

// Version R (SVG), conservée en réserve :
// #figure(
//   image("analyse-figures/structure_G_classes.svg",
//     alt: "Histogramme de la surface terrière par classe de diamètre de 5 cm, de 2,5 à 37,5 cm, avec un maximum dans la première classe et un second dans la classe 22,5-27,5 cm."),
//   caption: [Surface terrière par classe de diamètre de 5~cm, à partir du seuil de mesure de 2,5~cm (moyenne entre 28 placettes ; barres : IC 95 % par la loi de Student, tronquées à zéro). Les gaulis, non mesurés, sont exclus. Données en annexe.],
// ) <fig-G-classes>

// Source : transects_grands_arbres.csv, transects_grands_arbres_resume.csv, transects_chablis.csv (analyse_transects.R, créé et lancé le 01/11/2026).
Le long de 5~305~m de chemins répartis sur cinq transects, soit 53~050~m² de bande prospectée, 77 arbres de CBH $>=$ 126~cm ont été relevés. La densité de grands arbres est estimée à 14,51~±~3,42 arbres/ha (erreur-type).
// ATTENTION : longueur de T19 incertaine (« 300 ? » dans l'ODS) ; la densité de T19 et l'estimation globale en dépendent.

Les chablis n'ont été dénombrés, à ce jour, que le long de deux itinéraires : 2 petits bois (diamètre inférieur à 30~cm) et 5 bois moyens ou gros sur T01 ; 20 petits bois, 20 bois moyens (30 à 60~cm) et 18 gros bois (plus de 60~cm) sur T02. Faute de longueur prospectée, aucune densité n'est calculée.
// TODO (auteur) : mettre à jour ce paragraphe après correction des chablis (définition, transects T19 et T20, longueurs, unité des classes) ; le script analyse_transects.R n'exporte pour l'instant que les effectifs.

// Source : regeneration_resume.csv (analyse_regeneration.R, créé et lancé le 01/11/2026) ; moyenne entre placettes ± erreur-type (arbitrage auteur : valeurs seules, en tiges/m²).
Sur les sept placettes où elle a été comptée, la régénération de moins de 1,30~m de haut compte 5,04~±~0,41 tiges/m² de moins de 30~cm et 2,29~±~0,38 tiges/m² de 30 à 130~cm (moyenne ± erreur-type).
// Piste (auteur) : regrouper ces valeurs dans un tableau de synthèse des caractéristiques de la forêt ?

=== Stock de carbone

// Source : analyse-tables/carbone_stocks.csv (copie de la sortie du 01/11/2026 ; E = 0,10, ρ = 0,58, facteurs MDP, graine 2026).
Les tiges des placettes portent le stock de carbone le plus élevé (112,48~tC/ha, et 146,20~tC/ha avec les placettes de Romiguière, 2025), devant les grands arbres des transects (19,68~tC/ha), le bois mort au sol (6,13~tC/ha) et le bois mort sur pied (2,70~tC/ha) (@tab-carbone). Les volumes de bois mort, au sol et sur pied, sont de 22,47 et 9,92~m³/ha (@annexe-carbone).
// TODO : stock total à l'hectare et stock de la forêt entière — à faire exporter par le script (pas de somme à la main) ; stock de la forêt en attente de la surface QGIS (500 ha provisoires dans le script).
// Longueurs prospectées pour les grands arbres (transects.csv, 01/11/2026, d'après le tableau de l'onglet grands-arbres de l'ODS) : T05 1 940 m, T06 1 800 m, T16 205 m, T19 300 m, T20 1 060 m, soit 53 050 m² (message du script carbone). Les IC des autres compartiments changent légèrement (bootstrap à graine fixe, tirages décalés).
// ATTENTION : T19 = « 300 ? » dans l'ODS (valeur incertaine) ; T16 = 190 m auparavant dans transects.csv, « ~ 205 » dans l'ODS.

// TABLEAU : stocks par compartiment (IC 95 % par bootstrap, 1 000 rééchantillonnages).
#figure(
  table(
    columns: (1.5fr, 1.3fr, 1fr, 1.5fr, 1.5fr),
    align: (left, left, right, right, right),
    inset: 8pt,
    table.header([*Compartiment*], [*Données*], [*Biomasse (tMS/ha)*], [*Carbone (tC/ha)*], [*CO₂ (tCO₂/ha)*]),
    [Tiges des placettes], [Étude (28)], [199,43], [112,48 [75,39 ; 156,52]], [412,80 [276,68 ; 574,42]],
    [Tiges des placettes], [Étude + Romiguière (36)], [259,22], [146,20 [107,49 ; 193,21]], [536,56 [394,49 ; 709,08]],
    [Grands arbres des transects], [Étude], [34,89], [19,68 [13,21 ; 31,18]], [72,22 [48,47 ; 114,43]],
    [Bois mort au sol], [Étude], [13,03], [6,13 [2,58 ; 10,27]], [22,48 [9,48 ; 37,68]],
    [Bois mort sur pied], [Étude], [5,75], [2,70 [0,78 ; 5,08]], [9,92 [2,87 ; 18,64]],
  ),
  caption: [Stocks de biomasse, de carbone et de CO₂ par compartiment. Étude + Romiguière : 28 placettes de l'étude et 8 placettes de 40 m² de Romiguière (2025), même seuil de mesure, non corrigées de la pente. Entre crochets : IC 95 % par bootstrap (1~000 rééchantillonnages des placettes ou des transects). Biomasse vivante : biomasse aérienne seule ; le carbone et le CO₂ du vivant incluent la biomasse souterraine ($R = "0,20"$). Paramètres : $E = "0,10"$, $rho = "0,58"$~g/cm³, $"CF" = "0,47"$. Volumes et IC de la biomasse en @annexe-carbone.],
) <tab-carbone>
#titre-court(<tab-carbone>)[Stocks de carbone par compartiment]

=== Diversité alpha

// Source : diversite_alpha_resume.csv ; valeurs par placette : 06_ecologie/analyse/sorties/diversite_alpha_placettes.csv.
Une placette compte en moyenne 29,29~±~6,28 espèces, pour un indice de Shannon de 3,03~±~0,27 (moyenne ± écart-type, n = 28 ; @tab-div-alpha). L'écart-type entre placettes est le plus élevé pour l'alpha de Fisher. Les indices de chaque placette figurent en @annexe-indices-placettes.
// ¹D et ²D en forme brute (arbitrage auteur, 01/11/2026) ; ²D recalculé (1 / Σp²) dans fonctionsDiversite.R, alpha relancé le 01/11/2026. L'ancienne valeur corrigée (22,05) était supérieure à ¹D.

// TABLEAU : indices alpha (moyenne ± écart-type, IC 95 %, n = 28).
#figure(
  table(
    columns: (1.5fr, 1fr, 1fr),
    align: (left, right, right),
    inset: 8pt,
    table.header([*Indice (unité)*], [*Moyenne ± écart-type (n = 28)*], [*IC 95 %*]),
    [Richesse spécifique S = ⁰D (espèces)], [29,29 ± 6,28], [[26,85 ; 31,72]],
    [Indice de Shannon H′ (sans unité)], [3,03 ± 0,27], [[2,93 ; 3,13]],
    [exp(H′) = ¹D (espèces communes effectives)], [21,38 ± 5,37], [[19,29 ; 23,46]],
    [²D, inverse de Simpson (espèces dominantes effectives)], [15,93 ± 4,65], [[14,13 ; 17,74]],
    [Alpha de Fisher (sans unité)], [22,01 ± 9,32], [[18,40 ; 25,62]],
  ),
  caption: [Indices de diversité alpha par placette : moyenne entre 28 placettes ± écart-type ; IC 95 % par la loi de Student. Abondances : toutes les tiges comptées (tiges mesurées et gaulis), tiges indéterminées exclues. ¹D et ²D sous leur forme brute. Espèces : identités réconciliées. Valeurs par placette en @annexe-indices-placettes.],
) <tab-div-alpha>
#titre-court(<tab-div-alpha>)[Indices de diversité alpha]

=== Diversité bêta

// Sources : diversite_beta_resume_rapport.csv, diversite_beta_resume.csv, diversite_beta_whittaker.csv, diversite_beta_bray_niveaux.csv, diversite_beta_mono_commune.csv.
La richesse de l'ensemble des placettes ($gamma$ = 242 espèces) est 8,26 fois plus élevée que la richesse moyenne d'une placette ($macron(alpha)$ = 29,29 espèces). Le bêta additif est de 212,71 espèces. La dissimilarité de Bray-Curtis moyenne entre les 378 paires de placettes est de 0,81~±~0,09 (moyenne ± écart-type).

L'ordination NMDS a un stress de 0,23 (@fig-beta-nmds). [Description de la disposition des placettes par itinéraire.]
// TODO (à faire, auteur) : lire la figure NMDS (SVG du 31/10/2026) et décrire la disposition des placettes par itinéraire ; coordonnées dans diversite_beta_nmds_points.csv.

// FIGURE : ordination NMDS des 28 placettes, un symbole par itinéraire.
#figure(
  image("analyse-figures/diversite_beta_nmds.svg",
    alt: "Plan d'ordination NMDS à deux dimensions des 28 placettes, un symbole par itinéraire."),
  caption: [Ordination NMDS en deux dimensions des 28 placettes, sur la dissimilarité de Bray-Curtis (abondances, espèces réconciliées) ; stress = 0,23. Deux points proches correspondent à des placettes de composition proche. Chaque symbole représente un itinéraire. Coordonnées en @annexe-beta.],
) <fig-beta-nmds>
#titre-court(<fig-beta-nmds>)[Ordination NMDS des placettes]

Pour les deux indices, les dissimilarités moyennes sont les plus faibles entre placettes d'un même itinéraire (Jaccard : 0,71~±~0,07, moyenne ± écart-type, 37 paires), puis entre placettes d'un même polisin'ala (0,74~±~0,09, 16 paires). Elles sont voisines entre placettes d'une même commune et de communes différentes (@tab-beta-niveaux).
// Jaccard « même commune » = 0,885 dans le CSV (trois décimales) ; arrondi à 0,89 (arbitrage auteur, 02/11/2026).
// Comparaison descriptive seulement (paires non indépendantes, M&M) : aucun test cité.

// TABLEAU : dissimilarités moyennes (± écart-type) par niveau partagé.
#figure(
  table(
    columns: (5fr, 1fr, 2fr, 2fr),
    align: (left, right, right, right),
    inset: 8pt,
    table.header([*Niveau partagé par la paire*], [*Paires*], [*Jaccard*], [*Bray-Curtis*]),
    [Même itinéraire], [37], [0,71 ± 0,07], [0,64 ± 0,10],
    [Même polisin'ala (itinéraires différents)], [16], [0,74 ± 0,09], [0,76 ± 0,06],
    [Même commune (polisin'ala différents)], [70], [0,89 ± 0,04], [0,83 ± 0,07],
    [Communes différentes], [255], [0,86 ± 0,04], [0,83 ± 0,06],
  ),
  caption: [Dissimilarités moyennes ± écart-type entre paires de placettes selon le niveau le plus fin qu'elles partagent. Jaccard : présence-absence ; Bray-Curtis : abondances ; espèces réconciliées. Comparaison descriptive : les paires ne sont pas indépendantes.],
) <tab-beta-niveaux>
#titre-court(<tab-beta-niveaux>)[Dissimilarités par niveau partagé]
// Vérifié dans analyse_diversite_beta.R (01/11/2026) : case_when ordonné (même transect > même polisin'ala > même commune > communes différentes), chaque paire est classée au niveau le plus fin qu'elle partage ; les niveaux sont exclusifs.

// Figure retirée (02/11/2026, choix de l'auteur) : redondante avec le tableau par niveau ; fichier conservé dans analyse-figures.
// // FIGURE : boîtes à moustaches de la dissimilarité de Jaccard par niveau (sans étoiles de significativité, figure du 31/10/2026).
// #figure(
//   image("analyse-figures/diversite_beta_gradient.svg",
//     alt: "Boîtes à moustaches de la dissimilarité de Jaccard entre paires de placettes, pour quatre niveaux ordonnés du même itinéraire aux communes différentes."),
//   caption: [Dissimilarité de Jaccard (présence-absence, espèces réconciliées) entre paires de placettes selon le niveau partagé : même itinéraire (37 paires), même polisin'ala (16), même commune (70), communes différentes (255). Boîtes : quartiles ; trait : médiane ; moustaches : valeurs extrêmes dans la limite de 1,5 fois l'écart interquartile ; points : valeurs au-delà.],
// ) <fig-beta-gradient>
// #titre-court(<fig-beta-gradient>)[Dissimilarité de Jaccard par niveau partagé]
// Moustaches : geom_boxplot sans argument coef (défaut ggplot2 : 1,5 × IQR), vérifié le 01/11/2026.

Sur les 242 espèces, 69,4~% ne sont observées que dans une seule commune, contre 49,4~% en moyenne lorsque les communes sont réattribuées au hasard aux placettes (999 permutations ; $p$ = 0,001).
// La ligne « noms vernaculaires bruts » du CSV (80,6 % contre 61,7 %) est un contrôle de la réconciliation : à citer en Discussion si besoin, pas ici.

=== Espèces dominantes

// Source : ivi_especes.csv (31/10/2026, relancé le 01/11/2026 après passage en gaulis des tiges de 7 cm de P06). IVI sur 100.
Le classement porte sur 124 espèces, représentées par 479 tiges mesurées dans les 28 placettes, hors tiges indéterminées. L'IVI le plus élevé est celui de Babogna (6,59), devant Ambora (5,03) et Hazomainty (4,96) (@tab-ivi). Babogna a aussi la dominance relative la plus forte (9,96~%) et la fréquence relative la plus forte (4,59~%, 14 placettes) ; la densité relative la plus forte est celle de Hazomainty (6,05~%, 29 tiges). Six espèces ont un IVI supérieur à 3,5 ; l'IVI est inférieur à 1,5 à partir du rang 19.

Les trois composantes divergent pour certaines espèces. Ramiavogna et Sary, avec deux tiges chacune, ont une dominance relative de 5,00~% et de 4,50~%. Hasina, présente dans 12 placettes, a une fréquence relative de 3,93~% pour une dominance relative de 1,26~%. Cinquante-quatre espèces ne sont représentées que par une tige mesurée et 66 ne sont présentes que dans une placette ; à partir du rang 66, aucune espèce ne compte plus de deux tiges mesurées. Le classement complet figure en @annexe-ivi.

// TABLEAU : les quinze espèces de plus fort IVI.
#figure(
  table(
    columns: (1fr, 3fr, 1.5fr, 1.5fr, 1.5fr, 2fr),
    align: (right, left, right, right, right, right),
    inset: 8pt,
    table.header([*Rang*], [*Espèce*], [*DR (%)*], [*DoR (%)*], [*FR (%)*], [*IVI*]),
    [1], [Babogna], [5,22], [9,96], [4,59], [6,59],
    [2], [Ambora], [4,59], [7,23], [3,28], [5,03],
    [3], [Hazomainty], [6,05], [4,55], [4,26], [4,96],
    [4], [Menafatagna], [4,59], [5,03], [3,61], [4,41],
    [5], [Voapaka], [2,92], [5,87], [2,62], [3,80],
    [6], [Tsimahamasasokona], [4,38], [3,35], [3,61], [3,78],
    [7], [Randripody], [3,76], [1,33], [3,28], [2,79],
    [8], [Hasina], [3,13], [1,26], [3,93], [2,78],
    [9], [Hazombary], [3,55], [2,41], [1,64], [2,53],
    [10], [Sagnira], [1,67], [3,48], [1,64], [2,26],
    [11], [Kijy], [1,46], [3,24], [1,97], [2,22],
    [12], [Ramiavogna], [0,42], [5,00], [0,66], [2,02],
    [13], [Sary], [0,42], [4,50], [0,66], [1,86],
    [14], [Tsirika], [2,71], [0,62], [1,97], [1,77],
    [15], [Kabokala], [0,63], [3,63], [0,98], [1,75],
  ),
  caption: [Les quinze espèces de plus fort indice de valeur d'importance (IVI) sur l'ensemble du dispositif (28 placettes ; 479 tiges mesurées, gaulis et tiges indéterminées exclus). DR : densité relative ; DoR : dominance relative (part de la surface terrière) ; FR : fréquence relative (part des occurrences en placette). IVI = (DR + DoR + FR) / 3, la somme sur les 124 espèces valant 100. Espèces : identités réconciliées. Classement complet en @annexe-ivi.],
) <tab-ivi>
#titre-court(<tab-ivi>)[Les quinze espèces de plus fort IVI]

=== Richesse spécifique totale

// Sources : estimateurs_richesse_gamma.csv ; 06_ecologie/analyse/sorties/courbe_raréfaction_extrapolation.csv.
Les 28 placettes totalisent 242 espèces observées. Tous les estimateurs donnent une richesse supérieure, de 285,83 espèces (bootstrap) à 382,00 espèces (jackknife d'ordre 2). Chao2, estimateur principal, donne 331,16 espèces (IC 95~% : [295,46~; 390,70]) ; toutes les autres estimations, sauf celle du bootstrap, sont comprises dans cet intervalle (@tab-gamma).

// TABLEAU : estimateurs de la richesse totale.
#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: (left, left, right, right),
    inset: 8pt,
    table.header([*Estimateur*], [*Modèle (unité)*], [*Estimation (espèces)*], [*IC 95 %*]),
    [Chao2 (principal)], [Incidence (placette)], [331,16], [[295,46 ; 390,70]],
    [Jackknife d'ordre 1], [Incidence (placette)], [337,46], [[293,77 ; 381,16]],
    [Jackknife d'ordre 2], [Incidence (placette)], [382,00], [[343,43 ; 435,23]],
    [ICE], [Incidence (placette)], [365,80], [[324,92 ; 426,81]],
    [Bootstrap], [Incidence (placette)], [285,83], [[262,64 ; 309,01]],
    [Chao1], [Abondance (tige)], [298,66], [[273,52 ; 343,87]],
    [ACE], [Abondance (tige)], [315,49], [[297,90 ; 333,08]],
  ),
  caption: [Estimateurs asymptotiques de la richesse spécifique totale (28 placettes ; richesse observée $gamma_"obs"$ = 242 espèces, identités réconciliées, tiges indéterminées exclues). Chao2 est l'estimateur principal ; les autres sont donnés à titre de comparaison. IC 95 % : transformation logarithmique pour Chao2, Chao1 (iNEXT), jackknife d'ordre 2 et ICE (SpadeR) ; approximation normale (± 1,96 erreur-type) pour le jackknife d'ordre 1, le bootstrap et ACE (vegan).],
) <tab-gamma>
#titre-court(<tab-gamma>)[Estimateurs de la richesse totale]
// Méthode des IC vérifiée dans estimation_richesse_specifique.R (02/11/2026) : ChaoRichness (iNEXT) pour Chao1 et Chao2, ChaoSpecies (SpadeR) pour ICE et jackknife 2, estimation ± 1,96 × erreur-type (specpool/estimateR de vegan) pour jackknife 1, bootstrap et ACE. Le commentaire du script « IC exact » pour Chao1 ne correspond pas : ChaoRichness donne un intervalle log-transformé.

À 28 placettes (531,1~m²), la couverture d'échantillonnage est de 0,88 (IC 95~% : [0,87~; 0,90]). Extrapolée à 112 placettes, soit quatre fois la surface prospectée (2~124~m²), la richesse atteint 327,76 espèces ([290,28~; 365,24]) pour une couverture de 0,996 (@fig-rarefaction).
// Script relancé le 01/11/2026 sans titre ni sous-titre dans la figure (accord de l'auteur) : estimateurs inchangés ; IC de la raréfaction-extrapolation légèrement modifiés (bootstrap iNEXT sans graine).
// TODO (à faire, auteur) : lire la courbe et décrire sa forme (plateau ou non).

// FIGURE : courbe de raréfaction-extrapolation (incidence, q = 0).
#figure(
  image("analyse-figures/courbe_raréfaction_extrapolation.svg",
    alt: "Courbe de richesse spécifique en fonction du nombre de placettes, interpolée jusqu'à 28 placettes puis extrapolée jusqu'à 112 placettes, avec sa bande de confiance ; axe secondaire en surface horizontale cumulée."),
  caption: [Richesse spécifique (modèle d'incidence, ordre $q$ = 0) en fonction du nombre de placettes : interpolation de 1 à 28 placettes (trait pointillé : 28 placettes, 242 espèces), puis extrapolation jusqu'à 112 placettes, soit quatre fois l'effort réalisé. Axe supérieur : surface horizontale cumulée correspondante, à raison de 18,97~m² par placette en moyenne (531,1~m² pour 28 placettes ; 2~124~m² pour 112). Bande grise : IC 95~% par bootstrap. Données en @annexe-richesse.],
) <fig-rarefaction>
#titre-court(<fig-rarefaction>)[Courbe de raréfaction-extrapolation]