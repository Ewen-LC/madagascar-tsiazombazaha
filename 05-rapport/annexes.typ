#import "titres-courts.typ": titre-court

// Tableaux pivotés en 10 pt, comme les autres tableaux des annexes (auteur, 09/11/2026).

#show figure.where(kind: "annexe"): set figure.caption(position: top)
#set figure(numbering: "1")
#set figure(placement: none) // annexes : figures fixes et sécables, pas de flottants (09/11/2026)
#show figure.where(kind: "annexe"): set block(breakable: true)

#let nombre(x, decimales: 2) = {
  if x.match(regex("^-?[0-9]+(\.[0-9]+)?([eE]-?[0-9]+)?$")) == none { return x }
  let v = calc.round(float(x), digits: decimales)
  let parties = str(calc.abs(v)).split(".")
  let dec = if parties.len() > 1 { parties.at(1) } else { "" }
  while dec.len() < decimales { dec += "0" }
  let signe = if v < 0 { "−" } else { "" }
  // Séparateur des milliers (espace insécable) à partir de quatre chiffres
  let ent = parties.at(0)
  let groupes = ()
  while ent.len() > 3 { groupes.insert(0, ent.slice(ent.len() - 3)); ent = ent.slice(0, ent.len() - 3) }
  groupes.insert(0, ent)
  ent = groupes.join("\u{00A0}")
  if decimales == 0 { signe + ent } else { signe + ent + "," + dec }
}

// Règle des chiffres significatifs (Matériel et méthodes, Conventions ; auteur, 05/11/2026)
#let arrondir(x, d) = if d >= 0 { calc.round(x, digits: d) } else { calc.round(x / calc.pow(10, -d)) * calc.pow(10, -d) }
#let rangSig(x, n) = n - 1 - int(calc.floor(calc.log(calc.abs(x), base: 10)))
#let nombreD(x, d) = {
  let v = arrondir(float(x), d)
  let signe = if v < 0 { "−" } else { "" }
  signe + nombre(str(calc.abs(v)), decimales: calc.max(d, 0))
}
// Grandeur sans incertitude : trois chiffres significatifs
#let sig3(x) = if float(x) == 0 { "0" } else { nombreD(x, rangSig(float(x), 3)) }
// Moyenne et IC : rang de la plus petite demi-largeur à deux chiffres significatifs
#let rangIC(m, b, h) = rangSig(calc.min(float(m) - float(b), float(h) - float(m)), 2)
#let nombreIC(m, b, h) = {
  let d = rangIC(m, b, h)
  (nombreD(m, d), "[" + nombreD(b, d) + " ; " + nombreD(h, d) + "]")
}
// Moyenne ± erreur-type : moyenne à trois chiffres significatifs, erreur-type au même rang (arbitrage de l'auteur, 09/11/2026 : « 10,7 ± 0,7 »)
// Erreur-type déduite de l'IC 95 % de Student des CSV de sensibilité (36 placettes, 35 ddl, t = 2,030108) : ET = (haut − bas) / (2 t). Vérifié le 09/11/2026 : 477,99 tiges/ha pour la classe 2,5 cm, identique à l'erreur-type de classes-n-placettes-transects.csv.
#let etStudent(b, h) = str((float(h) - float(b)) / (2 * 2.030108))
#let nombreET(m, u) = {
  let d = rangSig(float(m), 3)
  nombreD(m, d) + " ± " + nombreD(u, d)
}

#let placettesN = csv("analyse-tables/structure-n-placettes.csv").slice(1)
#let placettesG = csv("analyse-tables/structure-g-placettes.csv").slice(1)
#let placettesAlpha = csv("analyse-tables/diversite-alpha-placettes.csv").slice(1)
#let classesN = csv("analyse-tables/sensibilite-romiguiere-classes-n.csv").slice(1)
#let classesG = csv("analyse-tables/sensibilite-romiguiere-classes-g.csv").slice(1)
#let classesNGA = csv("analyse-tables/transects-grands-arbres-classes-n.csv").slice(1)
#let classesGGA = csv("analyse-tables/transects-grands-arbres-classes-g.csv").slice(1)
#let pointsNMDS = csv("analyse-tables/diversite-beta-nmds-points-anonyme.csv").slice(1)
#let ivi = csv("analyse-tables/ivi-especes.csv").slice(1)
#let rarefaction = csv("analyse-tables/courbe-rarefaction-extrapolation.csv").slice(1)
#let rarefactionAnnexe = rarefaction
#let methodes = (Rarefaction: "Interpolation", Observed: "Observé", Extrapolation: "Extrapolation")

#pagebreak(weak: true)
= Table des annexes

#outline(title: none, target: figure.where(kind: "annexe"))

#pagebreak(weak: true)

