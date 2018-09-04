include image

blueBackground = rectangle(192, 120, "solid", "blue")

yellowHorizontalLine = rectangle(192, 24, "solid", "yellow")
yellowVerticalLine = rectangle(24, 120, "solid", "yellow") 

background = overlay-align("middle", "middle", yellowHorizontalLine, blueBackground)

swedishFlag = overlay-xy(yellowVerticalLine, -60, 0, background)

swedishFlag
