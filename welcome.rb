require 'colorize'
require 'artii'

# prints welcome messages and initial instructions
def welcome(fast)
    a = Artii::Base.new :font => 'slant'
    puts a.asciify('BATTLESHIP!')
    sleep(1) if !fast
    puts "Welcome to Ruby Battleship by Grey Joyner!"
    puts "-------"
    sleep(2) if !fast
    puts "To start, you will place your boats."
    sleep(2) if !fast
    puts "You have five boats to place:"
    sleep(2) if !fast
    puts " - Carrier (C): 5 spaces long"
    sleep(1.5) if !fast
    puts " - Battleship (B): 4 spaces long"
    sleep(1.5) if !fast
    puts " - Destroyer (D): 3 spaces long"
    sleep(1.5) if !fast
    puts " - Submarine (S): 3 spaces long"
    sleep(1.5) if !fast
    puts " - Patrol Boat (B): 2 spaces long"
    sleep(1.5) if !fast
    puts "-------"
    sleep(2) if !fast
    puts "At present your board is empty (as denoted by the full stops in each space)"
    sleep(2) if !fast
end