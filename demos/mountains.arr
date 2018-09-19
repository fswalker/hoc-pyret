# Rysujemy góry

include image

# Zadanie 1
# Narysuj górę (szary trójkąt)
gora = triangle(100, "solid", "gray")
gora

# Zadanie 2
# Narysuj śnieg na szczycie góry
snieg = triangle(30, "solid", "white")
overlay-align("center", "top", snieg, gora)

# Zadanie 3
# Narysuj czarną obwódkę wokół góry
szczyt1 =
  overlay(
    overlay-align("center", "top", snieg, gora),
    triangle(103, "outline", "black")
    )
szczyt1

# Zadanie 4
# Narysuje jeszcze 2 mniejsze góry
gora2 = triangle(80, "solid", "gray")
snieg2 = triangle(20, "solid", "white")
szczyt2 =
  overlay(
    overlay-align("center", "top", snieg2, gora2),
    triangle(83, "outline", "black")
  )
szczyt2

gora3 = triangle(50, "solid", "gray")
snieg3 = triangle(15, "solid", "white")
szczyt3 = 
  overlay(
    overlay-align("center", "top", snieg3, gora3),
    triangle(52, "outline", "black")
  )
szczyt3

# Zadanie 5
# Stwórz niebo, jako tło
niebo = rectangle(300, 150, "solid", "deep-sky-blue")
niebo

# Zadanie 6
# Dodaj słońce do tła
slonce = circle(20, "solid", "yellow")
tlo = 
  frame(
    place-image(
      slonce,
      50,
      40,
      niebo)
    )
tlo

# Zadanie 7
# Dodaj 3 góry do obrazka
obrazek =
  place-image(
    szczyt3,
    250,
    128,
    place-image(
      szczyt2,
      130,
      115,
      place-image(
        szczyt1,
        200,
        106,
        tlo)
    )
  )

obrazek
