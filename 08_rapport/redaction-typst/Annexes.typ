#import "TitresCourts.typ": titre-court

#show figure.where(kind: "annexe"): set figure.caption(position: top)
#set figure(numbering: "1")
#show figure.where(kind: "annexe"): set block(breakable: true)

#let nombre(x, decimales: 2) = {
  if x.match(regex("^-?[0-9]+(\.[0-9]+)?([eE]-?[0-9]+)?$")) == none { return x }
  let v = calc.round(float(x), digits: decimales)
  let parties = str(calc.abs(v)).split(".")
  let dec = if parties.len() > 1 { parties.at(1) } else { "" }
  while dec.len() < decimales { dec += "0" }
  let signe = if v < 0 { "−" } else { "" }
  if decimales == 0 { signe + parties.at(0) } else { signe + parties.at(0) + "," + dec }
}

#let placettesN = csv("analyse-tables/structure_N_placettes.csv").slice(1)
#let placettesG = csv("analyse-tables/structure_G_placettes.csv").slice(1)
#let placettesAlpha = csv("analyse-tables/diversite_alpha_placettes.csv").slice(1)
#let classesN = csv("analyse-tables/sensibilite_romiguiere_classes_N.csv").slice(1)
#let classesG = csv("analyse-tables/sensibilite_romiguiere_classes_G.csv").slice(1)
#let classesNGA = csv("analyse-tables/transects_grands_arbres_classes_N.csv").slice(1)
#let classesGGA = csv("analyse-tables/transects_grands_arbres_classes_G.csv").slice(1)
#let pointsNMDS = csv("analyse-tables/diversite_beta_nmds_points_anonyme.csv").slice(1)
#let ivi = csv("analyse-tables/ivi_especes.csv").slice(1)
#let rarefaction = csv("analyse-tables/courbe_raréfaction_extrapolation.csv").slice(1)
#let rarefactionAnnexe = rarefaction
#let methodes = (Rarefaction: "Interpolation", Observed: "Observé", Extrapolation: "Extrapolation")

#pagebreak(weak: true)
= Table des annexes

#outline(title: none, target: figure.where(kind: "annexe"))

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
  caption: [Liste des 34 entretiens semi-directifs (50 personnes, dont 14 entretiens collectifs). Date : jour et mois de 2026 ; Participants : nombre de participants présents ; Durée : heures et minutes, case vide si non notée ; Code enquêtés : codes de l'annexe Personnes rencontrées.],
) <annexe-entretiens>
#titre-court(<annexe-entretiens>)[Entretiens conduits]

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
    ..("ENQ100", "H", "54", [Agriculteur, _ampazaka_], [_polisinala_], "Mizilo Gara"),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Description des personnes rencontrées en entretien ou en sortie (n = 53, dont 50 en entretien). Genre : H = homme, F = femme ; Âge : en années. Case vide : non renseigné ou sans objet.],
) <annexe-echantillon-social>
#titre-court(<annexe-echantillon-social>)[Personnes rencontrées en entretien ou en sortie]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 1fr, 2fr, 5fr),
    align: (center, center, center, left),
    table.header([*Code*], [*Date*], [*_Fokontany_*], [*Motif*]),
    ..("S1", "mai", "Andriana", [Observation plantation _tranobe_ IA]),
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
#lorem(150)
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Canevas d'entretien.],
) <annexe-canevas>
#titre-court(<annexe-canevas>)[Canevas d'entretien]

#pagebreak(weak: true)

