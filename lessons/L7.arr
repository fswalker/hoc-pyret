# Lekcja 5
# Łączymy obrazki

include image

# Zadanie 1
# Funkcja beside układa obrazki obok siebie
beside(
  triangle(50, "solid", "orange"),
  triangle(50, "solid", "blue")
)

# Poniżej nazwiemy rysunek oka: eye
# Czyli przypisaliśmy rysunek do stałej eye
eye =
  overlay(
    circle(20, "solid", "black"),
    circle(100, "outline", "black")
  )

# Zadanie 2
# Narysuj dwoje oczu obok siebie
beside(
  eye,
  eye
)

# Zadanie 3
# Spróbuj umieścić kwadrat o boku 30 pomiędzy oczy
# Niestety funkcja beside potrafi zmieścić tylko 2 argumenty
# Co teraz?

square-eye =
  beside(
    square(30, "solid", "black"),
    eye
  )

beside(
  eye,
  square-eye
)

# Zadanie 4
# Magiczna sztuczka: jak sprawić, aby obrazek stał się niewidzialny
# Trzeba użyć specjalnego przezroczystego koloru: "transparent"
# Zmień kolor kwadratu powyżej na "transparent"
