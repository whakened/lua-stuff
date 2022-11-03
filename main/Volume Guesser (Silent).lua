local slA = 0
local slB = 0
local slC = 0
local hgt = 0
local varA = 0
local varB = 0
local varC = 0
local vol = 0
print("Volume Calculator (GVars)")
print("========================")
print("1: Triangular Prism")
print("2: Rectangular Prism")
print("3: Pentagonal Prism")
print("4: Hexagonal Prism")
print("5: Cylinder")
print("6: Triangular Pyramid")
print("7: Pyramid")
print("8: Pentagonal Pyramid")
print("9: Hexagonal Pyramid")
print("10: Sphere")
print("11: Hemisphere")
print("12: Cone")
io.write("Choice: ")
objSelect = io.read()
print("========================")
if objSelect == "1" then
	io.write("Volume to get (USE WHOLE FOR BETTER LOADTIME): ")
	varC = io.read()
	varC = math.floor(tonumber(varC)+0.5)
	print("========================")
	while vol ~= varC do
		slA = math.random()*math.random(1,100)
		slB = math.random()*math.random(1,100)
		hgt = math.random()*math.random(1,100)
		vol = math.floor(((1/2)*slA*slB*hgt)+0.5)
	end
	print("The volume of a Triangular Prism with:\nBase height = ".. slA .."\nBase length = ".. slB .."\nHeight = ".. hgt .."\nequals: ".. vol .." cube units")
elseif objSelect == "2" then
	io.write("Volume to get (USE WHOLE FOR BETTER LOADTIME): ")
	varC = io.read()
	varC = math.floor(tonumber(varC)+0.5)
	print("========================")
	while vol ~= varC do
		slA = math.random()*math.random(1,100)
		slB = math.random()*math.random(1,100)
		slC = math.random()*math.random(1,100)
		vol = math.floor((slA * slB * slC)+0.5)
	end
	print("The volume of a Rectangular Prism with:\nSide length A = ".. slA .."\nSide length B = ".. slB .."\nSide length C = ".. slC .."\nequals: ".. vol .." cube units")
elseif objSelect == "3" then
	io.write("Volume to get (USE WHOLE FOR BETTER LOADTIME): ")
	varC = io.read()
	varC = math.floor(tonumber(varC)+0.5)
	print("========================")
	while vol ~= varC do
		slA = math.random()*math.random(1,100)
		hgt = math.random()*math.random(1,100)
		vol = math.floor(((math.sqrt(25 + 10 * math.sqrt(5)) * (slA * slA) * hgt)/4)+0.5)
	end
  print("The volume of a Pentagonal Prism with:\nEdge length = ".. slA .."\nHeight = ".. hgt .."\nequals: ".. vol .." cube units")
elseif objSelect == "4" then
	io.write("Volume to get (USE WHOLE FOR BETTER LOADTIME): ")
	varC = io.read()
	varC = math.floor(tonumber(varC)+0.5)
	print("========================")
	while vol ~= varC do
		slA = math.random()*math.random(1,100)
		hgt = math.random()*math.random(1,100)
		vol = math.floor((((3*math.sqrt(3))/2)*((slA*slA)*hgt))+0.5)
	end
	print("The volume of a Hexagonal Prism with:\nEdge length = ".. slA .."\nHeight = ".. hgt .."\nequals: ".. vol .." cube units")
elseif objSelect == "5" then
	io.write("Volume to get (USE WHOLE FOR BETTER LOADTIME): ")
	varC = io.read()
	varC = math.floor(tonumber(varC)+0.5)
	print("========================")
	while vol ~= varC do
		slA = math.random()*math.random(1,100)
		hgt = math.random()*math.random(1,100)
		vol = math.floor((math.pi*((slA*slA)*hgt))+0.5)
	end
	print("The volume of a Cylinder with:\nRadius = ".. slA .."\nHeight = ".. hgt .."\nequals: ".. vol .." cube units")
