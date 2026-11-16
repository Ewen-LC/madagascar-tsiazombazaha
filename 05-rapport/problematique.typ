#import "titres-courts.typ": titre-court

#pagebreak(weak: true)
= Problématique

Cette partie présente le commanditaire et sa commande, l'analyse de celle-ci, puis la problématique et le cadre d'analyse qui en découlent.

== Commanditaire, commande et enjeux

=== Inter Aide

Inter Aide est une organisation non gouvernementale (ONG) française, créée en 1980, qui conçoit et met en œuvre des programmes de développement auprès des populations rurales défavorisées. Elle intervient aujourd'hui dans sept pays sur l'agriculture familiale et la préservation des ressources naturelles, l'accès à l'eau et la santé communautaire. Son fonctionnement repose sur la séparation entre un siège, en France, qui assure l'administration, la collecte de fonds et l'orientation stratégique des programmes, et des équipes techniques chargées de la mise en œuvre sur le terrain (@fig-organigramme).

#figure(
  {
    set text(size: 10pt)
    set par(justify: false)
    block(width: 15cm, height: 12.7cm, {
      place(top + left, dx: 0cm, dy: 1.5cm, rect(width: 15cm, height: 9.8cm, stroke: (thickness: 0.6pt, dash: "dashed")))
      // Bureau d'Antananarivo et échelle nationale retirés à la demande de la tutrice (relecture du 04/11/2026).
      place(top + left, line(start: (0cm, 5.3cm), end: (15cm, 5.3cm), stroke: (thickness: 0.4pt, dash: "dotted")))
      place(top + left, dx: 0.3cm, dy: 3.2cm, [_International_])
      place(top + left, dx: 0.3cm, dy: 8.65cm, [_Local_])
      place(top + left, dx: 12.4cm, dy: 10.7cm, [*Inter Aide*])
      place(top + left, dx: 3.0cm, dy: 0cm, rect(width: 9.0cm, height: 1.1cm, stroke: 0.6pt, align(center + horizon)[Bailleurs de fonds \ (FFEM, AFD, Jersey Overseas Aid, fondations)]))
      place(top + left, dx: 3.8cm, dy: 1.9cm, rect(width: 7.4cm, height: 2.0cm, stroke: 0.6pt, align(center + horizon)[*Siège France* (Versailles, Montpellier) \ administration, collecte de fonds, \ responsables de secteur géographique]))
      place(top + left, dx: 3.2cm, dy: 6.7cm, rect(width: 8.6cm, height: 4.2cm, stroke: 0.6pt))
      place(top + left, dx: 3.2cm, dy: 6.85cm, box(width: 8.6cm, align(center)[*Programme de Manakara*]))
      place(top + left, dx: 3.7cm, dy: 7.3cm, rect(width: 7.6cm, height: 0.6cm, stroke: 0.6pt, inset: 2pt, align(center + horizon)[Responsable de programme et adjoint]))
      place(top + left, dx: 3.7cm, dy: 8.7cm, rect(width: 7.6cm, height: 0.6cm, stroke: 0.6pt, inset: 2pt, align(center + horizon)[Coordination et ressources humaines]))
      place(top + left, dx: 3.7cm, dy: 10.1cm, rect(width: 7.6cm, height: 0.6cm, stroke: 0.6pt, inset: 2pt, align(center + horizon)[Techniciens résidant dans les _fokontany_]))
      place(top + left, dx: 4.5cm, dy: 11.5cm, rect(width: 6.0cm, height: 1.1cm, stroke: 0.6pt, align(center + horizon)[Bénéficiaires \ lignages (_tranobe_, _lohatrano_), VOI]))
      place(top + left, line(start: (7.5cm, 1.30cm), end: (7.5cm, 1.70cm), stroke: 0.7pt))
      place(top + left, polygon(fill: black, (7.41cm, 1.68cm), (7.59cm, 1.68cm), (7.5cm, 1.9cm)))
      place(top + left, polygon(fill: black, (7.41cm, 1.32cm), (7.59cm, 1.32cm), (7.5cm, 1.1cm)))
      place(top + left, line(start: (7.5cm, 3.90cm), end: (7.5cm, 6.50cm), stroke: 0.7pt))
      place(top + left, polygon(fill: black, (7.41cm, 6.48cm), (7.59cm, 6.48cm), (7.5cm, 6.7cm)))
      place(top + left, line(start: (7.5cm, 7.90cm), end: (7.5cm, 8.50cm), stroke: 0.7pt))
      place(top + left, polygon(fill: black, (7.41cm, 8.48cm), (7.59cm, 8.48cm), (7.5cm, 8.7cm)))
      place(top + left, line(start: (7.5cm, 9.30cm), end: (7.5cm, 9.90cm), stroke: 0.7pt))
      place(top + left, polygon(fill: black, (7.41cm, 9.88cm), (7.59cm, 9.88cm), (7.5cm, 10.1cm)))
      place(top + left, line(start: (7.5cm, 10.90cm), end: (7.5cm, 11.30cm), stroke: 0.7pt))
      place(top + left, polygon(fill: black, (7.41cm, 11.28cm), (7.59cm, 11.28cm), (7.5cm, 11.5cm)))
      place(top + left, polygon(fill: black, (7.41cm, 10.92cm), (7.59cm, 10.92cm), (7.5cm, 10.7cm)))
    })
  },
  caption: [Organisation d'Inter Aide autour du programme de Manakara. Le cadre en tirets délimite Inter Aide, les pointillés séparent les échelles internationale et locale. Les flèches simples indiquent la hiérarchie, les flèches doubles les échanges~; les responsables de secteur encadrent directement le responsable de programme. D'après les observations de l'auteur.],
) <fig-organigramme>
#titre-court(<fig-organigramme>)[Organisation d'Inter Aide autour du programme de Manakara]