// Arborescence et décompte du 09/11/2026 (dépôt remis à Inter Aide, géomatique comprise).
// TODOAVANTDEPOT : ajouter le PDF final (05-rapport/memoire-tsiazombazaha.pdf) au décompte de 05-rapport et au poids total.
#figure(
  stack(
    spacing: 0.8cm,
      block(width: 100%, text(size: 10pt, raw(block: true, lang: "text", "madagascar-tsiazombazaha/\n├── README.md, LICENSE, .gitignore\n├── 01-methodologie/\n├── 02-donnees/\n│   ├── ecologie/\n│   ├── referentiels/\n│   └── social/\n├── 03-scripts/\n│   ├── fonctions/\n│   └── scripts-a-ne-pas-relancer/\n├── 04-sorties/\n├── 05-rapport/\n│   ├── analyse-figures/\n│   ├── analyse-tables/\n│   └── images/\n└── 06-geomatique/\n    ├── donnees-brutes/\n    ├── donnees-traitees/\n    ├── scripts/\n    ├── cartes/\n    └── projets-qgis/"))),
      table(
        columns: (3.2cm, 1fr, 1.7cm, 1.9cm),
        align: (left, left, right, right),
        table.header([*Dossier*], [*Contenu*], [*Fichiers*], [*Poids*]),
        [01-methodologie], [Fiche de relevés de l'inventaire forestier et canevas d'entretien.], [3], [103 ko],
        [02-donnees], [Données de terrain nettoyées (une table par type d'observation), données de Romiguière (2025), référentiels taxonomiques et d'usages, métadonnées anonymisées de l'enquête.], [31], [294 ko],
        [03-scripts], [Scripts R d'analyse, de description et de figure, avec leurs fonctions partagées.], [21], [174 ko],
        [04-sorties], [Tables et figures produites par les scripts R.], [49], [225 ko],
        [05-rapport], [Sources Typst du mémoire, bibliographie, images et tables importées.], [49], [12,2 Mo],
        [06-geomatique], [Projet de cartographie~: données brutes (traces GPS, limites administratives, images satellitaires), couches traitées, scripts PyQGIS, cartes et projets QGIS.], [88], [104,4 Mo],
      ),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Arborescence du dépôt remis à Inter Aide (état du 09/11/2026) et contenu de ses dossiers. Le nombre de fichiers et le poids incluent les sous-dossiers~; le dépôt compte aussi trois fichiers de présentation (README.md, LICENSE, .gitignore). Poids total~: 117,4 Mo. Les transcriptions d'entretiens, les notes de sorties et les données nominatives ne sont pas diffusées.],
) <annexe-arborescence>
#titre-court(<annexe-arborescence>)[Arborescence du dépôt Git]

#pagebreak(weak: true)

// Arborescence en annexe 1 : première annexe citée, au dos de la page de titre (auteur, 04/11/2026).

#pagebreak(weak: true)

// Données de la figure des estimations de la surface forestière (@fig-estimations-forestieres ; guide, critère 80), 04/11/2026. Source : analyse-tables/estimations-surface-forestiere.csv, copie de documents-brouillons/figure-estimations-forestieres/ (valeurs recopiées des publications, aucun calcul).
#let estimations = csv("analyse-tables/estimations-surface-forestiere.csv").slice(1)
#let seriesEstimations = (
  "Vieilledent et al. (2018) - forêts naturelles": [Forêts naturelles (Vieilledent et al., 2018)],
  "Vieilledent et al. (2018) - forêts humides": [Forêts humides (Vieilledent et al., 2018)],
  "Green et Sussman (1990) - forêts humides": [Forêts humides (Green et Sussman, 1990)],
  "Autres estimations (Amelot 2017)": [Estimations isolées (Amelot, 2017)],
)
// Surface : arrondie à 0,01 Mha au-delà de deux décimales ; fourchette « min – max » si les deux bornes diffèrent.
#let surfaceMha(x) = if x.contains(".") and x.split(".").at(1).len() > 2 { nombre(x) } else { x.replace(".", ",") }
#figure(
  table(
    columns: (4.5fr, 3fr, 1fr, 1.5fr),
    align: (left, left, right, right),
    table.header([*Série*], [*Auteur de l'estimation*], [*Année*], [*Surface (Mha)*]),
    ..estimations.map(l => (
      seriesEstimations.at(l.at(0)),
      if l.at(0).starts-with("Autres") { l.at(1).replace(regex(" (\d{4})$"), m => " (" + m.captures.at(0) + ")") } else { "" },
      l.at(2),
      if l.at(3) == l.at(4) { surfaceMha(l.at(3)) } else { surfaceMha(l.at(3)) + " – " + surfaceMha(l.at(4)) },
    )).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Estimations publiées de la surface forestière de Madagascar, en millions d'hectares (Mha), valeurs recopiées des publications. Vieilledent et al. (2018)~: tableaux 1 (forêts naturelles) et 2 (forêts humides). Estimations isolées~: ensemble des forêts, d'après Amelot (2017, p. 36-37)~; Guichon (1960) porte sur des photographies de 1949-1957, placées en 1953~; les estimations de 2005-2010 sont placées en 2008. Auteur de l'estimation~: case vide pour les séries~; MEFT~: Ministère de l'environnement, des forêts et du tourisme~; ONE~: Office national pour l'environnement.],
) <annexe-estimations-forestieres>
// Sigles développés dans la seule légende, absents de la liste des abréviations (auteur, 04/11/2026). Amelot (2017) ne les développe pas. ONE : CEPF (2022), loi forestière (2002), Randriamamonjy (2007). MEFT : déduit du ministère de 2003 (Cooke et al., cités dans le guide des essences pour la restauration) et du rattachement au « Service des Eaux et Forêts » chez Amelot (2017, p. 37), à confirmer.
#titre-court(<annexe-estimations-forestieres>)[Estimations de la surface forestière]

#pagebreak(weak: true)

// Données du diagramme ombrothermique (@fig-ombrothermique ; guide, critère 80), 04/11/2026. Source : images/climat-worldclim-tsiazombazaha.csv (extraction du 31/10/2026).
#let climat = csv("images/climat-worldclim-tsiazombazaha.csv").slice(1)
#let nomsMois = ("Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre")
#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, right, right),
    table.header([*Mois*], [*Température moyenne (°C)*], [*Précipitations (mm)*]),
    ..climat.map(l => (nomsMois.at(int(l.at(0)) - 1), nombre(l.at(1), decimales: 1), l.at(2))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Normales climatiques mensuelles de la forêt de Tsiazombazaha (1970-2000), lues au centre de la forêt dans WorldClim 2.1, résolution de 10 minutes d'arc (Fick et Hijmans, 2017).],
) <annexe-climat>
#titre-court(<annexe-climat>)[Normales climatiques mensuelles]

#pagebreak(weak: true)

// Carte du plan d'aménagement du TFG 2025 (04/11/2026), citée dans le Site d'étude (Gestion de la forêt) et dans le volet social (Zonage).
// Carte en couleur : aucune version en niveaux de gris n'existe (auteur, 04/11/2026). ATTENTION : reproduction d'un document du VOI : vérifier la mention « reproduit de » ou l'accord du VOI.
// ATTENTION : la légende comporte une « zone de restauration », absente du zonage de l'article 1 du contrat (« zone à améliorer et à mettre en valeur », @tab-zonage-tdg) : correspondance à vérifier. Traduction du titre malgache à vérifier.
// TGRN (légende de la carte) : transfert de gestion des ressources naturelles (auteur, 04/11/2026) ; sigle d'annexe seulement, développé dans la légende (09/11/2026).
#figure(
  image("images/carte-limites-transfert-de-gestion-2025.png", width: 100%,
    alt: "Carte en couleur de la forêt de Tsiazombazaha : zone de conservation au centre, zones de droit d'usage à l'ouest et au sud-est, zone de restauration au nord, zone de culture et de reboisement en bordure, limite du transfert de gestion, circuit touristique, aire de repos et piscines naturelles, avec quelques noms de lieux."),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Carte du plan d'aménagement de la forêt de Tsiazombazaha (« _Sarin-tany ny drafi-panajariana ny ala'ny Tsiazombazaha_ ») issue du transfert de gestion de 2025~: zones de conservation, de droit d'usage, de restauration et de culture et reboisement, limite du transfert, circuit touristique, aire de repos et piscines naturelles. TGRN~: transfert de gestion des ressources naturelles. Reproduite de VOI Maharitra (2025).],
) <annexe-carte-tfg>
#titre-court(<annexe-carte-tfg>)[Carte du plan d'aménagement (transfert de gestion de 2025)]

#pagebreak(weak: true)

#let flore = csv("analyse-tables/liste-flore.csv").slice(1)
#let nomLatin1(n) = {
  let m = n.split(" ")
  if n.ends-with("aceae") or n.ends-with("idae") { n }
  else if m.len() == 1 { [#emph(n) sp.] }
  else if m.at(1) in ("sp", "sp.", "spp", "spp.", "Sp") { [#emph(m.at(0)) sp.] }
  else if m.at(1).starts-with("(") { emph(m.at(0)) }
  else {
    let k = 2
    while k < m.len() and m.at(k) == lower(m.at(k)) and not m.at(k).starts-with("(") { k += 1 }
    [#emph(m.slice(0, k).join(" "))]
  }
}
#let taxo(n) = {
  let m = n.split(" ")
  if n == "" { [] }
  else if m.len() == 1 and n.ends-with("idae") { n }
  else if m.at(-1) == "sp." { [#emph(m.slice(0, -1).join(" ")) sp.] }
  else { emph(n) }
}
#let nomLatin(n) = {
  if n == "" { return [] }
  if n == "++" { return [++] }
  n.split(" / ").map(nomLatin1).join(" / ")
}
#let codesSources = ("Relevé": "R", "Observation": "O", "Romiguière (2025)": "Rom", "Transfert de gestion (2004)": "TFG")
#let codeSources(x) = if x == "" { "" } else { x.split(", ").map(c => codesSources.at(c, default: c)).join(", ") }
#let libellesUsages = (
  "anti_foudre": "Antifoudre", "aphrodisiaque": "Aphrodisiaque", "balai": "Balai", "batan": "Batan",
  "bois_chauffage": "Bois de chauffage", "bois_construction": "Bois de construction",
  "canaux_irrigation": "Canaux d'irrigation", "charpente": "Charpente", "cloture": "Clôture",
  "colle": "Colle", "sculpture": "Sculpture", "construction_maison": "Construction de maison", "corde": "Corde",
  "douleurs_dentaires": "Douleurs dentaires", "ecorce_sucree": "Écorce sucrée", "fatigue": "Fatigue",
  "fixation_toiture": "Fixation de toiture", "fruit_comestible": "Fruit comestible",
  "gonflements": "Gonflements", "guitare": "Guitare", "haie": "Haie", "insecticide": "Insecticide",
  "magie": "Magie", "manche_beche": "Manche de bêche", "medicinale": "Médicinale",
  "menuiserie": "Menuiserie", "outils": "Outils", "panier": "Panier", "pilon": "Pilon",
  "plancher": "Plancher", "planche": "Planche", "pirogue": "Pirogue", "poteau": "Poteau",
  "poutre": "Poutre", "the": "Thé", "tressage": "Tressage", "vertiges": "Vertiges", "source_eau": "Source d'eau",
)
#let usagesFr(s) = if s == "" { "" } else {
  s.split(" | ").map(u => libellesUsages.at(u, default: u)).dedup().join(", ")
}
#figure(
  table(
    columns: (3.5fr, 4fr, 1fr, 4fr, 2fr),
    align: (left, left, right, left, left),
    table.header([*Nom vernaculaire*], [*Nom scientifique*], [*Types*], [*Usages*], [*Source*]),
    ..flore.map(r => (emph(r.at(0)), [#nomLatin(r.at(1))#if r.at(5) == "TRUE" [\*]#if r.at(7) == "Transfert de gestion (2004)" [†]], r.at(2), usagesFr(r.at(6)), codeSources(r.at(4)))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Liste de la flore (#flore.len() noms vernaculaires~; identités réconciliées, spécimens indéterminés exclus). Nom scientifique~: espèce, genre ou famille, sans auteur ni date~; ++~: au moins deux familles possibles, aucun nom donné~; case vide si l'espèce n'est pas rattachée~; \*~: nom déduit des identifications de Romiguière (2025) sur ses deux sites~; †~: nom donné par l'inventaire du transfert de gestion (2004), prioritaire sur Romiguière (2025) et sur les identifications personnelles. Types~: nombre de types distingués par le _polisinala_ (« 1/2 »~: existence de 1 ou 2 types selon des _polisinala_ différents). Usages~: usages cités pour l'espèce. Source~: R = relevé~; O = observation hors relevé~; Rom = Romiguière (2025)~; TFG = inventaire d'espèces du transfert de gestion (2004).],
) <annexe-flore>
#titre-court(<annexe-flore>)[Liste de la flore observée]

#pagebreak(weak: true)

#figure(
  table(
    columns: (2fr, 2fr, 3fr, 0.5fr),
    align: (left, left, left, right),
    table.header([*Usage*], [*Catégorie*], [*Sous-catégorie*], [*Code*]),
    ..("Antifoudre", "Social uses", "Religious uses", "0804"),
    ..("Aphrodisiaque", "Medicines", "Genitourinary system disorders", "1107"),
    ..("Balai", "Materials", "Wood", "0604"),
    ..("Batan", "Materials", "Wood", "0604"),
    ..("Bois de chauffage", "Fuels", "Fuelwood", "0703"),
    ..("Bois de construction", "Materials", "Wood", "0604"),
    ..("Canaux d'irrigation", "Materials", "Wood", "0604"),
    ..("Charpente", "Materials", "Wood", "0604"),
    ..("Clôture", "Materials", "Wood", "0604"),
    ..("Colle", "Materials", "Unspecified materials", "0601"),
    ..("Construction de maison", "Materials", "Wood", "0604"),
    ..("Corde", "Materials", "Fibres", "0602"),
    ..("Douleurs dentaires", "Medicines", "Pain", "1119"),
    ..("Écorce sucrée", "Food", "Bark", "0107"),
        ..("Fatigue", "Medicines", "Ill-defined symptoms", "1108"),
    ..("Fixation de toiture", "Materials", "Fibres", "0602"),
    ..("Fruit comestible", "Food", "Infructescences", "0110"),
    ..("Gonflements", "Medicines", "Inflammation", "1111"),
    ..("Guitare", "Materials", "Wood", "0604"),
    ..("Haie", "Environmental uses", "Boundaries, barriers, supports", "1208"),
    ..("Insecticide", "Poisons", "Arthropoda", "1009"),
    ..("Magie", "Social uses", "Religious uses", "0804"),
    ..("Manche de bêche", "Materials", "Wood", "0604"),
    ..("Médicinale", "Medicines", "Unspecified medicinal disorders", "1101"),
    ..("Menuiserie", "Materials", "Wood", "0604"),
    ..("Outils", "Materials", "Wood", "0604"),
    ..("Panier", "Materials", "Cane etc.", "0603"),
    ..("Pilon", "Materials", "Wood", "0604"),
    ..("Pirogue", "Materials", "Wood", "0604"),
    ..("Planche", "Materials", "Wood", "0604"),
    ..("Plancher", "Materials", "Wood", "0604"),
    ..("Poteau", "Materials", "Wood", "0604"),
    ..("Poutre", "Materials", "Wood", "0604"),
    ..("Sculpture", "Materials", "Wood", "0604"),
    ..("Source d'eau", "Food", "Exudates", "0113"),
    ..("Thé", "Food", "Unspecified parts", "0101"),
    ..("Tressage", "Materials", "Cane etc.", "0603"),
    ..("Vertiges", "Medicines", "Ill-defined symptoms", "1108"),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Usages locaux selon la classification de Cook (1995). Catégorie~: niveau 1~; Sous-catégorie~: niveau 2~; Code~: sous-catégorie.],
) <annexe-codes-cook>
#titre-court(<annexe-codes-cook>)[Correspondance usages locaux et classification Cook]

#pagebreak(weak: true)

#let segment(p, q) = if p != q {
  let x0 = calc.min(p.at(0), q.at(0))
  let y0 = calc.min(p.at(1), q.at(1))
  place(top + left, dx: x0 * 1cm, dy: y0 * 1cm, line(
    start: ((p.at(0) - x0) * 1cm, (p.at(1) - y0) * 1cm),
    end: ((q.at(0) - x0) * 1cm, (q.at(1) - y0) * 1cm),
    stroke: 0.6pt,
  ))
}
#let pointe(p, q) = {
  let (px, py) = p
  let (qx, qy) = q
  let dx = qx - px
  let dy = qy - py
  let long = calc.sqrt(dx * dx + dy * dy)
  let ux = dx / long
  let uy = dy / long
  let bx = qx - 0.25 * ux
  let by = qy - 0.25 * uy
  let sommets = ((qx, qy), (bx - 0.1 * uy, by + 0.1 * ux), (bx + 0.1 * uy, by - 0.1 * ux))
  let x0 = calc.min(..sommets.map(s => s.at(0)))
  let y0 = calc.min(..sommets.map(s => s.at(1)))
  place(top + left, dx: x0 * 1cm, dy: y0 * 1cm, polygon(
    fill: black,
    ..sommets.map(((x, y)) => ((x - x0) * 1cm, (y - y0) * 1cm)),
  ))
}
#let lien(cx, yEnfant, yBus, px, pBas) = {
  segment((cx, yEnfant), (cx, yBus))
  segment((cx, yBus), (px, yBus))
  segment((px, yBus), (px, pBas))
  pointe((px, yBus), (px, pBas))
}
#let etiquette(x, y, texte, largeur: 2.2cm) = place(
  top + left,
  dx: x * 1cm - largeur / 2,
  dy: y * 1cm - 0.2cm,
  box(width: largeur, align(center, box(fill: white, inset: 1pt, text(size: 7.5pt, texte)))),
)
#let fichier(x, y, nom, largeur: 2.6cm, hauteur: 1.3cm) = place(
  top + left,
  dx: x * 1cm,
  dy: y * 1cm,
  box(width: largeur, height: hauteur, stroke: 0.6pt, fill: white, inset: 2pt, align(center + horizon, par(justify: false, text(size: 7pt, nom)))),
)

#figure(
  block(breakable: false, stack(
    spacing: 0.5cm,
    align(center, box(width: 15cm, height: 9.6cm)[
      #fichier(0.0, 0.0, "metadonnees-enquete-1-entretiens.csv", largeur: 3.4cm, hauteur: 1.5cm)
      #fichier(6.2, 0.0, "metadonnees-enquete-2-sorties.csv", largeur: 3.4cm, hauteur: 1.5cm)
      #fichier(3.1, 2.6, "metadonnees-enquete-3-enquetes.csv", largeur: 3.4cm, hauteur: 1.5cm)
      #segment((1.7, 1.5), (1.7, 1.95))
      #segment((1.7, 1.95), (4.8, 1.95))
      #segment((4.8, 1.95), (4.8, 2.6))
      #pointe((4.8, 1.95), (4.8, 2.6))
      #etiquette(3.2, 1.95, "enquête", largeur: 1.6cm)
      #segment((6.5, 3.25), (7.9, 3.25))
      #segment((7.9, 3.25), (7.9, 1.5))
      #pointe((7.9, 3.25), (7.9, 1.5))
      #etiquette(7.2, 3.25, "sortie", largeur: 1.2cm)
    #segment((12.4, 0.65), (9.6, 0.65))
    #pointe((12.4, 0.65), (9.6, 0.65))
    #etiquette(11.0, 0.65, "sortie", largeur: 1.2cm)

      #fichier(12.4, 0.0, "transects.csv")

      #fichier(0.0, 5.2, "placettes.csv")
      #fichier(3.1, 5.2, "grands-arbres.csv")
      #fichier(6.2, 5.2, "chablis.csv")
      #fichier(9.3, 5.2, "autres-observations-flore.csv")
      #fichier(12.4, 5.2, "romiguiere-2025-*.csv")
      #lien(1.3, 5.2, 4.7, 13.7, 1.3)
      #lien(4.4, 5.2, 4.7, 13.7, 1.3)
      #lien(7.5, 5.2, 4.7, 13.7, 1.3)
      #lien(10.6, 5.2, 4.7, 13.7, 1.3)
      #lien(13.7, 5.2, 4.7, 13.7, 1.3)
      #etiquette(9.0, 4.7, "transect", largeur: 1.6cm)

      #fichier(0.0, 8.0, "flore.csv")
      #fichier(3.1, 8.0, "bois-mort.csv")
      #fichier(6.2, 8.0, "phenologie.csv")
      #fichier(12.4, 8.0, "correspondance-romiguiere-2025.csv")
      #lien(1.3, 8.0, 7.4, 1.3, 6.5)
      #lien(4.4, 8.0, 7.4, 1.3, 6.5)
      #lien(7.5, 8.0, 7.4, 1.3, 6.5)
      #etiquette(5.9, 7.4, "placette", largeur: 1.6cm)
      #lien(13.7, 8.0, 7.4, 13.7, 6.5)
      #etiquette(13.7, 7.2, "nom", largeur: 1.0cm)
    ]),
    {
    set text(size: 9pt)
    table(
      inset: (x: 4pt, y: 3pt),
      columns: (3.4fr, 6fr, 2.4fr),
      align: (left, left, left),
      table.header([*Fichier*], [*Contenu*], [*Clé*]),
      [transects.csv], [Itinéraires~: date, code du _polisinala_, placettes visitées, longueurs prospectées, commune~; sortie correspondante (même date)], [transect, sortie],
      [placettes.csv], [Variables de placette, surface, régénération, longueur de ligne pour le bois mort], [transect, placette],
      [flore.csv], [Tiges mesurées (CBH) et gaulis par espèce, types, usages], [placette, observation],
      [bois-mort.csv], [Chandelles et bois mort au sol~: CBH, degré de décomposition], [placette],
      [phenologie.csv], [Fleurs et fruits observés], [placette],
      [grands-arbres.csv], [Grands arbres~: nom vernaculaire, CBH, usages], [transect, grand arbre],
      [chablis.csv], [Chablis par classe de circonférence], [transect],
      [autres-observations-flore.csv], [Espèces notées hors placettes], [transect, placette],
      [romiguiere-2025-\*.csv], [Relevés de Romiguière (2025) à Tsiazombazaha~: tiges et régénération, placettes, liste et usages de ses espèces, identifications latines de ses deux sites (extraits de son classeur)], [transect, nom],
      [correspondance-romiguiere-2025.csv], [Correspondance entre les noms vernaculaires de Romiguière (2025) et les noms réconciliés de l'étude], [nom],
      [metadonnees-enquete-1-entretiens.csv], [Entretiens~: date, durée, lieu, _fokontany_, nombre d'enquêtés], [entretien, enquête],
      [metadonnees-enquete-2-sorties.csv], [Sorties de terrain~: date, _fokontany_, motif], [sortie],
      [metadonnees-enquete-3-enquetes.csv], [Personnes enquêtées, sans leur nom~: genre, âge, profession, lien au VOI], [enquête, entretien, sortie],
    )},
  )),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Liens entre les fichiers de données et de métadonnées, et contenu de chaque fichier avec les clés qu'il porte. Chaque flèche part du fichier qui porte la clé et pointe vers le fichier visé~; la clé est indiquée sur la flèche. Les métadonnées des entretiens et des sorties, qui contiennent des noms, ne sont pas diffusées dans le dépôt.],
) <annexe-fichiers-donnees>
#titre-court(<annexe-fichiers-donnees>)[Fichiers de données et clés de liaison]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 1fr, 2fr, 3fr, 3fr, 1fr,3fr),
    align: (center, center, center, left, left, center, left),
    table.header([*Code*], [*Date*], [*Participants*], [*_Fokontany_*], [*Lieu*], [*Durée*], [*Code enquêtés*]),
    ..("E1", "15/05", "1", "Manakara", "Bureau d’Inter Aide", "02:19", "ENQ01"),
    ..("E2", "16/06", "1", "Manakana", "Plantation", "01:00", "ENQ02"),
    ..("E3", "17/06", "2", "Mizilo Gara", "Mairie", "03:30", "ENQ03, ENQ04"),
    ..("E4", "01/07", "1", "Mizilo Gara", "Mairie", "", "ENQ05"),
    ..("E5", "01/07", "2", "Tsiazombazaha / Ampasipotsy", "Maison enquêté", "00:43", "ENQ06, ENQ07"),
    ..("E6", "02/07", "3", "Mizilo Gara", "Marché", "00:52", "ENQ08, ENQ09, ENQ10"),
    ..("E7", "02/07", "1", "Mizilo Gara", "Mairie", "01:48", "ENQ11"),
    ..("E8", "02/07", "1", "Mizilo Gara", "Maison enquêté, plantation", "02:04", "ENQ12"),
    ..("E9", "03/07", "5", "Mizilo Gara", "Maison enquêté", "02:22", "ENQ12, ENQ13, ENQ14, ENQ15, ENQ16"),
    ..("E10", "08/07", "1", "Andriana", "Maison technicien, maison enquêté, champ", "04:00", "ENQ17"),
    ..("E11", "08/07", "1", "Andriana", "Maison enquêté", "03:00", "ENQ18"),
    ..("E12", "09/07", "1", "Andriana", "Maison technicien", "00:48", "ENQ19"),
    ..("E13", "09/07", "1", "Andriana", "Maison technicien", "", "ENQ20"),
    ..("E14", "09/07", "1", "Andriana", "Maison technicien", "", "ENQ21"),
    ..("E15", "10/07", "2", "Andriana", "Maison technicien", "", "ENQ22, ENQ23"),
    ..("E16", "13/07", "3", "Tsiazombazaha / Ampasipotsy", "Champ", "", "ENQ24, ENQ25, ENQ26"),
    ..("E17", "21/07", "2", "Mizilo Gara", "Mairie", "03:20", "ENQ03, ENQ12"),
    ..("E18", "22/07", "2", "Manakana", "Maison enquêté", "06:00", "ENQ27, ENQ28"),
    ..("E19", "22/07", "2", "Manakana", "Maison louée", "01:28", "ENQ29, ENQ30"),
    ..("E20", "23/07", "2", "Manakana", "Maison enquêté", "04:04", "ENQ31, ENQ32"),
    ..("E21", "27/07", "1", "Ambahatrazo", "Mairie", "", "ENQ28"),
    ..("E22", "30/07", "1", "Ambalavolo", "Maison enquêté", "01:23", "ENQ34"),
    ..("E23", "30/07", "1", "Ambalavolo", "Rue", "01:37", "ENQ35"),
    ..("E24", "31/07", "1", "Ambalavolo", "Boutique", "01:54", "ENQ36"),
    ..("E25", "06/08", "1", "Ambalavolo", "Champ", "01:18", "ENQ37"),
    ..("E26", "12/08", "2", "Amborodra", [Maison président _fokontany_], "02:30", "ENQ38, ENQ39"),
    ..("E27", "12/08", "2", "Amborodra", [Maison président _fokontany_], "02:07", "ENQ40, ENQ41"),
    ..("E28", "13/08", "1", "Amborodra", [Maison président _fokontany_], "01:54", "ENQ42"),
    ..("E29", "19/08", "1", "Manakana", "Maison louée", "01:37", "ENQ44"),
    ..("E30", "25/08", "1", "Manakana", "Maison louée", "01:49", "ENQ45"),
    ..("E31", "27/08", "1", "Manakana", "Maison louée", "01:26", "ENQ46"),
    ..("E32", "31/08", "3", "Manakana", "Maison enquêté", "01:32", "ENQ47, ENQ48, ENQ49"),
    ..("E33", "14/09", "2", "Andriana", "Maison enquêté", "", "ENQ50, ENQ51"),
    ..("E34", "14/09", "1", "Andriana", "Maison enquêté", "", "ENQ52"),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Liste des 34 entretiens semi-directifs (50 personnes, dont 14 entretiens collectifs). Date~: jour et mois de 2026~; Participants~: nombre de participants présents~; Durée~: heures et minutes, case vide si non notée~; Code enquêtés~: codes de l'annexe Personnes rencontrées.],
) <annexe-entretiens>
#titre-court(<annexe-entretiens>)[Entretiens conduits]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 1fr, 2fr, 5fr),
    align: (center, center, center, left),
    table.header([*Code*], [*Date*], [*_Fokontany_*], [*Motif*]),
    ..("S1", "mai", "Andriana", [Observation plantation _tranobe_ Inter Aide]),
    ..("S2", "16/06", "Manakana", "Chantier de plantation Manakana"),
    ..("S3", "03/07", "Mizilo Gara", "Observation de Tsiazombazaha de loin et entretiens"),
    ..("S4", "24/07", "Manakana", "Prospection des sources"),
    ..("S5", "06/08", "Mizilo Gara", "Tracé de la route de FIANTSO"),
    ..("S6", "07/08", "Mizilo Gara", "Observation de la flore agricole"),
    ..("S7", "17/08", "Manakana", "Observation de la flore agricole"),
    ..("S8", "18/08", "Manakana", "Une placette"),
    ..("S9", "19/08", "Manakana", "Chemin Manakana – Andriana"),
    ..("S10", "20/08", "Manakana", "Une placette"),
    ..("S11", "25/08", "Manakana", "Deux placettes"),
    ..("S12", "26/08", "Manakana", "Chemin Manakana – Ambila"),
    ..("S13", "27/08", "Manakana", "Quatre placettes"),
    ..("S14", "02/09", "Mizilo Gara", "Quatre placettes"),
    ..("S15", "03/09", "Mizilo Gara", "Assemblée générale du VOI"),
    ..("S16", "04/09", "Mizilo Gara", "Une placette, une piscine naturelle, échanges"),
    ..("S17", "08/09", "Manakana", [Tournée Sarah – reboisement _tranobe_ en natif]),
    ..("S18", "09/09", "Andriana", "Tournée Sarah – reboisement VOI"),
    ..("S19", "11/09", "Mizilo Gara", "Quatre placettes"),
    ..("S20", "15/09", "Andriana", "Quatre placettes"),
    ..("S21", "16/09", "Andriana", "Quatre placettes"),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Liste des 21 sorties de terrain et motif.],
) <annexe-sorties>
#titre-court(<annexe-sorties>)[Liste des sorties de terrain]

