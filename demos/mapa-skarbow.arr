#Mapa skarbów
include image
include world

w = 900
h = 50

WIDTH = 1024
HEIGHT = 758
MARGIN = 50

PIRATE-MAP = image-url("https://github.com/fswalker/hoc-pyret/raw/master/demos/map.jpg")
TREASURE = image-url("https://github.com/fswalker/hoc-pyret/raw/master/demos/treasure_chest.png")
PIRATE   = image-url("https://github.com/fswalker/hoc-pyret/raw/master/demos/pirate_girl.png")
CRAB  = image-url("https://github.com/fswalker/hoc-pyret/raw/master/demos/Crab.png")
OCTOPUS  = image-url("https://github.com/fswalker/hoc-pyret/raw/master/demos/Octopus.png")
SHELL-BLUE  = image-url("https://github.com/fswalker/hoc-pyret/raw/master/demos/Shell%20-%20Blue.png")
SHELL-GREEN  = image-url("https://github.com/fswalker/hoc-pyret/raw/master/demos/Shell%20-%20Green.png")
SHELL-RED = image-url("https://github.com/fswalker/hoc-pyret/raw/master/demos/Shell%20-%20Red.png")

data Posn:
  | posn(x :: Number, y :: Number)
end

data World:
  | world(p :: Posn, b :: List<Posn>, f :: Number)
end

fun change-wd(wd :: World) -> World:  
  fun change-b(b :: List) -> List:
    fun change-f(t :: Posn) -> Posn:
      gx = 0
      gy = random(15)
      posn(num-modulo(t.x - gx, WIDTH ), num-modulo(t.y - gy,HEIGHT))  
    end
    cases (List) b:
      | empty => empty
      | link(f, r) =>
        cases (List) r:
          | empty => link(change-f(f), empty)
          | else  => link(change-f(f), change-b(r))
        end
    end
  end
  world(wd.p, change-b(wd.b), wd.f)
end

key-move = 10

fun keystroke(wd :: World, key) -> World:
ask:
    | key == "up"   then: world(posn(wd.p.x, wd.p.y - key-move), wd.b, wd.f )
    | key == "down" then: world(posn(wd.p.x, wd.p.y + key-move ), wd.b, wd.f)
    | key == "right" then: world(posn(wd.p.x + key-move, wd.p.y ), wd.b, wd.f)
    | key == "left" then: world(posn(wd.p.x - key-move, wd.p.y), wd.b, wd.f)
    | otherwise: w
  end
end

collision-treshold = (image-width(SHELL-RED) + image-height(PIRATE)) / 3

a = posn(200, random(HEIGHT)) 
b = posn(400, random(HEIGHT)) 
c = posn(600, random(HEIGHT)) 
d = posn(900, random(HEIGHT)) 
e = posn(1150, random(HEIGHT)) 

fun animation(wd :: World) -> Image:
  place-image(CRAB, wd.b.rest.rest.rest.rest.first.x, wd.b.rest.rest.rest.rest.first.y, 
    place-image(SHELL-GREEN, wd.b.rest.rest.rest.first.x, wd.b.rest.rest.rest.first.y, 
          place-image(SHELL-BLUE, wd.b.rest.rest.first.x, wd.b.rest.rest.first.y, 
            place-image(OCTOPUS, wd.b.rest.first.x, wd.b.rest.first.y, 
              place-image(SHELL-RED, wd.b.first.x, wd.b.first.y, 
                place-image(PIRATE, wd.p.x, wd.p.y,
                  place-image(TREASURE, 920, 440, PIRATE-MAP)))))))
end    

fun game-ends(wdg :: World) -> Boolean:
  fun collision(wd :: World) -> Boolean:
    fun distance(ba :: Posn, wa :: World) -> Number:
      fun sqr(n :: Number) -> Number: n * n end
      num-sqrt(sqr(ba.x - wa.p.x) + sqr(ba.y - wa.p.y))
    end
    (distance(wd.b.first, wd) <= collision-treshold) or (distance(wd.b.rest.first, wd) <= collision-treshold) or (distance(wd.b.rest.rest.first, wd) <= collision-treshold) or (distance(wd.b.rest.rest.rest.first, wd) <= collision-treshold) or (distance(wd.b.rest.rest.rest.rest.first, wd) <= collision-treshold) 
  end
  fun treasure-get(wd :: World) -> Boolean:
    dx = num-abs(wd.p.x - 920)
    dy = num-abs(wd.p.y - 440)
    (dx <= collision-treshold) and (dy <= collision-treshold)
end
  
  ask:
    | treasure-get(wdg) then: true and raise("Hurra! Zdobyłaś skarb!")
    | collision(wdg) then: true and raise("Ups, musisz spróbowac jeszcze raz!")
    | otherwise: false
  end
end

init-wd = world(posn(image-width(PIRATE) / 2, image-height(PIRATE) / 2), [list: a, b, c, d, e], 5)

fun play():
big-bang(init-wd, 
  [list: 
    on-tick(change-wd), 
    on-key(keystroke), 
    to-draw(animation), 
    stop-when(game-ends)
  ])
end

play()