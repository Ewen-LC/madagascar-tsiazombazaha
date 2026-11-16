#import "titres-courts.typ": titre-court

#pagebreak(weak: true)
= Résultats

// TODO (auteur) : développement de la revue à arbitrer (apport de chaque document retenu : colonne du tableau ou paragraphe de synthèse ?).
== Revue de la littérature <res-revue>
Les enregistrements ont été écartés pour trois motifs~: doublons, forêt homonyme et forêt non localisable (@fig-prisma). Huit documents ont été retenus, dont sept ont pu être récupérés.

// Diagramme PRISMA 2020 (Page et al., 2021), tracé en Typst ; effectifs par base, sans total.
#let boitePrisma(corps) = rect(width: 100%, inset: 6pt, stroke: 0.6pt + black, align(left, corps))
#let phasePrisma(corps, lignes: 1) = grid.cell(rowspan: lignes, fill: luma(220), inset: 4pt, align(center + horizon, corps))
#let entetePrisma(corps, colonnes: 1) = grid.cell(colspan: colonnes, fill: luma(220), inset: 4pt, align(center + horizon, strong(corps)))
#let pointeBas = polygon(fill: black, stroke: none, (0pt, 0pt), (9pt, 0pt), (4.5pt, 7pt))
#let flecheBas = align(center, box(width: 9pt, height: 14pt, {
  place(dx: 3.9pt, rect(width: 1.2pt, height: 8pt, fill: black, stroke: none))
  place(dy: 7pt, pointeBas)
}))
#let flecheDroite = align(center + horizon, box(width: 14pt, height: 9pt, {
  place(dy: 3.9pt, rect(width: 8pt, height: 1.2pt, fill: black, stroke: none))
  place(dx: 7pt, polygon(fill: black, stroke: none, (0pt, 0pt), (0pt, 9pt), (7pt, 4.5pt)))
}))

Trois des documents retenus rapportent des relevés naturalistes dans la forêt (@tab-revue-documents). Rajaonson et al. (2010) y ont recherché les lémuriens pendant une journée, le 25 janvier 2009, et n'y ont trouvé que deux espèces, _Avahi laniger_ et _Eulemur rufus_. Romiguière (2025) y a relevé la flore ligneuse sur huit placettes (voir Matériel et méthodes, « Données complémentaires »). Le document de transfert de gestion de 2004 contient des listes d'espèces végétales et animales.
// Banque mondiale (2021) : tableau 96, p. 235 du PDF (02_Bibliographie/articles/revue-tzba-mentiondevlpttourisme.pdf, lu le 03/11/2026) ; seule mention de Tsiazombazaha dans les 436 pages. Cette étude foncière renseigne aussi l'organisation sociale des communes riveraines. Chez les Antemoro, le _tranobe_ désigne à la fois le lignage, la grande maison sacrée où il accomplit les rituels ancestraux et son grand tombeau~; au milieu des années 2000, ces lignages étaient au nombre de treize, chacun représenté par un chef, l'_ampazaka_ (Müller et Evers, s. d.).
// ATTENTION : graphie « ampazaka » retenue partout (auteur, 02/11/2026) ; vérifier la graphie employée par Müller et Evers (s. d.) (« ampanjaka » auparavant).
// REF? Müller, D. F. & Evers, S. J. T. M. (s. d.). Case studies of land access practices in Fianarantsoa province, Madagascar. VU University Amsterdam. — lu (note 70, p. 3) ; terrain de 2006 ; support de publication et année à identifier (le chapitre IRD d'OpenEdition proposé le 01/11/2026 est un autre texte : Moreau, 2005).
// TODO : vérifier auprès des enquêtés ou d'Inter Aide que le nombre de lignages et leur organisation sont toujours d'actualité.
// Rajaonson et al. (2010), p. 37 (lu le 01/11/2026) : forêt visitée le 25/01/2009 (une journée), aucun bambou ; nomenclature de la source (« Eulemur rufus »).
// Romiguière (2025) : huit placettes de 40 m² (M&M, « Données complémentaires ») ; deux semaines exploratoires à Tsiazombazaha, trois mois à Vorovoka (auteur, 01/11/2026).
// TODO : nombre d'espèces citées par le transfert de gestion de 2004 et par Romiguière (2025), une fois les listes consolidées.
// GBIF : recherche à part, directement sur le site du GBIF, hors revue PRISMA (auteur, 01/11/2026) ; les occurrences sont présentées avec la liste de la faune. Le projet de stage mentionne 205 occurrences d'un inventaire d'octobre 2008 (« Mollusques (2008) » de l'ancienne esquisse ?) : TODO, à revérifier sur le GBIF avant de citer.