L'ONG est présente à Madagascar depuis 1994. Dans les régions Vatovavy et Fitovinany, elle a mené des programmes d'agriculture, de reboisement, de santé et d'accès à l'eau potable. L'équipe de Manakara compte actuellement sept membres de bureau ainsi qu'une douzaine de techniciens résidant dans les _fokontany_ d'intervention du projet EcoBois.

Les programmes agricoles ont d'abord visé à promouvoir des innovations techniques et des variétés performantes pour permettre aux familles d'augmenter et de diversifier leurs productions. À partir de 2011, l'approche vise les familles précaires disposant de collines dégradées et peu fertiles, les _tanety_ (Inter Aide, 2015)~; depuis 2016, l'équipe de Manakara abandonne les activités agricoles et se consacre pleinement au reboisement de ces collines avec des essences exotiques à croissance rapide, principalement l'_acacia_ (_Acacia_ sp.) et le _kinina_ (_Eucalyptus_ sp.), afin de répondre aux besoins en bois des ménages et de restaurer les terres.

Les reboisements sont réalisés sur les parcelles collectives des terres lignagères, avec les lignages (_tranobe_, la famille élargie~: un père, tous ses fils, les oncles et les cousins) et leurs subdivisions (_lohatrano_, le ménage d'un père et de ses fils). Les planteurs reçoivent une «~prime à l'arbre vivant~», versée pendant la période de soudure et conditionnée à la survie des arbres au bout de deux ans et à l'entretien des parcelles. Près de 2,5 millions d'arbres ont ainsi été plantés à Madagascar sur 1~600~ha de collines déboisées. En 2022, une évaluation externe a jugé ces reboisements pertinents et recommandé leur extension. Le projet EcoBois prolonge cette démarche en y ajoutant la préservation des forêts naturelles, sujet nouveau pour Inter Aide.

=== Le projet EcoBois

Depuis le second semestre 2025, Inter Aide porte le projet EcoBois («~Concilier préservation des écosystèmes et autonomie en bois~»), au Malawi et à Madagascar, en s'appuyant dans chaque pays sur des partenaires (ONG, universités, etc.), dont WeForest au Malawi. Prévu sur cinq ans, il vise, selon le document de projet (Inter Aide et WeForest, 2025), à «~créer les conditions pour préserver les ressources naturelles et les forêts, en permettant à des populations vulnérables affectées par le changement climatique de répondre durablement à leurs besoins en bois par la sylviculture, l'agroforesterie et le repeuplement en essences natives~». Son budget total est de 4~953~020~euros, financé par le Fonds français pour l'environnement mondial (FFEM) aux côtés de l'Agence française de développement (AFD), de Jersey Overseas Aid et de fondations privées.

#figure(
  image("images/carte-localisation.svg", width: 100%,
    alt: "Carte en niveaux de gris de la région Fitovinany, avec un encart de Madagascar : la forêt de Tsiazombazaha en noir, les communes du périmètre EcoBois hachurées et trois fragments forestiers voisins (Vorovoka, Lakia, Vatovavy) marqués par un arbre."),
  caption: [Localisation de la forêt de Tsiazombazaha dans la région Fitovinany (Madagascar en encart), avec les communes du périmètre EcoBois et les fragments de forêt naturelle voisins (Vorovoka, Lakia, Vatovavy). Échelle 1/550~000~; quadrillage en degrés décimaux (WGS84), projection UTM 38~S (EPSG:32738).],
) <fig-carte-localisation>
#titre-court(<fig-carte-localisation>)[Localisation de la forêt de Tsiazombazaha]

