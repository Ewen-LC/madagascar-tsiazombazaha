// Titres courts pour les listes de figures, tableaux et annexes.
// Usage après la légende : #titre-court(<étiquette>)[Titre court]
// Sans titre court, la légende complète est utilisée dans la liste.
#let titres-courts = state("titres-courts", (:))
#let titre-court(lab, court) = titres-courts.update(d => { d.insert(str(lab), court); d })
