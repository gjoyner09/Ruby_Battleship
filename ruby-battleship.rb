require_relative('board.rb')
require_relative('welcome.rb')
require_relative('user-turn.rb')

welcome
puts "Here is your board:"
puts
$user_board = Board.new
$user_board.print_board
puts
$user_board.place_boat_instructions($user_board.carrier)
$user_board.place_boat_instructions($user_board.battleship)
$user_board.place_boat_instructions($user_board.destroyer)
$user_board.place_boat_instructions($user_board.submarine)
$user_board.place_boat_instructions($user_board.patrol_boat)

$comp_board = Board.new
$comp_board.place_boat_comp($comp_board.carrier)
$comp_board.place_boat_comp($comp_board.battleship)
$comp_board.place_boat_comp($comp_board.destroyer)
$comp_board.place_boat_comp($comp_board.submarine)
$comp_board.place_boat_comp($comp_board.patrol_boat)

$user_guess_board = Board.new
$comp_guess_board = Board.new

user_turn
user_turn
user_turn