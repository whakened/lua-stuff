function tochar(n) return string.char((n+96)) end
--USAGE | 1=a, 2=b, 3=c, 26=z. tochar(1) returns a.

function wait(s) sb=tonumber(os.clock())+s;while os.clock()<sb do end end
--USAGE | s is how many seconds to pause the script for. wait(5) will pause for 5 seconds.

sleep = wait --alias as sleep for my fellow sleep() users

function tonum(c) return string.byte(c)-96 end
--USAGE | a=1, b=2, c=3, z=26.

function math.quad(a, b, c)
	d = b*b-4*a*c
	if d==0 then
		return (-b/2/a)
	else if d>0 then
			return {(-b+math.sqrt(d))/2/A, (-b-math.sqrt(d))/2/a}
		 else
			return {-b/2/a, math.sqrt(-d)/2/a, -b/2/a, -math.sqrt(-d)/2/a}
		 end
	end
end
--USAGE | Returns quadratic formula of given numbers. math.quad(5,6,1) returns {-0.2, -1}.

function math.dist(xa, ya, xb, yb)
	return math.sqrt(((xB - xA)^2)+((yB - yA)^2))
end
--USAGE | Returns distance of both points. math.dist(1,0,5,0) returns 4.

function math.pyth(a, b) return math.sqrt((a*a) + (b*b)) end
--USAGE | Returns pythagorean theorem. math.pyth(1,2) returns 2.2360679774998.

function math.midp(xa, ya, xb, yb)
	return {((xa+xb)/2), ((ya + yb)/2)}
end
--USAGE | Returns midpoint of two points. math.midp(1,5,5,5) returns {3, 5}.

function math.round(a)
	return math.floor(a+0.5)
end
--USAGE | Returns a number rounded properly. math.round(5.35) returns 5, while math.round(5.53) returns 6.
