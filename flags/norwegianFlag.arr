include image

whiteHorizontalLine = rectangle(192, 24, "solid", "white")
blueHorizontalLine = rectangle(192, 12, "solid", "darkblue")

whiteVerticalLine = rectangle(24, 120, "solid", "white") 
blueVerticalLine = rectangle(12, 120, "solid", "darkblue") 

blueBackground = rectangle(192, 120, "solid", "red")

blueCross = overlay-xy(blueHorizontalLine, 56, -54, blueVerticalLine)
whiteCross = overlay-xy( whiteHorizontalLine, 50, -48, whiteVerticalLine)

cross = overlay(blueCross, whiteCross)

norwegianFlag = overlay(cross, blueBackground)

norwegianFlag