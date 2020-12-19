require_relative('board.rb')
require_relative('welcome.rb')
require_relative('user_turn.rb')
require_relative('computer_turn.rb')
require_relative('game_over.rb')
require 'colorize'
require 'artii'
require 'tty-prompt'
require 'tty-link'

# clears the terminal screen and sets the defaults to normal difficulty and normal speed
system("clear")
easy = false
fast = false

# prints help messages if the user includes '-h' or '--help' in the arguments
if ARGV[0] == "-h" || ARGV[0] == "--help"
    puts "HELP FOR RUBY BATTLESHIP:"
    puts "- To read the rules of Battleship, please visit the following link:"
    puts TTY::Link.link_to("- OFFICIAL HASBRO BATTLESHIP RULES", "https://www.hasbro.com/common/instruct/Battleship.PDF") 
    puts "- You will start by placing your boats. Empty spaces on your board are represented by a full stop."
    puts "- You will first indicate whether your boat will be places horizontally or vertically by typing 'h' or 'v'."
    puts "- Then you will indicate the space for your boat to start in by typing the space, e.g. 'C3'."
    puts "- Once you have placed all boats, you will type 'heads' or 'tails' to determine who goes first."
    puts "- When it is your turn, you will type the space you want to guess, e.g. 'C3'."
    puts "- The program will tell you whether you hit one of the computer's boats or whether you missed."
    puts "- The program will show you the state of the board that you've guessed, with 'x' representing a miss, a letter representing a boat you've hit and a full stop representing a space you have not yet guessed."
    puts "- When either you or the computer has sunk every boat, the program will tell you who won."
    exit
# prints about messages if the user includes the argument 'about'
elsif ARGV[0] == "about"
    puts "This is Ruby Battleship!"
    puts "It was created by Grey Joyner in 2020."
    puts "Its purpose is to create a terminal app to play the game battleship."
    exit
# makes the difficulty 'easy' if the user includes the argument 'easy' (computer guesses at random)
elsif ARGV[0] == "easy" || ARGV[1] == "easy"
    easy = true
# makes the speed 'fast' if the user includes the argument 'fast' (ignores all the sleep methods)
elsif ARGV[0] == "fast" || ARGV[1] == "fast"
    fast = true
elsif ARGV[0]
    puts "Invalid argument. For help, type '-h' or '--help'. For easy mode, type 'easy'."
    exit
end

ARGV.clear

# prints welcome messages and instructions, initialises the user's board and gets user to place her/his boats
welcome(fast)
puts "Here is your board:"
sleep(1.5) if !fast
user_board = Board.new
puts
user_board.print_board
puts
sleep(2) if !fast
user_board.place_boat_instructions(user_board.carrier, fast)
sleep(2) if !fast
user_board.place_boat_instructions(user_board.battleship, fast)
sleep(2) if !fast
user_board.place_boat_instructions(user_board.destroyer, fast)
sleep(2) if !fast
user_board.place_boat_instructions(user_board.submarine, fast)
sleep(2) if !fast
user_board.place_boat_instructions(user_board.patrol_boat, fast)

# initialises the computer's board and randomly places the computer's boats
comp_board = Board.new
comp_board.place_boat_comp(comp_board.carrier)
comp_board.place_boat_comp(comp_board.battleship)
comp_board.place_boat_comp(comp_board.destroyer)
comp_board.place_boat_comp(comp_board.submarine)
comp_board.place_boat_comp(comp_board.patrol_boat)

# initialises the guessed boards for the user and computer (blank to start)
user_guess_board = Board.new
comp_guess_board = Board.new

# flips a coin to see who goes first
sleep(1) if !fast
prompt = prompt = TTY::Prompt.new
coin = prompt.select("Now to decide who goes first, we will flip a coin. Please choose 'heads' or 'tails':", %w(heads tails))
result = rand(2)
result == 0 ? result = "heads" : result = "tails"
sleep(1) if !fast
puts result == coin ? "It was #{coin}! You get to go first." : "It was #{result}. The computer will go first."
puts

# if user loses the coin toss, the computer goes first
if result != coin
    computer_turn(user_board.board, comp_guess_board.board, comp_board.boats, fast, easy)
end

# alternates between user turn and computer turn until the game is over
over = false
while !over
    sleep(2) if !fast
    puts "It's now your turn."
    puts
    sleep(2) if !fast
    user_turn(comp_board.board, user_guess_board.board, user_board.boats, fast)
    over = done(user_guess_board.board)
    if over
        sleep(1) if !fast
        puts
        puts "You won! Congratulations!"
        a = Artii::Base.new :font => 'slant'
        puts a.asciify('WIN!')
        sleep(2) if !fast
        break
    end
    puts
    puts "It is the computer's turn."
    sleep(1) if !fast
    computer_turn(user_board.board, comp_guess_board.board, comp_board.boats, fast, easy)
    over = done(comp_guess_board.board)
    if over
        sleep(1) if !fast
        puts "You lost. Better luck next time!"
        sleep(1) if !fast
        puts
        puts "Here is the computer's board:"
        sleep(1) if !fast
        puts
        comp_board.print_board
        puts
        a = Artii::Base.new :font => 'slant'
        puts a.asciify('LOSE!')
        sleep(2) if !fast
    end
end

