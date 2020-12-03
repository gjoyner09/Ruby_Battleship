require_relative('./board.rb')

puts "Welcome to Ruby Battleship by Grey Joyner!"
puts "-------"
# sleep(2)
puts "To read the rules of Battleship, please visit https://www.hasbro.com/common/instruct/Battleship.PDF"
puts "-------"
# sleep(2)
puts "To start, you will place your boats."
# sleep(2)
puts "You have five boats to place:"
# sleep(2)
puts " - Carrier (C): 5 spaces long"
# sleep(1.5)
puts " - Battleship (B): 4 spaces long"
# sleep(1.5)
puts " - Destroyer (D): 3 spaces long"
# sleep(1.5)
puts " - Submarine (S): 3 spaces long"
# sleep(1.5)
puts " - Patrol Boat (B): 2 spaces long"
# sleep(1.5)
puts "-------"
# sleep(2)
puts "At present your board is empty (as denoted by the full stops in each space)"
# sleep(2)
puts "Here is your board:"
# sleep(2)
puts
user_board = Board.new
user_board.print_board
puts
user_board.place_boat_instructions(user_board.carrier)
user_board.place_boat_instructions(user_board.battleship)
user_board.place_boat_instructions(user_board.destroyer)
user_board.place_boat_instructions(user_board.submarine)
user_board.place_boat_instructions(user_board.patrol_boat)
