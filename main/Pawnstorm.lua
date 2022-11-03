local willToCapture = 100
local waitTime = 0.15
local doDebug = false
board = {1,1,1,1,1,1,1,1,
		 1,1,1,1,1,1,1,1,
		 ".",".",".",".",".",".",".",".",
		 ".",".",".",".",".",".",".",".",
		 ".",".",".",".",".",".",".",".",
		 ".",".",".",".",".",".",".",".",
		 8,8,8,8,8,8,8,8,
		 8,8,8,8,8,8,8,8}
local VarA = 0
local VarB = 0
local VarC = 0
local gameMode = 0
local currentPlayer = 1
local gameVerdict = 0
local squareToMove = 0
local moveTo = 0
local botSelectList = {}
local botMoveToList = {}
local botMaxSelect = 0
local evaluationW = 0
local evaluationB = 0
local trueEvalW = 0
local trueEvalB = 0
local bestMove = {}
local evalledVar = 0
local currMove = 0
--
local evalBoard = {}
local secondaryEvalBoard = {}
local evalBotSelectList = {}
local evalBotMoveToList = {}
local evalBotMaxSelect = 0
local evalWSave = 0
print("1: Play as White")
print("2: Play as Black")
print("3: AI vs AI")
print("4: Player vs Player")
io.write("Choice: ")
local player = io.read()
if player ~= "" then --Determine what type of game it is (probably does nothing)
	if player == "1" or player == "2" then
		gameMode = "Player vs AI"
	elseif player == "3" then
		gameMode = "AI vs AI"
	else
		gameMode = "Player vs Player"
	end
else
	os.exit()
end
function wait (a) --wait function
    local sec = tonumber(os.clock() + a);
    while (os.clock() < sec) do
    end
end
function printBoard() --prints the board from white's view
	print("8 |".. board[57] .." ".. board[58] .." ".. board[59] .." ".. board[60] .." ".. board[61] .." ".. board[62] .." ".. board[63] .." ".. board[64] .."|")
	print("7 |".. board[49] .." ".. board[50] .." ".. board[51] .." ".. board[52] .." ".. board[53] .." ".. board[54] .." ".. board[55] .." ".. board[56] .."|")
	print("6 |".. board[41] .." ".. board[42] .." ".. board[43] .." ".. board[44] .." ".. board[45] .." ".. board[46] .." ".. board[47] .." ".. board[48] .."|")
	print("5 |".. board[33] .." ".. board[34] .." ".. board[35] .." ".. board[36] .." ".. board[37] .." ".. board[38] .." ".. board[39] .." ".. board[40] .."|")
	print("4 |".. board[25] .." ".. board[26] .." ".. board[27] .." ".. board[28] .." ".. board[29] .." ".. board[30] .." ".. board[31] .." ".. board[32] .."|")
	print("3 |".. board[17] .." ".. board[18] .." ".. board[19] .." ".. board[20] .." ".. board[21] .." ".. board[22] .." ".. board[23] .." ".. board[24] .."|")
	print("2 |".. board[9]  .." ".. board[10] .." ".. board[11] .." ".. board[12] .." ".. board[13] .." ".. board[14] .." ".. board[15] .." ".. board[16] .."|")
	print("1 |".. board[1]  .." "..  board[2] .." "..  board[3] .." "..  board[4] .." "..  board[5] .." "..  board[6] .." "..  board[7] .." "..  board[8] .."|")
	print("==================")
	print("X  A B C D E F G H")
end
function printBoardB() --prints the board from black's view
	print( ".1 |".. board[1] .." "..  board[2] .." "..  board[3] .." "..  board[4] .." "..  board[5] .." "..  board[6] .." "..  board[7] .." "..  board[8] .."|  8")
	print( ".9 |".. board[9] .." ".. board[10] .." ".. board[11] .." ".. board[12] .." ".. board[13] .." ".. board[14] .." ".. board[15] .." ".. board[16] .."| 16")
	print("17 |".. board[17] .." ".. board[18] .." ".. board[19] .." ".. board[20] .." ".. board[21] .." ".. board[22] .." ".. board[23] .." ".. board[24] .."| 24")
	print("25 |".. board[25] .." ".. board[26] .." ".. board[27] .." ".. board[28] .." ".. board[29] .." ".. board[30] .." ".. board[31] .." ".. board[32] .."| 32")
	print("33 |".. board[33] .." ".. board[34] .." ".. board[35] .." ".. board[36] .." ".. board[37] .." ".. board[38] .." ".. board[39] .." ".. board[40] .."| 40")
	print("41 |".. board[41] .." ".. board[42] .." ".. board[43] .." ".. board[44] .." ".. board[45] .." ".. board[46] .." ".. board[47] .." ".. board[48] .."| 48")
	print("49 |".. board[49] .." ".. board[50] .." ".. board[51] .." ".. board[52] .." ".. board[53] .." ".. board[54] .." ".. board[55] .." ".. board[56] .."| 56")
	print("57 |".. board[57] .." ".. board[58] .." ".. board[59] .." ".. board[60] .." ".. board[61] .." ".. board[62] .." ".. board[63] .." ".. board[64] .."| 64")
