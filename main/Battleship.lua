boardA = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
boardB = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
math.randomseed(os.time())
math.random()
math.random()
print("Select difficulty.")
print("0 | infant")
print("1 | Easy")
print("2 | Medium")
print("3 | Challenging")
print("4 | Expert")
print("5 | Impossible")
local difficulty = tonumber(io.read())
if difficulty<0 or difficulty>5 then difficulty=3 end
function wait(a)
    local sec=tonumber(os.clock()+a);
    while (os.clock()<sec) do
    end
end
function scatterShips(board)
	for i=5,2,-1 do
		local length = i --ship length
		local direction=0
		canLeft,canRight,canUp,canDown=true,true,true,true
		local potentialDirections = {}
		local point = math.random(1,72)
		if point<=length*12 then
			canUp=false
		elseif point>=96-(length*12) then
			canDown=false
		else
			direction = math.random(1,2)
		end
		tempPoint=point
		while tempPoint>12 do
			tempPoint=tempPoint-12
		end
		if tempPoint<i then
			canLeft=false
		elseif tempPoint>12-i then
			canRight=false
		end
		if canUp==true then
			table.insert(potentialDirections, 1)
		end
		if canDown==true then
			table.insert(potentialDirections, 2)
		end
		if canLeft==true then
			table.insert(potentialDirections, 3)
		end
		if canRight==true then
			table.insert(potentialDirections, 4)
		end
		direction=potentialDirections[math.random(1,#potentialDirections)]
		if direction==1 then
			board[point]=1
			if length>1 then board[point-12]=1 end
			if length>2 then board[point-24]=1 end
			if length>3 then board[point-36]=1 end
			if length>4 then board[point-48]=1 end
		end
		if direction==2 then
			board[point]=1
			if length>1 then board[point+12]=1 end
			if length>2 then board[point+24]=1 end
			if length>3 then board[point+36]=1 end
			if length>4 then board[point+48]=1 end
		end
		if direction==3 then
			board[point]=1
			if length>1 then board[point-1]=1 end
			if length>2 then board[point-2]=1 end
			if length>3 then board[point-3]=1 end
			if length>4 then board[point-4]=1 end
		end
		if direction==4 then
			board[point]=1
			if length>1 then board[point+1]=1 end
			if length>2 then board[point+2]=1 end
			if length>3 then board[point+3]=1 end
			if length>4 then board[point+4]=1 end
		end
	end
end
scatterShips(boardA)
scatterShips(boardB)
local move = 0
print("Game Prepared!")
print("")
print("Controls:\n[Letter][Number]: Guess a tile on the enemy's board.\nMyBoard | mb: Show your board.\nKnown: Shows all moves you've made.\nHelp: Show this dialogue.")
function console()
	cmd=string.lower(io.read())
	if cmd=="mb" or cmd=="myboard" or cmd=="my board" then
		writeBoard(boardA)
		print("")
	elseif string.len(cmd)==2 then
		invalidCoordinate=false
		moveCoordinate = getCoordinateFromInput(cmd:sub(1,1),tonumber(cmd:sub(2,2)))
		if type(moveCoordinate)=="number" then
			if moveCoordinate<97 and moveCoordinate>0 then
				makeMove(moveCoordinate,boardB)
			else
				print("Incorrect coordinates. Try [A-L][1-8].")
			end
		else
			print("Incorrect coordinates. Try [A-L][1-8].")
		end
	elseif cmd=="known" then
		showKnown()
		print("")
	elseif cmd=="help" then
		print("")
		print("Controls:\n[Letter][Number]: Guess a tile on the enemy's board.\nMyBoard | mb: Show your board.\nKnown: Shows all moves you've made.\nHelp: Show this dialogue.")
	end
	if cmd=="otherboard" then
		writeBoard(boardB)
		print("")
	end
	console()
end
function writeBoard(board)
	io.write("1 | ")
	for i=1,#board,1 do
		if tostring(board[i])=="0" then
			io.write(". ")
		elseif tostring(board[i])=="1" then
			io.write("8 ")
		elseif tostring(board[i])=="2" then
			io.write("! ")
		elseif tostring(board[i])=="3" then
			io.write("x ")
		end
		if i==12 or i==24 or i==36 or i==48 or i==60 or i==72 or i==84 then
			io.write("\n".. (i/12)+1 .." | ")
		end
	end
	io.write("\n# | A B C D E F G H I J K L")
end
function getCoordinateFromInput(letter, number)
	coordinate=0
	if letter=="a" then coordinate=coordinate+1 end
	if letter=="b" then coordinate=coordinate+2 end
	if letter=="c" then coordinate=coordinate+3 end
	if letter=="d" then coordinate=coordinate+4 end
	if letter=="e" then coordinate=coordinate+5 end
	if letter=="f" then coordinate=coordinate+6 end
	if letter=="g" then coordinate=coordinate+7 end
	if letter=="h" then coordinate=coordinate+8 end
	if letter=="i" then coordinate=coordinate+9 end
	if letter=="j" then coordinate=coordinate+10 end
	if letter=="k" then coordinate=coordinate+11 end
	if letter=="l" then coordinate=coordinate+12 end
	if coordinate==0 then
		invalidCoordinate=true
	end
	if type(number)~="number" then
		invalidCoordinate=true
	elseif invalidCoordinate==false then
		for i=1,number,1 do
			coordinate=coordinate+12
		end
		coordinate=coordinate-12
	end
	if invalidCoordinate==false then
		return coordinate
	else
		--print("Incorrect coordinates. Try [A-L][1-8].")
	end
end
function makeMove(coordinate, board)
	if board[coordinate]==0 then
		print("Miss.")
		board[coordinate]=3
	elseif board[coordinate]==1 then
		print("Hit!")
		board[coordinate]=2
	elseif board[coordinate]==2 then
		print("Already tried.")
	elseif board[coordinate]==3 then
		print("Already tried.")
	end
	wait(1)
	print("Opponent's turn!")
	wait(1)
	opponentCoordinate=0
	opponentMoveWorks=false
	opponentHardSkip=false
	while opponentMoveWorks==false do
		--print("the")
		coordinatePartOne = math.random(1,12)
		coordinatePartTwo = math.random(1,8)
		opponentCoordinate=(coordinatePartOne + ((coordinatePartTwo*12)-12))
		if difficulty==0 then
			if boardA[opponentCoordinate]==0 or boardA[opponentCoordinate]==2 or boardA[opponentCoordinate]==3 then
				opponentMoveWorks=true
			end
		elseif difficulty==1 then
			if boardA[opponentCoordinate]==0 or boardA[opponentCoordinate]==1 or boardA[opponentCoordinate]==2 or boardA[opponentCoordinate]==3 then
				opponentMoveWorks=true
			end
		elseif difficulty==2 then
			if boardA[opponentCoordinate]==0 or boardA[opponentCoordinate]==1 then
				opponentMoveWorks=true
			end
		elseif difficulty==3 then
			if boardA[opponentCoordinate]==0 or boardA[opponentCoordinate]==1 then
				if boardA[opponentCoordinate]==0 and opponentHardSkip==true then
					--print("br")
					opponentMoveWorks=true
					opponentHardSkip=false
				elseif boardA[opponentCoordinate]==1 and math.random()>0.85 then
					--print("good!")
					opponentMoveWorks=true
				elseif boardA[opponentCoordinate]==1 then
					--print("SKIPPED AHHAAHA.")
					opponentHardSkip=true
				end
			end
		elseif difficulty==4 then
			if boardA[opponentCoordinate]==0 or boardA[opponentCoordinate]==1 then
				if boardA[opponentCoordinate]==0 and opponentHardSkip==true then
					--print("br")
					opponentMoveWorks=true
					opponentHardSkip=false
				elseif boardA[opponentCoordinate]==1 and math.random()>0.75 then
					--print("good!")
					opponentMoveWorks=true
				elseif boardA[opponentCoordinate]==1 then
					--print("SKIPPED AHHAAHA.")
					opponentHardSkip=true
				end
			end
		elseif difficulty==5 then
			if boardA[opponentCoordinate]==1 then
				opponentMoveWorks=true
			end
		end
	end
	coordinateOpponentString = ""
	opponentCoordinate=0
	if coordinatePartOne==1 then coordinateOpponentString="a" end
	if coordinatePartOne==2 then coordinateOpponentString="b" end
	if coordinatePartOne==3 then coordinateOpponentString="c" end
	if coordinatePartOne==4 then coordinateOpponentString="d" end
	if coordinatePartOne==5 then coordinateOpponentString="e" end
	if coordinatePartOne==6 then coordinateOpponentString="f" end
	if coordinatePartOne==7 then coordinateOpponentString="g" end
	if coordinatePartOne==8 then coordinateOpponentString="h" end
	if coordinatePartOne==9 then coordinateOpponentString="i" end
	if coordinatePartOne==10 then coordinateOpponentString="j" end
	if coordinatePartOne==11 then coordinateOpponentString="k" end
	if coordinatePartOne==12 then coordinateOpponentString="l" end
	--opponentCoordinate=opponentCoordinate+((coordinatePartTwo*12)-12)
	opponentCoordinate = getCoordinateFromInput(coordinateOpponentString,coordinatePartTwo)
	coordinateOpponentString=(coordinateOpponentString .. tostring(coordinatePartTwo))
	print("Opponent tries: ".. coordinateOpponentString)
	--print(opponentCoordinate)
	if boardA[opponentCoordinate]==0 then
		print("Opponent missed.")
		boardA[opponentCoordinate]=3
	elseif boardA[opponentCoordinate]==1 then
		print("Opponent hit!")
		boardA[opponentCoordinate]=2
	elseif boardA[opponentCoordinate]==2 then
		print("Opponent already tried.")
	elseif boardA[opponentCoordinate]==3 then
		print("Opponent already tried.")
	end
	playerWhoWins = 0
	for i=1,#boardA,1 do
		if boardA[i]==1 then
			break
		end
		if i==#boardA then
			playerWhoWins=2
		end
	end
	for i=1,#boardB,1 do
		if boardB[i]==1 then
			break
		end
		if i==#boardB then
			playerWhoWins=1
		end
	end
	if playerWhoWins~=0 then
		initiateWin()
	end
	print("")
	move = move + 1
end
function showKnown()
	io.write("1 | ")
	for i=1,#boardB,1 do
		if tostring(boardB[i])=="0" then
			io.write(". ")
		elseif tostring(boardB[i])=="1" then
			io.write(". ")
		elseif tostring(boardB[i])=="2" then
			io.write("! ")
		elseif tostring(boardB[i])=="3" then
			io.write("x ")
		end
		if i==12 or i==24 or i==36 or i==48 or i==60 or i==72 or i==84 then
			io.write("\n".. (i/12)+1 .." | ")
		end
	end
	io.write("\n# | A B C D E F G H I J K L")
end
function initiateWin()
	print("")
	print("====================")
	print("")
	if playerWhoWins==1 then
		print("You win!")
		print("Congratulations!")
		writeBoard(boardA)
		local playerShipsLeft=0
		for i=1,96,1 do
			if boardA[i]==1 then playerShipsLeft=playerShipsLeft+1 end
		end
		print("")
		print("")
		print("You had ".. playerShipsLeft .." ship tiles left!")
	elseif playerWhoWins==2 then
		print("Opponent wins!")
		print("Better luck next time!")
		writeBoard(boardB)
		local opponentShipsLeft=0
		for i=1,96,1 do
			if boardB[i]==1 then opponentShipsLeft=opponentShipsLeft+1 end
		end
		print("")
		print("")
		print("Opponent had ".. opponentShipsLeft .." ship tiles left!")
	end
	wait(3)
	io.read()
	os.exit()
end
console()
io.read()
