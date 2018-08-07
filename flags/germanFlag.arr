include image

top = rectangle(192, 30, "solid", "black")
middle = rectangle(192, 30, "solid", "red")
bottom = rectangle(192, 30, "solid", "yellow")

germanFlag = overlay-xy(
  overlay-xy(top, 0, 30, middle), 0, 60, bottom)
germanFlag