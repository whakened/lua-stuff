--[[
	A volume library for lua.
	math.vol("", w, x, y, z)
	=========================
	Arguments:
	               CUBE | math.vol("cube", length, width, height)
	   TRIANGULAR PRISM | math.vol("triangular prism", baseHeight, baseEdgeLength, height)
	   PENTAGONAL PRISM | math.vol("pentagonal prism", baseEdgeLength, height)
	    HEXAGONAL PRISM | math.vol("hexagonal prism", baseEdgeLength, height)
	           CYLINDER | math.vol("cylinder", radius, height)
	TRIANGLULAR PYRAMID | math.vol("triangular pyramid", baseArea, height)
	            PYRAMID | math.vol("pyramid", baseArea, height)
	 PENTAGONAL PYRAMID | math.vol("pentagonal pyramid", baseEdgeLength, height)
	  HEXAGONAL PYRAMID | math.vol("hexagonal pyramid", baseEdgeLength, height)
				 SPHERE | math.vol("sphere", radius)
			 HEMISPHERE | math.vol("hemisphere", radius)

]]

function math.vol(shape, a, b, c, d)
	if type(shape)~="string" then
		return nil
	else
		if shape=="cube" then
			return a*b*c
		elseif shape=="triangular prism" then
			return ((1/2)*a*b*c)
		elseif shape=="pentagonal prism" then
			return (math.sqrt(25 + 10 * math.sqrt(5)) * (a * a) * b)/4
		elseif shape=="hexagonal prism" then
			return ((3*math.sqrt(3))/2)*((a*a)*b)
		elseif shape=="cylinder" then
			return math.pi*((a*a)*b)
		elseif shape=="triangular pyramid" then
			return 1/3*(a*b)
		elseif shape=="pyramid" then
			return (a*b*c)/3
		elseif shape=="pentagonal pyramid" then
			return (1/12)*(a*a)*b*math.sqrt(25+10*math.sqrt(5))
		elseif shape=="hexagonal pyramid" then
			return (math.sqrt(3)/2)*(a*a)*b
		elseif shape=="sphere" then
			return (4/3)*math.pi*(a*a*a)
		elseif shape=="hemisphere" then
			return ((4/3)*math.pi*(a*a*a))/2
		end
	end
end