#pagebreak(weak: true)

#figure(
  [
    // Canevas du 30/06/2026 (01-methodologie/2026-06-30-canevas-entretien-mizilo.odt), mis en forme le 09/11/2026 :
    // questions reformulées en questions ouvertes et concrètes et regroupées par thème (Kaufmann, 2011) ;
    // retirés : questions fermées de classement, « Qui vit dans la forêt ? », « Qu'y a-t-il dans la forêt ? » (fusionnées),
    // « Comment restaurer la forêt ? », « Quelles sont vos priorités / les menaces qui pèsent sur vous ? »,
    // « Qu'est-ce que les gens attendent du VOI ? » ; nom de l'interprète et champs nominatifs (nom, contact) retirés.
    #set text(size: 10pt)
    #set par(justify: true, leading: 0.55em)
    #set align(left)
    #set enum(numbering: "1.", spacing: 0.75em)
    #let theme(t) = block(above: 1.3em, below: 1em, sticky: true, strong(t))
    #let relance(r) = [\ #text(size: 9pt, style: "italic")[Relances~: #r]]

    #theme[Fiche de l'entretien]
    Code de l'entretien, date, heures de début et de fin, _fokontany_, lieu, enquêteur, interprète. Enquêté~: code anonyme, genre, âge, lieu de naissance (village, _fokontany_, commune), profession, lien avec le VOI.

    #theme[Présentation (lue par l'interprète)]
    Merci d'avoir accepté de nous recevoir. Je suis traducteur-interprète et voici un étudiant français en stage. Nous travaillons pour l'ONG Inter Aide, qui reboise depuis 2015, dans certains _fokontany_, des _tanety_ dégradées appartenant à des _tranobe_ volontaires. Depuis 2025, Inter Aide s'intéresse aussi à la conservation et à la restauration de la forêt de Tsiazombazaha, en s'appuyant notamment sur le VOI. Nous souhaitons mieux comprendre l'histoire de cette forêt, son importance pour les habitants et ce qu'ils pensent du reboisement. Avez-vous des questions~? L'entretien dure environ deux heures~: cela vous convient-il~?

    #theme[1\. Parcours de l'enquêté]
    #set enum(numbering: n => [1.#n])
    + Parlez-moi de votre métier.
    + D'où venez-vous~? Comment êtes-vous arrivé ici~?
    + Quelles terres travaillez-vous, et qu'y faites-vous~? #relance[les possédez-vous ou les louez-vous~? forêt, plantations, cultures, rizières, _tanety_.]
    + Racontez-moi l'histoire de votre _tranobe_ et ses liens avec Tsiazombazaha.

    #theme[2\. La forêt]
    #set enum(numbering: n => [2.#n])
    + Racontez-moi l'histoire de la forêt. Comment a-t-elle changé, autrefois et ces dernières années~?
    + Quelles histoires, traditions ou rituels sont liés à la forêt~? #relance[esprits, lieux sacrés, interdits.]
    + À qui appartient la forêt~?
    + Qui va dans la forêt, et pour y faire quoi~? #relance[certains vont-ils jusqu'au cœur de la forêt~? le VOI a-t-il changé cela~?]
    + Quels arbres trouve-t-on dans la forêt, et à quoi servent-ils~? #relance[lesquels sont devenus rares, et pourquoi~? plantes médicinales, animaux, sources d'eau.]
    + Dans quel état est la forêt aujourd'hui~? Qu'est-ce qui la menace~?

    #theme[3\. La forêt et vous]
    #set enum(numbering: n => [3.#n])
    + À quelle fréquence allez-vous en forêt, pour y faire quoi, et combien de temps cela vous prend-il~?
    + Que vous apporte la forêt~? #relance[expliquez-moi comment vous chassez, récoltez le miel, cueillez ou abattez un arbre~; quel bois utilisez-vous, et pour quoi~? y a-t-il autant de ressources qu'avant~? que faites-vous quand vous ne les trouvez plus en forêt~?]
    + Qu'est-ce qui a changé dans votre accès à la forêt~? Qu'en pensez-vous~?
    + Votre regard sur la forêt a-t-il changé~?

    #theme[4\. Le VOI et vous]
    #set enum(numbering: n => [4.#n])
    + Comment avez-vous connu le VOI~? #relance[pourquoi avez-vous adhéré, ou non~?]
    + Que pensez-vous de ses actions~? #relance[reboisement, interdictions et sanctions~; qu'est-ce qui a changé depuis le retour du VOI~?]
    + Qu'attendez-vous du VOI~?

    #theme[5\. Le reboisement]
    #set enum(numbering: n => [5.#n])
    + À quoi sert-il de planter des arbres~? Qu'attendez-vous des plantations~?
    + Où faut-il planter, et à qui appartiennent ces collines~?
    + Quels arbres faut-il planter~? #relance[natifs, exotiques ou fruitiers (cannelle, manguier)~?]
    + Racontez-moi comment s'est déroulée la plantation organisée par le VOI. #relance[y avez-vous participé, et pourquoi~? à quelles conditions participeriez-vous à une plantation près de la forêt~?]
    + Expliquez-moi comment vous plantez un arbre. #relance[pépinière, transplantation, entretien.]
    + À qui profiteront les plantations du VOI~? Qu'est-ce qui peut les menacer~?
    + Qu'attendez-vous d'Inter Aide~?

    #theme[6\. Fonctionnement du VOI (membres du bureau et DREDD)]
    #set enum(numbering: n => [6.#n])
    + Présentez-nous le VOI. #relance[combien de membres compte-t-il par commune~?]
    + Racontez-nous la mise en place du VOI. #relance[qui a voulu le transfert de gestion, en 2004 puis en 2025~? pourquoi n'a-t-il pas été renouvelé~? comment s'est déroulée la médiation environnementale~?]
    + Que s'est-il passé pendant les années sans transfert de gestion~? #relance[la DREDD est-elle intervenue~?]
    + Que prévoit le plan de gestion~? #relance[à quoi correspondent les zones~? à quoi serviront les zones de reboisement~? une exploitation forestière est-elle envisagée~?]
    + Quelles actions le VOI mène-t-il aujourd'hui~? #relance[patrouilles des _polisinala_, reboisement.]
    + Pourquoi vous êtes-vous engagé dans le bureau du VOI~?
    + Quelles difficultés rencontrez-vous, et comment pensez-vous les surmonter~? #relance[tous les membres et toutes les communes s'impliquent-ils autant~? pourquoi~?]
    + Quelles relations entretenez-vous avec la DREDD~?

    #theme[Clôture]
    Souhaitez-vous revenir sur un point ou aborder un sujet dont nous n'avons pas parlé~? Avez-vous des questions~? Remercier la personne et l'informer qu'une fiche de synthèse en malgache sera disponible auprès du technicien d'Inter Aide à partir de novembre.
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Canevas d'entretien semi-directif (version du 30 juin 2026). Les questions servaient de guide~: leur ordre et leur formulation ont été adaptés à chaque échange, et les relances suivaient les propos des enquêtés. La partie 6 ne concernait que les membres du bureau du VOI et l'administration forestière.],
) <annexe-canevas>
#titre-court(<annexe-canevas>)[Canevas d'entretien]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 3fr, 2fr, 2fr),
    align: (center, center, center, left, left, left),
    table.header([*Code*], [*Genre*], [*Âge*], [*Profession*], [*Lien au VOI*], [*_Fokontany_*]),
    ..("ENQ01", "H", "", "Responsable programme", "", "Manakara"),
    ..("ENQ02", "H", "30", "Coordinateur programme", "", "Manakana"),
    ..("ENQ03", "H", "65", "Agriculteur", "Vice-président", "Mizilo Gara"),
    ..("ENQ04", "H", "57", "Agriculteur", [_polisinala_], "Mizilo Gara"),
    ..("ENQ05", "H", "", [Président _fokontany_], "", "Mizilo Gara"),
    ..("ENQ06", "H", "", "", "Aucun", "Tsiazombazaha / Ampasipotsy"),
    ..("ENQ07", "F", "", "", "Aucun", "Tsiazombazaha / Ampasipotsy"),
    ..("ENQ08", "H", "36", "Agriculteur", "Aucun", "Mizilo Gara"),
    ..("ENQ09", "H", "40", "Agriculteur", "Aucun", "Mizilo Gara"),
    ..("ENQ10", "H", "62", "", "Observateur", "Mizilo Gara"),
    ..("ENQ11", "H", "", "Agriculteur, maire", "Membre", "Mizilo Gara"),
    ..("ENQ12", "H", "66", "Agriculteur", "Secrétaire", "Mizilo Gara"),
    ..("ENQ13", "H", "35", "Instituteur", "Membre", "Mizilo Gara"),
    ..("ENQ14", "F", "28", "Agricultrice, vannière", "Membre", "Mizilo Gara"),
    ..("ENQ15", "H", "47", "Agriculteur", "Ancien membre", "Mizilo Gara"),
    ..("ENQ16", "F", "37", "Agricultrice, vannière", "Ancienne membre", "Mizilo Gara"),
    ..("ENQ17", "H", "", [Président _fokontany_], "", "Andriana"),
    ..("ENQ18", "H", "", "Agriculteur, éleveur", "Président du VOI", "Andriana"),
    ..("ENQ19", "H", "", "Agriculteur", [Pépiniériste, _polisinala_], "Andriana"),
    ..("ENQ20", "H", "", "", "Pépiniériste", "Andriana"),
    ..("ENQ21", "F", "54", "Agent communautaire", "Membre", "Andriana"),
    ..("ENQ22", "H", "26", "Agriculteur", [_polisinala_], "Andriana"),
    ..("ENQ23", "H", "", "", [Conseiller, _polisinala_], "Andriana"),
    ..("ENQ24", "H", "", "", [_polisinala_, comité feu], "Ampasipotsy"),
    ..("ENQ25", "F", "", "", "Membre", "Ampasipotsy"),
    ..("ENQ26", "H", "", [Président _fokontany_], "Comité feu", "Ampasipotsy"),
    ..("ENQ27", "H", "", "", "Vice-président", "Ambahatrazo"),
    ..("ENQ28", "H", "", "", "Trésorier", "Manakana"),
    ..("ENQ29", "H", "", [Président _fokontany_], [_polisinala_], "Manakana"),
    ..("ENQ30", "H", "", [Vice-président _fokontany_], "", "Manakana"),
    ..("ENQ31", "H", "", "", "", "Manakana"),
    ..("ENQ32", "H", "", "", "", "Manakana"),
    ..("ENQ33", "H", "50", "Agriculteur", [_polisinala_], "Manakana"),
    ..("ENQ34", "F", "38", "Agent communautaire", "Aucun", "Ambalavolo"),
    ..("ENQ35", "H", "25", "Agriculteur", "Aucun", "Ambalavolo"),
    ..("ENQ36", "F", "21", "Agricultrice, commerçante", "Aucun", "Ambalavolo"),
    ..("ENQ37", "H", "51", [Agriculteur, _polisinala_], [_polisinala_], "Ambalavolo"),
    ..("ENQ38", "H", "49", [_Ampazaka_, agriculteur], "Membre", "Amborodra"),
    ..("ENQ39", "H", "65", "Agriculteur", "Ancien membre", "Amborodra"),
    ..("ENQ40", "H", "55", [Agriculteur, président _fokontany_], "Membre", "Amborodra"),
    ..("ENQ41", "H", "40", "Agriculteur, adjoint", "Membre", "Amborodra"),
    ..("ENQ42", "H", "69", "Agriculteur", "Membre", "Amborodra"),
    ..("ENQ43", "H", "", "Agriculteur", [_polisinala_], "Manakana"),
    ..("ENQ44", "F", "", "Technicienne programme", "Aucun", "Manakana"),
    ..("ENQ45", "H", "43", "Agriculteur", "Membre", "Manakana"),
    ..("ENQ46", "H", "35", [Agriculteur, _ampazaka_], "Pépiniériste", "Manakana"),
    ..("ENQ47", "F", "30", "Agricultrice", "Aucun / Membre", "Manakana"),
    ..("ENQ48", "H", "47", "Agriculteur", "Membre", "Manakana"),
    ..("ENQ49", "F", "38", "", "Membre", "Manakana"),
    ..("ENQ50", "H", "", "", [_polisinala_], "Andriana"),
    ..("ENQ51", "H", "", "", "Membre", "Andriana"),
    ..("ENQ52", "H", "", "", "Membre", "Andriana"),
    ..("ENQ53", "H", "54", [Agriculteur, _ampazaka_], [_polisinala_], "Mizilo Gara"),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Description des personnes rencontrées en entretien ou en sortie (n = 53, dont 50 en entretien). Genre~: H = homme, F = femme~; Âge~: en années. Case vide~: non renseigné ou sans objet.],
) <annexe-echantillon-social>
#titre-court(<annexe-echantillon-social>)[Personnes rencontrées en entretien ou en sortie]

