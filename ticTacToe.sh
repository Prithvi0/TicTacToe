#!/bin/bash -x
printf "Welcome to TicTacToe\n"
# ARRAY DECLARATION
declare -a defaultBoard

# CONSTANTS
CROSS=0
CIRCLE=1

# FUNCTION TO RESET THE BOARD
function boardReset () {
	for((element=0;element<=8;element++))
	do
		defaultBoard[$element]=" "	# TAKING EVERY CELL AS AN EMPTY SPACE
	done
}

# CONDITION TO ASSIGN A LETTER TO PLAYER AND CHECK WHO PLAYS FIRST
function assignLetterAndToss () {
	letterAssign=$((RANDOM%2))
	if [[ $letterAssign -eq "$CROSS" ]]
	then
		printf "You won the toss. Its your turn\n"
		playerLetter="X"
		playerToss="win"
	elif [[ $letterAssign -eq "$CIRCLE" ]]
	then
		printf "You lost the toss\n"
		playerLetter="O"
		playerToss="lose"
	fi
	printf "Your assigned letter is $playerLetter\n"
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
		if [[ ${defaultBoard[$row]}${defaultBoard[$((row+1))]}${defaultBoard[$((row+2))]} == $1$1$1 ]]
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
		if [[ ${defaultBoard[$column]}${defaultBoard[$((column+3))]}${defaultBoard[$((column+6))]} == $1$1$1 ]]
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
		if [[ ${defaultBoard[0]}${defaultBoard[4]}${defaultBoard[8]} == $1$1$1 || ${defaultBoard[2]}${defaultBoard[4]}${defaultBoard[6]} == $1$1$1 ]]
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

function positionSelect () {
	local playerPosition="false"
	local count=0
	while [[ $count -le 8 ]]
	do
		read -p "Enter cell position Number: " cellPosition
		if [[ ${defaultBoard[$cellPosition]} == "X" || ${defaultBoard[$cellPosition]} == "O" ]]
		then
			printf "Enter another position\n"
			count=$(($count-1))
		else
			playerPosition="true"
		fi

		if [[ $playerPosition -eq "true" ]]
		then
			defaultBoard[$cellPosition]=$playerLetter
			count=$(($count+1))
			displayBoard
			checkWin $playerLetter
			if [[ $checkBoardRow == "true" || $checkBoardColumn == "true" || $checkBoardDiagonal == "true" ]]
			then
				playResult="You Win"
				break
			else
				playResult="false"
			fi

			if [[ $playerPosition == "false" ]]
			then
				playResult="draw"
			else
				playResult="change turn"
			fi
		fi
	done
}

# CALLING THE FUNCTIONS
boardReset
assignLetterAndToss
displayBoard
positionSelect
