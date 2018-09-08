# Lekcja 6
# Wstawiamy obrazek z internetu

include image

# 1.
# Sprawdź jaki obrazek znajduje się pod adresem: https://goo.gl/sGQheU
# Aby wyświetliś obrazek, podaj adres jako string do funkcji image-url.
image-url("https://goo.gl/sGQheU")

# 2.
# Funkcja scale potrafi zmienić rozmiar obrazka.
# 0.3 zmniejsza obrazek.
# 1.3 powiększa obrazek.
# Zamiast 3 możesz użyć dowolnej liczby.
rectangle(500, 300, "solid", "pink")

scale(0.3, rectangle(500, 300, "solid", "pink"))

# 3.
# Spróbuj zmniejszyć kotkę ninja używając funkcji scale.
scale(0.5, image-url("https://goo.gl/sGQheU"))

# 4.
# Stwórz flagę kociego klanu ninja.
# Użyj funkcji overlay, zmniejszonego obrazka i różowego tła.
overlay(
  scale(0.5, image-url("https://goo.gl/sGQheU")),
  rectangle(500, 300, "solid", "pink")
)


# Zadanie
# Użyj funkcji overlay i scale - stwórz piracką flagę.
# Adres do obrazka pirackiej czaszki:
# https://code.pyret.org/img/pyret-logo.png

# 1. Narysuj czarny prostokąt.
# 2. Wyświetl obrazek funkcją image-scale.
# 3. Zmniejsz obrazek funkcją scale, tak żeby zmieścił się na czarnym tle.
# 4. Przekaż zmniejszony obrazek i czarny prostokąt do funkcji overlay.
overlay(
  scale(0.4, image-url("https://code.pyret.org/img/pyret-logo.png")),
  rectangle(500, 300, "solid", "black")
)