end
function printEvalBoard()
	print("57 |".. evalBoard[57] .." ".. evalBoard[58] .." ".. evalBoard[59] .." ".. evalBoard[60] .." ".. evalBoard[61] .." ".. evalBoard[62] .." ".. evalBoard[63] .." ".. evalBoard[64] .."| 64")
	print("49 |".. evalBoard[49] .." ".. evalBoard[50] .." ".. evalBoard[51] .." ".. evalBoard[52] .." ".. evalBoard[53] .." ".. evalBoard[54] .." ".. evalBoard[55] .." ".. evalBoard[56] .."| 56")
	print("41 |".. evalBoard[41] .." ".. evalBoard[42] .." ".. evalBoard[43] .." ".. evalBoard[44] .." ".. evalBoard[45] .." ".. evalBoard[46] .." ".. evalBoard[47] .." ".. evalBoard[48] .."| 48")
	print("33 |".. evalBoard[33] .." ".. evalBoard[34] .." ".. evalBoard[35] .." ".. evalBoard[36] .." ".. evalBoard[37] .." ".. evalBoard[38] .." ".. evalBoard[39] .." ".. evalBoard[40] .."| 40")
	print("25 |".. evalBoard[25] .." ".. evalBoard[26] .." ".. evalBoard[27] .." ".. evalBoard[28] .." ".. evalBoard[29] .." ".. evalBoard[30] .." ".. evalBoard[31] .." ".. evalBoard[32] .."| 32")
	print("17 |".. evalBoard[17] .." ".. evalBoard[18] .." ".. evalBoard[19] .." ".. evalBoard[20] .." ".. evalBoard[21] .." ".. evalBoard[22] .." ".. evalBoard[23] .." ".. evalBoard[24] .."| 24")
	print( ".9 |".. evalBoard[9] .." ".. evalBoard[10] .." ".. evalBoard[11] .." ".. evalBoard[12] .." ".. evalBoard[13] .." ".. evalBoard[14] .." ".. evalBoard[15] .." ".. evalBoard[16] .."| 16")
	print( ".1 |".. evalBoard[1] .." "..  evalBoard[2] .." "..  evalBoard[3] .." "..  evalBoard[4] .." "..  evalBoard[5] .." "..  evalBoard[6] .." "..  evalBoard[7] .." "..  evalBoard[8] .."|  8")
end
function algNotate(change) --dear god. changes long algebraic notation to a number the script understands
	if change=="a1" then VarB=1 elseif change=="b1" then VarB=2 elseif change=="c1" then VarB=3 elseif change=="d1" then VarB=4 elseif change=="e1" then VarB=5 elseif change=="f1" then VarB=6 elseif change=="g1" then VarB=7 elseif change=="h1" then VarB=8 elseif change=="a2" then VarB=9 elseif change=="b2" then VarB=10 elseif change=="c2" then VarB=11 elseif change=="d2" then VarB=12 elseif change=="e2" then VarB=13 elseif change=="f2" then VarB=14 elseif change=="g2" then VarB=15 elseif change=="h2" then VarB=16 elseif change=="a3" then VarB=17 elseif change=="b3" then VarB=18 elseif change=="c3" then VarB=19 elseif change=="d3" then VarB=20 elseif change=="e3" then VarB=21 elseif change=="f3" then VarB=22 elseif change=="g3" then VarB=23 elseif change=="h3" then VarB=24 elseif change=="a4" then VarB=25 elseif change=="b4" then VarB=26 elseif change=="c4" then VarB=27 elseif change=="d4" then VarB=28 elseif change=="e4" then VarB=29 elseif change=="f4" then VarB=30 elseif change=="g4" then VarB=31 elseif change=="h4" then VarB=32 elseif change=="a5" then VarB=33 elseif change=="b5" then VarB=34 elseif change=="c5" then VarB=35 elseif change=="d5" then VarB=36 elseif change=="e5" then VarB=37 elseif change=="f5" then VarB=38 elseif change=="g5" then VarB=39 elseif change=="h5" then VarB=40 elseif change=="a6" then VarB=41 elseif change=="b6" then VarB=42 elseif change=="c6" then VarB=43 elseif change=="d6" then VarB=44 elseif change=="e6" then VarB=45 elseif change=="f6" then VarB=46 elseif change=="g6" then VarB=47 elseif change=="h6" then VarB=48 elseif change=="a7" then VarB=49 elseif change=="b7" then VarB=50 elseif change=="c7" then VarB=51 elseif change=="d7" then VarB=52 elseif change=="e7" then VarB=53 elseif change=="f7" then VarB=54 elseif change=="g7" then VarB=55 elseif change=="h7" then VarB=56 elseif change=="a8" then VarB=57 elseif change=="b8" then VarB=58 elseif change=="c8" then VarB=59 elseif change=="d8" then VarB=60 elseif change=="e8" then VarB=61 elseif change=="f8" then VarB=62 elseif change=="g8" then VarB=63 elseif change=="h8" then VarB=64 end
end
function evalWhite() --evaluates white's position
	evaluationW = 0
	for i=1,56,1 do
		if board[i] == 1 then
			if i < 9 then
				evaluationW = evaluationW - 0.075
			elseif i < 17 then
				evaluationW = evaluationW - 0.025
			elseif i < 33 then
				evaluationW = evaluationW + 0.05
			elseif i < 41 then
				evaluationW = evaluationW + 0.5
			elseif i < 49 then
				evaluationW = evaluationW + 1.25
			elseif i < 57 then
				evaluationW = evaluationW + 6.75
			end
			if board[i+8] == "." then
				evaluationW = evaluationW + 0.05
			end
			if i < 17 then
				if board[i+16] == "." and board[i+8] == "." then
					evaluationW = evaluationW + 0.05
				end
			end
			if board[i+7] == 8 then
				if i ~= 1 and i ~= 9 and i ~= 17 and i ~= 25 and i ~= 33 and i ~= 41 and i ~= 49 and i ~= 57 then
					evaluationW = evaluationW + 0.15
				end
			end
			if board[i+9] == 8 then
				if i ~= 8 and i ~= 16 and i ~= 24 and i ~= 32 and i ~= 40 and i ~= 48 and i ~= 56 and i ~= 64 then
					evaluationW = evaluationW + 0.15
				end
			end
		end
	end
	trueEvalW = evaluationW