elseif objSelect == "6" then
	io.write("Volume to get (USE WHOLE FOR BETTER LOADTIME): ")
	varC = io.read()
	varC = math.floor(tonumber(varC)+0.5)
	print("========================")
	while vol ~= varC do
		slA = math.random()*math.random(1,100)
		hgt = math.random()*math.random(1,100)
		vol = math.floor((1/3*(slA*hgt))+0.5)
	end
	print("The volume of a Triangular Pyramid with:\nBase area = ".. slA .."\nHeight = ".. hgt .."\nequals: ".. vol .." cube units")
elseif objSelect == "7" then
	io.write("Volume to get (USE WHOLE FOR BETTER LOADTIME): ")
	varC = io.read()
	varC = math.floor(tonumber(varC)+0.5)
	print("========================")
	while vol ~= varC do
		slA = math.random()*math.random(1,100)
		slB = math.random()*math.random(1,100)
		hgt = math.random()*math.random(1,100)
		vol = math.floor(((slA*slB*hgt)/3)+0.5)
	end
	print("The volume of a Pyramid with:\nBase length = ".. slA .."\nBase width = ".. slB .."\nHeight = ".. hgt .."\nequals: ".. vol .." cube units")
elseif objSelect == "8" then
	io.write("Volume to get (USE WHOLE FOR BETTER LOADTIME): ")
	varC = io.read()
	varC = math.floor(tonumber(varC)+0.5)
	print("========================")
	while vol ~= varC do
		slA = math.random()*math.random(1,100)
		hgt = math.random()*math.random(1,100)
		vol = math.floor(((1/12)*(slA*slA)*hgt*math.sqrt(25+10*math.sqrt(5)))+0.5)
	end
	print("The volume of a Pentagonal Pyramid with:\nBase edge length = ".. slA .."\nHeight = ".. hgt .."\nequals: ".. vol .." cube units")
elseif objSelect == "9" then
	io.write("Volume to get (USE WHOLE FOR BETTER LOADTIME): ")
	varC = io.read()
	varC = math.floor(tonumber(varC)+0.5)
	print("========================")
	while vol ~= varC do
		slA = math.random()*math.random(1,100)
		hgt = math.random()*math.random(1,100)
		vol = math.floor(((math.sqrt(3)/2)*(slA*slA)*hgt)+0.5)
	end
	print("The volume of a Hexagonal Pyramid with:\nBase edge length = ".. slA .."\nHeight = ".. hgt .."\nequals: ".. vol .." cube units")
elseif objSelect == "10" then
	io.write("Volume to get (USE WHOLE FOR BETTER LOADTIME): ")
	varC = io.read()
	varC = math.floor(tonumber(varC)+0.5)
	print("========================")
	while vol ~= varC do
		slA = math.random()*math.random(1,100)
		vol = math.floor(((4/3)*math.pi*(slA*slA*slA))+0.5)
	end
	print("The volume of a Sphere with:\nRadius = ".. slA .."\nequals: ".. vol .." cube units")
elseif objSelect == "11" then
	io.write("Volume to get (USE WHOLE FOR BETTER LOADTIME): ")
	varC = io.read()
	varC = math.floor(tonumber(varC)+0.5)
	print("========================")
	while vol ~= varC do
		slA = math.random()*math.random(1,100)
		vol = math.floor(((4/3)*math.pi*(slA*slA*slA))+0.5)/2
	end
	print("The volume of a Hemisphere with:\nRadius = ".. slA .."\nequals: ".. vol .." cube units")
elseif objSelect == "12" then
	io.write("Volume to get (USE WHOLE FOR BETTER LOADTIME): ")
	varC = io.read()
	varC = math.floor(tonumber(varC)+0.5)
	print("========================")
	while vol ~= varC do
		slA = math.random()*math.random(1,100)
		hgt = math.random()*math.random(1,100)
		vol = math.floor((math.pi*(slA*slA)*(hgt/3))+0.5)
	end
	print("The volume of a Cone with:\nRadius = ".. slA .."\nHeight = ".. hgt .."\nequals: ".. vol .." cube units")
end
print("========================")
io.write("Press enter to close this window...")
io.read()
