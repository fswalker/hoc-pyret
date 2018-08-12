include image

blue-strip =
  rectangle(235, 25, "solid", "blue")

white-strip =
  rectangle(235, 100, "solid", "white")

bkg =
  above(
    blue-strip,
    above(
      white-strip,
      blue-strip
      )
    )

t = triangle(80, "solid", "blue")
flip-t = flip-vertical(t)

base-star =
  overlay-xy(
    t,
    0,
    22,
    flip-t)

t1 = triangle(10, "solid", "white")
t2 = rotate(60, t1)
t3 = rotate(60, t2)
t4 = rotate(60, t3)
t5 = rotate(60, t4)
t6 = rotate(60, t5)

center-polygon = regular-polygon(
  20,
  6,
  "solid",
  "white"
  )

whole-star =
  place-image(
    center-polygon,
    40,
    45,
    place-image(
      t6,
      18,
      33,
      place-image(
        t5,
        18,
        58,
        place-image(
          t4,
          40,
          73,
          place-image(
            t3,
            63,
            58,
            place-image(
              t2,
              63,
              33,
              place-image(
                t1,
                40,
                17,
                base-star)
              )
            )
          )
        )
      )
    )

israel =
  overlay(
    whole-star,
    bkg
    )

israel
