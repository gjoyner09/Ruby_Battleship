require 'colorize'

def welcome
    puts "Welcome to Ruby Battleship by Grey Joyner!".colorize(:blue)
    puts "-------"
    sleep(2)
    puts "To start, you will place your boats."
    sleep(2)
    puts "You have five boats to place:"
    sleep(2)
    puts " - Carrier (C): 5 spaces long"
    sleep(1.5)
    puts " - Battleship (B): 4 spaces long"
    sleep(1.5)
    puts " - Destroyer (D): 3 spaces long"
    sleep(1.5)
    puts " - Submarine (S): 3 spaces long"
    sleep(1.5)
    puts " - Patrol Boat (B): 2 spaces long"
    sleep(1.5)
    puts "-------"
    sleep(2)
    puts "At present your board is empty (as denoted by the full stops in each space)"
    sleep(2)
end