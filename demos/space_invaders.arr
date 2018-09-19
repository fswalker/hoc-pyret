# Space Invaders Game

include image
include world

WIDTH = 300
HEIGHT = 500

INVADER-X-SPEED = 1.5
INVADER-Y-SPEED = 1.5
TANK-SPEED = 2
MISSILE-SPEED = 10

HIT-RANGE = 10

INVADE-RATE = 100
INVADE-THRESHOLD = 10

BACKGROUND = empty-scene(WIDTH, HEIGHT)

INVADER =
  overlay-xy(
    ellipse(10, 15, "outline", "blue"),
    -5, 6,
    ellipse(20, 10, "solid", "blue"))

TANK =
  overlay-xy(
    overlay(
      ellipse(28, 8, "solid", "black"),
      ellipse(30, 10, "solid", "green")),
    5, -14,
    above(
      rectangle(5, 10, "solid", "black"),
      rectangle(20, 10, "solid", "black")))

TANK-HEIGHT = image-height(TANK)
TANK-HEIGHT-HALF = TANK-HEIGHT / 2

MISSILE = ellipse(5, 15, "solid", "red")
MISSILE-HEIGHT-HALF = image-height(MISSILE) / 2

GAME-OVER =
  text-font(
    "GAME OVER",
    48,
    "red",
    "Uroob",
    "modern", 
    "normal",
    "bold",
    false)

EMPTY-LIST-IMG = rectangle(WIDTH, HEIGHT, "outline", "transparent")

# Data Definitions:

data Game:
  | game(invaders, missiles, tank)
end

data Tank:
  | tank(x, dir)
end

T0 = tank(WIDTH / 2, 1)
T1 = tank(50, 1)
T2 = tank(50, -1)

data Invader:
  | invader(x, y, dx)
end

I1 = invader(150, 100, 12)
I2 = invader(150, HEIGHT, -10)
I3 = invader(150, (HEIGHT + 10), 10)

data Missile:
  | missile(x, y)
end

M1 = missile(150, 300)
M2 = missile(I1.x, I1.y + 10)
M3 = missile(I1.x, I1.y + 5)

G0 = game(empty, empty, T0)
G1 = game(empty, empty, T1)
G2 = game([list: I1], [list: M1], T1)
G3 = game([list: I1, I2], [list: M1, M2], T1)
G7 = game([list: I1, I2, invader(50, HEIGHT - 100, 10)], [list: M1, M2], T1)

# Functions:

fun main(g):
  big-bang(g, [list:
      on-tick(update-game),
      on-key(handle-key),
      to-draw(render-game),
      stop-when(game-over)
    ])
end

fun update-game(g):
  game(
    update-invaders(g),
    update-missiles(g),
    update-tank(g.tank)
    )
end

fun handle-key(g, key):
  ask:
    | key == " "     then: fire-missile(g)
    | key == "left"  then: move-tank-left(g)
    | key == "right" then: move-tank-right(g)
    | otherwise: g
  end
end

fun game-over(g):
  invader-landed(g.invaders)
end

fun invader-landed(loi):
  cases (List) loi:
    | empty => false
    | link(f, r) =>
      if f.y > HEIGHT:
        true
      else:
        invader-landed(r)
      end
  end
end

fun render-game(g):
  overlay(
    final-screen(g),
    overlay(
      render-invaders(g.invaders),
      overlay(
        render-missiles(g.missiles),
          render-tank(
            g.tank,
            BACKGROUND)
        )
      )
    )
end
  
fun final-screen(g):
  if game-over(g):
    GAME-OVER
  else:
    EMPTY-LIST-IMG
  end
end      

fun get-invader-direction(seed):
  if num-modulo(seed, 2) == 0:
    1
  else:
    -1
  end
where:
  get-invader-direction(0) is 1
  get-invader-direction(642) is 1
  get-invader-direction(10) is 1
  get-invader-direction(13) is -1
  get-invader-direction(145) is -1
  get-invader-direction(1) is -1
end

fun create-random-invader():
  iwidth = num-random(WIDTH)
  invader(
    iwidth,
    0 - image-height(INVADER),
    get-invader-direction(iwidth))
end

fun add-invader-randomly(loi):
  if num-random(INVADE-RATE) < INVADE-THRESHOLD:
    link(
      create-random-invader(),
      loi)
  else:
    loi
  end
end

fun adjust-position(i):
  ask:
    | i.x >= WIDTH then: invader(WIDTH - (i.x - WIDTH), i.y, -1 * i.dx)
    | i.x <= 0     then: invader(-1 * i.x, i.y, -1 * i.dx)
    | otherwise: i
  end
end

check:    
  move-invader(invader(10, 10, INVADER-X-SPEED)) 
    is invader(10 + INVADER-X-SPEED, 10 + INVADER-Y-SPEED, INVADER-X-SPEED)
  move-invader(
    invader(WIDTH - INVADER-X-SPEED, 50, INVADER-X-SPEED)) 
    is invader(WIDTH, 50 + INVADER-Y-SPEED, -1 * INVADER-X-SPEED)
  move-invader(
    invader(2 * INVADER-X-SPEED, 50, -1 * INVADER-X-SPEED)) 
    is invader(INVADER-X-SPEED, 50 + INVADER-Y-SPEED, -1 * INVADER-X-SPEED)
   move-invader(
    invader(INVADER-X-SPEED, 10, -1 * INVADER-X-SPEED))
    is invader(0, 10 + INVADER-Y-SPEED, INVADER-X-SPEED)
  move-invader(
    invader(INVADER-X-SPEED / 2, 10, -1 * INVADER-X-SPEED))
    is invader(INVADER-X-SPEED / 2, 10 + INVADER-Y-SPEED, INVADER-X-SPEED)
