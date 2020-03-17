#!/bin/bash -x
printf "Welcome to TicTacToe\n"
# ARRAY DECLARATION
declare -a defaultBoard

# CONSTANTS
CROSS=0
CIRCLE=1

# VARIABLES
count=0

# FUNCTION TO RESET THE BOARD
function boardReset () {
	for((element=0;element<=8;element++))
	do
		defaultBoard[$element]=" "	# TAKING EVERY CELL AS AN EMPTY SPACE
	done
}

# FUNCTION TO GENERATE RANDOM VALUE FOR TOSS AND LETTER ASSIGNMENT
function randomGenerate () {
	letterAssign=$((RANDOM%2))
}

# FUNCTION FOR PLAYER LETTER AS 'X' AND COMPUTER LETTER AS 'O'
function playerXComputerO () {
	playerLetter="X"
	computerLetter="O"
}

# FUNCTION FOR PLAYER LETTER AS 'O' AND COMPUTER LETTER AS 'X'
function playerOComputerX () {
	playerLetter="O"
	computerLetter="X"
}

# CONDITION TO ASSIGN A LETTER TO PLAYER AND CHECK WHO PLAYS FIRST
function assignLetterAndToss () {
	randomGenerate	# CALLING THE FUNCTION FOR RANDOM VALUE GENERATION
	if [[ $letterAssign -eq "$CROSS" ]]
	then
		read -p "You won the Toss. Please choose your letter (X/O): " chooseLetter
		nextTurn="true"
		if [[ $chooseLetter == "X" || $chooseLetter == "x" ]]
		then
			playerXComputerO
			printf "Your assigned letter is $playerLetter\n"
		elif [[ $chooseLetter == "O" || $chooseLetter == "o" ]]
		then
			playerOComputerX
			printf "Your assigned letter is $playerLetter\n"
		else
			printf "Please choose X/O\n"
			assignLetterAndToss	# IF ENTERED VALUE IS NOT 'X' OR 'O', TOSS AGAIN
		fi
	elif [[ $letterAssign -eq "$CIRCLE" ]]
	then
		nextTurn="false"
		printf "You lost the toss\n"
		randomGenerate	# CALLING THE FUNCTION FOR RANDOM VALUE GENERATION
		if [[ $letterAssign -eq "$CROSS" ]]
		then
			playerXComputerO
		else
			playerOComputerX
		fi
		printf "Your assigned letter is $playerLetter\n"
	fi
}

# FUNCTION TO DISPLAY THE BOARD
function displayBoard () {
	for((cell=0;cell<=8;cell++))
	do
		if [[ $((cell%3)) -eq 0 && $cell -le 3 ]]
		then
			printf "_${defaultBoard[$cell]}_|_${defaultBoard[$((cell+1))]}_|_${defaultBoard[$((cell+2))]}_\n"
		elif [[ $((cell%6)) -eq 0 && $cell -le 9 ]]
		then
			printf " ${defaultBoard[$cell]} | ${defaultBoard[$((cell+1))]} | ${defaultBoard[$((cell+2))]} \n"
		fi
	done
}

# FUNCTION TO CHECK FOR ROW, COLUMN AND DIAGONAL MATCH
function boardRowColumnDiagonal () {
	column=0
	diagonal=0
	for((row=0;row<=8;row=$((row+3)) ))
	do
		rowCheck=${defaultBoard[$row]}${defaultBoard[$((row+1))]}${defaultBoard[$((row+2))]}
		columnCheck=${defaultBoard[$column]}${defaultBoard[$((column+3))]}${defaultBoard[$((column+6))]}
		diagonalCheck1=${defaultBoard[0]}${defaultBoard[4]}${defaultBoard[8]}
		diagonalCheck2=${defaultBoard[2]}${defaultBoard[4]}${defaultBoard[6]}
		if [[ $rowCheck == $1$1$1 || $columnCheck == $1$1$1 || $diagonalCheck1 == $1$1$1 || $diagonalCheck2 == $1$1$1 ]]
		then
			result="win"
		fi
		((column++))
	done
}

# FUNCTION FOR GAME BETWEEN PLAYER AND COMPUTER
function playerVsComputer()
{
	# REPEAT UNTIL THE CELL COUNT REACHES 8 (0 TO 8)
	while [[ $count -le 8 ]]
	do
		# CONDITION FOR PLAYER TO PLAY WHEN WON THE TOSS
		if [[ $nextTurn == "true" ]]
		then
			read -p "Enter Cell position number: " cellPosition
			positionSelect $playerLetter $cellPosition
			nextTurn="false"
			if [[ $result == "win" ]]
			then
				printf "player win\n"
				exit
			fi
		fi
		# CONDITION FOR COMPUTER TO PLAY WHEN WON THE TOSS
		if [[ $nextTurn == "false" ]]
		then
			computerPosition=$(($RANDOM%9))
			positionSelect $computerLetter $computerPosition
			nextTurn="true"
			if [[ $result == "win" ]]
			then
				printf "computer win\n"
				exit
			fi
		fi
	done
}

# FUNCTION TO SELECT A CELL POSITION
function positionSelect () {
	local playerPosition="false"
	local letter=$1
	local cellPosition=$2
	if [[ ${defaultBoard[$cellPosition]} == "X" || ${defaultBoard[$cellPosition]} == "O" ]]
	then
		printf "Enter another position\n"
		playerVsComputer	# CALLING THE FUNCTION
	else
		playerPosition="true"
	fi

	if [[ $playerPosition == "true" ]]
	then
		defaultBoard[$cellPosition]=$letter
		count=$(($count+1))
		displayBoard
		boardRowColumnDiagonal $letter

		if [[ $playerPosition == "false" ]]
		then
			result="draw"
			printf "draw\n"
			exit
		else
			if [[ $result -ne "win" || $result -ne "draw" ]]
			then
				printf "change turn\n"
			fi
		fi
	fi
}

# CALLING THE FUNCTIONS
boardReset
assignLetterAndToss
displayBoard
playerVsComputer
