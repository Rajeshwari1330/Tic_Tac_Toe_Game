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
createBoard
