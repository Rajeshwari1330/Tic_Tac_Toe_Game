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
	compValue=x
	echo "player is assigned $playerValue and computer is assigned $compValue"
else
	playerValue=x
	compValue=o
	echo "player is assigned $playerValue and computer is assigned $compValue"
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
echo "COMPUTER IS PLAYING LIKE ME ONLY"
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
        board[$place]=$compValue
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
				echo "you can play the move here you may win if you play correctly"
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
				echo "you can play the move here you may win if you play correctly"
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
	testWin 1 2 3 testWin 2 3 1 testWin 3 1 2 testWin 3 2 1 testWin 2 1 3 testWin 1 3 2
	testWin 4 5 6 testWin 5 6 4 testWin 6 4 5 testWin 6 5 4 testWin 5 4 6 testWin 4 6 5
	testWin 7 8 9 testWin 8 9 7 testWin 9 7 8 testWin 9 8 7 testWin 8 7 9 testWin 7 9 8
	testWin 1 4 7 testWin 4 7 1 testWin 7 1 4 testWin 7 4 1 testWin 4 1 7 testWin 1 7 4
	testWin 2 5 8 testWin 5 8 2 testWin 8 2 5 testWin 8 5 2 testWin 5 2 8 testWin 2 8 5
	testWin 3 6 9 testWin 6 9 3 testWin 9 3 6 testWin 9 6 3 testWin 6 3 9 testWin 3 9 6
	testWin 1 5 9 testWin 5 9 1 testWin 9 1 5 testWin 9 5 1 testWin 5 1 9 testWin 1 9 5
	testWin 3 5 7 testWin 5 7 3 testWin 7 3 5 testWin 7 5 3 testWin 5 3 7 testWin 3 7 5
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

