print("Give me a number.")
local num=math.floor(tonumber(io.read()))
print("Factors of "..num..":")
local factors={}
local perfectSquares = ",4,9,16,25,36,49,64,81,100,121,144,169,196,225,256,289,324,361,400,441,484,529,576,625,676,729,784,841,900,961,"
local primes = ",2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,241,251,257,263,269,271,277,281,283,293,"
printString = ""
for i=1,num,1 do
	if not string.find(tostring(num/i), "%.") then
		printString = tostring(i)
		origPrintString = printString
		if string.find(perfectSquares, (",".. origPrintString ..",")) then
			printString=(printString .. " (S)")
		end
		if string.find(primes, (",".. origPrintString ..",")) then
			printString=(printString .. " (P)")
		end
		print(printString)
	end
end
print("============")
io.read()
