include image
import image as I

leaf-url = "http://curia.europa.eu/juris/html/images/pl/T-215-06-2-2.png"
leaf = I.image-url(leaf-url)

leafScaled = scale(32, leaf)

red = rectangle(48, 120, "solid", "red")
white = rectangle(48, 120, "solid", "white")

left = beside(red, white)
right = flip-horizontal(left)

canadianFlagBackground = beside(left, right)
canadianFlagBackgroundScaled = scale( 80, canadianFlagBackground)

canadianFlag = overlay-align("center", "center", leafScaled, canadianFlagBackgroundScaled)
canadianFlag