#figure(
  [
#lorem(150)
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Protocole de relevé et matériel.],
) <annexe-protocole>
#titre-court(<annexe-protocole>)[Protocole de relevé et matériel]

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
  caption: [Usages locaux selon la classification de Cook (1995). Catégorie : niveau 1 ; Sous-catégorie : niveau 2 ; Code : sous-catégorie.],
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
    spacing: 0.8cm,
    align(center, box(width: 15cm, height: 9.6cm)[
      #fichier(0.0, 0.0, "metadonnees_enquete-de-terrain_1_entretiens.csv", largeur: 3.4cm, hauteur: 1.5cm)
      #fichier(6.2, 0.0, "metadonnees_enquete-de-terrain_2_sorties.csv", largeur: 3.4cm, hauteur: 1.5cm)
      #fichier(3.1, 2.6, "metadonnees_enquete-de-terrain_3_enquetes.csv", largeur: 3.4cm, hauteur: 1.5cm)
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
    table(
      columns: (3.4fr, 5fr, 2.4fr),
      align: (left, left, left),
      table.header([*Fichier*], [*Contenu*], [*Clé*]),
      [transects.csv], [Itinéraires : date, _polisinala_, placettes visitées, longueurs prospectées, commune ; sortie correspondante (même date)], [transect, sortie],
      [placettes.csv], [Variables de placette, surface, régénération, longueur de ligne pour le bois mort], [transect, placette],
      [flore.csv], [Tiges mesurées (CBH) et gaulis par espèce, types, usages], [placette, observation],
      [bois-mort.csv], [Chandelles et bois mort au sol : CBH, degré de décomposition], [placette],
      [phenologie.csv], [Fleurs et fruits observés], [placette],
      [grands-arbres.csv], [Grands arbres : nom vernaculaire, CBH, usages], [transect, grand arbre],
      [chablis.csv], [Chablis par classe de circonférence], [transect],
      [autres-observations-flore.csv], [Espèces notées hors placettes], [transect, placette],
      [romiguiere-2025-\*.csv], [Relevés de Romiguière (2025) à Tsiazombazaha : tiges et régénération, placettes, liste et usages de ses espèces, identifications latines de ses deux sites (extraits de son classeur)], [transect, nom],
      [correspondance-romiguiere-2025.csv], [Correspondance entre les noms vernaculaires de Romiguière et les noms latins], [nom],
      [metadonnees_enquete-de-terrain_1_entretiens.csv], [Entretiens : date, durée, lieu, _fokontany_, nombre d'enquêtés], [entretien, enquête],
      [metadonnees_enquete-de-terrain_2_sorties.csv], [Sorties de terrain : date, _fokontany_, motif], [sortie],
      [metadonnees_enquete-de-terrain_3_enquetes.csv], [Personnes enquêtées : genre, âge, profession, lien au VOI], [enquête, entretien, sortie],
    ),
  )),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Liens entre les fichiers de données et de métadonnées, et contenu de chaque fichier avec les clés qu'il porte. Chaque flèche part du fichier qui porte la clé et pointe vers le fichier visé ; la clé est indiquée sur la flèche.],
) <annexe-fichiers-donnees>
#titre-court(<annexe-fichiers-donnees>)[Fichiers de données et clés de liaison]

#pagebreak(weak: true)

