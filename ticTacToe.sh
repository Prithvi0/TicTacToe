#!/bin/bash -x
printf "Welcome to TicTacToe\n"
# ARRAY DECLARATION
declare -a defaultBoard

# CONSTANTS
CROSS=0
CIRCLE=1

# VARIABLES
count=0
letterAssign=$((RANDOM%2))

# FUNCTION TO RESET THE BOARD
function boardReset () {
	for((element=0;element<=8;element++))
	do
		defaultBoard[$element]=" "	# TAKING EVERY CELL AS AN EMPTY SPACE
	done
}

# CONDITION TO ASSIGN A LETTER TO PLAYER AND CHECK WHO PLAYS FIRST
function assignLetterAndToss () {
	if [[ $letterAssign -eq "$CROSS" ]]
	then
		read -p "You won the Toss. Please choose your letter (X/O): " chooseLetter
		nextTurn="true"
		if [[ $chooseLetter == "X" || $chooseLetter == "x" ]]
		then
			playerLetter="X"
			computerLetter="O"
			printf "Your assigned letter is $playerLetter\n"
		elif [[ $chooseLetter == "O" || $chooseLetter == "o" ]]
		then
			playerLetter="O"
			computerLetter="X"
			printf "Your assigned letter is $playerLetter\n"
		else
			printf "Please choose X/O\n"
			assignLetterAndToss
		fi
	elif [[ $letterAssign -eq "$CIRCLE" ]]
	then
		nextTurn="false"
		printf "You lost the toss\n"
		playerLetter="O"
		computerLetter="X"
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

# FUNCTION TO CHECK FOR ROW MATCH
function boardRow () {
	for((row=0;row<=8;row=$((row+3)) ))
	do
		rowCheck=${defaultBoard[$row]}${defaultBoard[$((row+1))]}${defaultBoard[$((row+2))]}
		if [[ $rowCheck == $1$1$1 ]]
		then
			rowCell="true"
			break
		else
			rowCell="false"
		fi
	done
	printf "$rowCell\n"
}

# FUNCTION TO CHECK FOR COLUMN MATCH
function boardColumn () {
	for((column=0;column<3;column++))
	do
		columnCheck=${defaultBoard[$column]}${defaultBoard[$((column+3))]}${defaultBoard[$((column+6))]}
		if [[ $columnCheck == $1$1$1 ]]
		then
			columnCell="true"
			break
		else
			columnCell="false"
		fi
	done
	printf "$columnCell\n"
}

# FUNCTION TO CHECK FOR DIAGONAL MATCH
function boardDiagonal () {
	diagonal1=${defaultBoard[0]}${defaultBoard[4]}${defaultBoard[8]}
	diagonal2=${defaultBoard[2]}${defaultBoard[4]}${defaultBoard[6]}
	if [[ $diagonal1 == $1$1$1 || $diagonal2 == $1$1$1 ]]
	then
		diagonalCell="true"
	else
		diagonalCell="false"
	fi
	printf "$diagonalCell\n"
}

# FUNCTION TO CHECK WIN CONDITION
function checkWin()
{
	checkBoardRow=$(boardRow $1)
	checkBoardColumn=$(boardColumn $1)
	checkBoardDiagonal=$(boardDiagonal $1)
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
		fi
		# CONDITION FOR COMPUTER TO PLAY WHEN WON THE TOSS
		if [[ $nextTurn == "false" ]]
		then
			computerPosition=$(($RANDOM%9))
			positionSelect $computerLetter $computerPosition
			nextTurn="true"
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
		playerVsComputer	# CALLING THE FUNCTION
	else
		playerPosition="true"
	fi

	if [[ $playerPosition == "true" ]]
	then
		defaultBoard[$cellPosition]=$letter
		count=$(($count+1))
		displayBoard
		checkWin $letter
		# CHECKING ROW, COLUMN AND DIAGONAL WINS
		if [[ $checkBoardRow == "true" || $checkBoardColumn == "true" || $checkBoardDiagonal == "true" ]]
		then
			playResult="Win"
			exit
		else
			playResult="false"
		fi

		if [[ $playerPosition == "false" ]]
		then
			playResult="draw"
			exit
		else
			playResult="change turn"
		fi
	fi
}

# CALLING THE FUNCTIONS
boardReset
assignLetterAndToss
displayBoard
playerVsComputer
