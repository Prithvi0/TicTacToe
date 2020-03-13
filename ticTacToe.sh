#!/bin/bash -x
printf "Welcome to TicTacToe\n"
# ARRAY DECLARATION
declare -a defaultBoard

# FUNCTION TO RESET THE BOARD
function boardReset () {
	for((element=0;element<=8;element++ ))
	do
		defaultBoard[$element]=" "	# TAKING EVERY CELL AS AN EMPTY SPACE
	done
}

# CONDITION TO ASSIGN A LETTER TO PLAYER
function assignLetter () {
	letterAssign=$((RANDOM%2))
	if [[ $letterAssign -eq 0 ]]
	then
		playerLetter="X"
	else
		playerLetter="O"
	fi
	printf "Your assigned letter is $playerLetter\n"
}

# CONDITION FOR A TOSS TO CHECK WHO PLAYS FIRST
function gameToss () {
toss=$((RANDOM%2))
if [[ $toss -eq 0 ]]
then
	printf "You won the toss. Its your turn\n"
else
	printf "You lost the toss\n"
fi
}

# FUNCTION TO DISPLAY THE BOARD
function displayBoard () {
	for element in {0..8}
	do
		if [[ $((element%3)) -eq 0 && $element -le 3 ]]
		then
			printf "_${defaultBoard[$element]}_|_${defaultBoard[$((element+1))]}_|_${defaultBoard[$((element+2))]}_\n"
		elif [[ $((element%6)) -eq 0 && $element -le 9 ]]
		then
			printf " ${defaultBoard[$element]} | ${defaultBoard[$((element+1))]} | ${defaultBoard[$((element+2))]} \n"
		fi
	done
}
# CALLING THE FUNCTIONS
boardReset
assignLetter
gameToss
displayBoard
