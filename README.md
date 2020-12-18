# Ruby Battleship
## By Grey Joyner
### December 2020

Link to Github repo: https://github.com/gjoyner09/Ruby_Battleship


Program purpose: create the game Battleship in the Terminal. The app will allow the user to play against an AI in the game Battleship. The user will place her/his boats and guess spaces to try to sink the AI's ships. The goal of building the game is to create a fun game that people can play, as well as provide me practice in building a full Ruby terminal app. 

Target audience: anyone aged 5-infinity who enjoys games and wants to have fun

How the user will use the program: the user must have a working computer, Ruby and the Terminal. The user will run the shell bash script to play the game. The user will read the welcome messages and instructions, place her/his boats, then choose heads or tails to choose who will go first. When it is the user's turn, she or he will guess a space and the program will inform her or him about whether it was a hit, a sunk boat or a miss. When it is the computer's turn, the program will inform the user where the computer guessed and if it was a hit. Once the game is over, the program will inform the user.

## Features:

### Intro and help
The game includes 'help' and 'about' functions that inform the user about the game. At the beginning of the game, the game provides some info about how to play.

### Place boats
After the introduction, the user places her or his boats. She first determines whether to place the boat vertically or horizontally. Then she indicates which starting space to place the boat into. The AI's boats are then placed randomly.

### Coin flip
After all boats are placed, the user chooses heads or tails. A coin is randomly flipped. If the user wins, she gets to go first. Otherwise, the AI goes first.

### User turn
When it is the user's turn, the program shows her the state of what she has already guessed. She then guesses a space. The program updates her guessed board and lets her know whether it was a hit, a sunk boat or a miss. 

### Computer turn
When it is the AI's turn, the AI first looks to see if there are any unsunk boats to target. If not, the computer guesses randomly. If so, the computer guesses an adjacent space. The program updates the AI's guessed board and informs the user of the results.

### Game over
After each turn for both the user and computer, the program checks to see if the game is over. If so, the program displays the result of the game and shows the computer's board if the user lost. It then exits the program.

## How the user will interact with the program

The user will find out information about the program from this README or from running the program with the '-h' or '--help' argument.

The user will use the features by either scrolling up and down and pressing enter to select a feature (for the direction and coin flip) or by typing their response (for the spaces). 

There is full error handling built into the program, using various methods. One method is using the tty-prompt gem, which means that the user can only select either the horizontal or vertical directions, or heads or tails for the coin flip. Additionally, there are built-in functions that check that any spaces guessed by the user are both within the board and have not yet been guessed. In some cases when an error may occur in the code, I have used `rescue` to avoid an error being thrown. I have tested the program many times to ensure that potential errors are avoided.

## Flowchart

![Flowchart](Flowchart.jpg)

## Project Management

Link to Trello Board: https://trello.com/b/zp1ZMWqv/ruby-battleship

![Trello](Trello.jpg)

![Card1](TrelloCard1.jpg)

![Card2](TrelloCard2.jpg)