// Placée avant le tableau 3, sans flottement (demande de l'auteur, 09/11/2026).
#figure(
  placement: none,
  {
    set text(size: 8pt)
    set par(justify: false, leading: 0.5em, first-line-indent: 0pt)
    grid(
      columns: (1.4cm, 1fr, 0.6cm, 1fr, 0.3cm, 0.45fr, 0.45fr),
      row-gutter: 0.1cm,
      align: horizon,
      [], entetePrisma(colonnes: 3)[Identification par les bases bibliographiques], [], entetePrisma(colonnes: 2)[Identification par d'autres méthodes],
      // Identification
      phasePrisma[Identi\-fication],
      boitePrisma[Enregistrements identifiés :\ Google Scholar (n = 18)\ Web of Science (n = 0)\ Internet Archive Scholar (n = 15)\ RefSeek (n = 8)],
      flecheDroite,
      boitePrisma[Enregistrements retirés avant la sélection, doublons :\ Google Scholar (n = 4)\ Internet Archive Scholar (n = 6)\ RefSeek (n = 6)],
      [],
      grid.cell(colspan: 2, boitePrisma[Documents identifiés :\ moteur de recherche Google (n = 1)\ documents internes d'Inter Aide (n = 3)]),
      // Flèche longue des autres méthodes : bord droit de la demi-colonne gauche, pointe en bas
      [], flecheBas, [], [], [],
      grid.cell(rowspan: 3, stroke: (right: 1.2pt + black), place(bottom + right, dx: 4.5pt, pointeBas)), grid.cell(rowspan: 3, []),
      // Sélection
      phasePrisma(lignes: 5)[Sélection],
      boitePrisma[Enregistrements examinés (titre et résumé) :\ Google Scholar (n = 14)\ Internet Archive Scholar (n = 9)\ RefSeek (n = 2)],
      flecheDroite,
      boitePrisma[Enregistrements exclus :\ forêt homonyme (n = 11~; 5~; 1)\ forêt non localisable (n = 1~; 3~; 0)],
      [],
      flecheBas, [], [], [],
      boitePrisma[Documents recherchés pour récupération :\ Google Scholar (n = 2)\ Internet Archive Scholar (n = 1)\ RefSeek (n = 1)],
      flecheDroite,
      boitePrisma[Documents non récupérés :\ Internet Archive Scholar (n = 1)],
      [],
      grid.cell(colspan: 2, boitePrisma[Documents recherchés pour récupération (n = 4)\ Documents non récupérés (n = 0)]),
      flecheBas, [], [], [], grid.cell(colspan: 2, flecheBas),
      boitePrisma[Documents évalués pour l'éligibilité (texte intégral) :\ Google Scholar (n = 2)\ RefSeek (n = 1)],
      flecheDroite,
      boitePrisma[Documents exclus (n = 0)],
      [],
      grid.cell(colspan: 2, boitePrisma[Documents évalués pour l'éligibilité (n = 4)\ Documents exclus (n = 0)]),
      // Inclusion
      [], flecheBas, [], [], [], grid.cell(colspan: 2, flecheBas),
      phasePrisma[Inclusion],
      grid.cell(colspan: 6, boitePrisma[Documents retenus~: n = 8, dont 7 récupérés (@tab-revue-documents)]),
    )
  },
  caption: [Diagramme de sélection des documents portant sur la forêt de Tsiazombazaha, selon la déclaration PRISMA 2020 (Page et al., 2021). Requête~: « Tsiazombazaha », avril 2026. Pour les exclusions, les effectifs sont ceux de Google Scholar, d'Internet Archive Scholar et de RefSeek, dans cet ordre.],
) <fig-prisma>
#titre-court(<fig-prisma>)[Diagramme PRISMA de la revue de littérature]

#figure(
  placement: none,
  table(
    columns: (3fr, 2fr, 2fr, 4fr, 1fr),
    align: (left, left, left, left, center),
    inset: 6pt,
    table.header([*Document*], [*Type*], [*Source*], [*Contenu relatif à la forêt*], [*Récupéré*]),
    [Müller et Evers (s. d.)], [Article], [Google Scholar], [Foncier dans les communes riveraines de la forêt], [Oui],
    [Rajaonson et al. (2010)], [Article scientifique], [Google Scholar], [Lémuriens~: une journée de prospection dans la forêt], [Oui],
    [Ramanarana (2005)], [Mémoire], [Internet Archive Scholar], [Potentiel écotouristique de la forêt, pour l'association FIANTSO], [Non],
    [Banque mondiale (2021)], [Rapport de projet], [RefSeek], [Mention de la forêt parmi les sites touristiques proposés lors d'une consultation publique à Manakara, d'accès jugé difficile], [Oui],
    [Champion et al. (s. d.)], [Article de blog], [Google], [Mention d'un cas litigieux d'exploitation de la forêt], [Oui],
    [Romiguière (2025)], [Mémoire], [Documents internes], [Étude socio-écologique des fragments de Vorovoka et de Tsiazombazaha, pour Inter Aide], [Oui],
    [VOI Maharitra (2004)], [Document officiel], [Documents internes], [Transfert de gestion de la forêt au VOI Maharitra], [Oui],
    [VOI Maharitra (2025)], [Document officiel], [Documents internes], [Renouvellement du transfert de gestion], [Oui],
  ),
  caption: [Documents retenus par la revue de littérature sur la forêt de Tsiazombazaha.],
) <tab-revue-documents>
#titre-court(<tab-revue-documents>)[Documents retenus par la revue de littérature]
// Blog : https://www.anthropologieenligne.com/pages/zafimahavitaM.html (Champion et al., s. d.) ; entrées des documents du tableau complétées dans bibliographie.yml (09/11/2026).


== Analyse des données écologiques

=== Description de la forêt

// TODO (autre rédacteur) : saisir dans le tableau des résultats les surfaces issues des couches QGIS (script carte2_territoire.py, 03/11/2026, UTM 38 S) : périmètre transféré 973 ha ; zones de droit d'usage 52 ha ; forêt dans le périmètre 618 ha (classification Sentinel-2 du 6 mai 2026, foret_2026_sentinel2_perimetre.gpkg, qui remplace depuis le 04/11/2026 le contour « très grossier » de 596 ha). Ces valeurs diffèrent des 1 068 ha (périmètre) et ~640 ha (massif) utilisés ailleurs dans le rapport : trancher avant publication.

// Interprétation en discussion ?
// pente moyenne = foret située sur des collines, comme le reste de la matrice agricole
// faible hauteur et ouverture : typique makgahce + forêt très perturbée
*Caractéristiques des placettes.* La pente médiane des placettes est de 21,5~% (de 0 à 53~%). Le couvert forestier est majoritairement ouvert et bas, avec des recouvrements autour de 25 à 50~% et la présence d'un arbre supérieur à 10 mètres de hauteur dans seulement 17 placettes. L'humus se présente sous des formes plus ou moins dynamiques de mull, et le sol est sec dans 25 placettes. Lichens et lianes sont abondants, épiphytes, mousses et champignons peu fréquents (@tab-caracteristiques-placettes~; @fig-photo-canopee~; détail par placette en @annexe-caracteristiques-placettes).

#let caracPlac = csv("analyse-tables/placettes-caracteristiques-resume.csv").slice(1)
#let caracVariables = caracPlac.map(r => r.at(0)).dedup()
#figure(
  table(
    columns: (3fr, 7fr),
    align: (left, left),
    inset: 6pt,
    table.header([*Caractéristique*], [*Classes (nombre de placettes)*]),
    ..caracVariables.map(v => (
      v,
      caracPlac.filter(r => r.at(0) == v).map(r => r.at(2) + " (" + r.at(3).replace(".", ",") + ")").join(" ; "),
    )).flatten(),
  ),
  caption: [Caractéristiques des 28 placettes~: nombre de placettes par classe~; pour le recouvrement de la canopée, nombre de quadrants (4 par placette, 112 au total)~; pour la pente, minimum, médiane et maximum (%). Épiphytes, mousses, lichens, lianes et champignons~: nombre d'arbres porteurs. Sec~: sol sec. NA~: non noté.],
) <tab-caracteristiques-placettes>
#titre-court(<tab-caracteristiques-placettes>)[Caractéristiques des placettes]

#figure(
  grid(
    columns: 2,
    column-gutter: 0.4cm,
    row-gutter: 0.2cm,
    image("images/ouverture-canopee-typique.jpg", height: 7.5cm, alt: "Vue vers le ciel à travers une canopée ouverte : quelques houppiers séparés par de larges trouées."),
    image("images/ouverture-canopee-pres-ruisseau.jpg", height: 7.5cm, alt: "Vue vers le ciel près d'un ruisseau : grandes feuilles et palmes au premier plan, ciel visible entre les houppiers."),
    text(size: 10pt)[(a)], text(size: 10pt)[(b)],
  ),
  kind: image,
  caption: [La canopée de la forêt de Tsiazombazaha est très ouverte~: (a) en cœur de forêt (S20, 15~septembre 2026)~; (b) près d'un ruisseau, en bordure de forêt (S21, 16~septembre 2026).],
) <fig-photo-canopee>
#titre-court(<fig-photo-canopee>)[Ouverture de la canopée]

*Listes d'espèces et usages.* Les 28 placettes comptent 242 espèces. Abaisser le seuil de précomptage de 5 à 2,5~cm double presque le nombre d'espèces relevées parmi les tiges mesurées (@tab-seuil). Avec les autres sources, la liste de la flore réunit au total 303 espèces (@annexe-flore). Parmi elles, 120 sont rattachées à un nom scientifique. Les _polisinala_ ont décrit plusieurs types pour 53 espèces.
// Source : liste-flore-resume.csv (analyse-usages-cook.R, 02/11/2026). Romiguière (2025) : correspondance des noms validée par l'auteur (referentiels/correspondance-romiguiere-2025.csv). TODO (auteur) : espèces du transfert de gestion de 2004 à ajouter ; niveau de rattachement (espèce, genre, famille) à faire exporter si utile.
// Source : diversite-indeterminees.csv (analyse-diversite-alpha.R) ; 1 948 + 51 = 1 999 tiges (structure-resume.csv). « Valotra / Voamalimpangady » (P06, 2 gaulis) compté comme espèce indéterminée (auteur), d'où 51 tiges indéterminées et γ = 242.
// Source : seuil-diametre-especes-nouvelles.csv (analyse-seuil-diametre.R, 02/11/2026) ; espèces indéterminées exclues.

// TABLEAU : espèces nouvelles par classe de diamètre puis hors placettes.
#figure(
  table(
    columns: (6cm, auto, auto, auto, auto),
    align: (left, right, right, right, right),
    inset: 8pt,
    table.header([*Catégorie*], [*Effectif*], [*Espèces*], [*Dont nouvelles*], [*Total cumulé*]),
    [Placettes~: tiges de DBH $>=$ 5~cm], [154], [64], [64], [64],
    [Placettes~: tiges de DBH de 2,5 à 5~cm], [325], [100], [60], [124],
    [Placettes~: gaulis], [1~469], [214], [118], [242],
    [Hors placettes~: grands arbres, observations, phénologie], [137], [59], [18], [260],
    [Autres sources~: Romiguière (2025), transfert de gestion (2004)], [–], [–], [43], [303],
  ),
  caption: [Nombre d'espèces ajoutées à la liste de la flore à chaque étape, dans l'ordre indiqué~: seules sont comptées comme ajoutées les espèces absentes des étapes précédentes. Effectif~: tiges mesurées, gaulis comptés ou observations~; non applicable aux autres sources (–). Espèces~: noms vernaculaires réconciliés, et non espèces botaniques~; espèces indéterminées exclues.],
) <tab-seuil>
#titre-court(<tab-seuil>)[Espèces nouvelles par classe de diamètre]

Des usages sont cités pour 117 des 303 espèces de la liste. L'usage comme matériau domine largement, avec 96 espèces (@tab-usages).
// Source : usages-cook-categories.csv et usages-cook-resume.csv (analyse-usages-cook.R, 01/11/2026) : usages de flore.csv (via reconciliation-taxonomique.csv et normalisation-usages.csv) réunis avec ceux de liste-especes-usages-types.csv, classés par correspondance-usages-cook.csv.
// 260 espèces : référentiel, relevés et usages réunis, hors « Espèce indéterminée » et la ligne parasite « N/A » du référentiel.

#figure(
  table(
    columns: (2.5fr, 1fr, 4fr),
    align: (left, right, left),
    inset: 8pt,
    table.header([*Catégorie d'usage (Cook, 1995)*], [*Nombre d'espèces*], [*Usages cités*]),
    [Matériaux], [96], [Balai, _batan_, bois de construction, canaux d'irrigation, charpente, clôture, colle, construction de maison, corde, fixation de toiture, guitare, manche de bêche, menuiserie, outils, panier, pilon, pirogue, planche, plancher, poteau, poutre, sculpture, tressage],
    [Médicaments], [12], [Aphrodisiaque, douleurs dentaires, fatigue, gonflements, vertiges, usage médicinal non précisé],
    [Usages sociaux], [9], [Antifoudre, magie],
    [Alimentation], [4], [Écorce sucrée, fruit comestible, source d'eau, thé],
    [Combustibles], [2], [Bois de chauffage],
    [Usages environnementaux], [2], [Haie],
    [Poisons des non-vertébrés], [1], [Insecticide],
  ),
  caption: [Nombre d'espèces citées pour chaque catégorie d'usage de premier niveau de la classification de Cook (1995)~: 117 espèces à usage classé sur les 303 de la liste, d'après les usages recueillis au cours de l'étude, ceux notés par Romiguière (2025) sur ses tiges de Tsiazombazaha et ceux du transfert de gestion de 2004~; une espèce peut relever de plusieurs catégories. Espèces~: noms vernaculaires réconciliés. Les usages cités relèvent du second niveau~; leurs codes figurent en @annexe-codes-cook.],
) <tab-usages>
#titre-court(<tab-usages>)[Usages par catégorie de premier niveau]

92 taxons animaux sont recensés (@annexe-faune)~: 13 observés directement ou indirectement au cours des cheminements, 49 cités par le transfert de gestion (2004), 2 par Rajaonson et al. (2010) et 28 par le GBIF @gbif_2026. 

=== Structure forestière et stock de carbone

// Source : structure-resume.csv (copie de structure-resume-indices.csv) ; surface : courbe-rarefaction-extrapolation.csv (531,09 m² à 28 placettes) et message du script de structure (531,1 m²).
// Arrondis : deux décimales ; densités à l'hectare arrondies à l'unité (arbitrage auteur, 15/10/2026).
*Structure forestière.* La densité est estimée à 37~600~±~2~600 tiges/ha et la surface terrière à 37,3~±~5,3~m²/ha (moyenne ± erreur-type, n = 28~; @tab-structure). Avec les huit placettes de Romiguière (2025), la surface terrière monte à 41,8~±~4,8~m²/ha (n = 36).
// Source G (36 placettes) : sensibilite-romiguiere.csv (analyse-sensibilite-romiguiere.R, 02/11/2026).
// Écart-type pour la dispersion entre placettes (tiges par placette), erreur-type pour les estimations à l'hectare (N, G) : arbitrage de l'auteur du 01/11/2026.

// Tableau de structure : valeurs brutes de structure-resume.csv (05/11/2026) arrondies à la main selon la règle du M&M.
#figure(
  table(
    columns: 5,
    align: (left, left, right, right, right),
    inset: 8pt,
    table.header([*Indicateur (unité)*], [*Placettes*], [*Moyenne*], [*Écart-type*], [*Erreur-type*]),
    [Tiges par placette (tiges)], [Étude (28)], [71,4], [26,4], [5,0],
    [Densité N (tiges/ha)], [Étude (28)], [37~600], [13~500], [2~600],
    [Surface terrière G (m²/ha)], [Étude (28)], [37,3], [28,0], [5,3],
    [Surface terrière G (m²/ha)], [Étude + Romiguière (36)], [41,8], [28,7], [4,8],
  ),
  caption: [Indicateurs de structure forestière. Placettes~: les 28 placettes de l'étude, et pour G ces mêmes placettes complétées des 8 placettes de 40 m² de Romiguière (2025), relevées au même seuil (CBH ≥ 8 cm) et non corrigées de la pente~; N n'est pas calculé avec ces dernières, faute de gaulis relevés. Moyenne entre placettes~; écart-type~: dispersion entre placettes~; erreur-type de la moyenne. Indicateurs rapportés à la surface horizontale. Les gaulis (tiges de plus de 1,30 m de haut et de CBH < 8 cm) sont inclus dans N et exclus de G. Valeurs par placette en @annexe-indices-placettes.],
) <tab-structure>
#titre-court(<tab-structure>)[Indicateurs de structure forestière]

// erreur-type à donner pour les densité et surfaces terrière ici — appliqué le 09/11/2026 (classes-n- et classes-g-placettes-transects.csv ; classe 0-2,5 cm sans erreur-type : IC 95 %).
La densité décroît de 28~400 tiges/ha (IC 95~%~: [24~000~; 32~800]) dans la classe de diamètre 0-2,5~cm à 528~±~75 tiges/ha dans la classe 7,5-10~cm~; au-delà de 10~cm, elle ne dépasse pas 305~±~54 tiges/ha (moyenne ± erreur-type~; @fig-hist-classes). La surface terrière la plus élevée est celle de la classe 2,5-7,5~cm (10,7~±~0,7~m²/ha), suivie de la classe 22,5-27,5~cm (8,48~±~2,38~m²/ha~; @fig-G-classes). La densité des arbres de diamètre supérieur ou égal à 40 cm est estimée à 14,5~±~3,4 arbres/ha (erreur-type), pour une surface terrière de 3,34~±~0,73~m²/ha.

// FIGURE tracée en Typst. Source : analyse-tables/classes-n-placettes-transects.csv (analyse-sensibilite-romiguiere.R, 05/11/2026) : placettes (28 de l'étude et 8 de Romiguière, 2025 ; classe 0-2,5 cm : 28 placettes) et grands arbres des transects additionnés ; IC 95 % combinés (erreurs-types quadratiques, ddl de Welch-Satterthwaite).
#let classesDiam = csv("analyse-tables/classes-n-placettes-transects.csv").slice(1).map(r => r.slice(0, 8).map(v => if v == "NA" { 0 } else { float(v) }))
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
    pad(top: 0.6cm, box(width: largeur + marge + 0.3cm, height: hauteur + 1.4cm, {
      // Grille et graduations de l'axe des ordonnées
      for k in range(nbDecades + 1) {
        let dy = hauteur - hauteur * k / nbDecades
        place(dx: marge, dy: dy, line(length: largeur, stroke: (paint: luma(200), thickness: 0.4pt, dash: "dashed")))
        place(dx: 0pt, dy: dy - 0.5em, box(width: marge - 0.15cm, align(right, graduations.at(k))))
      }
      // Barres et erreur-type (IC 95 % pour la classe 0-2,5 cm, seule sans erreur-type dans le CSV : NA ramené à 0)
      for r in classesDiam {
        let i = int(calc.round(r.at(0) / 2.5))
        let x = marge + pas * i
        let h = y(r.at(3))
        place(dx: x + pas * 0.1, dy: hauteur - h, rect(width: pas * 0.8, height: h, fill: luma(170), stroke: 0.4pt + black))
        let vBas = if r.at(4) > 0 { r.at(3) - r.at(4) } else { r.at(6) }
        let vHaut = if r.at(4) > 0 { r.at(3) + r.at(4) } else { r.at(7) }
        let bas = y(vBas)
        let haut = y(vHaut)
        let cx = x + pas / 2
        place(dx: cx, dy: hauteur - haut, line(start: (0pt, 0pt), end: (0pt, haut - bas), stroke: 0.6pt + black))
        place(dx: cx - pas * 0.3, dy: hauteur - haut, line(length: pas * 0.6, stroke: 0.6pt + black))
        if vBas > 0.1 {
          place(dx: cx - pas * 0.3, dy: hauteur - bas, line(length: pas * 0.6, stroke: 0.6pt + black))
        }
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
    }))
  },
  caption: [Densité de tiges par classe de diamètre de 2,5~cm~: tiges des placettes et grands arbres des transects additionnés. Placettes~: moyenne entre les 28 placettes de l'étude et les 8 placettes de 40~m² de Romiguière (2025), et entre les seules 28 placettes de l'étude pour la classe 0-2,5~cm, qui comprend les gaulis. Grands arbres (CBH $>=$ 126~cm, soit un DBH d'au moins 40~cm)~: effectif rapporté aux 53~050~m² de bande prospectée sur cinq transects. Barres d'erreur~: moyenne ± erreur-type~; pour les classes comprenant des grands arbres, erreurs-types des placettes (entre placettes) et des transects (estimateur par le ratio entre les cinq transects) combinées~; pour la classe 0-2,5~cm, dont l'erreur-type n'est pas fournie, IC 95~%. Les bornes inférieures négatives ou inférieures à 0,1~tige/ha sont ramenées à l'axe, sans trait horizontal. Axe des ordonnées en échelle logarithmique. Données en @annexe-classes-diametre.],
) <fig-hist-classes>
#titre-court(<fig-hist-classes>)[Densité de tiges par classe de diamètre]

// Source : analyse-tables/classes-g-placettes-transects.csv (36 placettes) et transects-grands-arbres-resume.csv (G_m2_ha).

// FIGURE tracée en Typst. Source : analyse-tables/classes-g-placettes-transects.csv (analyse-sensibilite-romiguiere.R, 05/11/2026) : 36 placettes (étude et Romiguière, 2025) et grands arbres des transects additionnés ; IC 95 % combinés comme pour la densité.
#let classesG = csv("analyse-tables/classes-g-placettes-transects.csv").slice(1).map(r => r.slice(0, 9).map(float))
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
    pad(top: 0.6cm, box(width: largeur + marge + 0.3cm, height: hauteur + 1.4cm, {
      // Grille et graduations de l'axe des ordonnées
      for k in range(5) {
        let dy = hauteur - hauteur * k / 4
        place(dx: marge, dy: dy, line(length: largeur, stroke: (paint: luma(200), thickness: 0.4pt, dash: "dashed")))
        place(dx: 0pt, dy: dy - 0.5em, box(width: marge - 0.15cm, align(right, str(4 * k))))
      }
      // Barres et erreur-type
      for r in classesG {
        let i = int(calc.round((r.at(0) - 2.5) / 5))
        let x = marge + pas * i
        let h = y(r.at(4))
        place(dx: x + pas * 0.1, dy: hauteur - h, rect(width: pas * 0.8, height: h, fill: luma(170), stroke: 0.4pt + black))
        let bas = y(r.at(4) - r.at(5))
        let haut = y(r.at(4) + r.at(5))
        let cx = x + pas / 2
        place(dx: cx, dy: hauteur - haut, line(start: (0pt, 0pt), end: (0pt, haut - bas), stroke: 0.6pt + black))
        place(dx: cx - pas * 0.15, dy: hauteur - haut, line(length: pas * 0.3, stroke: 0.6pt + black))
        if r.at(4) - r.at(5) > 0 {
          place(dx: cx - pas * 0.15, dy: hauteur - bas, line(length: pas * 0.3, stroke: 0.6pt + black))
        }
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
    }))
  },
  caption: [Surface terrière par classe de diamètre de 5~cm, à partir du seuil de mesure de 2,5~cm~: tiges des placettes et grands arbres des transects additionnés. Placettes~: moyenne entre les 28 placettes de l'étude et les 8 placettes de 40~m² de Romiguière (2025). Grands arbres (CBH $>=$ 126~cm, soit un DBH d'au moins 40~cm)~: surface terrière rapportée aux 53~050~m² de bande prospectée. Barres d'erreur~: moyenne ± erreur-type, combinant placettes et transects comme en @fig-hist-classes~; les bornes inférieures négatives sont ramenées à zéro, sans trait horizontal. Les gaulis, non mesurés, sont exclus. Données en @annexe-classes-diametre.],
) <fig-G-classes>
#titre-court(<fig-G-classes>)[Surface terrière par classe de diamètre]

// Source : transects-grands-arbres.csv, transects-grands-arbres-resume.csv, transects-chablis.csv (analyse-transects.R, créé et lancé le 01/11/2026).


// Les chablis n'ont été dénombrés, à ce jour, que le long de deux itinéraires : 2 petits bois (circonférence inférieure à 30~cm) et 5 bois moyens ou gros sur T01 ; 20 petits bois, 20 bois moyens (30 à 60~cm) et 18 gros bois (plus de 60~cm) sur T02. Faute de longueur prospectée, aucune densité n'est calculée.
// TODO (auteur) : mettre à jour ce paragraphe après correction des chablis (définition, transects T19 et T20, longueurs, unité des classes) ; le script analyse-transects.R n'exporte pour l'instant que les effectifs.

// Source : regeneration-resume.csv (analyse-regeneration.R, créé et lancé le 01/11/2026) ; moyenne entre placettes ± erreur-type (arbitrage auteur : valeurs seules, en tiges/m²).
La régénération des tiges de moins de 1,30~m de haut vaut 5,04~±~0,41 tiges/m² pour celles de moins de 30~cm et 2,29~±~0,38 tiges/m² de 30 à 130~cm (moyenne ± erreur-type, n = 7).
// Piste (auteur) : regrouper ces valeurs dans un tableau de synthèse des caractéristiques de la forêt ?

// Source : analyse-tables/carbone-stocks.csv et carbone-total-foret.csv (copies des sorties du 03/11/2026, surface 640 ha ; E = 0,10, ρ = 0,58, facteurs MDP, graine 2026).
// Total avec les tiges de l'étude et de Romiguière (2025) : carbone-total-foret-romiguiere.csv (analyse-sensibilite-romiguiere.R ; autres compartiments repris de carbone-stocks.csv). Même total dans resume.typ.
*Stock de carbone.* Les arbres de petit diamètre portent l'essentiel du stock de carbone (@tab-carbone). Les quatre compartiments stockent au total 175~tC/ha (IC 95~%~: [135~; 223]), soit 112~000~tC (IC 95~%~: [87~000~; 143~000]) et 410~000~tCO₂ (IC 95~%~: [318~000~; 525~000]) rapportés aux 640~ha de la forêt. La biomasse aérienne sèche des arbres vivants est de 259~tMS/ha (IC 95~%~: [191~; 343]) pour les arbres de moins de 40~cm et de 35~tMS/ha ([23~; 55]) pour les autres~; celle du bois mort est de 13,0~tMS/ha au sol ([5,5~; 21,8]) et de 5,8~tMS/ha sur pied ([1,7~; 10,8]).
// Biomasse sèche rétablie dans le texte le 09/11/2026 (auteur) : sensibilite-romiguiere.csv (tiges étude + Romiguière, 259,2 [190,6 ; 342,6]) et carbone-stocks.csv (grands arbres 34,9 [23,4 ; 55,3] ; bois mort au sol 13,03 [5,50 ; 21,84] ; sur pied 5,75 [1,67 ; 10,81]) ; arrondi au rang de la plus petite demi-largeur (M&M).
// Erreur-type de G des grands arbres (0,73 m²/ha) : calculée le 09/11/2026 à la demande de l'auteur, estimateur par le ratio entre les cinq transects (même formule que analyse-transects.R pour la densité), sur 02-donnees/ecologie/grands-arbres.csv et transects.csv ; vérification : densité 14,51 ± 3,42 et G 3,341 retrouvés. À intégrer au script (resumeGA).
// Longueurs prospectées pour les grands arbres (transects.csv, d'après l'onglet grands-arbres de l'ODS) : T05 1 940 m, T06 1 800 m, T16 205 m, T19 300 m, T20 1 060 m, soit 53 050 m².
// ATTENTION : T19 = « 300 ? » dans l'ODS (valeur incertaine) ; T16 = 190 m auparavant dans transects.csv, « ~ 205 » dans l'ODS.

// COR : supprimer la colonne biomasse, inutile — appliqué le 09/11/2026. Valeurs retirées (tMS/ha) : 259 ; 35 ; 13,0 ; 5,8.
#figure(
  table(
    columns: 4,
    align: (left, right, right, right),
    inset: 8pt,
    table.header([*Compartiment*], [*Volume (m³/ha)*], [*Carbone (tC/ha)*], [*CO₂ (tCO₂/ha)*]),
    [Arbres < 40~cm], [450 [330~;~590]], [146 [107~;~193]], [540 [390~;~710]],
    [Arbres $>=$ 40~cm], [60 [40~;~95]], [19,7 [13,2~;~31,2]], [72 [48~;~114]],
    [Bois mort au sol], [22 [9~;~38]], [6,1 [2,6~;~10,3]], [22 [9~;~38]],
    [Bois mort sur pied], [9,9 [2,9~;~18,6]], [2,7 [0,8~;~5,1]], [9,9 [2,9~;~18,6]],
    [Total], [–], [175 [135~;~223]], [640 [500~;~820]],
  ),
  caption: [Stocks de carbone et de CO₂ par compartiment. Entre crochets~: IC 95~% par bootstrap (1~000 rééchantillonnages des placettes ou des transects). Le carbone et le CO₂ du vivant incluent la biomasse souterraine ($R = "0,20"$). Paramètres~: $E = "0,10"$, $rho = "0,58"$~g/cm³, $"CF" = "0,47"$. Volume~: partie aérienne. Total~: somme des quatre compartiments~; IC 95~% par propagation des IC des compartiments, supposés indépendants.],
) <tab-carbone>
#titre-court(<tab-carbone>)[Stocks de carbone par compartiment]

=== Diversité
// COR : dans toute la section on se limite à trois chiffres significatifs ex 71,4+-26,4 — appliqué le 09/11/2026 (arbitrage de l'auteur : « 10,7 ± 0,7 ») : moyenne à trois chiffres significatifs, incertitude (erreur-type ou écart-type) au même rang. Jaccard repris de diversite-beta-jaccard-niveaux.csv et diversite-beta-resume-rapport.csv (04-sorties).

// Source : diversite-alpha-resume.csv ; valeurs par placette : 04-sorties/diversite-alpha-placettes.csv.
// COR : on met l'erreur type partout finalement là où elle est pertinente, on reste syr IC là où l'erreur-type n'est pas calculable (conditions non-respectées) — appliqué le 09/11/2026 : figures et texte des classes de diamètre passés en erreur-type (IC 95 % conservé pour la classe 0-2,5 cm, sans erreur-type). IC conservés : carbone (bootstrap), estimateurs de richesse (IC log-transformés), couverture (bootstrap). Jaccard : écart-type conservé (paires non indépendantes, erreur-type non pertinente).
// COR : quand l'IC95 est déterminée par Student, et que l'écart-type est noté, pas besoin d'afficher l'IC — appliqué le 09/11/2026 dans resultats.typ : plus aucun IC de Student affiché (figures des classes en erreur-type). Le tableau de l'annexe des classes de diamètre affiche encore les IC 95 % : non modifié.
*Diversité alpha.* Une placette compte en moyenne 29,3~±~1,2 espèces, pour un indice de Shannon de 3,03~±~0,05 (moyenne ± erreur-type, n = 28~; @tab-div-alpha). L'erreur-type est la plus élevée pour l'alpha de Fisher. Les indices de chaque placette figurent en @annexe-indices-placettes.

// TABLEAU : indices alpha (moyenne ± erreur-type, n = 28 ; valeurs brutes de diversite-alpha-resume.csv, 05/11/2026).
#figure(
  table(
    columns: 2,
    align: (left, right),
    inset: 8pt,
    table.header([*Indice (unité)*], [*Moyenne ± erreur-type (n = 28)*]),
    [Richesse spécifique S (espèces)], [29,3 ± 1,2],
    [Indice de Shannon H′ (sans unité)], [3,03 ± 0,05],
    [Inverse de l'indice de Simpson (sans unité)], [15,9 ± 0,9],
    [Alpha de Fisher (sans unité)], [22,0 ± 1,8],
  ),
  caption: [Indices de diversité alpha par placette~: moyenne entre placettes ± erreur-type. Abondances~: toutes les tiges comptées (tiges mesurées et gaulis), tiges indéterminées exclues. Shannon et inverse de Simpson sous leur forme brute. Espèces~: noms vernaculaires réconciliés, et non espèces botaniques. Valeurs par placette en @annexe-indices-placettes.],
) <tab-div-alpha>
#titre-court(<tab-div-alpha>)[Indices de diversité alpha]

// Sources : diversite-beta-resume-rapport.csv, diversite-beta-resume.csv, diversite-beta-whittaker.csv, diversite-beta-jaccard-niveaux.csv (analyse-diversite-beta.R relancé le 04/11/2026, Jaccard seul).
*Diversité bêta.* Le bêta multiplicatif de Whittaker vaut 8,26 ($gamma$ = 242 espèces~; $macron(alpha)$ = 29,3 espèces) et le bêta additif 213 espèces. La dissimilarité de Jaccard moyenne entre les 378 paires de placettes est de 0,847~±~0,071 (moyenne ± écart-type). Elle est plus faible entre placettes d'un même itinéraire qu'entre placettes d'une même commune ou de communes différentes (@tab-beta-niveaux). Sur l'ordination NMDS (stress = 0,218), les placettes d'un même itinéraire sont visuellement groupées (@fig-beta-nmds), ce qui suggère une autocorrélation spatiale des espèces ou des identifications par le _polisinala_.

// TABLEAU : dissimilarités moyennes (± écart-type) par niveau partagé.
#figure(
  table(
    columns: 3,
    align: (left, right, right),
    inset: 8pt,
    table.header([*Niveau partagé par la paire*], [*Paires*], [*Jaccard (sans unité)*]),
    [Même itinéraire], [37], [0,710 ± 0,068],
    [Même _polisinala_ (itinéraires différents)], [16], [0,742 ± 0,086],
    [Même commune (_polisinala_ différents)], [70], [0,885 ± 0,037],
    [Communes différentes], [255], [0,864 ± 0,043],
  ),
  caption: [Dissimilarité de Jaccard moyenne ± écart-type entre paires de placettes selon le niveau le plus fin qu'elles partagent (présence-absence). Comparaison descriptive~: les paires ne sont pas indépendantes. Espèces~: noms vernaculaires réconciliés.],
) <tab-beta-niveaux>
#titre-court(<tab-beta-niveaux>)[Dissimilarités par niveau partagé]

// FIGURE : ordination NMDS des 28 placettes, un symbole par itinéraire.
#figure(
  image("analyse-figures/diversite-beta-nmds.svg",
    alt: "Plan d'ordination NMDS à deux dimensions des 28 placettes, un symbole par itinéraire."),
  caption: [Ordination NMDS en deux dimensions des 28 placettes, sur la dissimilarité de Jaccard (présence-absence)~; stress = 0,218. Deux points proches correspondent à des placettes de composition proche. Chaque symbole représente un itinéraire. Espèces~: noms vernaculaires réconciliés. Coordonnées en @annexe-beta.],
) <fig-beta-nmds>
#titre-court(<fig-beta-nmds>)[Ordination NMDS des placettes]
// Vérifié dans analyse-diversite-beta.R (01/11/2026) : case_when ordonné (même transect > même polisin'ala > même commune > communes différentes), chaque paire est classée au niveau le plus fin qu'elle partage ; les niveaux sont exclusifs.

// Source : ivi-especes.csv (analyse-ivi.R). IVI sur 100.
*Espèces dominantes.* Sur les 124 espèces classées, _Babogna_ a l'IVI le plus élevé, avec la plus forte dominance et la plus forte fréquence relatives~; _Hazomainty_ a la plus forte densité relative (@tab-ivi). Six espèces ont un IVI supérieur à 3,5~; il tombe sous 1,5 à partir du rang 19. Certaines espèces doivent leur rang à une seule composante~: _Ramiavogna_ et _Sary_, avec deux tiges chacune, à leur dominance relative, _Hasina_ à sa fréquence. Cinquante-quatre espèces ne comptent qu'une tige mesurée et 66 ne sont présentes que dans une placette (classement complet en @annexe-ivi).

// TABLEAU : les quinze espèces de plus fort IVI.
#figure(
  table(
    columns: (1fr, 3fr, 1.5fr, 1.5fr, 1.5fr, 2fr),
    align: (right, left, right, right, right, right),
    inset: 8pt,
    table.header([*Rang*], [*Espèce*], [*DR (%)*], [*DoR (%)*], [*FR (%)*], [*IVI (%)*]),
    [1], [_Babogna_], [5,22], [9,96], [4,59], [6,59],
    [2], [_Ambora_], [4,59], [7,23], [3,28], [5,03],
    [3], [_Hazomainty_], [6,05], [4,55], [4,26], [4,96],
    [4], [_Menafatagna_], [4,59], [5,03], [3,61], [4,41],
    [5], [_Voapaka_], [2,92], [5,87], [2,62], [3,80],
    [6], [_Tsimahamasasokona_], [4,38], [3,35], [3,61], [3,78],
    [7], [_Randripody_], [3,76], [1,33], [3,28], [2,79],
    [8], [_Hasina_], [3,13], [1,26], [3,93], [2,78],
    [9], [_Hazombary_], [3,55], [2,41], [1,64], [2,53],
    [10], [_Sagnira_], [1,67], [3,48], [1,64], [2,26],
    [11], [_Kijy_], [1,46], [3,24], [1,97], [2,22],
    [12], [_Ramiavogna_], [0,42], [5,00], [0,66], [2,02],
    [13], [_Sary_], [0,42], [4,50], [0,66], [1,86],
    [14], [_Tsirika_], [2,71], [0,62], [1,97], [1,77],
    [15], [_Kabokala_], [0,63], [3,63], [0,98], [1,75],
  ),
  caption: [Les quinze espèces de plus fort indice de valeur d'importance (IVI) sur l'ensemble du dispositif (28 placettes~; 479 tiges mesurées, gaulis et tiges indéterminées exclus). DR~: densité relative~; DoR~: dominance relative (part de la surface terrière)~; FR~: fréquence relative (part des occurrences en placette). IVI = (DR + DoR + FR) / 3, la somme sur les 124 espèces valant 100. Espèces~: noms vernaculaires réconciliés, et non espèces botaniques. Classement complet en @annexe-ivi.],
) <tab-ivi>
#titre-court(<tab-ivi>)[Les quinze espèces de plus fort IVI]

// Sources : estimateurs-richesse-gamma.csv ; 04-sorties/courbe-rarefaction-extrapolation.csv.
*Richesse spécifique totale.* Les 28 placettes totalisent 242 espèces observées. Chao2, estimateur principal, donne 331 espèces (IC 95~%~: [295~; 391])~; toutes les autres estimations, sauf celle du bootstrap, sont comprises dans cet intervalle (@tab-gamma).

// TABLEAU : estimateurs de la richesse totale.
#figure(
  table(
    columns: 4,
    align: (left, left, right, right),
    inset: 8pt,
    table.header([*Estimateur*], [*Modèle*], [*Estimation (espèces)*], [*IC 95 %*]),
    [Chao2 (principal)], [Incidence], [331], [[295~;~391]],
    [Jackknife d'ordre 1], [Incidence], [337], [[294~;~381]],
    [Jackknife d'ordre 2], [Incidence], [382], [[343~;~435]],
    [ICE], [Incidence], [366], [[325~;~427]],
    [Bootstrap], [Incidence], [286], [[263~;~309]],
    [Chao1], [Abondance], [299], [[274~;~344]],
    [ACE], [Abondance], [315], [[298~;~333]],
  ),
  caption: [Estimateurs asymptotiques de la richesse spécifique totale (28 placettes~; richesse observée $gamma_"obs"$ = 242 espèces, tiges indéterminées exclues). Espèces~: noms vernaculaires réconciliés, et non espèces botaniques. Modèle d'incidence~: présence des espèces par placette~; modèle d'abondance~: nombre de tiges par espèce. Chao2 est l'estimateur principal~; les autres sont donnés à titre de comparaison. IC 95 %~: transformation logarithmique pour Chao2, Chao1 (iNEXT), jackknife d'ordre 2 et ICE (SpadeR)~; approximation normale (± 1,96 erreur-type) pour le jackknife d'ordre 1, le bootstrap et ACE (vegan).],
) <tab-gamma>
#titre-court(<tab-gamma>)[Estimateurs de la richesse totale]
// Méthode des IC vérifiée dans estimation-richesse-specifique.R (02/11/2026) : ChaoRichness (iNEXT) pour Chao1 et Chao2, ChaoSpecies (SpadeR) pour ICE et jackknife 2, estimation ± 1,96 × erreur-type (specpool/estimateR de vegan) pour jackknife 1, bootstrap et ACE. Le commentaire du script « IC exact » pour Chao1 ne correspond pas : ChaoRichness donne un intervalle log-transformé.

Avec 28 placettes (531~m²), la couverture d'échantillonnage est de 88,4~% (IC 95~%~: [86,7~; 90,2]~%).
// IC de la raréfaction-extrapolation : bootstrap iNEXT sans graine (légères variations d'un lancement à l'autre).
// TODO (à faire, auteur) : lire la courbe et décrire sa forme (plateau ou non).

// FIGURE : courbe de raréfaction-extrapolation (incidence, q = 0).
#figure(
  image("analyse-figures/courbe-rarefaction-extrapolation.svg",
    alt: "Courbe du nombre de noms vernaculaires réconciliés en fonction du nombre de placettes, interpolée jusqu'à 28 placettes puis extrapolée jusqu'à 112 placettes, avec sa bande de confiance."),
  caption: [Richesse en noms vernaculaires réconciliés (modèle d'incidence, ordre $q$ = 0) en fonction du nombre de placettes~: interpolation de 1 à 28 placettes (trait pointillé~: 28 placettes, 242 noms), puis extrapolation jusqu'à 112 placettes, soit quatre fois l'effort réalisé. Une placette représente en moyenne 19,0~m² de surface horizontale, soit 531~m² pour 28 placettes et 2~120~m² pour 112. Bande grise~: IC 95~% par bootstrap. Données en @annexe-richesse.],
) <fig-rarefaction>
#titre-court(<fig-rarefaction>)[Courbe de raréfaction-extrapolation]

== Évolution du couvert forestier

// ATTENTION : 20 placettes sur 28 dans la forêt de 2025 = 8 hors forêt (calcul du 04/11/2026 rapporté en Discussion, sur les points GPS reconstitués par date et ordre de passage ; correspondance GPS-placettes à valider).
Le périmètre du VOI transmis par Inter Aide couvre 974~ha, contre 1~068~ha selon le contrat de 2025. Dans ce périmètre, la forêt classée couvrait 601~ha en 1973, 418~ha en 1990 et 401~ha en 2025 (@fig-carte-couvert~; @tab-couvert-communes). L'essentiel de la perte date de 1973-1990 (183~ha, soit 30~% de la forêt de 1973)~: le cœur du massif est resté relativement stable, et la plupart des lambeaux forestiers qui l'entouraient ont disparu. Depuis 1990, environ 17~ha ont été perdus, en lisière et au nord du massif. Hors du périmètre, la forêt classée a presque disparu. En 1973, près du tiers de la surface des _fokontany_ concernés n'était pas classé (nuages)~: la perte d'avant 1990 y est inconnue.

Cette classification ne retient que la forêt dense~: seules 20 des 28 placettes inventoriées, toutes installées en forêt, tombent dans la forêt de 2025. Elle sous-estime donc la surface de la forêt et sert à mesurer ses pertes, non sa surface absolue.
// Résultats seulement ; valeurs : 02_donnees_traitees/bases_de_donnees/couvert_forestier_surfaces.csv, couvert_forestier_fokontany.csv et couvert_forestier_communes.csv (script carte4_couvert_forestier.py, 04/11/2026). Pertes dans le périmètre : 183 (1973-1990), 9 (1990-2000), 0 (2000-2010), 2 (2010-2017), 5 (2017-2025) ; la somme de 1990 à 2025 est 16, la différence 418 - 401 = 17 vient des arrondis.
// ATTENTION : forêt 2025 dans le périmètre = 401 ha, contre ~640 ha de massif cités ailleurs et 618 ha de la classification Sentinel-2 2026 (indicative) : à trancher avant publication.

// Source de la carte 4 : 04_Geomatique/projet_sig_tsiazombazaha/03_analyses/scripts/carte4_couvert_forestier.py (export PDF converti en SVG par pdftocairo : images/carte-couvert-1973-2017.svg). Rasters Vieilledent et al. (2018), mise à jour 2017 (Cirad Dataverse, doi:10.18167/DVN1/AUBRRC).
// TODO (auteur) : (1) en 1973 la valeur 5 des rasters correspond aux pixels NON CLASSÉS (nuages sur l'image Landsat MSS ; 3,3 Mha à l'échelle de Madagascar, laissés tels quels par Vieilledent et al., 2018, §2.1) : la forêt de 1973 est donc sous-estimée dans ces zones (18 374 ha non classés dans la fenêtre cartographiée, dont 12 ha dans le périmètre du VOI) et la « perte 1973-1990 » ne porte que sur la forêt classée en 1973 ; (2) 2018-2025 : forêt de 2017 moins la perte annuelle de Hansen et al. (2013, GFC-2025-v1.13, années 18 à 25), comme Vieilledent et al. pour 2001-2014 ; la perte de Hansen peut sous-estimer les pertes et ignore les gains ; la surface de 2026 n'est pas estimée (une seule scène Sentinel-2, NDVI de la forêt et du non-forêt trop proches) ; forêt 2025 dans le périmètre du VOI : 401 ha (406 en 2017), à rapprocher des ~640 ha du massif cités ailleurs ; (3) les couches de chemins, d'eau et de terres agricoles de la carte de Romiguière ne sont pas reprises ; (4) tableau des fokontany : couvert_forestier_fokontany.csv, limites OCHA et BNGRC (2018) ; « Mahatsara » = Manakana, « Vohitrandriana » = Amborodra.
#figure(
  image("images/carte-couvert-1973-2017.svg", width: 100%,
    alt: "Carte en niveaux de gris de la forêt de Tsiazombazaha : un massif noir central (forêt en 2025) dans le périmètre du VOI, entouré de lambeaux gris clair de forêt perdus entre 1973 et 1990 et, à l'est, de grandes zones hachurées non classées en 1973 ; de rares petites surfaces plus foncées perdues entre 1990 et 2025 en lisière."),
  caption: [Évolution du couvert forestier de la forêt de Tsiazombazaha de 1973 à 2025~: forêt en 2025 (noir) et forêt perdue par période, du gris clair (perte ancienne, 1973-1990) au gris foncé (perte récente, 2017-2025). Les zones hachurées n'avaient pas été classées en 1973 (nuages)~: la forêt de cette date y est inconnue. Le périmètre du VOI Maharitra et les limites communales sont indiqués. Échelle 1/35~000~; quadrillage en degrés décimaux (WGS84), projection UTM 38~S (EPSG:32738). Sources~: cartes de couvert forestier de Vieilledent et al. (2018), mises à jour jusqu'en 2017 (résolution de 30~m), prolongées jusqu'en 2025 par la perte annuelle de couvert de Hansen et al. (2013, version GFC-2025-v1.13)~; périmètre~: VOI Maharitra (2025), transmis par Inter Aide~; limites communales~: OCHA et BNGRC (2018).],
) <fig-carte-couvert>
#titre-court(<fig-carte-couvert>)[Évolution du couvert forestier de Tsiazombazaha]

// Surfaces en hectares entiers : hors règle des chiffres significatifs (auteur, 05/11/2026).
#figure(
  table(
    columns: 9,
    align: (left, right, right, right, right, right, right, right, right),
    inset: 5pt,
    // Trait sous la ligne des dates, en plus de celui sous « Forêt (ha) »
    stroke: (x, y) => if y == 0 { (top: 0.8pt, bottom: 0.5pt) } else if y == 1 { (bottom: 0.5pt) },
    table.header(
      table.cell(rowspan: 2, align: horizon)[*Commune*], table.cell(rowspan: 2, align: horizon)[*Surface (ha)*], table.cell(rowspan: 2, align: horizon)[*Non classé en 1973 (ha)*], table.cell(colspan: 6, align: center)[*Forêt (ha)*],
      [*1973*], [*1990*], [*2000*], [*2010*], [*2017*], [*2025*],
    ),
    [Mizilo Gara], [3 175], [241], [422], [254], [251], [251], [249], [245],
    [Ambahatrazo], [7 988], [1 771], [347], [212], [198], [195], [186], [179],
    [Ambila], [2 054], [511], [0], [0], [0], [0], [0], [0],
    [Vohimasina Sud], [9 092], [4 685], [20], [9], [2], [2], [2], [2],
    [*Ensemble*], [*22 309*], [*7 207*], [*789*], [*475*], [*451*], [*448*], [*437*], [*425*],
    [dont dans périmètre VOI], [974], [12], [601], [418], [409], [408], [406], [401],
    [dont hors périmètre VOI], [21 336], [7 196], [188], [57], [42], [40], [31], [24],
  ),
  caption: [Surface de forêt naturelle jamais dégradée après 1973 par commune (_fokontany_ concernés entre parenthèses): Mizilo Gara (Mizilo Gara, Ampasipotsy et Tsiazombazaha)~; Ambahatrazo (Ambahatrazo, Amborodra, Ambalavolo et Manakana)~;  Ambila (Andriana)~; commune de Vohimasina Sud (Tsararano). Chaque colonne donne la surface forestière restante cette année. En 1973, la forêt n'est connue que pour les zones non-nuageuses. Sources~: Vieilledent et al. (2018), mises à jour jusqu'en 2017 (30~m), prolongées jusqu'en 2025 avec Hansen et al. (2013).],
) <tab-couvert-communes>
#titre-court(<tab-couvert-communes>)[Surface forestière par commune, 1973-2025]
// SOU : ~; limites des _fokontany_ : OCHA et BNGRC (2018)~; périmètre du VOI : VOI Maharitra (2025). Calcul de l'auteur.
