#!/bin/bash -x
echo "Welcome to TicTacToe"
# ARRAY DECLARATION
declare -a defaultBoard

# START FRESH WITH RESETTING THE BOARD
function boardReset () {
	for((element=0;element<=8;element++ ))
	do
		defaultBoard[$element]=" "
	done
}
boardReset