// TODOAVANTDEPOT : mettre à jour l'arborescence, le nombre de fichiers et les poids (état du 03/11/2026 ; depuis : References.typ supprimé, carbone_total_foret.csv ajouté) avant le dépôt final.
#figure(
  stack(
    spacing: 0.8cm,
      block(width: 100%, text(size: 10pt, raw(block: true, lang: "text", "madagascar-tsiazombazaha/\n├── .gitignore\n├── LICENSE\n├── README.md\n├── 05_Sociologie/\n│   ├── brouillons-redaction/\n│   ├── canevas/\n│   └── donnees/\n├── 06_ecologie/\n│   ├── analyse/\n│   │   ├── donnees/\n│   │   ├── referentiels/\n│   │   ├── scripts/\n│   │   │   ├── fonctions/\n│   │   │   ├── archives/\n│   │   │   └── scripts-a-ne-pas-relancer/\n│   │   └── sorties/\n│   │       ├── figures/\n│   │       └── resumes-pour-rapport/\n│   ├── archivage-donnees/\n│   └── methodologie/\n└── 08_rapport/\n    ├── consignes-redaction-et-templates/\n    ├── documents-brouillons/\n    │   └── points-de-travail/\n    ├── documents-etapes/\n    ├── donnees/\n    └── redaction-typst/\n        ├── analyse-figures/\n        ├── analyse-tables/\n        └── images/"))),
      table(
        columns: (3.2fr, 8.2fr, 1.2fr, 1.4fr),
        align: (left, left, right, right),
        table.header([*Dossier*], [*Contenu*], [*Fichiers*], [*Poids*]),
        [./], [Présentation du dépôt (README.md), licence, règles d'exclusion Git (.gitignore).], [3], [8 ko],
        [./05_Sociologie/brouillons-redaction/], [Brouillons de méthodologie d'enquête et de plan (Word).], [4], [1,7 Mo],
        [./05_Sociologie/canevas/], [Canevas d'entretien, génériques et pour Mizilo.], [2], [79 ko],
        [./05_Sociologie/donnees/], [Transcriptions d'entretiens, comptes rendus de sorties et d'observations, tableaux d'activités humaines et de faune, métadonnées de l'enquête (CSV).], [56], [454 ko],
        [./06_ecologie/analyse/], [Projet R : données, référentiels, scripts et sorties. Contient aussi des fichiers de session R (.RData, .Rhistory, .Rproj.user/) et .AGENTS.md.], [90], [1,6 Mo],
        [./donnees/], [Données de terrain nettoyées, une table par type d'observation (transects, placettes, flore, bois mort, chablis, grands arbres, phénologie, observations hors placettes).], [8], [64 ko],
        [./referentiels/], [Tables de correspondance : usages et classification de Cook, types d'espèces, réconciliation taxonomique, normalisation des usages.], [4], [35 ko],
        [./scripts/], [Scripts R d'analyse, avec un README sur l'ordre d'exécution.], [17], [138 ko],
        [./fonctions/], [Fonctions partagées : diversité, structure, aire-espèce.], [4], [19 ko],
        [./archives/], [Anciens scripts, conservés pour mémoire.], [3], [4 ko],
        [./scripts-a-ne-pas-relancer/], [Script de référence, non relancé (liste définitive des espèces).], [1], [8 ko],
        [./sorties/], [Résultats produits par les scripts (CSV, SVG) ; source des tables et figures du rapport.], [51], [302 ko],
        [./figures/], [Figures SVG produites par les scripts.], [6], [90 ko],
        [./resumes-pour-rapport/], [Résumés d'indices repris dans le rapport.], [6], [20 ko],
        [./06_ecologie/archivage-donnees/], [Saisies et brouillons d'origine (feuilles de calcul, réconciliation taxonomique ancienne).], [3], [150 ko],
        [./06_ecologie/methodologie/], [Protocole d'inventaire, fiche de relevés, pré-inventaire, découpage des placettes, documentation sur l'humus.], [6], [963 ko],
        [./08_rapport/consignes-redaction-et-templates/], [Guides et consignes de l'école, modèle PRISMA, notice Zotero, autorisation de mise en ligne.], [4], [1,9 Mo],
        [./08_rapport/documents-brouillons/], [Brouillons de résultats (PRISMA), couche de géodonnées, comptes rendus de points de travail.], [5], [101 ko],
        [./08_rapport/documents-etapes/], [Documents remis aux étapes du stage : projet, présentation, diagramme de Gantt, rapport d'avancement.], [5], [9,8 Mo],
        [./08_rapport/donnees/], [Données reprises dans le rapport : métadonnées de l'enquête, correspondance des usages, stocks de carbone, phénologie, observations hors placettes.], [8], [35 ko],
        [./08_rapport/redaction-typst/], [Sources du rapport (chapitres et annexes en Typst, bibliographie hayagriva.yml) ; compilation par main.typ.], [50], [1,1 Mo],
        [./analyse-figures/], [Figures SVG importées par le rapport.], [6], [90 ko],
        [./analyse-tables/], [Copies CSV importées par les tableaux et annexes du rapport.], [19], [37 ko],
        [./images/], [Photographies, logos, carte et données climatiques.], [6], [539 ko],
      ),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Le dépôt remis à Inter Aide suit l'arborescence de Git à l'état du 03/11/2026. Chaque dossier et sous-dossier est décrit dans le tableau ci-dessous ; les chemins sont donnés par rapport au dossier parent le plus proche. Les fichiers ne sont pas tous listés : ceux qui sont uniques (données brutes, scripts, documents finaux) sont nommés dans la description, et les séries homogènes (sorties R, transcriptions d'entretiens) sont décrites par leur motif de nom. Les colonnes Fichiers et Poids donnent le nombre de fichiers suivis par Git et leur poids cumulé. Poids total du dépôt suivi : 17,8 Mo.],
) <annexe-arborescence>
#titre-court(<annexe-arborescence>)[Arborescence du dépôt Git]
#pagebreak(weak: true)

#let flore = csv("analyse-tables/liste_flore.csv").slice(1)
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
    ..flore.map(r => (r.at(0), [#nomLatin(r.at(1))#if r.at(5) == "TRUE" [\*]#if r.at(7) == "Transfert de gestion (2004)" [†]], r.at(2), usagesFr(r.at(6)), codeSources(r.at(4)))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Liste de la flore (#flore.len() noms vernaculaires ; identités réconciliées, spécimens indéterminés exclus). Nom scientifique : espèce, genre ou famille, sans auteur ni date (nom complet dans liste_flore_annexe9.csv) ; ++ : au moins deux familles possibles, aucun nom donné ; case vide si l'espèce n'est pas rattachée ; \* : nom déduit des identifications de Romiguière (2025) sur ses deux sites ; † : nom donné par l'inventaire du transfert de gestion (2004), prioritaire sur Romiguière (2025) et sur les identifications personnelles. Types : nombre de types distingués par le _polisinala_ (« 1/2 » : existence de 1 ou 2 types selon des _polisinala_ différents). Usages : usages cités pour l'espèce. Source : R = relevé ; O = observation hors relevé ; Rom = Romiguière (2025) ; TFG = inventaire d'espèces du transfert de gestion (2004).],
) <annexe-flore>
#titre-court(<annexe-flore>)[Liste de la flore observée]

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
  caption: [Liste de la faune établie. Taxonomie : nom scientifique sans auteur ni date ; nom complet dans liste_faune_annexe10.csv. Sources : Observation (observations de terrain, 2026) ; TFG : transfert de gestion du VOI Maharitra (2004) ; Rajaonson : Rajaonson et al. (2010) ; GBIF : téléchargement du 3 novembre 2026, cité en @gbif_2026, 28 taxons de non-vertébrés relevés à Tsiazombazaha, 204 occurrences au total. Les espèces citées par le transfert n'ont pas été observées par l'auteur.],
) <annexe-faune>
#titre-court(<annexe-faune>)[Liste de la faune établie]

#pagebreak(weak: true)

#figure(
  [
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      align: (left, right, right, right, right, right),
      table.header([*Placette*], [*Surface*], [*Tiges mesurées*], [*Gaulis*], [*N*], [*G*]),
      ..placettesN.map(n => {
        let g = placettesG.find(r => r.at(0) == n.at(0))
        (n.at(0), nombre(n.at(1), decimales: 1), n.at(2), n.at(3), nombre(n.at(6), decimales: 0), nombre(g.at(4), decimales: 1))
      }).flatten(),
    )
    #v(1em)
    #table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr),
      align: (left, right, right, right, right),
      table.header([*Placette*], [*S*], [*H*], [*1/Simpson*], [*α de Fisher*]),
      ..placettesN.map(n => {
        let a = placettesAlpha.find(r => r.at(0) == n.at(0))
        (n.at(0), a.at(1), nombre(a.at(2)), nombre(a.at(4), decimales: 1), nombre(a.at(6), decimales: 1))
      }).flatten(),
    )
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Indices par placette. Surface horizontale en m² ; N : densité en tiges par hectare (tiges mesurées et gaulis) ; G : surface terrière en m² par hectare (tiges mesurées). S : richesse spécifique ; H : indice de Shannon (H′) ; 1/Simpson : inverse de l'indice de Simpson ; α de Fisher : paramètre de la distribution log-série. Indices calculés sur toutes les tiges comptées, tiges indéterminées exclues.],
) <annexe-indices-placettes>
#titre-court(<annexe-indices-placettes>)[Indices par placette]

#pagebreak(weak: true)

#let caracParPlacette = csv("analyse-tables/placettes_caracteristiques.csv").slice(1)
#page(flipped: true)[
#figure(
  [
    #show table: set text(size: 8.5pt)
    #table(
      columns: 12 * (auto,),
      align: (left, left, right, center, left, left, left, center, center, center, center, center),
      inset: (x: 4pt, y: 2.5pt),
      table.header([*Placette*], [*Itinéraire*], [*Pente (%)*], [*Canopée (%) \ N / E / S / O*], [*Strates*], [*Humus*], [*Sol*], [*Épiphytes*], [*Mousses*], [*Lichens*], [*Lianes*], [*Champignons*]),
      ..caracParPlacette.flatten().map(x => if x == "NA" { "" } else { x }),
    )
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Caractéristiques par placette. Canopée : classe de recouvrement estimée dans les quadrants nord, est, sud et ouest. Strates présentes : H, herbacée (0 à 2~m) ; A, sous-bois ou arbustive (2 à 10~m) ; Ci, canopée inférieure (10 à 20~m) ; Cs, canopée supérieure (plus de 20~m). Humus selon Jabiol et al. (2016) ; deux types séparés par « / » : types notés ensemble sur le terrain. Sol : humidité du sol au toucher. Épiphytes, mousses, lichens, lianes et champignons : nombre d'arbres porteurs (0-2, 3-10, > 10). Case vide : non noté. Source : placettes_caracteristiques.csv.],
) <annexe-caracteristiques-placettes>
#titre-court(<annexe-caracteristiques-placettes>)[Caractéristiques par placette]
]

#pagebreak(weak: true)

#figure(
  [
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 1.2em,
      row-gutter: 1.2em,
      table(
        columns: (1fr, 1fr, 1fr),
        align: (left, right, right),
        table.header([*Classe de diamètre*], [*Densité*], [*IC 95*]),
        ..classesN.map(r => (nombre(r.at(0), decimales: 1) + " – " + nombre(str(float(r.at(0)) + 2.5), decimales: 1), nombre(r.at(1), decimales: 0), "[" + nombre(r.at(2), decimales: 0) + " ; " + nombre(r.at(3), decimales: 0) + "]")).flatten(),
      ),
      table(
        columns: (1fr, 1fr, 1fr),
        align: (left, right, right),
        table.header([*Classe de diamètre*], [*G*], [*IC 95*]),
        ..classesG.map(r => (nombre(r.at(4), decimales: 1) + " – " + nombre(r.at(5), decimales: 1), nombre(r.at(1)), "[" + nombre(r.at(2)) + " ; " + nombre(r.at(3)) + "]")).flatten(),
      ),
      table(
        columns: (1fr, 1fr, 1fr),
        align: (left, right, right),
        table.header([*Classe de diamètre, transects*], [*Arbres*], [*Densité*]),
        ..classesNGA.map(r => (nombre(r.at(0), decimales: 1) + " – " + nombre(str(float(r.at(0)) + 2.5), decimales: 1), r.at(1), nombre(r.at(2)))).flatten(),
      ),
      table(
        columns: (1fr, 1fr, 1fr),
        align: (left, right, right),
        table.header([*Classe de diamètre, transects*], [*Arbres*], [*G*]),
        ..classesGGA.map(r => (nombre(r.at(0), decimales: 1) + " – " + nombre(r.at(1), decimales: 1), r.at(2), nombre(r.at(4)))).flatten(),
      ),
    )
  ],
  kind: "annexe",
  supplement: [Annexe],
  caption: [Densité et surface terrière par classe de diamètre (classes en cm ; densité en tiges par hectare, sauf pour les transects en arbres par hectare ; G en m² par hectare ; IC 95 % : intervalle de confiance à 95 %) : moyenne entre placettes et IC par la loi de Student : 28 placettes de l'étude et 8 placettes de 40 m² de Romiguière (2025), sauf pour la classe 0 – 2,5 cm (28 placettes de l'étude) (bornes inférieures négatives non tronquées, contrairement aux figures). La classe 0 – 2,5 cm inclut les gaulis ; les classes sans tige sont absentes. Deux derniers tableaux : grands arbres des transects (CBH ≥ 126 cm, soit un DBH d'au moins 40 cm), effectif et surface terrière rapportés aux 53 050 m² de bande prospectée sur cinq transects, sans intervalle de confiance.],
) <annexe-classes-diametre>
#titre-court(<annexe-classes-diametre>)[Densité et surface terrière par classe de diamètre]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1.2fr, 1.2fr, 1.6fr),
    align: (left, right, right, left, left, left),
    table.header([*Placette*], [*NMDS1*], [*NMDS2*], [*Itinéraire*], [*_Polisinala_*], [*Commune*]),
    ..pointsNMDS.map(r => (r.at(0), nombre(r.at(1)), nombre(r.at(2)), r.at(3), r.at(4), r.at(5))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Coordonnées des 28 placettes dans l'ordination NMDS (dissimilarité de Bray-Curtis, deux dimensions, stress = 0,23), avec leur itinéraire, leur commune et le code de leur _polisinala_ (code d'enquêté, voir @annexe-echantillon-social). Source : diversite_beta_nmds_points.csv, noms remplacés par les codes d'enquêté.],
) <annexe-beta>
#titre-court(<annexe-beta>)[Coordonnées des placettes (NMDS)]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 2.5fr, 1fr, 1fr, 1fr, 1fr),
    align: (right, left, right, right, right, right),
    table.header([*Rang*], [*Espèce*], [*DR*], [*DoR*], [*FR*], [*IVI*]),
    ..ivi.map(r => (r.at(0), r.at(1), nombre(r.at(5)), nombre(r.at(6)), nombre(r.at(7)), nombre(r.at(8)))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Indice de valeur d'importance (IVI) des 124 espèces (28 placettes ; 479 tiges mesurées, gaulis et tiges indéterminées exclus). DR : densité relative ; DoR : dominance relative ; FR : fréquence relative ; IVI = (DR + DoR + FR) / 3 ; DR, DoR, FR et IVI en % (sur 100).],
) <annexe-ivi>
#titre-court(<annexe-ivi>)[Indice de valeur d'importance (IVI)]

#pagebreak(weak: true)

#figure(
  table(
    columns: (1fr, 1.4fr, 1.2fr, 1.2fr, 2fr, 1.1fr),
    align: (right, left, right, right, right, right),
    table.header([*Placettes*], [*Méthode*], [*Surface*], [*Richesse*], [*IC 95*], [*Couverture*]),
    ..rarefactionAnnexe.map(r => (r.at(1), methodes.at(r.at(2)), nombre(r.at(10), decimales: 1), nombre(r.at(4)), "[" + nombre(r.at(5)) + " ; " + nombre(r.at(6)) + "]", nombre(r.at(7)))).flatten(),
  ),
  kind: "annexe",
  supplement: [Annexe],
  caption: [Courbe de raréfaction-extrapolation de la richesse spécifique (modèle d'incidence, ordre q = 0) : richesse (nombre d'espèces) et couverture d'échantillonnage (proportion, de 0 à 1) selon le nombre de placettes et la surface horizontale cumulée (en m²) ; IC 95 % (intervalle de confiance à 95 %) par bootstrap. Extrapolation : tous les points calculés. Les estimateurs asymptotiques figurent dans le corps du texte.],
) <annexe-richesse>
#titre-court(<annexe-richesse>)[Courbe de raréfaction-extrapolation]

