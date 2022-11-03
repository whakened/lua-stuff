local gb={}
function gb.new(w, h, id)
	local tb={}
	local b={}
	local wd=w or 1
	local ht=h or 1
	local id=id or 0
	for i=1,wd*ht,1 do
		b[i]=id
	end
	tb={b, wd, ht}
	return tb
end
function gb.dim(tb)
	return tb[2], tb[3]
end
function gb.set(b, it, v)
	local tb=b
	mb=tb[1]
	if mb[it]~=nil then mb[it]=v or 1 end
	tb[1]=mb
	return tb
end
function gb.left(tb, ind)
	local tind=ind
	while tind>tb[2] do tind=tind-tb[2] end
	if tind~=1 then
		return ind-1
	end
end
function gb.up(tb, ind)
	if ind>tb[2] then
		return ind-tb[2]
	end
end
function gb.down(tb, ind)
	if ind<=(tb[2]*tb[3])-tb[2] then
		return ind+tb[2]
	end
end
function gb.right(tb, ind)
	local tind=ind
	while tind>tb[2] do tind=tind-tb[2] end
	if tind~=tb[2] then
		return ind+1
	end
end
function gb.write(tb, wt)
	b = tb[1]
	if wt=="basic" then
		for i in pairs(b) do
			io.write(b[i])
			local ti=i
			while ti>tb[2] do
				ti=ti-tb[2]
			end
			if ti==tb[2] then
				io.write("\n")
			end
		end
		io.write("\n")
	end
	if wt=="basic spaced" then
		for i in pairs(b) do
			io.write(b[i] .." ")
			local ti=i
			while ti>tb[2] do
				ti=ti-tb[2]
			end
			if ti==tb[2] then
				io.write("\n")
			end
		end
		io.write("\n")
	end
	--[[
		CUSTOM WRITERS
		To write a custom writer, it's advised to just follow the example
		writer, unless you know what you are doing. Have fun!

		This example will write ". ? A ? ." if the board reads {0, 2, 1, 3, 0}, and has a width of 5.

		if wt=="example writer" then
			for i in pairs(b) do
				if b[i]==0 then
					io.write(". ")
				elseif b[i]==1 then
					io.write("A ")
				else
					io.write("? ")
				end
				local ti=i
				while ti>tb[2] do
					ti=ti-tb[2]
				end
				if ti==tb[2] then
					io.write("\n")
				end
			end
			io.write("\n")
		end
	]]
end

return gb
