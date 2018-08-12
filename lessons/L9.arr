# Lekcja 9
# Zabawa z flagami państw

include image

# Zadanie 1
# Narysuj flagę Japonii.
frame(
  overlay(
    circle(30, "solid", "red"),
    rectangle(150, 100, "solid", "white")
  )
)

# Zadanie 2
# Narysuj flagę Francji.
frame(
  beside(
    rectangle(64, 120, "solid", "blue"),
    beside(
      rectangle(64, 120, "solid", "white"),
      rectangle(64, 120, "solid", "red")
    )
  )
)

# Zadanie 3
# Narysuj flagę Niemiec.
frame(
  above(
    rectangle(192, 30, "solid", "black"),
    above(
      rectangle(192, 30, "solid", "red"),
      rectangle(192, 30, "solid", "yellow")
    )
  )
)

# Zadanie 4
# Narysuj flagę Włoch.
frame(
  beside(
    rectangle(64, 120, "solid", "dark-green"),
    beside(
      rectangle(64, 120, "solid", "white"),
      rectangle(64, 120, "solid", "red")
    )
  )
)
