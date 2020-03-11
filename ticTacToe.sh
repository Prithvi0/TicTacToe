#!/bin/bash -x
echo "Welcome to TicTacToe"
# ARRAY DECLARATION
declare -a defaultBoard

# CONSTANTS
letter1=0
letter2=1
player=0
computer=1

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

# CONDITION FOR A TOSS TO CHECK WHO PLAYS FIRST
toss=$((RANDOM%2))
if [[ $toss -eq $player ]]
then
	tossWon="player"
elif [[ $toss -eq $computer ]]
then
	tossWon="computer"
fi

# FUNCTION TO DISPLAY THE BOARD
function board () {
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
board