Le projet s'organise en trois composantes~: répondre aux besoins en bois des familles par une production agroforestière ou sylvicole~; mobiliser les acteurs locaux pour une gestion durable des paysages agricoles et forestiers~; définir les conditions de reproduction et de mise à l'échelle des solutions et en capitaliser les enseignements. La présente étude s'inscrit dans la deuxième composante, consacrée à la préservation des espaces forestiers et à leur gouvernance. Elle relève principalement de l'activité 2.1~: «~Réaliser un diagnostic de quatre espaces forestiers du sud-est de Madagascar (diagnostic forestier, modes de gestion et compréhension des interactions avec les communautés avoisinantes)~». L'étude alimente aussi l'activité 2.3, qui vise à comprendre et renforcer la gestion communautaire d'au moins deux des quatre forêts, et, dans une moindre mesure, l'activité 2.2, consacrée à des indicateurs et outils de suivi destinés aux acteurs locaux.

Le stage s'inscrit dans le dispositif de suivi-évaluation du projet, pour lequel l'#box[UFR GEN-V] d'AgroParisTech envoie un stagiaire par an dans chacun des deux pays. Ce dispositif doit répondre à trois questions évaluatives, qui portent sur la couverture des besoins en bois des familles, sur la préservation des forêts et sur les transformations paysagères. L'étude relève de la deuxième~: «~Le développement de la production de bois au sein des espaces agricoles, couplé aux actions menées au sein des réserves forestières, contribue-t-il à une meilleure préservation et à une amélioration de la biodiversité dans ces espaces forestiers menacés~?~».

À Madagascar, le projet intervient autour de Manakara (@fig-carte-localisation). Il ne subsiste dans cette zone que quelques fragments de forêt naturelle de taille significative où l'on trouve encore des essences natives~: Lakia (environ 150~ha), où aucune restriction d'usage n'existe, Vorovoka (environ 250~ha), dont la gestion a été transférée en 2022 au VOI Tsimanavaka, Tsiazombazaha (environ 640~ha~; VOI Maharitra, 2025), gérée par le VOI Maharitra depuis 2004, et la forêt de Vatovavy, au nord. Le projet retient en priorité les forêts de Vorovoka et de Tsiazombazaha.

=== La commande et ses enjeux

La commande émane du siège d'Inter Aide. Elle porte sur l'état écologique de la forêt de Tsiazombazaha, sur les usages et les perceptions qu'en ont les populations, et sur sa gestion actuelle par les acteurs locaux. Son but est de mieux définir les enjeux de préservation et de gestion des reliquats forestiers, en lien avec les reboisements menés dans les territoires voisins. Elle doit fournir un état initial de la forêt et de sa gestion, et éclairer les orientations du projet dans les années à venir. Les résultats s'adressent à l'équipe de Manakara et au siège.

Le stage s'est déroulé du 15 avril au 14 octobre 2026, réparti entre cinq mois au sein de l'équipe de Manakara et un mois en télétravail en France. Les livrables attendus sont le présent mémoire, une note de synthèse de cinq pages destinée à l'équipe, une note d'une page destinée aux bénéficiaires, les données acquises accompagnées de leurs métadonnées, et des fiches de protocole séparées.