end
function evalBlack() -- evaluates black's position
	evaluationB = 0
	for i=9,64,1 do
		if board[i] == 8 then
			if i > 56 then
				evaluationB = evaluationB - 0.075
			elseif i > 48 then
				evaluationB = evaluationB - 0.05
			elseif i > 32 then
				evaluationB = evaluationB + 0.05
			elseif i > 24 then
				evaluationB = evaluationB + 0.5
			elseif i > 16 then
				evaluationB = evaluationB + 1.25
			elseif i > 8 then
				evaluationB = evaluationB + 6.75
			end
			if board[i-8] == "." then
				evaluationB = evaluationB + 0.05
			end
			if i > 48 then
				if board[i-16] == "." and board[i-8] == "." then
					evaluationB = evaluationB + 0.05
				end
			end
			if board[i-7] == 1 then
				if i ~= 8 and i ~= 16 and i ~= 24 and i ~= 32 and i ~= 40 and i ~= 48 and i ~= 56 and i ~= 64 then
					evaluationB = evaluationB + 0.15
				end
			end
			if board[i-9] == 1 then
				if i ~= 1 and i ~= 9 and i ~= 17 and i ~= 25 and i ~= 33 and i ~= 41 and i ~= 49 and i ~= 57 then
					evaluationB = evaluationB + 0.15
				end
			end
		end
	end
	trueEvalB = evaluationB
