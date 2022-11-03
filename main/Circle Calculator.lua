local calcSelect = 0
local subSelect = 0
local radius = 0
local degreeA = 0
local degreeB = 0
local circumference = 0
local x,y = 0
local area = 0
print("Circle Calculator")
print("========================")
print("1: Circumference")
print("2: Area")
print("3: <XYZ, Y on Circumference")
print("4: <XYZ, Y Inside Circle")
print("5: <XYZ, Y Inside Circle, Y on Center")
print("6: <XYZ, Y Outside Circle")
print("7: <XYZ, Y Outside Circle, One Tangent")
print("8: <XYZ, Y Outside Circle, Two Tangents")
print("9: Coordinates and radius to Standard Form")
print("10: Coordinates and radius to General Form")
print("11: Standard Form to General Form")
print("12: Area of Sector")
io.write("Choice: ")
calcSelect = io.read()
print("========================")
if calcSelect == "1" then
	io.write("Radius: ")
	radius = io.read()
	radius = tonumber(radius)
	circumference = (2 * math.pi * radius)
	print("========================")
	print("The circumference of a circle with:\nRadius = ".. radius .."\nequals: ".. circumference)
elseif calcSelect == "2" then
	io.write("Radius: ")
	radius = io.read()
	radius = tonumber(radius)
	area = math.pi*(radius*radius)
	print("========================")
	print("The area of a circle with:\nRadius = ".. radius .."\nequals: ".. area .." square units")
elseif calcSelect == "3" then
--
	print("1. Degree of <XYZ")
	print("2. Degree of arc XYZ")
	io.write("Choice: ")
	subSelect = io.read()
	print("========================")
	if subSelect == "1" then
		io.write("Degree of arc XZ: ")
		degreeA = io.read()
		degreeA = tonumber(degreeA)
		degreeB = (degreeA/2)
		print("========================")
		print("The degree of <XYZ with:\nArc XZ = ".. degreeA .."\nequals: ".. degreeB .." degrees")
	elseif subSelect == "2" then
		io.write("Degree of <XYZ: ")
		degreeA = io.read()
		degreeA = tonumber(degreeA)
		degreeB = (degreeA*2)
		print("========================")
		print("The degree of arc XZ with:\nm<XYZ = ".. degreeA .."\nequals: ".. degreeB .." degrees")
	end
--
elseif calcSelect=="4" or calcSelect=="5" then
--
	print("1. Degree of <XYZ")
	print("2. Degree of arc XYZ")
	io.write("Choice: ")
	subSelect = io.read()
	print("========================")
	if subSelect == "1" then
		io.write("Degree of arc XZ: ")
		degreeA = io.read()
		degreeA = tonumber(degreeA)
		degreeB = degreeA
		print("========================")
		print("The degree of <XYZ with:\nArc XZ = ".. degreeA .."\nequals: ".. degreeB .." degrees")
	elseif subSelect == "2" then
		io.write("Degree of <XYZ: ")
		degreeA = io.read()
		degreeA = tonumber(degreeA)
		degreeB = degreeA
		print("========================")
		print("The degree of arc XZ with:\nm<XYZ = ".. degreeA .."\nequals: ".. degreeB .." degrees")
	end
--
elseif calcSelect == "6" then
--
	print("Refer to https://wrcstrshr.ml/tools/maths/angkxyzoutcirc.png for input.")
	print("Degree of arc ABC: ")
	degreeA = tonumber(io.read())
	print("Degree of arc XYZ: ")
	degreeB = tonumber(io.read())
	print("The degree of angle XYZ with:\nm<ABC = ".. degreeA .."\nm<XYZ = ".. degreeB .."\nequals: ".. 0.5*(degreeA-degreeB) .." degrees")
--
elseif calcSelect=="7" then
--
	print("Refer to https://wrcstrshr.ml/tools/maths/angkxyoutcirconetang.png for input.")
	print("Degree of arc ABC: ")
	degreeA = tonumber(io.read())
	print("Degree of arc XYA: ")
	degreeB = tonumber(io.read())
	print("The degree of angle XYZ with:\nm<ABC = ".. degreeA .."\nm<XYA = ".. degreeB .."\nequals: ".. 0.5*(degreeA-degreeB) .." degrees")
--
elseif calcSelect=="8" then
--
	print("Refer to https://wrcstrshr.ml/tools/maths/angkabcdoutcirctwotang.png for input.")
	print("Degree of arc ABC: ")
	degreeA = tonumber(io.read())
	print("Degree of arc CDA: ")
	degreeB = tonumber(io.read())
	print("The degree of angle XYZ with:\nm<ABC = ".. degreeA .."\nm<CDA = ".. degreeB .."\nequals: ".. 0.5*(degreeA-degreeB) .." degrees")
--
elseif calcSelect == "9" then
--
	print("What is the X coordinate of the circle's center?")
	x = tonumber(io.read())
	print("What is the Y coordinate of the circle's center?")
	y = tonumber(io.read())
	print("What is the radius of the circle?")
	radius = tonumber(io.read())
	print("The Standard Form of a circle with:\nX = ".. x .."\nY = ".. y .."\nRadius = ".. radius .."\nEquals: (x - ".. x ..")^2 + (y - ".. y ..")^2 = ".. radius^2)
--
elseif calcSelect == "10" then
--
	print("What is the X coordinate of the circle's center?")
	x = tonumber(io.read())
	print("What is the Y coordinate of the circle's center?")
	y = tonumber(io.read())
	print("What is the radius of the circle?")
	radius = tonumber(io.read())
	print("The General Form of a circle with:\nX = ".. x .."\nY = ".. y .."\nRadius = ".. radius .."\nEquals: x^2 + y^2 + ".. -(2*x) .."x + ".. -(2*y) .."y + ".. ((x^2 + y^2) - radius^2) .." = 0")
--
elseif calcSelect == "11" then
--
	print("In the first parentheses set, what is the second number? (Check for negatives!)")
	print("e.g. (x - 123)^2, -123 would be the number.")
	x = -tonumber(io.read())
	print("Second parentheses set number? (Again, check for negatives!)")
	y = -tonumber(io.read())
	print("What does the equation equal?")
	radius = math.sqrt(tonumber(io.read()))
	print("The General Form of a circle with:\nX = ".. x .."\nY = ".. y .."\nRadius = ".. radius .."\nEquals: x^2 + y^2 + ".. -(2*x) .."x + ".. -(2*y) .."y + ".. ((x^2 + y^2) - radius^2) .." = 0")
--
elseif calcSelect == "12" then
--
	print("What is the radius of the circle?")
	radius = tonumber(io.read())
	print("What is the central angle?")
	degreeA = tonumber(io.read())
	print("The area of a sector with:\nRadius = ".. radius .."\nCentral angle: ".. degreeA .."\nEquals: ".. ((radius*radius)*degreeA)/2)
--
end
print("========================")
io.write("Press enter to close this window...")
io.read()
