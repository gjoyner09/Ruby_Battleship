require_relative('board.rb')
require_relative('welcome.rb')
require_relative('user-turn.rb')
require_relative('computer-turn.rb')
require_relative('game-over.rb')

welcome
puts "Here is your board:"
puts
user_board = Board.new
user_board.print_board
puts
user_board.place_boat_instructions(user_board.carrier)
user_board.place_boat_instructions(user_board.battleship)
user_board.place_boat_instructions(user_board.destroyer)
user_board.place_boat_instructions(user_board.submarine)
user_board.place_boat_instructions(user_board.patrol_boat)

comp_board = Board.new
comp_board.place_boat_comp(comp_board.carrier)
comp_board.place_boat_comp(comp_board.battleship)
comp_board.place_boat_comp(comp_board.destroyer)
comp_board.place_boat_comp(comp_board.submarine)
comp_board.place_boat_comp(comp_board.patrol_boat)

user_guess_board = Board.new
comp_guess_board = Board.new

puts "Now to decide who goes first, we will flip a coin. Please type 'heads' or 'tails'."
coin = gets.chomp.downcase
while coin != "heads" && coin != "tails"
    puts "Invalid input. Please type 'heads' or 'tails'."
    coin = gets.chomp.downcase
end
result = rand(2)
result == 0 ? result = "heads" : result = "tails"
puts result == coin ? "It was #{coin}! You get to go first." : "It was #{result}. The computer will go first."

if result != coin
    computer_turn(user_board.board, comp_guess_board.board, comp_board.boats)
end

over = false
while !over
    user_turn(comp_board.board, user_guess_board.board, user_board.boats)
    # over = done(user_guess_board.board)
    # break if over
    computer_turn(user_board.board, comp_guess_board.board, comp_board.boats)
    # over = done(comp_guess_board.board)
end