#pagebreak(weak: true)

#let caracParPlacette = csv("analyse-tables/placettes-caracteristiques.csv").slice(1)
// Page en portrait, figure pivotée d'un quart de tour (auteur, 04/11/2026) ; largeur du bloc = hauteur utile de la page.
// Bloc centré horizontalement et verticalement dans la zone de texte de la page.
#context block(width: 100%, height: 100%, align(center + horizon, rotate(-90deg, reflow: true, block(width: page.height - 5cm)[
#figure(
  [
    #show table: set text(size: 10pt)
    #table(
      // Largeurs fixées pour que la canopée tienne sur une ligne en 10 pt, comme les autres tableaux des annexes (auteur, 09/11/2026).
      columns: (1.65cm, 1.8cm, 1.2cm, 3.85cm, 2.35cm, 3.15cm, 1.75cm, 1.9cm, 1.7cm, 1.45cm, 1.5cm, 2.4cm),
      align: (left, left, center, center, left, left, left, center, center, center, center, center),
      inset: (x: 2.5pt, y: 2pt),
      table.header([*Placette*], [*Itinéraire*], [*Pente (%)*], [*Canopée (%) \ N/E/S/O*], [*Strates*], [*Humus*], [*Sol*], [*Épiphytes*], [*Mousses*], [*Lichens*], [*Lianes*], [*Champignons*]),
      // Canopée sans espaces autour des « / » pour tenir sur une ligne (mise en forme seule).
      ..caracParPlacette.map(r => r.enumerate().map(((i, x)) => if x == "NA" { "" } else if i == 3 { x.replace(" / ", "/") } else { x })).flatten(),
    )
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Caractéristiques par placette. Canopée~: classe de recouvrement estimée dans les quadrants nord, est, sud et ouest. Strates présentes~: H, herbacée (0 à 2~m)~; A, sous-bois ou arbustive (2 à 10~m)~; Ci, canopée inférieure (10 à 20~m)~; Cs, canopée supérieure (plus de 20~m). Humus selon Jabiol et al. (2009)~; deux types séparés par « / »~: types notés ensemble sur le terrain. Sol~: humidité du sol au toucher. Épiphytes, mousses, lichens, lianes et champignons~: nombre d'arbres porteurs (0-2, 3-10, > 10). Case vide~: non noté.],
) <annexe-caracteristiques-placettes>
#titre-court(<annexe-caracteristiques-placettes>)[Caractéristiques par placette]
])))

