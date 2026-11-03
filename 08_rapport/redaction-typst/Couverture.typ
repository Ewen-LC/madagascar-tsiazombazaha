#page(margin: (x: 2cm, top: 1.5cm, bottom: 2cm))[

  #grid(
    columns: (1fr, 1fr),
    align: (left + horizon, right + horizon),
    image("/images/logo-agroparistech.png", height: 2.2cm),
    image("/images/logo-inter-aide.png", height: 2.2cm),
  )

  #v(1fr)

  #align(center)[
    #text(size: 14pt)[Mémoire de fin d'études]

    #text(size: 12pt)[présenté pour l'obtention du diplôme d'ingénieur AgroParisTech \ et du diplôme d'établissement Sciences et ingénierie forestières]

    #v(1fr)

    #text(size: 18pt)[*Diagnostic écologique et social de la forêt tropicale \ humide de Tsiazombazaha, sud-est de Madagascar*]

    #v(1fr)

    #image("/images/tsiazombazaha-couverture.jpg", width: 100%)

    #v(1fr)

    #text(size: 14pt)[Ewen LE COEUR]

    #text(size: 12pt)[Stage réalisé du 15 avril 2026 au 14 octobre 2026 au sein de l'ONG Inter Aide]
  ]

  #v(1fr)

  #align(center)[
    #text(size: 11pt)[
      Soutenu le 19 novembre 2026 à Montpellier

      #v(0.5em)

      devant le jury composé de

      #v(0.5em)

      #grid(
        columns: 2,
        column-gutter: 1em,
        row-gutter: 0.9em,
        align: (right, left),
        [Tutrice de stage], [Mme Léna Aguilhon, cheffe de secteur agriculture et agroforesterie du Malawi, Madagascar et Éthiopie, Inter Aide.],
        [Enseignant référent], [Pr Alexandre Gaudin, enseignant-chercheur en socio-anthropologie de l'environnement, UMR SENS, AgroParisTech.],
        [Rapporteur externe], [Dr Lilian Blanc, chercheur à l'Unité de recherche Forêts et Sociétés, CIRAD.],
      )
    ]
  ]
]

#counter(page).update(1)

#pagebreak(weak: true)

#place(top + right)[
    _Photographie de couverture : la lisière de Tsiazombazaha, vue depuis une colline mitoyenne. \ Production personnelle._
]