# Pirate Ship Animation

include image
include world

SHIP = image-url("https://goo.gl/FKfucr")
SHIP-X-MOVE = 2

WIDTH = 800
HEIGHT = 500
WATER-HEIGHT = 300
SHIP-Y = (HEIGHT - WATER-HEIGHT) + 25

BLANK-SCENE = empty-scene(WIDTH, HEIGHT)

WATER = rectangle(WIDTH, WATER-HEIGHT, "solid", "blue")
SKY = rectangle(WIDTH, HEIGHT - WATER-HEIGHT, "solid", "deep-sky-blue")
SUN = circle(30, "solid", "yellow")

BASE = above(SKY, WATER)

BACKGROUND =
  place-image(SUN,
    10,
    10,
    place-image(BASE,
      WIDTH / 2, HEIGHT / 2,
      BLANK-SCENE))

check:
  move-ship-x-on-tick(50) is 50 + SHIP-X-MOVE
  move-ship-x-on-tick(0) is 0 + SHIP-X-MOVE
  move-ship-x-on-tick(100) is 100 + SHIP-X-MOVE
end

fun move-ship-x-on-tick(w):
  w + SHIP-X-MOVE
end

fun place-ship-x(w):
  place-image(SHIP,
    w,
    SHIP-Y,
    BACKGROUND)
end

big-bang(0, [list:
    on-tick(move-ship-x-on-tick),
    to-draw(place-ship-x)])
