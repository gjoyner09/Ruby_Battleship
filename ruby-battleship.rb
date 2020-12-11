require_relative('board.rb')
require_relative('welcome.rb')
require_relative('user-turn.rb')
require_relative('computer-turn.rb')
require_relative('game-over.rb')

system("clear")

welcome
puts "Here is your board:"
sleep(1.5)
user_board = Board.new
puts
user_board.print_board
puts
sleep(2)
user_board.place_boat_instructions(user_board.carrier)
sleep(2)
user_board.place_boat_instructions(user_board.battleship)
sleep(2)
user_board.place_boat_instructions(user_board.destroyer)
sleep(2)
user_board.place_boat_instructions(user_board.submarine)
sleep(2)
user_board.place_boat_instructions(user_board.patrol_boat)

comp_board = Board.new
comp_board.place_boat_comp(comp_board.carrier)
comp_board.place_boat_comp(comp_board.battleship)
comp_board.place_boat_comp(comp_board.destroyer)
comp_board.place_boat_comp(comp_board.submarine)
comp_board.place_boat_comp(comp_board.patrol_boat)

user_guess_board = Board.new
comp_guess_board = Board.new

sleep(1)
puts "Now to decide who goes first, we will flip a coin. Please type 'heads' or 'tails':"
coin = gets.chomp.downcase
while coin != "heads" && coin != "tails"
    sleep(0.5)
    puts "Invalid input. Please type 'heads' or 'tails'."
    coin = gets.chomp.downcase
end
result = rand(2)
result == 0 ? result = "heads" : result = "tails"
sleep(1)
puts result == coin ? "It was #{coin}! You get to go first." : "It was #{result}. The computer will go first."
puts

if result != coin
    computer_turn(user_board.board, comp_guess_board.board, comp_board.boats)
end

over = false
while !over
    sleep(2)
    puts "It's now your turn."
    puts
    sleep(2)
    user_turn(comp_board.board, user_guess_board.board, user_board.boats)
    over = done(user_guess_board.board)
    if over
        sleep(1)
        puts "You won! Congratulations!"
        sleep(2)
        break
    end
    puts
    puts "It is the computer's turn."
    sleep(1)
    computer_turn(user_board.board, comp_guess_board.board, comp_board.boats)
    over = done(comp_guess_board.board)
    if over
        sleep(1)
        puts "You lost. Better luck next time!"
        sleep(2)
    end
end