end
function evalMoves(p)
	if p == 1 then
		evalledVar = 0
		VarC = -999
		for doEval=1,botMaxSelect,1 do
			for smh=1,64,1 do
				evalBoard[smh] = board[smh]
			end
			if evalBoard[(botSelectList[doEval])] == 1 then
				evalBoard[(botMoveToList[doEval])] = 1
			elseif evalBoard[(botSelectList[doEval])] == 2 then
				evalBoard[(botMoveToList[doEval])] = 2
			end
			evalBoard[(botSelectList[doEval])] = "."
			evaluationW = 0
			if doDebug==true then
				print("Main eval: ".. doEval .."/".. botMaxSelect)
				wait(1)
			end
			for i=1,64,1 do
				if evalBoard[i] == 1 then
					if i < 9 then
						evaluationW = evaluationW - 0.15
					elseif i < 17 then
						evaluationW = evaluationW - 0.05
					elseif i < 33 then
						evaluationW = evaluationW + 0.05
					elseif i < 41 then
						evaluationW = evaluationW + 0.075
					elseif i < 49 then
						evaluationW = evaluationW + 0.1
					elseif i < 57 then
						evaluationW = evaluationW + 0.5
					elseif i == 57 or i == 58 or i == 59 or i == 60 or i == 61 or i == 62 or i == 63 or i == 64 then
						evaluationW = evaluationW + 250
						print("YO RIGHT HERE | ".. i)
					end
					if evalBoard[i+8] == "." then
						evaluationW = evaluationW + 0.0025
					end
					if i < 17 then
						if evalBoard[i+16] == "." and evalBoard[i+8] == "." then
							evaluationW = evaluationW + 0.005
						end
					end
					if evalBoard[i+7] == 8 then
						if i ~= 1 and i ~= 9 and i ~= 17 and i ~= 25 and i ~= 33 and i ~= 41 and i ~= 49 and i ~= 57 then
							evaluationW = evaluationW - 0.75
						end
					end
					if evalBoard[i+9] == 8 then
						if i ~= 8 and i ~= 16 and i ~= 24 and i ~= 32 and i ~= 40 and i ~= 48 and i ~= 56 and i ~= 64 then
							evaluationW = evaluationW - 0.75
						end
					end
				elseif evalBoard[i] == 2 then
					if evalBoard[i+8] ~= 1 and evalBoard[i+8] ~= 2 then
						if i ~= 57 and i ~= 58 and i ~= 59 and i ~= 60 and i ~= 61 and i ~= 62 and i ~= 63 and i ~= 64 then
							evaluationW = evaluationW + 0.0075
						end
					end
					if evalBoard[i+1] ~= 1 and evalBoard[i+1] ~= 2 then
						if i ~= 8 and i ~= 16 and i ~= 24 and i ~= 32 and i ~= 40 and i ~= 48 and i ~= 56 and i ~= 64 then
							evaluationW = evaluationW + 0.0075
						end
					end
					if evalBoard[i-1] ~= 1 and evalBoard[i-1] ~= 2 then
						if i ~= 1 and i ~= 9 and i ~= 17 and i ~= 25 and i ~= 33 and i ~= 41 and i ~= 49 and i ~= 57 then
							evaluationW = evaluationW + 0.0075
						end
					end
					if evalBoard[i-8] ~= 1 and evalBoard[i-8] ~= 2 then
						if i ~= 1 and i ~= 2 and i ~= 3 and i ~= 4 and i ~= 5 and i ~= 6 and i ~= 7 and i ~= 8 then
							evaluationW = evaluationW + 0.0075
						end
					end
				end
				evalWSave = evaluationW
				evaluationB = 0
				evalBotSelectList = {}
				evalBotMoveToList = {}
				evalBotMaxSelect = 0
				for o=1,64,1 do
					evaluationW = evalWSave
					if board[o] == 8 then
						if o > 56 then
							evaluationW = evaluationW + 0.15
						elseif o > 48 then
							evaluationW = evaluationW + 0.05
						elseif o > 32 then
							evaluationW = evaluationW - 0.05
						elseif o > 24 then
							evaluationW = evaluationW - 0.075
						elseif o > 16 then
							evaluationW = evaluationW - 0.1
						elseif o > 8 then
							evaluationW = evaluationW - 0.5
						end
						if board[o-8] == "." then
							evaluationW = evaluationW - 0.0025
							table.insert(evalBotSelectList,o)
							table.insert(evalBotMoveToList,(o-8))
							evalBotMaxSelect = (evalBotMaxSelect + 1)
						end
						if o > 48 then
							if board[o-16] == "." and board[o-8] == "." then
								evaluationW = evaluationW - 0.005
								table.insert(evalBotSelectList,o)
								table.insert(evalBotMoveToList,(o-16))
								evalBotMaxSelect = (evalBotMaxSelect + 1)
							end
						end
						if board[o-7] == 1 or board[o-7] == 2 then
							if o ~= 8 and o ~= 16 and o ~= 24 and o ~= 32 and o ~= 40 and o ~= 48 and o ~= 56 and o ~= 64 then
								evaluationW = evaluationW + 0.75
								table.insert(evalBotSelectList,o)
								table.insert(evalBotMoveToList,(o-7))
								evalBotMaxSelect = (evalBotMaxSelect + 1)
							end
						end
						if board[o-9] == 1 or board[o-9] == 2 then
							if o ~= 1 and o ~= 9 and o ~= 17 and o ~= 25 and o ~= 33 and o ~= 41 and o ~= 49 and o ~= 57 then
								evaluationW = evaluationW + 0.75
								table.insert(evalBotSelectList,o)
								table.insert(evalBotMoveToList,(o-9))
								evalBotMaxSelect = (evalBotMaxSelect + 1)
							end
						end
					elseif board[o] == 9 then
						if board[o+8] ~= 8 and board[o+8] ~= 9 then
							if o ~= 57 and o ~= 58 and o ~= 59 and o ~= 60 and o ~= 61 and o ~= 62 and o ~= 63 and o ~= 64 then
								evaluationW = evaluationW - 0.0075
								table.insert(evalBotSelectList,o)
								table.insert(evalBotMoveToList,(o+8))
								evalBotMaxSelect = (evalBotMaxSelect + 1)
							end
						end
						if board[o+1] ~= 8 and board[o+1] ~= 9 then
							if o ~= 8 and o ~= 16 and o ~= 24 and o ~= 32 and o ~= 40 and o ~= 48 and o ~= 56 and o ~= 64 then
								evaluationW = evaluationW - 0.0075
								table.insert(evalBotSelectList,o)
								table.insert(evalBotMoveToList,(o+1))
								evalBotMaxSelect = (evalBotMaxSelect + 1)
							end
						end
						if board[o-1] ~= 8 and board[o-1] ~= 9 then
							if o ~= 1 and o ~= 9 and o ~= 17 and o ~= 25 and o ~= 33 and o ~= 41 and o ~= 49 and o ~= 57 then
								evaluationW = evaluationW - 0.0075
								table.insert(evalBotSelectList,o)
								table.insert(evalBotMoveToList,(o-1))
								evalBotMaxSelect = (evalBotMaxSelect + 1)
							end
						end
						if board[o-8] ~= 8 and board[o-8] ~= 9 then
							if o ~= 1 and o ~= 2 and o ~= 3 and o ~= 4 and o ~= 5 and o ~= 6 and o ~= 7 and o ~= 8 then
								evaluationW = evaluationW - 0.0075
								table.insert(evalBotSelectList,o)
								table.insert(evalBotMoveToList,(o-8))
								evalBotMaxSelect = (evalBotMaxSelect + 1)
							end
						end
					end
				end
				evalWSave = evaluationW
				for doEvalAgain=1,evalBotMaxSelect,1 do
					for smh=1,64,1 do
						evalBoard[smh] = board[smh]
					end
					if evalBoard[(botSelectList[doEval])] == 1 then
						evalBoard[(botMoveToList[doEval])] = 1
					elseif evalBoard[(botSelectList[doEval])] == 2 then
						evalBoard[(botMoveToList[doEval])] = 2
					end
					evalBoard[(botSelectList[doEval])] = "."
					if evalBoard[(evalBotSelectList[doEvalAgain])] == 8 then
						evalBoard[(evalBotMoveToList[doEvalAgain])] = 8
					elseif evalBoard[(evalBotSelectList[doEvalAgain])] == 9 then
						evalBoard[(evalBotMoveToList[doEvalAgain])] = 9
					end
					evalBoard[(evalBotSelectList[doEvalAgain])] = "."
					if doDebug==true then
						printEvalBoard()
						print(doEvalAgain .."/".. evalBotMaxSelect)
						print(evalBotSelectList[1])
					end
					for p=1,64,1 do
						evaluationW = evalWSave
						if evalBoard[p] == 1 then
							evaluationW = evaluationW + 0.025
							if p < 9 then
								evaluationW = evaluationW - 0.15
							elseif p < 17 then
								evaluationW = evaluationW - 0.05
							elseif p < 33 then
								evaluationW = evaluationW + 0.05
							elseif p < 41 then
								evaluationW = evaluationW + 0.075
							elseif p < 49 then
								evaluationW = evaluationW + 0.1
							elseif p < 57 then
								evaluationW = evaluationW + 0.5
							elseif p == 57 or p == 58 or p == 59 or p == 60 or p == 61 or p == 62 or p == 63 or p == 64 then
								evaluationW = evaluationW + 250
							end
							if evalBoard[p+8] == "." then
								evaluationW = evaluationW + 0.0025
							end
							if p < 17 then
								if evalBoard[p+16] == "." and evalBoard[p+8] == "." then
									evaluationW = evaluationW + 0.005
								end
							end
							if evalBoard[p+7] == 8 or evalBoard[p+7] == 9 then
								if p ~= 1 and p ~= 9 and p ~= 17 and p ~= 25 and p ~= 33 and p ~= 41 and p ~= 49 and p ~= 57 then
									evaluationW = evaluationW - 0.75
								end
							end
							if evalBoard[p+9] == 8 or evalBoard[p+9] == 9 then
								if p ~= 8 and p ~= 16 and p ~= 24 and p ~= 32 and p ~= 40 and p ~= 48 and p ~= 56 and p ~= 64 then
									evaluationW = evaluationW - 0.75
								end
							end
						elseif evalBoard[p] == 2 then
							if evalBoard[p+8] ~= 1 and evalBoard[p+8] ~= 2 then
								if p ~= 57 and p ~= 58 and p ~= 59 and p ~= 60 and p ~= 61 and p ~= 62 and p ~= 63 and p ~= 64 then
									evaluationW = evaluationW + 0.0075
								end
							end
							if evalBoard[p+1] ~= 1 and evalBoard[p+1] ~= 2 then
								if p ~= 8 and p ~= 16 and p ~= 24 and p ~= 32 and p ~= 40 and p ~= 48 and p ~= 56 and p ~= 64 then
									evaluationW = evaluationW + 0.0075
								end
							end
							if evalBoard[p-1] ~= 1 and evalBoard[p-1] ~= 2 then
								if p ~= 1 and p ~= 9 and p ~= 17 and p ~= 25 and p ~= 33 and p ~= 41 and p ~= 49 and p ~= 57 then
									evaluationW = evaluationW + 0.0075
								end
							end
							if evalBoard[p-8] ~= 1 and evalBoard[p-8] ~= 2 then
								if p ~= 1 and p ~= 2 and p ~= 3 and p ~= 4 and p ~= 5 and p ~= 6 and p ~= 7 and p ~= 8 then
									evaluationW = evaluationW + 0.0075
								end
							end
						elseif evalBoard[p] == 8 then
							evaluationW = evaluationW - 0.025
							if p > 56 then
								evaluationW = evaluationW + 0.15
							elseif p > 48 then
								evaluationW = evaluationW + 0.05
							elseif p > 32 then
								evaluationW = evaluationW - 0.05
							elseif p > 24 then
								evaluationW = evaluationW - 0.075
							elseif p > 16 then
								evaluationW = evaluationW - 0.1
							elseif p > 8 then
								evaluationW = evaluationW - 0.5
							elseif p < 9 then
								evaluationW = evaluationW - 250
							end
							if evalBoard[p+8] == "." then
								evaluationW = evaluationW - 0.0025
							end
							if p < 17 then
								if evalBoard[p+16] == "." and evalBoard[p+8] == "." then
									evaluationW = evaluationW - 0.005
								end
							end
							if evalBoard[p+7] == 1 or evalBoard[p+7] == 2 then
								if p ~= 1 and p ~= 9 and p ~= 17 and p ~= 25 and p ~= 33 and p ~= 41 and p ~= 49 and p ~= 57 then
									evaluationW = evaluationW - 0.75
								end
							end
							if evalBoard[p+9] == 1 or evalBoard[p+9] == 2 then
								if p ~= 8 and p ~= 16 and p ~= 24 and p ~= 32 and p ~= 40 and p ~= 48 and p ~= 56 and p ~= 64 then
									evaluationW = evaluationW - 0.75
								end
							end
						elseif evalBoard[p] == 9 then
							evaluationW = evaluationW - 0.025
							if evalBoard[p+8] ~= 8 and evalBoard[p+8] ~= 9 then
								if p ~= 57 and p ~= 58 and p ~= 59 and p ~= 60 and p ~= 61 and p ~= 62 and p ~= 63 and p ~= 64 then
									evaluationW = evaluationW - 0.0075
								end
							end
							if evalBoard[p+1] ~= 8 and evalBoard[p+1] ~= 9 then
								if p ~= 8 and p ~= 16 and p ~= 24 and p ~= 32 and p ~= 40 and p ~= 48 and p ~= 56 and p ~= 64 then
									evaluationW = evaluationW - 0.0075
								end
							end
							if evalBoard[p-1] ~= 8 and evalBoard[p-1] ~= 9 then
								if p ~= 1 and p ~= 9 and p ~= 17 and p ~= 25 and p ~= 33 and p ~= 41 and p ~= 49 and p ~= 57 then
									evaluationW = evaluationW - 0.0075
								end
							end
							if evalBoard[p-8] ~= 8 and evalBoard[p-8] ~= 9 then
								if p ~= 1 and p ~= 2 and p ~= 3 and p ~= 4 and p ~= 5 and p ~= 6 and p ~= 7 and p ~= 8 then
									evaluationW = evaluationW - 0.0075
								end
							end
						end
					end
					--prev location that worked
				end
				--might work but eh
			end
			if evaluationW > VarC then
				bestMove[1] = botSelectList[doEval]
				bestMove[2] = botMoveToList[doEval]
				evalledVar = doEval
				VarC = evaluationW
				if doDebug==true then
					print("cool")
					print(VarC .."| eval of move was: ".. evaluationW)
					wait(1)
				end
			else
				if doDebug==true then print(VarC .."| eval of move was: ".. evaluationW) end
			end
		end
		--lol doesnt work
	end