#pagebreak(weak: true)

#figure(
  table(

    columns: (3fr, 3fr, 2fr, 2fr),
    align: (left, left, left, left),
    table.header([*Nom vernaculaire*], [*Taxonomie*], [*Groupe*], [*Source*]),
    ..("Simpona", taxo("Propithecus diadema"), "Lémuriens", "TFG"),
    ..("Tantana", taxo("Phaner furcifer"), "Lémuriens", "TFG"),
    ..("Tsitsidy", taxo("Microcebus sp."), "Lémuriens", "TFG"),
    ..("Varikandana", taxo("Varecia variegata"), "Lémuriens", "TFG"),
    ..("Varikovoka", taxo("Lemur fulvus rufus"), "Lémuriens", "TFG"),
    ..("", taxo("Avahi laniger"), "Lémuriens", "Rajaonson"),
    ..("", taxo("Eulemur rufus"), "Lémuriens", "Rajaonson"),
    ..("Alazana", "", "Mammifères", "TFG"),
    ..("Fanaloka", taxo("Eupleres goudotii"), "Mammifères", "TFG"),
    ..("Fandrefiala", "", "Mammifères", "TFG"),
    ..("Fosa", taxo("Cryptoprocta ferox"), "Mammifères", "TFG"),
    ..("Hala", "", "Mammifères", "TFG"),
    ..("Lambo", taxo("Potamochoerus larvatus"), "Mammifères", "Observation, TFG"),
    ..("Langoso", "", "Mammifères", "TFG"),
    ..("Maingoka", "", "Mammifères", "TFG"),
    ..("Menarana", taxo("Leoheterodon sp."), "Mammifères", "TFG"),
    ..("Sokina", taxo("Setifer setosus"), "Mammifères", "TFG"),
    ..("Tombotsodina", taxo("Fossa fossana"), "Mammifères", "TFG"),
    ..("Trambo", "", "Mammifères", "TFG"),
    ..("Trandraka", taxo("Tenrec ecaudatus"), "Mammifères", "TFG"),
    ..("Voalavo be bonga", taxo("Rattus rattus"), "Mammifères", "TFG"),
    ..("Voalavo fody", taxo("Neosomys rufus"), "Mammifères", "TFG"),
    ..("Voantsira", taxo("Galidia elegans"), "Mammifères", "TFG"),
    ..("Voatandroka", "", "Mammifères", "TFG"),
    ..("Akanga", taxo("Numida meleagris"), "Oiseaux", "TFG"),
    ..("Akohonala", taxo("Lophotibis cristata"), "Oiseaux", "TFG"),
    ..("Anjay", "", "Oiseaux", "Observation"),
    ..("Boeza", "", "Oiseaux", "Observation"),
    ..("Boizo", "", "Oiseaux", "Observation"),
    ..("Boloky be", taxo("Coracopsis vasa"), "Oiseaux", "TFG"),
    ..("Boloky kely", taxo("Coracopsis nigra"), "Oiseaux", "TFG"),
    ..("Finaingo maitso", taxo("Treron australis"), "Oiseaux", "TFG"),
    ..("Finaingo manga", taxo("Alectroenas sp."), "Oiseaux", "TFG"),
    ..("Fody", taxo("Foudia sp."), "Oiseaux", "TFG"),
    ..("Goaika", taxo("Corvus albus"), "Oiseaux", "Observation, TFG"),
    ..("Hitsikitsika", taxo("Falco newtoni"), "Oiseaux", "TFG"),
    ..("Kitreoka", "", "Oiseaux", "Observation"),
    ..("Leromba", "", "Oiseaux", "Observation"),
    ..("Marotaina", taxo("Archidothera tristis"), "Oiseaux", "TFG"),
    ..("Papango", taxo("Milvus aegyptius"), "Oiseaux", "Observation, TFG"),
    ..("Railovy", taxo("Dicrurus forficatus"), "Oiseaux", "TFG"),
    ..("Sarivazo", taxo("Agapornis canus"), "Oiseaux", "TFG"),
    ..("Sohimanga", taxo("Nectarinia notata"), "Oiseaux", "TFG"),
    ..("Sohimanga", taxo("Nectarinia souimanga"), "Oiseaux", "TFG"),
    ..("Tetso", taxo("Accipitridae"), "Oiseaux", "Observation"),
    ..("Toloho", taxo("Centropus toulou"), "Oiseaux", "Observation, TFG"),
    ..("Tsipoy", taxo("Margaroperdix sp."), "Oiseaux", "TFG"),
    ..("Vano", taxo("Butorides striata"), "Oiseaux", "TFG"),
    ..("Vano", taxo("Egretta alba"), "Oiseaux", "TFG"),
    ..("Vano", taxo("Nycticorax nycticorax"), "Oiseaux", "TFG"),
    ..("Voromahery", taxo("Accipiter francesii"), "Oiseaux", "TFG"),
    ..("Voromahery", taxo("Accipiter sp."), "Oiseaux", "TFG"),
    ..("Vorompotsy", taxo("Bubulcus ibis"), "Oiseaux", "TFG"),
    ..("Vorondolo", taxo("Asio sp."), "Oiseaux", "TFG"),
    ..("Vorondreo", "", "Oiseaux", "Observation"),
    ..("Lapata", "", "Reptiles", "TFG"),
    ..("Mandotra", taxo("Sauzinia sp."), "Reptiles", "TFG"),
    ..("Tanapisaka", taxo("Uroplatus sp."), "Reptiles", "TFG"),
    ..("Tarondro", "", "Reptiles", "TFG"),
    ..("Voalavo", taxo("Chamaeleo parsonii"), "Reptiles", "TFG"),
    ..("Sahona", taxo("Mantella sp."), "Amphibiens", "TFG"),
    ..("Soabakaka", taxo("Rana sp."), "Amphibiens", "TFG"),
    ..("Vitsika", taxo("Formicidae"), "Arthropodes", "Observation"),
    ..("", taxo("Clubionidae"), "Arthropodes", "GBIF"),
    ..("", taxo("Nesticidae"), "Arthropodes", "GBIF"),
    ..("", taxo("Salticidae"), "Arthropodes", "GBIF"),
    ..("", taxo("Spirostreptidae"), "Arthropodes", "GBIF"),
    ..("", taxo("Zodariidae"), "Arthropodes", "GBIF"),
    ..("", taxo("Acavidae"), "Mollusques", "GBIF"),
    ..("", taxo("Ampelita sp."), "Mollusques", "GBIF"),
    ..("", taxo("Boucardicus sp."), "Mollusques", "GBIF"),
    ..("", taxo("Cyathopoma sp."), "Mollusques", "GBIF"),
    ..("", taxo("Embertoniphanta farafanga"), "Mollusques", "GBIF"),
    ..("", [Gastropoda], "Mollusques", "GBIF"),
    ..("", [Gastropoda], "Mollusques", "GBIF"),
    ..("", [Gastropoda], "Mollusques", "GBIF"),
    ..("", taxo("Gulella sp."), "Mollusques", "GBIF"),
    ..("", taxo("Hainesia sp."), "Mollusques", "GBIF"),
    ..("", taxo("Helicophanta bicingulata"), "Mollusques", "GBIF"),
    ..("", taxo("Helicophanta souverbiana"), "Mollusques", "GBIF"),
    ..("", taxo("Helicophanta sp."), "Mollusques", "GBIF"),
    ..("", taxo("Kalidos sp."), "Mollusques", "GBIF"),
    ..("", taxo("Kaliella sp."), "Mollusques", "GBIF"),
    ..("", [Littorinimorpha], "Mollusques", "GBIF"),
    ..("", taxo("Malagarion sp."), "Mollusques", "GBIF"),
    ..("", taxo("Microcystis sp."), "Mollusques", "GBIF"),
    ..("", taxo("Parvedentulina sp."), "Mollusques", "GBIF"),
    ..("", taxo("Reticulapex sp."), "Mollusques", "GBIF"),
    ..("", taxo("Sitala sp."), "Mollusques", "GBIF"),
    ..("", taxo("Subulina sp."), "Mollusques", "GBIF"),
    ..("", taxo("Tropidophora sp."), "Mollusques", "GBIF"),
    ..("Akoragna", "", "Non identifiés", "Observation"),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Liste de la faune établie. Taxonomie~: nom scientifique sans auteur ni date. Sources~: Observation (observations de terrain, 2026)~; TFG~: transfert de gestion du VOI Maharitra (2004)~; Rajaonson~: Rajaonson et al. (2010)~; GBIF~: téléchargement du 3 novembre 2026, cité en @gbif_2026, 28 taxons de non-vertébrés relevés à Tsiazombazaha, 204 occurrences au total. Les espèces citées par le transfert n'ont pas été observées par l'auteur.],
) <annexe-faune>
#titre-court(<annexe-faune>)[Liste de la faune établie]