Pour Inter Aide, la commande répond d'abord à un manque de connaissances. Les forêts naturelles ne sont entrées dans le champ d'action de l'ONG qu'avec le projet EcoBois, et il n'existe que peu de données disponibles sur les deux forêts ciblées. À Tsiazombazaha, seules deux semaines de terrain exploratoire, lors d'un stage consacré en 2025 à Vorovoka, ont précédé cette étude (Romiguière, 2025). Inter Aide attend donc une connaissance de base de la forêt~: son état de dégradation, le lien qu'entretiennent les populations avec elle, sa valeur patrimoniale et son histoire.

Ces connaissances doivent aider l'ONG à répondre à des questions plus précises. L'intérêt du projet pour les forêts tient en partie à leur rôle dans l'alimentation en eau des rizières, notamment pour la culture de petite saison. Lors de ses visites, Inter Aide a par ailleurs relevé des coupes de bois précieux, des défrichements et la production de charbon, sans savoir lesquelles de ces pressions pèsent le plus sur la forêt ni comment les réduire. Quant à la gestion, l'histoire du transfert est mal connue de l'ONG, qui s'interroge sur la pertinence de s'appuyer sur le VOI pour préserver et restaurer la forêt.

Enfin, l'étude doit proposer des indicateurs de suivi pour la deuxième question évaluative, en vue notamment d'un éventuel réseau de parcelles de surveillance permanente, prévu par le document de projet.

== Analyse de la commande

La problématique validée lors du projet de stage, en mai 2026, était une question de conservation~: «~Pourquoi et comment conserver la forêt de Tsiazombazaha~?~». Elle tenait pour acquis que la forêt devait être conservée et que le VOI en était le levier. L'étude revient au diagnostic demandé par le document de projet~: elle décrit l'état de la forêt et de sa gestion, et n'en tire des orientations qu'en discussion.

L'objet de l'étude varie selon les documents~: le document de projet vise la forêt, tandis que le contrat de transfert de gestion porte sur un périmètre de 1~068~ha, qui inclut, autour d'environ 640~ha de forêt, des rizières et des zones dégradées (VOI Maharitra, 2025). L'étude distingue donc trois échelles~: la forêt, sur laquelle porte le volet écologique, puis le périmètre transféré et les _fokontany_ membres du VOI, sur lesquels porte le volet social.
La commande demande d'évaluer la valeur patrimoniale de la forêt. Le document de projet la justifie par des lémuriens menacés cités pour Madagascar en général, sans données propres à Tsiazombazaha. Les seules données sur la faune de la forêt sont une liste de cinq lémuriens jointe au contrat de transfert de 2004, sans méthode ni auteur (VOI Maharitra, 2004), et une journée de prospection en 2009, qui n'atteste que deux espèces, _Avahi laniger_ et _Eulemur rufus_ (Rajaonson et al., 2010). La valeur patrimoniale de la forêt reste donc à établir~; l'étude, centrée sur la flore ligneuse, avec des noms vernaculaires, ne la traite pas.
Le document de projet demande aussi de comprendre «~le niveau d'activité et de performance~» des communautés de base, sans en préciser les critères. Juger la performance du VOI supposerait de savoir ce qu'aurait été la forêt sans lui~; à l'échelle nationale, les transferts de gestion n'ont d'ailleurs en moyenne que des effets modestes sur la déforestation (Rasolofoson et al., 2015). L'étude ne mesure donc pas cette performance~: elle décrit le fonctionnement du VOI, ses règles et leur application, au regard des conditions d'une gestion durable des ressources communes (Ostrom, 1990).

La commande émane du siège, mais le stage est accueilli par l'équipe de Manakara, dont les attentes diffèrent. L'équipe de terrain s'y est d'abord peu intéressée. L'étude en tient compte~: une note de synthèse lui est destinée, et une partie des recommandations formulées en discussion porte sur ses activités.

