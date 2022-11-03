gb = require("gblib")
require("Luatils")
math.randomseed(os.time())
GameTable = gb.new(5,5)
gb.set(GameTable, 13, 1)
if gb.left(GameTable, 13)~=nil then gb.set(GameTable, gb.left(GameTable, 13), 2) end
if gb.up(GameTable, 13)~=nil then gb.set(GameTable, gb.up(GameTable, 13), 3) end
gb.set(GameTable, gb.down(GameTable, 13), 4)
gb.set(GameTable, gb.right(GameTable, 13), 5)
gameWidth, gameHeight = gb.dim(GameTable)
print(gameWidth .." by ".. gameHeight)
gb.write(GameTable, "basic spaced")

print("")
print("Demonstration of how the basic gblib commands work. Press enter to view a complex demonstration.")
io.read()

gameTable = gb.new(5,5)
playerLocation=1
temp = 0
while true do
	wait(0.5)
	os.execute("cls")
	wasPossible=false
	while wasPossible==false do
		temp = math.random(1,4)
		if temp==1 then
			if gb.left(gameTable, playerLocation)~=nil then
				gb.set(gameTable, playerLocation, 8)
				playerLocation=gb.left(gameTable, playerLocation)
				gb.set(gameTable, playerLocation, 1)
				wasPossible=true
			end
		elseif temp==2 then
			if gb.up(gameTable, playerLocation)~=nil then
				gb.set(gameTable, playerLocation, 8)
				playerLocation=gb.up(gameTable, playerLocation)
				gb.set(gameTable, playerLocation, 1)
				wasPossible=true
			end
		elseif temp==3 then
			if gb.down(gameTable, playerLocation)~=nil then
				gb.set(gameTable, playerLocation, 8)
				playerLocation=gb.down(gameTable, playerLocation)
				gb.set(gameTable, playerLocation, 1)
				wasPossible=true
			end
		elseif temp==4 then
			if gb.right(gameTable, playerLocation)~=nil then
				gb.set(gameTable, playerLocation, 8)
				playerLocation=gb.right(gameTable, playerLocation)
				gb.set(gameTable, playerLocation, 1)
				wasPossible=true
			end
		end
	end
	gb.write(gameTable, "basic spaced")
end
