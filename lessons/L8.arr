# Lekcja 8
# Układamy obrazki jeden na drugim

include image

# Funkcja above pozwala ułożyć obrazki nad sobą.
# Narysujmy drzewo.
above(
  circle(50, "solid", "forest-green"),
  rectangle(20, 100, "solid", "brown")
)

# Zadanie 1
# Narysuj prosty domek.
above(
  triangle(100, ", "red"),
  square(100, "outline", "black")
)

# Zadanie 2
# Narysuj flagę Polski.
# Przypisz ją do stałej flag-pl.
flag-pl =
  above(
    rectangle(120, 30, "solid", "white"),
    rectangle(120, 30, "solid", "red")
  )

# Zadanie 3
# Narysuj obwódkę wokół flagi Polski.
overlay(
  rectangle(120, 60, "outline", "black"),
  flag-pl
)

# Zadanie 4
# Narysuj obwódkę, wokół flagi Polski.
# Wykorzystaj funkcję frame.
frame(flag-pl)
