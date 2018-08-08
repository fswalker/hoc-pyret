include image

left = rectangle(64, 120, "solid", "black")
middle = rectangle(64, 120, "solid", "yellow")
right = rectangle(64, 120, "solid", "red")

belgianFlag = overlay-xy(overlay-xy(left, 64, 0, middle), 128, 0, right)

belgianFlag