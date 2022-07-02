-- Hangman console version Lua 5.1
-- http://pastebin.com/GbctjwVe
-- get dictionary.txt from github or elsewhere call it "dictionary.txt" in same folder as script
-- https://github.com/dmcguinness/Hangman/blob/master/dictionary.txt

version = "1.1.0"

function createDictionaryObject()
	clsDictionary = {} -- the table representing the class, which will double as the metatable for any instances
	clsDictionary.__index = clsDictionary -- failed table lookups on the instances should fallback to the class table, to get methods

	local self = setmetatable({}, clsDictionary)
	local fso = ""
	local line = ""
	local lenLine = 0
	local newIndex = 0

	self.report = "" -- no error so nothing to report

	fso = (io.open("dictionary.txt", "r")) -- check if dictionary file in place
	if fso ~= nil then
		self.wordLength = {} -- define table
		for i = 1,25 do -- create 25 tables within the wordLength{} table
			self.wordLength[i] = {}
		end

		for line in fso:lines() do   -- read each line in dictionary and put into correct list
			lenLine = #line
			if line:sub(1,2)=="//" then
				--print("Skipped comment '".. line .."'.")
				--io.read()
			elseif lenLine > 0 then -- ignore empty lines
				newIndex = #self.wordLength[lenLine] + 1
				if string.find(line, "-") == nil then -- ignore hyphenated words
					self.wordLength[lenLine][newIndex] = line
				end
			end
		end
		fso:close() -- close text file

	else -- file missing
		self.report = "Error: File 'dictionary.txt' not found"
	end

    function clsDictionary.getError(self) -- property get: error text
        return self.report
    end

    function clsDictionary.getWord(self, length) -- method: get a word from the dictionary
        local returnValue = ""

		if length > 0 and length < 26 then -- word must be between 1 and 25 characters
            listLength = #self.wordLength[length]
            if listLength > 0 then
				returnValue = string.upper(self.wordLength[length][math.random(1, listLength)])
            end
        else
            self.report = "Error: Word length nil or too long"
        end

		return returnValue
    end

	return self
end