Enfin, la deuxième question évaluative porte sur un effet du projet. Le mesurer suppose de comparer la forêt avant et après l'intervention, ou avec des forêts sans intervention. Une étude ponctuelle sur une seule forêt ne le permet pas. L'étude fournit donc un état de départ et des indicateurs pour un suivi ultérieur.
Deux enjeux de la commande ne sont traités qu'indirectement~: l'enjeu hydrique, par les seules perceptions des habitants, et l'histoire de la dégradation, par des données existantes sur le couvert forestier.

== Problématique et cadre d'analyse

=== Question et sous-questions

Recentrée sur le diagnostic, l'étude répond à la question centrale suivante~: quel est l'état de conservation de la forêt de Tsiazombazaha, quelles pressions et quelle gestion permettent de le comprendre, et quelles orientations en tirer pour la stratégie d'Inter Aide~?

Elle se décline en trois sous-questions (SQ)~:
+ SQ1~: Quel est l'état écologique actuel de la forêt~?
+ SQ2~: Quels usages les habitants des _fokontany_ membres du VOI font-ils de la forêt, comment la perçoivent-ils, et quelles pressions y sont rapportées ou observées~?
+ SQ3~: Comment s'organise la gestion de la forêt~: par qui, selon quelles règles, et comment ces règles sont-elles appliquées et perçues~?

Ces sous-questions sont descriptives~: l'étude ne teste pas d'hypothèse. Elle combine deux volets. Le premier, écologique, repose sur un inventaire forestier et l'examen de données existantes (SQ1). Le second, social, repose sur des échanges menés avec les habitants sous forme d'entretiens semi-directifs et lors de sorties en forêt (SQ2 et SQ3). Les deux volets ont été menés et analysés séparément, puis croisés en discussion pour répondre à la question centrale et formuler des recommandations pour Inter Aide.


=== Cadre d'analyse

L'étude mobilise un cadre d'écologie pour caractériser l'état de la forêt et deux cadres de sciences sociales pour situer l'étude et organiser ses résultats.

Le volet écologique relève de la biologie de la conservation, qui étudie les espèces, les communautés et les écosystèmes perturbés (Soulé, 1985). La forêt de Tsiazombazaha en est un cas~: un fragment isolé, soumis à des coupes et à des défrichements.
Ce volet mobilise les outils classiques de l'écologie forestière et de l'écologie des communautés~: structure du peuplement (Mille et Louppe, 2015), stock de carbone (Chave et al., 2014), diversité alpha et bêta (Whittaker, 1960~; Jost, 2006) et estimation de la richesse spécifique totale (Chao, 1987~; Chao et al., 2014). Les valeurs obtenues sont ensuite comparées à celles d'autres forêts tropicales humides, de Madagascar ou d'ailleurs.

// Reformulé le 09/11/2026 (accord de l'auteur) : les cadres servent au positionnement et à l'organisation des résultats, non plus à l'analyse en Discussion.
Deux cadres de sciences sociales orientent la posture de l'étude et l'organisation de ses résultats. L'analyse stratégique de la gestion environnementale (ASGE~; Mermet et al., 2005) prend l'état de la forêt comme référence~: l'analyste n'est pas neutre et produit une lecture utile à un acteur qui veut l'améliorer, ici Inter Aide. Elle distingue la gestion effective, l'ensemble des actions humaines qui influent sur la forêt, de la gestion intentionnelle, menée pour l'améliorer~; cette distinction ordonne le volet social, des usages et pressions (SQ2) à l'organisation du VOI (SQ3). La forêt est enfin décrite comme une ressource commune au sens d'Ostrom (1990)~: il est coûteux d'en exclure des usagers, et ce que l'un prélève n'est plus disponible pour les autres. Ce cadre fournit le vocabulaire de la gestion, droits, règles, surveillance et sanctions, avec lequel les résultats de SQ3 sont présentés.

// Retiré le 09/11/2026 (accord de l'auteur) : la grille n'est plus utilisée en Discussion.
// La grille des systèmes socio-écologiques d'Ostrom (2009) sert enfin à croiser les volets écologique et social. Elle décompose un système en quatre ensembles, la ressource, ses unités, les usagers et le système de gouvernance, et analyse les interactions entre ces ensembles et leurs effets sur la ressource et sur les usagers, en tenant compte du contexte social, économique et politique.