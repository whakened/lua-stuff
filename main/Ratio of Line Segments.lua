print("What is the X of point A?")
local xA = io.read()
print("What is the Y of point A?")
local yA = io.read()
print("What is the X of point B?")
local xB = io.read()
print("What is the Y of point B?")
local yB = io.read()
print("What is the first number in the ratio?")
local rA = io.read()
print("What is the second number in the ratio?")
local rB = io.read()
local xC = (xA + (rA/(rA+rB)) * (xB - xA))
local yC = (yA + (rA/(rA+rB)) * (yB - yA))
print(xC ..", ".. yC)
io.read()