end
while true do --the whole game
	if currentPlayer == 1 and gameVerdict == 0 then --if player is white then play white
		print("WHITE TO PLAY")
		printBoard()
		if player == "1" or player == "4" then
			evalWhite()
			io.write("Piece to move: ")
			squareToMove = io.read()
			algNotate(squareToMove)
			squareToMove = VarB
			print(squareToMove)
			print(board[squareToMove])
			if board[squareToMove] ~= 1 and board[squareToMove] ~= 2 then
				print("bruh this aint even your piece")
			end
			io.write("Square to move to: ")
			moveTo = io.read()
			algNotate(moveTo)
			moveTo = VarB
			if (squareToMove+7) == moveTo then
				if squareToMove ~= 1 and squareToMove ~= 9 and squareToMove ~= 17 and squareToMove ~= 25 and squareToMove ~= 33 and squareToMove ~= 41 and squareToMove ~= 49 and squareToMove ~= 57 then
					if board[moveTo] == "." or board[moveTo] == 1 or board[moveTo] == 2 then
						print("illegal; nothing to capture")
					else
						board[squareToMove] = "."
						board[moveTo] = 1
					end
				else
					print("illegal; this piece cant capture left")
				end
			elseif (squareToMove+16) == moveTo then
				if board[moveTo] == "." and board[moveTo-8] == "." then
					board[squareToMove] = "."
					board[moveTo] = 1
				else
					print("illegal; piece is blocked")
				end
			elseif (squareToMove+8) == moveTo then
				if board[moveTo] == 8 or board[moveTo] == 1 or board[moveTo] == 2 or board[moveTo] == 9 then
					print("illegal; you cant move there")
				else
					board[squareToMove] = "."
					board[moveTo] = 1
				end
			elseif (squareToMove+9) == moveTo then
				if squareToMove ~= 8 and squareToMove ~= 16 and squareToMove ~= 24 and squareToMove ~= 32 and squareToMove ~= 40 and squareToMove ~= 48 and squareToMove ~= 56 and squareToMove ~= 64 then
					if board[moveTo] == "." or board[moveTo] == 1 or board[moveTo] == 2 then
						print("illegal; nothing to capture")
					else
						board[squareToMove] = "."
						board[moveTo] = 1
					end
				else
					print("illegal; this piece can't capture right")
				end
			else
				print("wtf are you thinking")
			end
		else
			evaluationW = 0
			for i=1,56,1 do
				if board[i] == 1 then
					if i < 9 then
						evaluationW = evaluationW - 0.15
					elseif i < 17 then
						evaluationW = evaluationW - 0.05
					elseif i < 33 then
						evaluationW = evaluationW + 0.05
					elseif i < 41 then
						evaluationW = evaluationW + 0.075
					elseif i < 49 then
						evaluationW = evaluationW + 0.1
					elseif i < 57 then
						evaluationW = evaluationW + 0.5
					end
					if board[i+8] == "." then
						wait(waitTime)
						evaluationW = evaluationW + 0.05
						table.insert(botSelectList,i)
						table.insert(botMoveToList,(i+8))
						botMaxSelect = (botMaxSelect + 1)
					end
					if i < 17 then
						if board[i+16] == "." and board[i+8] == "." then
							wait(waitTime)
							evaluationW = evaluationW + 0.05
							table.insert(botSelectList,i)
							table.insert(botMoveToList,(i+16))
							botMaxSelect = (botMaxSelect + 1)
						end
					end
					if board[i+7] == 8 or board[i+7] == 9 then
						if i ~= 1 and i ~= 9 and i ~= 17 and i ~= 25 and i ~= 33 and i ~= 41 and i ~= 49 and i ~= 57 then
							wait(waitTime)
							evaluationW = evaluationW - 0.15
							table.insert(botSelectList,i)
							table.insert(botMoveToList,(i+7))
							botMaxSelect = (botMaxSelect + 1)
						end
					end
					if board[i+9] == 8 or board[i+9] == 9 then
						if i ~= 8 and i ~= 16 and i ~= 24 and i ~= 32 and i ~= 40 and i ~= 48 and i ~= 56 and i ~= 64 then
							wait(waitTime)
							evaluationW = evaluationW - 0.15
							table.insert(botSelectList,i)
							table.insert(botMoveToList,(i+9))
							botMaxSelect = (botMaxSelect + 1)
						end
					end
				elseif board[i] == 2 then
					if board[i+8] ~= 1 and board[i+8] ~= 2 then
						if i ~= 57 and i ~= 58 and i ~= 59 and i ~= 60 and i ~= 61 and i ~= 62 and i ~= 63 and i ~= 64 then
							wait(waitTime)
							evaluationW = evaluationW + 0.05
							table.insert(botSelectList,i)
							table.insert(botMoveToList,(i+8))
							botMaxSelect = (botMaxSelect + 1)
						end
					end
					if board[i+1] ~= 1 and board[i+1] ~= 2 then
						if i ~= 8 and i ~= 16 and i ~= 24 and i ~= 32 and i ~= 40 and i ~= 48 and i ~= 56 and i ~= 64 then
							wait(waitTime)
							evaluationW = evaluationW + 0.15
							table.insert(botSelectList,i)
							table.insert(botMoveToList,(i+1))
							botMaxSelect = (botMaxSelect + 1)
						end
					end
					if board[i-1] ~= 1 and board[i-1] ~= 2 then
						if i ~= 1 and i ~= 9 and i ~= 17 and i ~= 25 and i ~= 33 and i ~= 41 and i ~= 49 and i ~= 57 then
							wait(waitTime)
							evaluationW = evaluationW + 0.15
							table.insert(botSelectList,i)
							table.insert(botMoveToList,(i-1))
							botMaxSelect = (botMaxSelect + 1)
						end
					end
					if board[i-8] ~= 1 and board[i-8] ~= 2 then
						if i ~= 1 and i ~= 2 and i ~= 3 and i ~= 4 and i ~= 5 and i ~= 6 and i ~= 7 and i ~= 8 then
							wait(waitTime)
							evaluationW = evaluationW + 0.15
							table.insert(botSelectList,i)
							table.insert(botMoveToList,(i-8))
							botMaxSelect = (botMaxSelect + 1)
						end
					end
				end
			end
			trueEvalW = evaluationW
			evaluationW = evaluationW - trueEvalB
			print(botMaxSelect .." possible moves for white..")
			print("Evaluation: ".. evaluationW)
			if botMaxSelect == 0 then
				gameVerdict = 3
			else
				if currMove > 1 then
					evalMoves(1)
					if evalledVar ~= 0 then
						if board[(bestMove[1])] == 1 then
							board[(bestMove[2])] = 1
						elseif board[(bestMove[1])] == 2 then
							board[(bestMove[2])] = 2
						end
						if doDebug==true then
							print(board[(bestMove[1])])
							print(board[(bestMove[2])])
							print("literally: ".. evalledVar)
						end
						board[(botSelectList[evalledVar])] = "."
					else
						math.randomseed(os.time())
						for i=0,10,1 do
							math.randomseed(os.time())
							VarA = VarA + math.random(1, botMaxSelect)
							VarA = 0
						end
						VarA = VarA + math.random(1, botMaxSelect)
						if board[(botSelectList[VarA])] == 1 then
							board[(botMoveToList[VarA])] = 1
						elseif board[(botSelectList[VarA])] == 2 then
							board[(botMoveToList[VarA])] = 2
						end
						board[(botSelectList[VarA])] = "."
					end
				else
					math.randomseed(os.time())
					for i=0,10,1 do
						math.randomseed(os.time())
						VarA = VarA + math.random(1, botMaxSelect)
						VarA = 0
					end
					VarA = VarA + math.random(1, botMaxSelect)
					if board[(botSelectList[VarA])] == 1 then
						board[(botMoveToList[VarA])] = 1
					elseif board[(botSelectList[VarA])] == 2 then
						board[(botMoveToList[VarA])] = 2
					end
					board[(botSelectList[VarA])] = "."
				end
				botSelectList = {}
				botMoveToList = {}
				botMaxSelect = 0
			end
		end
		print("================")
		if board[57] == 1 or board[58] == 1 or board[59] == 1 or board[60] == 1 or board[61] == 1 or board[62] == 1 or board[63] == 1 or board[64] == 1 then
			gameVerdict = 1
		end
		currentPlayer = 2
	elseif currentPlayer == 2 and gameVerdict == 0 then --if player is black then play black
		print("BLACK TO PLAY")
		printBoard()
		if player == "2" or player == "4" then
			evalBlack()
			io.write("Piece to move: ")
			squareToMove = io.read()
			algNotate(squareToMove)
			squareToMove = VarB
			print(squareToMove)
			print(board[squareToMove])
			if board[squareToMove] ~= 8 and board[squareToMove] ~= 9 then
				print("bruh this aint even your piece")
			end
			io.write("Square to move to: ")
			moveTo = io.read()
			algNotate(moveTo)
			moveTo = VarB
			if (squareToMove-7) == moveTo then
				if squareToMove ~= 8 and squareToMove ~= 16 and squareToMove ~= 24 and squareToMove ~= 32 and squareToMove ~= 40 and squareToMove ~= 48 and squareToMove ~= 56 and squareToMove ~= 64 then
					if board[moveTo] == "." or board[moveTo] == 8 then
						print("illegal; nothing to capture")
					else
						board[squareToMove] = "."
						board[moveTo] = 8
					end
				else
					print("illegal; this piece cant capture left")
				end
			elseif (squareToMove-16) == moveTo then
				if board[moveTo] == "." and board[moveTo+8] == "." then
					board[squareToMove] = "."
					board[moveTo] = 8
				else
					print("illegal; piece is blocked")
				end
			elseif (squareToMove-8) == moveTo then
				if board[moveTo] == 8 or board[moveTo] == 1 then
					print("illegal; you cant move there")
				else
					board[squareToMove] = "."
					board[moveTo] = 8
				end
			elseif (squareToMove-9) == moveTo then
				if squareToMove ~= 1 and squareToMove ~= 9 and squareToMove ~= 17 and squareToMove ~= 25 and squareToMove ~= 33 and squareToMove ~= 41 and squareToMove ~= 49 and squareToMove ~= 57 then
					if board[moveTo] == "." or board[moveTo] == 2 then
						print("illegal; nothing to capture")
					else
						board[squareToMove] = "."
						board[moveTo] = 8
					end
				else
					print("illegal; this piece can't capture right")
				end
			else
				print("wtf are you thinking")
			end
		elseif player == "1" or player == "3" then
			evaluationB = 0
			for i=9,64,1 do
				if board[i] == 8 then
					if i > 56 then
						evaluationB = evaluationB - 0.15
					elseif i > 48 then
						evaluationB = evaluationB - 0.05
					elseif i > 32 then
						evaluationB = evaluationB + 0.05
					elseif i > 24 then
						evaluationB = evaluationB + 0.075
					elseif i > 16 then
						evaluationB = evaluationB + 0.1
					elseif i > 8 then
						evaluationB = evaluationB + 0.125
					end
					if board[i-8] == "." then
						wait(waitTime)
						evaluationB = evaluationB + 0.05
						table.insert(botSelectList,i)
						table.insert(botMoveToList,(i-8))
						botMaxSelect = (botMaxSelect + 1)
					end
					if i > 48 then
						if board[i-16] == "." and board[i-8] == "." then
							wait(waitTime)
							evaluationB = evaluationB + 0.05
							table.insert(botSelectList,i)
							table.insert(botMoveToList,(i-16))
							botMaxSelect = (botMaxSelect + 1)
						end
					end
					if board[i-7] == 1 or board[i-9] == 2 then
						if i ~= 8 and i ~= 16 and i ~= 24 and i ~= 32 and i ~= 40 and i ~= 48 and i ~= 56 and i ~= 64 then
							wait(waitTime)
							evaluationB = evaluationB + 0.15
							for n=1,willToCapture,1 do
								table.insert(botSelectList,i)
								table.insert(botMoveToList,(i-7))
								botMaxSelect = (botMaxSelect + 1)
							end
						end
					end
					if board[i-9] == 1 or board[i-9] == 2 then
						if i ~= 1 and i ~= 9 and i ~= 17 and i ~= 25 and i ~= 33 and i ~= 41 and i ~= 49 and i ~= 57 then
							wait(waitTime)
							evaluationB = evaluationB + 0.15
							for n=1,willToCapture,1 do
								table.insert(botSelectList,i)
								table.insert(botMoveToList,(i-9))
								botMaxSelect = (botMaxSelect + 1)
							end
						end
					end
				elseif board[i] == 9 then
					if board[i+8] ~= 8 and board[i+8] ~= 9 then
						if i ~= 57 and i ~= 58 and i ~= 59 and i ~= 60 and i ~= 61 and i ~= 62 and i ~= 63 and i ~= 64 then
							wait(waitTime)
							evaluationB = evaluationB + 0.05
							table.insert(botSelectList,i)
							table.insert(botMoveToList,(i+8))
							botMaxSelect = (botMaxSelect + 1)
						end
					end
					if board[i+1] ~= 8 and board[i+1] ~= 9 then
						if i ~= 8 and i ~= 16 and i ~= 24 and i ~= 32 and i ~= 40 and i ~= 48 and i ~= 56 and i ~= 64 then
							wait(waitTime)
							evaluationB = evaluationB + 0.15
							table.insert(botSelectList,i)
							table.insert(botMoveToList,(i+1))
							botMaxSelect = (botMaxSelect + 1)
						end
					end
					if board[i-1] ~= 8 and board[i-1] ~= 9 then
						if i ~= 1 and i ~= 9 and i ~= 17 and i ~= 25 and i ~= 33 and i ~= 41 and i ~= 49 and i ~= 57 then
							wait(waitTime)
							evaluationB = evaluationB + 0.15
							table.insert(botSelectList,i)
							table.insert(botMoveToList,(i-1))
							botMaxSelect = (botMaxSelect + 1)
						end
					end
					if board[i-8] ~= 8 and board[i-8] ~= 9 then
						if i ~= 1 and i ~= 2 and i ~= 3 and i ~= 4 and i ~= 5 and i ~= 6 and i ~= 7 and i ~= 8 then
							wait(waitTime)
							evaluationB = evaluationB + 0.15
							table.insert(botSelectList,i)
							table.insert(botMoveToList,(i-8))
							botMaxSelect = (botMaxSelect + 1)
						end
					end
				end
			end
			trueEvalB = evaluationB
			evaluationB = evaluationB - trueEvalW
			print(botMaxSelect .." possible moves for black..")
			print("Evaluation: ".. evaluationB)
			if botMaxSelect == 0 then
				gameVerdict = 3
			else
				math.randomseed(os.time())
				for i=0,10,1 do
					math.randomseed(os.time())
					VarA = VarA + math.random(1, botMaxSelect)
					VarA = 0
				end
			VarA = VarA + math.random(1, botMaxSelect)
				if board[(botSelectList[VarA])] == 8 then
					board[(botMoveToList[VarA])] = 8
				elseif board[(botSelectList[VarA])] == 9 then
					board[(botMoveToList[VarA])] = 9
				end
				board[(botSelectList[VarA])] = "."
				botSelectList = {}
				botMoveToList = {}
				botMaxSelect = 0
			end
			currMove = currMove + 1
		end
		print("================")
		if board[1] == 8 or board[2] == 8 or board[3] == 8 or board[4] == 8 or board[5] == 8 or board[6] == 8 or board[7] == 8 or board[8] == 8 then
			gameVerdict = 2
		end
		currentPlayer = 1
	elseif gameVerdict == 1 then
		print("================")
		printBoard()
		print("================")
		print("PLAYER 1 WINS!")
		if player == "1" then
			print("Good job!")
		else
			print("Better luck next time.")
		end
		io.read()
		os.exit()
	elseif gameVerdict == 2 then
		print("================")
		printBoard()
		print("================")
		print("PLAYER 2 WINS!")
		if player == "2" then
			print("Good job!")
		else
			print("Better luck next time.")
		end
		io.read()
		os.exit()
	elseif gameVerdict == 3 then
		print("================")
		printBoard()
		print("================")
		print("Stalemate")
		if player == "2" then
			print("No possible moves for black!")
		elseif player == "1" then
			print("No possible moves for white!")
		else
			print("No possible moves!")
		end
		print("Better luck next time.")
		io.read()
		--os.exit()
	end
end
io.read()




