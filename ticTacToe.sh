#!/bin/bash -x
echo "Welcome to TicTacToe"
# ARRAY DECLARATION
declare -a defaultBoard

# CONSTANTS
letter1=0
letter2=1

# FUNCTION TO RESET THE BOARD
function boardReset () {
	for((element=0;element<=8;element++ ))
	do
		defaultBoard[$element]=" "
	done
}
boardReset	# CALLING THE FUNCTION

# CONDITION TO ASSIGN A LETTER TO PLAYER
letterAssign=$((RANDOM%2))
if [[ $letterAssign -eq $letter1 ]]
then
	playerLetter="X"
elif [[ $letterAssign -eq $letter2 ]]
then
	playerLetter="O"
fi

