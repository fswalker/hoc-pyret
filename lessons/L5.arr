# Lekcja 5
# Łączymy obrazki

include image

# Zadanie 1
# Funkcja overlay nakłada jeden obrazek na drugi
# Narysuj żółtą gwiazdkę, na niebieskim tle
# Co się stanie, gdy zmienimy kolejność obrazków?
overlay(
  star(50, "solid", "yellow"),
  circle(50, "solid", "blue")
)

# Zadanie 2
# Narysujmy oko
# Czyli małe czarne kółko w dużym kole z czarną obwódką
overlay(
  circle(20, "solid", "black"),
  circle(100, "outline", "black")
)
