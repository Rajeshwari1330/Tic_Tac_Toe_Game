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
	playerValue=o
	computerValue=x
	echo "player is assigned $playerValue and computer is assigned $computerValue"
else
	playerValue=x
	computerValue=o
	echo "player is assigned $playerValue and computer is assigned $computerValue"
fi
}

function toss()
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
toss

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

winPlayer=0
winComputer=0
function testWin()
{
	if(($toss==0 || $toss==1))
        then

                if [[ ${board[$1]} == o ]]
                then
			if [[ ${board[$2]} == o ]]
			then
				if [[ ${board[$3]} == o ]]
				then
                        		winPlayer=1
					winComputer=1
				fi
			fi
		elif [[ ${board[$1]} == x ]]
		then
			if [[ ${board[$3]} == x ]]
			then
				if [[ ${board[$2]} == x ]]
				then
					winComputer=1
					winPlayer=1
				fi
			fi
		fi
	fi
}

function checkWin()
{
	testWin 1 2 3
	testWin 4 5 6
	testWin 7 8 9
	testWin 1 4 7
	testWin 2 5 8
	testWin 3 6 9
	testWin 1 5 9
	testWin 3 5 7
}

if(($toss==0))
then
	while(($leftPlayer != 1))
	do
		playerPlay
		checkWin
		if(($winPlayer==1))
		then
			echo "--------------player is winner-------------------"
			exit
		fi
		if(($leftComputer!=2))
		then
			computerPlay
			sleep 1
			checkWin
	                if(($winComputer==1))
        	        then
        	                echo "--------------------computer is winner-------------------"
                	        exit
                	fi

		fi
	done
	echo "game is tie !! no one is winner"
	echo "game is exiting"
	exit
else
	while(($leftComputer != 1))
	do
		computerPlay
		sleep 1
			checkWin
			if(($winComputer==1))
                        then
                                echo "---------------------------computer is winner----------------------------"
                                exit
                        fi
		if(($leftPlayer!=2))
		then
			playerPlay
			checkWin
			if(($winPlayer==1))
                        then
                                echo "-------------------------------player is winner------------------------------"
                                exit
                        fi
		fi
	done
	echo "game is tie !! no one is winner"
	echo "game is exiting"
	exit
fi