#pagebreak(weak: true)

// Tableau unique, une ligne par placette, sur une page portrait pivotée, comme l'annexe des caractéristiques par placette (auteur, 04/11/2026).
#context block(width: 100%, height: 100%, align(center + horizon, rotate(-90deg, reflow: true, block(width: page.height - 5cm)[
#figure(
  [
    #show table: set text(size: 10pt)
    #table(
      columns: 10 * (auto,),
      align: (left,) + 9 * (right,),
      inset: (x: 5pt, y: 2pt),
      table.header([*Placette*], [*Surface*], [*Tiges mesurées*], [*Gaulis*], [*N*], [*G*], [*S*], [*H*], [*1/Simpson*], [*α de Fisher*]),
      ..placettesN.map(n => {
        let g = placettesG.find(r => r.at(0) == n.at(0))
        let a = placettesAlpha.find(r => r.at(0) == n.at(0))
        (n.at(0), sig3(n.at(1)), n.at(2), n.at(3), sig3(n.at(6)), nombre(g.at(4), decimales: 1), a.at(1), sig3(a.at(2)), sig3(a.at(4)), sig3(a.at(6)))
      }).flatten(),
    )
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Indices par placette. Surface horizontale en m²~; N~: densité en tiges par hectare (tiges mesurées et gaulis)~; G~: surface terrière en m² par hectare (tiges mesurées). S~: richesse spécifique~; H~: indice de Shannon (H′)~; 1/Simpson~: inverse de l'indice de Simpson~; α de Fisher~: paramètre de la distribution log-série. Indices calculés sur toutes les tiges comptées, tiges indéterminées exclues.],
) <annexe-indices-placettes>
#titre-court(<annexe-indices-placettes>)[Indices par placette]
])))

