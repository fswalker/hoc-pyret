# Lekcja 6
# Wstawiamy obrazek z internetu

include image

# Zadanie 1
# Sprawdź jaki obrazek znajduje się pod adresem: https://goo.gl/sGQheU
# Aby wyświetliś obrazek, podaj adres jako string do funkcji: image-url.
image-url("https://goo.gl/sGQheU")

# Zadanie 2
# Funkcja scale zmniejsza obrazki.
rectangle(500, 300, "solid", "purple")
scale(0.3, rectangle(500, 300, "solid", "purple"))

# Zadanie 3
# Spróbuj zmniejszyć kotkę ninja używając funkcji scale.
scale(0.5, image-url("https://goo.gl/sGQheU"))

# Zadanie 3
# Użyj funkcji overlay i scale - stwórz piracką flagę.
# Adres do obrazka piracjkiej czaszki:
# https://code.pyret.org/img/pyret-logo.png
overlay(
  scale(0.15, image-url("https://code.pyret.org/img/pyret-logo.png")),
  rectangle(200, 100, "solid", "black")
)
