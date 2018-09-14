# Treasure Map Game

include image
include world

data Pos:
  | pos(x, y)
end

data PirateMapGame:
  | pirateMapGame(pirate, treasure)
end

PIRATE = image-url("https://goo.gl/rnSXju")
PIRATE-X-MOVE = 5
PIRATE-Y-MOVE = 5
TREASURE-THRESHOLD = 30

WIDTH = 1024
HEIGHT = 758
MARGIN = 50

BLANK-SCENE = empty-scene(WIDTH, HEIGHT)

PIRATE-MAP = image-url("https://goo.gl/bxdSs7")
TREASURE = image-url("https://goo.gl/6NuYxp")

CROSS = overlay(
    overlay(
    rotate(45, rectangle(50, 10, "solid", "red")),
    rotate(135, rectangle(50, 10, "solid", "red"))
    ),
    overlay(
    rotate(45, rectangle(52, 12, "outline", "black")),
    rotate(135, rectangle(52, 12, "outline", "black"))
    )
  )

BACKGROUND =
  place-image(PIRATE-MAP,
    WIDTH / 2, HEIGHT / 2,
    BLANK-SCENE)

fun place-pirate(w, img):
  place-image(PIRATE,
    w.pirate.x,
    w.pirate.y,
    img)
end

fun place-cross(w):
  place-image(CROSS,
    w.treasure.x,
    w.treasure.y,
    BACKGROUND)
end

fun place-treasure(w, img):
  treasure = 
    if treasure-found(w):
      TREASURE
    else:
      square(0, "solid", "transparent")
    end
  place-image(treasure,
    w.treasure.x,
    w.treasure.y,
    img)
end

fun draw-map(w):
  place-treasure(
    w,
    place-pirate(
      w, 
      place-cross(w)
      )
    )
end

check:
  move-pirate(pos(10, 20), "up") is pos(10, 20 - PIRATE-Y-MOVE)
  move-pirate(pos(10, 20), "down") is pos(10, 20 + PIRATE-Y-MOVE)
  move-pirate(pos(10, 20), "left") is pos(10 - PIRATE-X-MOVE, 20)
  move-pirate(pos(10, 20), "right") is pos(10 + PIRATE-X-MOVE, 20)
end

fun move-pirate(p, key):
  ask:
    | key == "up"    then: pos(p.x, p.y - PIRATE-Y-MOVE)
    | key == "down"  then: pos(p.x, p.y + PIRATE-Y-MOVE)
    | key == "left"  then: pos(p.x - PIRATE-X-MOVE, p.y)
    | key == "right" then: pos(p.x + PIRATE-X-MOVE, p.y)
    | otherwise: p
  end
end

fun handle-key(w, key):
  pirateMapGame(move-pirate(w.pirate, key), w.treasure)
end

check:
  treasure-found(pirateMapGame(pos(100, 100), pos(200, 200))) is false
  treasure-found(pirateMapGame(pos(100, 100), pos(100, 200))) is false
  treasure-found(pirateMapGame(pos(100, 100), pos(200, 100))) is false
  # X
  treasure-found(pirateMapGame(pos(100, 100), 
      pos(100 + TREASURE-THRESHOLD, 100))) is true
  treasure-found(pirateMapGame(pos(100, 100), 
      pos(100 + (TREASURE-THRESHOLD - 1), 100))) is true
  treasure-found(pirateMapGame(pos(100, 100), 
      pos(100 - TREASURE-THRESHOLD, 100))) is true
  treasure-found(pirateMapGame(pos(100, 100), 
      pos(100 - (TREASURE-THRESHOLD - 1), 100))) is true
  # Y
  treasure-found(pirateMapGame(pos(100, 100), 
      pos(100, 100 + TREASURE-THRESHOLD))) is true
  treasure-found(pirateMapGame(pos(100, 100), 
      pos(100, 100 + (TREASURE-THRESHOLD - 1)))) is true
  treasure-found(pirateMapGame(pos(100, 100), 
      pos(100, 100 - TREASURE-THRESHOLD))) is true
  treasure-found(pirateMapGame(pos(100, 100), 
      pos(100, 100 - (TREASURE-THRESHOLD - 1)))) is true
end

fun treasure-found(w):
  dx = num-abs(w.pirate.x - w.treasure.x)
  dy = num-abs(w.pirate.y - w.treasure.y)
  (dx <= TREASURE-THRESHOLD) and (dy <= TREASURE-THRESHOLD)
end

fun get-random-pos-with-margin():
  x = num-random(WIDTH - (MARGIN * 2)) + MARGIN
  y = num-random(HEIGHT - (MARGIN * 2)) + MARGIN
  pos(x, y)
end

fun initialize-game():
  pirate = get-random-pos-with-margin()
  treasure = get-random-pos-with-margin()
  w = pirateMapGame(pirate, treasure)
  if treasure-found(w):
    initialize-game()
  else:
    w
  end
end


fun init():
  init-world =
    initialize-game()
  big-bang(init-world, [list:
    on-key(handle-key),
    to-draw(draw-map),
    stop-when(treasure-found)])
end

init()
