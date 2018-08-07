# Panda 

include image 

background = empty-scene(200, 200) 

ear = circle(12, "solid", "black") 

head = underlay-xy(ear, -15, -5, 
  underlay-xy(ear, -140, -5, 
    overlay( 
      circle(89, "solid", "white"), 
      circle(90, "outline", "black") 
    ))) 

eye = overlay(
  circle(2, "solid", "black"),
  overlay(circle(4, "solid", "green"),
    overlay(circle(5, "solid", "black"),
      overlay(circle(8, "solid", "white"),
        circle(25, "solid", "black")))))
 
eyes = overlay-xy(eye, 80, 0, eye)

nose =
  overlay-xy(
    ellipse(30, 15, "solid", "white"),
    2,
    5,
    ellipse(25, 20, "solid", "black")
  )

mouth =
  overlay-xy(
    circle(40, "solid", "white"),
    1,
    5,
    circle(39, "solid", "black")
    )


panda = 
  overlay-xy(
    overlay-xy(
    nose,
      -25,
      -30,
      mouth),
    -60,
    -75,
    place-image(
      eyes,
      100,
      75,
      overlay(
        head, 
        background)))

panda
