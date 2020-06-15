#!/bin/bash -x
tput clear
echo "Welcome to the TIC TAC TOE GAME SIMULATOR"

function createBoardReset()
{
        board=( " " 1 2 3 4 5 6 7 8 9 )
        echo "Game is Starting now........."
}

function createBoard()
{
        echo "${board[1]} | ${board[2]} | ${board[3]}"
        echo "-----------"
        echo "${board[4]} | ${board[5]} | ${board[6]}"
        echo "-----------"
        echo "${board[7]} | ${board[8]} | ${board[9]}"
       
}

function assignValue()
{
value=$((RANDOM%2))
if(($value==0))
then
	playerValue=0
	computerValue=x
	echo "player is assigned $playerValue and computer is assigned $computerValue"
else
	playerValue=x
	computerValue=0
	echo "player is assigned $playerValue and computer is assigned $computerValue"
fi
}

function tossVal()
{
toss=$((RANDOM%2))
if(($toss==0))
then
	echo "player will play first"
else
	echo "computer will play first"
fi
}

createBoard
createBoardReset
echo "Setting up the board and creating"
sleep 1
createBoard
sleep 1
assignValue
sleep 1
tossVal
echo "player and computer both can think that where they will place the value"

function repeatPlayerComputer()
{
	for value in ${filled[@]}
	do
		if(($value==$place))
		then
			playerCheck=0
			computerCheck=0
			break
		else
			playerCheck=1
			computerCheck=1
		fi
	done
}

leftPlayer=6
function playerPlay()
{
	filled+=( 0 )
	playerCheck=0
	echo "-----------------------------------------------"
	echo "enter the place where you want to put you value"
	echo "choose from left outs ---------->> ${board[@]}"
	read place
	repeatPlayerComputer
	while(($playerCheck==0))
	do
		repeatPlayerComputer
		echo "enter new value where you wnat to put out of ${board[@]}"
		read place
		repeatPlayerComputer
		continue

		echo "good to move on"
	done
	echo "player choosed $place"
	unset -v 'board[$place]'
	board[$place]=$playerValue
	filled+=( $place )
	createBoard
	let "leftPlayer=leftPlayer-1"
	echo "-----------------------------------------------------------------"
}

leftComputer=6
function computerPlay()
{
	filled+=( 0 )
	computerCheck=0
	echo "------------------------------------------------------------------"
	echo "computer is choosing the place"
	echo "choosing from the left outs ------------>> ${board[@]}"
	place=$((RANDOM%9 + 1))
	echo "computer choosed this before checking for repetition $place"
	repeatPlayerComputer
	while(($computerCheck==0))
	do
                repeatPlayerComputer
                echo "COMPUTER is entering new value where you want to put out of ${board[@]}"
                place=$((RANDOM%9 + 1))
                repeatPlayerComputer
		continue

		echo "good to move on"
        done
	echo "computer choosed $place"
	unset -v 'board[$place]'
        board[$place]=$computerValue
	filled+=( $place )
	createBoard
	let "leftComputer=leftComputer-1"
	echo "---------------------------------------------------------------------------------"
}

if(($toss==0))
then
	while(($leftPlayer != 1))
	do
		playerPlay
		if(($leftComputer!=2))
		then
			computerPlay
		sleep 1
		fi
	done
	echo "game is exiting"
	exit
else
	while(($leftComputer != 1))
	do
		computerPlay
		sleep 1
		if(($leftPlayer!=2))
		then
			playerPlay
		fi
	done
	echo "game is exiting"
	exit
fi

