local sequence = ""
local output = ""
local from_file = false
print("Convert file to sequence? (y/n)")
local input
while not input do
	input = io.read()
	if input == "y" then
		from_file = true
		break
	elseif input == "n" then
		break
	else
		input = nil
	end
end
--possible pairs = ac, ca, gt, tg
local offset = 0
local ac = 1
local ca = 10
local gt = 100
local tg = 0
local pairs = {ac, ca, gt, tg}
local function offset_wrap(x)
	return ((x-1)%4)+1
end
if not from_file then
	local sequence = io.read()
	while string.len(sequence)%2 ~= 0 do
		print("String is not of even length.")
		sequence = io.read()
	end
	local byte = 0
	local temp_byte = 0
	for i=1,string.len(sequence),2 do
		local pair = string.sub(sequence,i,i+1)
		temp_byte = byte
		--print(temp_byte)
		if pair == "ac" then
			byte = byte+pairs[offset_wrap(offset+1)]
		elseif pair == "ca" then
			byte = byte+pairs[offset_wrap(offset+2)]
		elseif pair == "gt" then
			byte = byte+pairs[offset_wrap(offset+3)]
		elseif pair == "tg" then
			byte = byte+pairs[offset_wrap(offset+4)]
		end
		--print(byte)
		if byte == temp_byte then
			output = output..string.char(byte)
			print(byte .." cleared")
			byte = 0
		end
		offset = offset + 1
	end
	print(output) --caactggtcaacgtcaactggtgt
else

end --caactggtcaactgcaacgtaccatgcagtcaactggtcaactgcatgactggtcaactggtcatgcatgcatg = Hello