function createHangmanObject()
    clsHangman = {} -- the table representing the class, which will double as the metatable for any instances
	clsHangman.__index = clsHangman -- failed table lookups on the instances should fallback to the class table, to get methods

    --[[
        0_________________
        1|    _________  |
        2|    | /     |  |
        3|    |/      O  |
        4|    |      /|\ |
        5|    |       |  |
        6|    |      / \ |
        7| ___|___       |
        8|_______________|
    ]]--
	local self = setmetatable({}, clsHangman)
	self.stage = 1
	self.lettersAvailable = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	self.lettersChosen = ""
	self.completed = false
	self.progress = ""
	self.fail = false
	self.word = ""
	guessIsWord = false

	self.row = {{},{},{},{},{},{},{},{},{}} -- setup array elements for graphics
	--stage 0 - new game
	self.row[1][1] = "_________________"
	self.row[2][1] = "|               |"
	self.row[3][1] = "|               |"
	self.row[4][1] = "|               |"
	self.row[5][1] = "|               |"
	self.row[6][1] = "|               |"
	self.row[7][1] = "|               |"
	self.row[8][1] = "|               |"
	self.row[9][1] = "|_______________|"
	-- stage 1 - 1 mistake
	self.row[1][2] = "_________________"
	self.row[2][2] = "|               |"
	self.row[3][2] = "|               |"
	self.row[4][2] = "|               |"
	self.row[5][2] = "|               |"
	self.row[6][2] = "|               |"
	self.row[7][2] = "|               |"
	self.row[8][2] = "| _______       |"
	self.row[9][2] = "|_______________|"
	-- stage 2 - 2 mistakes
	self.row[1][3] = "_________________"
	self.row[2][3] = "|               |"
	self.row[3][3] = "|    |          |"
	self.row[4][3] = "|    |          |"
	self.row[5][3] = "|    |          |"
	self.row[6][3] = "|    |          |"
	self.row[7][3] = "|    |          |"
	self.row[8][3] = "| ___|___       |"
	self.row[9][3] = "|_______________|"

	self.row[1][4] = "_________________"
	self.row[2][4] = "|    _________  |"
	self.row[3][4] = "|    | /        |"
	self.row[4][4] = "|    |/         |"
	self.row[5][4] = "|    |          |"
	self.row[6][4] = "|    |          |"
	self.row[7][4] = "|    |          |"
	self.row[8][4] = "| ___|___       |"
	self.row[9][4] = "|_______________|"

	self.row[1][5] = "_________________"
	self.row[2][5] = "|    _________  |"
	self.row[3][5] = "|    | /     |  |"
	self.row[4][5] = "|    |/         |"
	self.row[5][5] = "|    |          |"
	self.row[6][5] = "|    |          |"
	self.row[7][5] = "|    |          |"
	self.row[8][5] = "| ___|___       |"
	self.row[9][5] = "|_______________|"

	self.row[1][6] = "_________________"
	self.row[2][6] = "|    _________  |"
	self.row[3][6] = "|    | /     |  |"
	self.row[4][6] = "|    |/      O  |"
	self.row[5][6] = "|    |          |"
	self.row[6][6] = "|    |          |"
	self.row[7][6] = "|    |          |"
	self.row[8][6] = "| ___|___       |"
	self.row[9][6] = "|_______________|"

	self.row[1][7] = "_________________"
	self.row[2][7] = "|    _________  |"
	self.row[3][7] = "|    | /     |  |"
	self.row[4][7] = "|    |/      O  |"
	self.row[5][7] = "|    |      /   |"
	self.row[6][7] = "|    |          |"
	self.row[7][7] = "|    |          |"
	self.row[8][7] = "| ___|___       |"
	self.row[9][7] = "|_______________|"

	self.row[1][8] = "_________________"
	self.row[2][8] = "|    _________  |"
	self.row[3][8] = "|    | /     |  |"
	self.row[4][8] = "|    |/      O  |"
	self.row[5][8] = "|    |      /|  |"
	self.row[6][8] = "|    |          |"
	self.row[7][8] = "|    |          |"
	self.row[8][8] = "| ___|___       |"
	self.row[9][8] = "|_______________|"

	self.row[1][9] = "_________________"
	self.row[2][9] = "|    _________  |"
	self.row[3][9] = "|    | /     |  |"
	self.row[4][9] = "|    |/      O  |"
	self.row[5][9] = "|    |      /|"..string.char(92) .." |" -- backspace causes printing errors so use ascii code
	self.row[6][9] = "|    |          |"
	self.row[7][9] = "|    |          |"
	self.row[8][9] = "| ___|___       |"
	self.row[9][9] = "|_______________|"

	self.row[1][10] = "_________________"
	self.row[2][10] = "|    _________  |"
	self.row[3][10] = "|    | /     |  |"
	self.row[4][10] = "|    |/      O  |"
	self.row[5][10] = "|    |      /|"..string.char(92) .." |"
	self.row[6][10] = "|    |       |  |"
	self.row[7][10] = "|    |          |"
	self.row[8][10] = "| ___|___       |"
	self.row[9][10] = "|_______________|"

	self.row[1][11] = "_________________"
	self.row[2][11] = "|    _________  |"
	self.row[3][11] = "|    | /     |  |"
	self.row[4][11] = "|    |/      O  |"
	self.row[5][11] = "|    |      /|"..string.char(92) .." |"
	self.row[6][11] = "|    |       |  |"
	self.row[7][11] = "|    |      /   |"
	self.row[8][11] = "| ___|___       |"
	self.row[9][11] = "|_______________|"
	-- stage 11 - 11 mistakes - end of game
	self.row[1][12] = "_________________"
	self.row[2][12] = "|    _________  |"
	self.row[3][12] = "|    | /     |  |"
	self.row[4][12] = "|    |/      O  |"
	self.row[5][12] = "|    |      /|"..string.char(92) .." |"
	self.row[6][12] = "|    |       |  |"
	self.row[7][12] = "|    |      / "..string.char(92) .." |"
	self.row[8][12] = "| ___|___       |"
	self.row[9][12] = "|_______________|"


    function clsHangman.printStage(self) -- method: print graphics for current stage
        for i = 1, 9 do
            print(self.row[i][self.stage])
        end
        wordOut = ""
        for i = 1, #self.progress do
            wordOut = wordOut.." "..string.sub(self.progress, i, i)
        end
        print(wordOut)
    end

    function clsHangman.setWord(self, newWord) -- property set: use word from clsDictionary object
        local wordLength = #newWord

		self.word = newWord
        self.progress = ""
        for i = 1, wordLength do -- create a string of underscores as placeholders for letters
            self.progress = self.progress..'_'
        end
    end

    function clsHangman.getWord(self) -- property get: current word used in game
        return self.word
    end

    function clsHangman.getLettersAvailable(self) -- property get: list of letters mot yet tried
        return self.lettersAvailable
    end

    function clsHangman.getLettersChosen(self) -- property get: list of letters already tried
        return self.lettersChosen
    end

    function clsHangman.getCompleted(self) -- property get: game complete, either pass or fail
        return self.completed
    end

    function clsHangman.checkGuess(self, guess) -- method: check letter entered by user
		local front =""
		local middle = ""
		local endWord = ""
		local sortTable = {}

        if string.find(self.lettersChosen, guess) == nil then -- letter not used before
			if guessIsWord==true then
				self.progress = self.word
				self.completed = true
            elseif string.find(self.word, guess) ~= nil and string.len(guess) == 1 then -- letter is in game word!
                --add letter to self.progress (replace underscore characters with letters)
                position = string.find(self.word, guess) -- nil = not found, 1 = beginning
                while position ~= nil do -- found in game word
                    if position == 1 then -- first letter of word, so substitute letter for first underscore
                        front = guess
                        middle = ""
                        endWord = string.sub(self.progress, 2)
                    else -- not first letter, calculate new string with letter in place of underscore
                        front = string.sub(self.progress, 1, position - 1)
                        middle = guess
                        if position == #self.word then -- last letter.
                            endWord = ""
                        else
                            endWord = string.sub(self.progress, position + 1)
                        end
                    end
                    self.progress = front..middle..endWord
                    position = string.find(self.word, guess, position + 1)
                end
				if string.find(self.progress, '_') == nil then -- game completed as all underscores are gone
                    self.completed = true
                end
            else
                --draw next stage of hangman
                if self.stage == 11 then -- game over, word not found
                    self.fail = true
                    self.completed = true
                end
                self.stage = self.stage + 1 -- make sure next / final graphic is drawn
            end
			-- add last letter to string, convert to table, sort table and return to string
			if string.len(guess) == 1 then
				self.lettersChosen = self.lettersChosen..guess
				for i = 1, #self.lettersChosen do
					sortTable[i] = string.sub(self.lettersChosen, i, i)
				end
				table.sort(sortTable)
				self.lettersChosen = ""
				for k,v in ipairs(sortTable) do --rebuild string from table
					self.lettersChosen = self.lettersChosen..v
				end
			end
			if guessIsWord==false then
				if string.len(guess) == 1 then
					position = string.find(self.lettersAvailable, guess) -- remove last letter from list of available letters
					self.lettersAvailable = string.sub(self.lettersAvailable, 1, position - 1)..string.sub(self.lettersAvailable, position + 1)
				else
					print("Improper input!")
				end
			end
        end
    end

    function clsHangman.getFail(self) -- property get: game over with fail :(
        return self.fail
    end

	return self
end

function printMenu(wordlist, game)
    local word  = ""

	os.execute('cls') -- clear screen
    print("Hangman v"..version .." | Updated by ME.")
	print("Original code found at http://pastebin.com/GbctjwVe")
	print("=====")
	while word == "" do
		word = wordlist:getWord(math.random(5, 15)) -- get a 5 to 15 word from the dictionary
	end
    game:setWord(word) -- pass it to the game
    print("Guess the "..tostring(#game:getWord()).." letter word that I have chosen!")
end

function play(game)
	local doContinue = true

    repeat
        game:printStage()
		doContinue = true
        print("Letters Used:"..game:getLettersChosen())
        print("Letters Available: "..game:getLettersAvailable())
        print()
        repeat
			io.write("Choose a letter: ")
            guess = io.read('*l')
            if #guess > 0 then
				--print(string.upper(guess) .. string.upper(game:getWord()))
				if string.upper(guess)==string.upper(game:getWord()) then
					--print("the Similar")
					doContinue = false
					guessIsWord = true
                elseif (string.byte(guess) > 64 and string.byte(guess) < 91) or (string.byte(guess) > 96 and string.byte(guess) < 123) then
                    guess = string.upper(guess)
					doContinue = false
                end
            end
        until not doContinue
        game:checkGuess(guess)
    until game:getCompleted()
end

function main()
	local doContinue = true

    wordlist = createDictionaryObject() -- create instance of clsDictionary, which will read text file and sort into lists by word length
    if wordlist:getError() == "" then -- no errors opening dictionary
        while doContinue do
			-- Lua random generator is buggy. This helps
			math.randomseed(os.time())
			math.random()
			math.random()
            game = createHangmanObject() -- create instance of clsHangman as a game object
            printMenu(wordlist, game) -- print introduction and get word from dictionary object
            play(game) -- play the game
            game:printStage() -- print final stage
            if game:getFail() then
                print ("Sorry, you didn't get the word!")
                print("The word was: "..game:getWord())
            else
                print("Well done!")
            end
			print("Do you want to play again? (Y/N)")
            answer = io.read(1)
            if string.upper(answer) ~= "Y" then -- any key to quit, Y to continue
                os.execute('cls')
                doContinue = false
            end
        end
    else -- error opening dictionary. ? deleted/moved/renamed
        print(wordlist:getError())
    end
end
-- program runs from here
main()