end

fun move-invader(i):
  adjust-position(
    invader(
      i.x + i.dx,
      i.y + INVADER-Y-SPEED,
      i.dx))
end

fun move-invaders(loi):
  cases (List) loi:
    | empty => empty
    | link(f, r) =>
      link(
        move-invader(f),
        move-invaders(r))
  end
end

fun move-missile(m):
  missile(m.x, m.y - MISSILE-SPEED)
end

fun move-missiles(lom):
  for map(m from lom):
    move-missile(m)
  end
end

check:
  missile-hit-invader(
    missile(100, 100), 
    invader(100, 100, 10)) is true
  missile-hit-invader(
    missile(100, 100 + HIT-RANGE), 
    invader(100, 100, 10)) is true
  missile-hit-invader(
    missile(100 + HIT-RANGE, 100 + HIT-RANGE), 
    invader(100, 100, 10)) is true
  missile-hit-invader(
    missile(101 + HIT-RANGE, 100 + HIT-RANGE), 
    invader(100, 100, 10)) is false
  missile-hit-invader(
    missile(100, 101 + HIT-RANGE), invader(100, 10, 10)) is false
end
fun missile-hit-invader(m, i):
  (num-abs(m.x - i.x) <= HIT-RANGE) 
  and
  (num-abs(m.y - i.y) <= HIT-RANGE) 
end

fun invader-exploded(lom, i):
  for fold(answer from false, m from lom):
    missile-hit-invader(m, i) or answer
  end
end

fun remove-destroyed-invaders(lom, loi):
  for filter(i from loi):
    not(invader-exploded(lom, i))
  end
end

fun update-invaders(g):
  remove-destroyed-invaders(
    move-missiles(g.missiles),
    move-invaders(
      add-invader-randomly(g.invaders)
      )
    )
end

fun missile-exploded(loi, m):
  for fold(answer from false, i from loi):
    missile-hit-invader(m, i) or answer
  end
end

fun remove-exploded-missiles(loi, lom):
  for filter(m from lom):
    not(missile-exploded(loi, m))
  end
end

check:
  missile-hidden(missile(200, -10)) is true
  missile-hidden(missile(200, (-1 * MISSILE-HEIGHT-HALF))) is true
  missile-hidden(missile(200, 0)) is false
  missile-hidden(missile(200, 10)) is false
end
fun missile-hidden(m):
  m.y <= (-1 * MISSILE-HEIGHT-HALF)
end

check:
  remove-hidden-missiles(
    [list: missile(200, MISSILE-SPEED)]) is [list: missile(200, MISSILE-SPEED)]
  remove-hidden-missiles(
    [list: missile(200, -1 * MISSILE-HEIGHT-HALF)]) is empty
end
fun remove-hidden-missiles(lom):
  for filter(m from lom):
    not(missile-hidden(m))
  end
end

fun update-missiles(g):
  remove-exploded-missiles(
    move-invaders(g.invaders),
    remove-hidden-missiles(
      move-missiles(g.missiles)))
end

fun calculate-tank-x(t):
  t.x + (t.dir * TANK-SPEED)
end

fun fix-tank-x(x):
  ask:
    | x < 0      then: 0
    | x > WIDTH  then: WIDTH
    | otherwise: x
  end
end

fun update-tank(t):
  tank(
    fix-tank-x(
        calculate-tank-x(t)),
    t.dir)
end

fun render-invader(i, img):
  place-image(
    INVADER,
    i.x, i.y,
    img)
end

fun render-invaders(loi):
  for fold(img from EMPTY-LIST-IMG, i from loi):
    render-invader(i, img)
  end
end

fun render-missile(m, img):
  place-image(
    MISSILE,
    m.x, m.y,
    img
    )
end

fun render-missiles(lom):
  for fold(img from EMPTY-LIST-IMG, m from lom):
    render-missile(m, img)
  end
end

fun render-tank(t, bg):
  place-image(
    TANK,
    t.x,
    (HEIGHT - TANK-HEIGHT-HALF),
    bg)
end

fun create-new-missile(g):
  missile(
    g.tank.x,
    HEIGHT - (TANK-HEIGHT + MISSILE-HEIGHT-HALF))
end

fun fire-missile(g):
  game(
    g.invaders,
    link(
      create-new-missile(g),
      g.missiles),
    g.tank)
end

fun move-tank(g, dir):
  if (dir == -1) or (dir == 1):
    game(
      g.invaders,
      g.missiles,
      tank(
        g.tank.x,
        dir))
  else:
    g
  end
end

fun move-tank-left(g):
  move-tank(g, -1)
end

fun move-tank-right(g):
  move-tank(g, 1)
end