#pagebreak(weak: true)

#figure(
  [
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 1.2em,
      row-gutter: 1.2em,
      table(
        columns: (1fr, 1.4fr),
        align: (left, right),
        table.header([*Classe de diamètre*], [*Densité ± ET*]),
        ..classesN.map(r => (nombre(r.at(0), decimales: 1) + " – " + nombre(str(float(r.at(0)) + 2.5), decimales: 1), if float(r.at(0)) == 0 { nombreIC(r.at(1), r.at(2), r.at(3)).join(" ") } else { nombreET(r.at(1), etStudent(r.at(2), r.at(3))) })).flatten(),
      ),
      table(
        columns: (1fr, 1.4fr),
        align: (left, right),
        table.header([*Classe de diamètre*], [*G ± ET*]),
        ..classesG.map(r => (nombre(r.at(4), decimales: 1) + " – " + nombre(r.at(5), decimales: 1), nombreET(r.at(1), etStudent(r.at(2), r.at(3))))).flatten(),
      ),
      table(
        columns: (1fr, 1fr, 1fr),
        align: (left, right, right),
        table.header([*Classe de diamètre, transects*], [*Arbres*], [*Densité ± ET*]),
        ..classesNGA.map(r => (nombre(r.at(0), decimales: 1) + " – " + nombre(str(float(r.at(0)) + 2.5), decimales: 1), r.at(1), nombreET(r.at(2), r.at(3)))).flatten(),
      ),
      table(
        columns: (1fr, 1fr, 1fr),
        align: (left, right, right),
        table.header([*Classe de diamètre, transects*], [*Arbres*], [*G ± ET*]),
        ..classesGGA.map(r => (nombre(r.at(0), decimales: 1) + " – " + nombre(r.at(1), decimales: 1), r.at(2), nombre(r.at(4), decimales: 1) + " ± " + nombre(r.at(5), decimales: 1))).flatten(),
      ),
    )
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Densité et surface terrière par classe de diamètre (classes en cm~; densité en tiges par hectare, sauf pour les transects en arbres par hectare~; G en m² par hectare~; ET~: erreur-type)~: moyenne entre placettes ± erreur-type~: 28 placettes de l'étude et 8 placettes de 40 m² de Romiguière (2025), sauf pour la classe 0 – 2,5 cm (28 placettes de l'étude), donnée avec son intervalle de confiance à 95 % entre crochets, faute d'erreur-type. La classe 0 – 2,5 cm inclut les gaulis~; les classes sans tige sont absentes. Deux derniers tableaux~: grands arbres des transects (CBH ≥ 126 cm, soit un DBH d'au moins 40 cm), effectif et surface terrière rapportés aux 53 050 m² de bande prospectée sur cinq transects~; ET~: erreur-type de l'estimateur par le ratio entre transects.],
) <annexe-classes-diametre>
#titre-court(<annexe-classes-diametre>)[Densité et surface terrière par classe de diamètre]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1.2fr, 1.2fr, 1.6fr),
    align: (left, right, right, left, left, left),
    table.header([*Placette*], [*NMDS1*], [*NMDS2*], [*Itinéraire*], [*_Polisinala_*], [*Commune*]),
    ..pointsNMDS.map(r => (r.at(0), sig3(r.at(1)), sig3(r.at(2)), r.at(3), r.at(4), r.at(5))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Coordonnées des 28 placettes dans l'ordination NMDS (dissimilarité de Jaccard, deux dimensions, stress = 0,218), avec leur itinéraire, leur commune et le code de leur _polisinala_ (code d'enquêté, voir @annexe-echantillon-social).],
) <annexe-beta>
#titre-court(<annexe-beta>)[Coordonnées des placettes (NMDS)]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 2.5fr, 1fr, 1fr, 1fr, 1fr),
    align: (right, left, right, right, right, right),
    table.header([*Rang*], [*Espèce*], [*DR*], [*DoR*], [*FR*], [*IVI*]),
    ..ivi.map(r => (r.at(0), emph(r.at(1)), nombre(r.at(5)), nombre(r.at(6)), nombre(r.at(7)), nombre(r.at(8)))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Indice de valeur d'importance (IVI) des 124 espèces (28 placettes~; 479 tiges mesurées, gaulis et tiges indéterminées exclus). DR~: densité relative~; DoR~: dominance relative~; FR~: fréquence relative~; IVI = (DR + DoR + FR) / 3~; DR, DoR, FR et IVI en % (sur 100).],
) <annexe-ivi>
#titre-court(<annexe-ivi>)[Indice de valeur d'importance (IVI)]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 1.4fr, 1.2fr, 1.2fr, 2fr, 1.1fr),
    align: (right, left, right, right, right, right),
    table.header([*Placettes*], [*Méthode*], [*Surface*], [*Richesse*], [*IC 95*], [*Couverture*]),
    ..rarefactionAnnexe.map(r => (r.at(1), methodes.at(r.at(2)), sig3(r.at(10)), ..nombreIC(r.at(4), r.at(5), r.at(6)), sig3(r.at(7)))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Courbe de raréfaction-extrapolation de la richesse spécifique (modèle d'incidence, ordre q = 0)~: richesse (nombre d'espèces) et couverture d'échantillonnage (proportion, de 0 à 1) selon le nombre de placettes et la surface horizontale cumulée (en m²)~; IC 95 % (intervalle de confiance à 95 %) par bootstrap. Extrapolation~: tous les points calculés. Les estimateurs asymptotiques figurent dans le corps du texte.],
) <annexe-richesse>
#titre-court(<annexe-richesse>)[Courbe de raréfaction-extrapolation]

#pagebreak(weak: true)

// Carte dessinée par les anciens (déplacée du volet social, 09/11/2026), citée dans Résultats du volet social, Zonage ; placée en dernière annexe (ordre de première citation, 09/11/2026).
// ATTENTION : ne faire figurer ni le nom de l'ancien ni aucune donnée nominative.
#figure(
  image("images/carte-tsiazombazaha-ancien.pdf", width: 100%,
    alt: "Carte dessinée à la main de la forêt de Tsiazombazaha : périmètre et noms de lieux."),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Carte de la forêt de Tsiazombazaha dessinée à la main lors d'une visite entre anciens~: périmètre et noms des lieux importants. Document remis par un ancien~; photographie~: auteur.],
) <annexe-carte-anciens>
#titre-court(<annexe-carte-anciens>)[Carte de la forêt dessinée par les anciens]
