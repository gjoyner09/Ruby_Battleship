require "tty-prompt"

class Board

    attr_accessor :board, :carrier, :battleship, :destroyer, :submarine, :patrol_boat, :boats

    # Sets up a blank board
    def initialize
        @board = []
        8.times {@board.push([".", ".", ".", ".", ".", ".", ".", "."])}
        @carrier = {length: 5, letter: "C", name: "Carrier"}
        @battleship = {length: 4, letter: "B", name: "Battleship"}
        @destroyer = {length: 3, letter: "D", name: "Destroyer"}
        @submarine = {length: 3, letter: "S", name: "Submarine"}
        @patrol_boat = {length: 2, letter: "P", name: "Patrol Boat"}
        @boats = [@carrier, @battleship, @destroyer, @submarine, @patrol_boat]
    end

    # Turns a space (e.g. 'C3') into an array of [row,column] (e.g. [2,2])
    def self.space_to_row_col(space)
        return false if space.length != 2
        rowcol = []
        if space[1].to_i >= 1 && space[1].to_i <= 8
            rowcol.push(space[1].to_i - 1)
        else
            return false
        end
        if space[0].downcase == 'a' || 
            space[0].downcase == 'b' || 
            space[0].downcase == 'c' || 
            space[0].downcase == 'd' || 
            space[0].downcase == 'e' || 
            space[0].downcase == 'f' || 
            space[0].downcase == 'g' || 
            space[0].downcase == 'h'
                rowcol.push(space[0].downcase.ord - 97)
        else
            return false
        end
        return rowcol
    end

    # turns an array of [row, column] (e.g. [2,2]) into a space (e.g. 'C3')
    def self.rowcol_to_space(rowcol)
        space = (rowcol[1]+97).chr('UTF-8').upcase
        space << (rowcol[0]+1).to_s
        return space
    end

    # Determines if a desired boat placement is valid (makes sure it doesn't go off the board or run into another boat)
    def valid?(length, row, column, direction)
        begin
            for i in 1..length
                if @board[row][column] != "."
                    return false
                else
                    direction == "Horizontal" ? column += 1 : row += 1
                end
            end
        rescue
            return false
        end
        return true
    end

    # places the boat on the board based on user's direction and space inputs
    def place_boat_instructions(boat, fast)
        # asks user for input
        puts "Let's place your #{boat[:name]} (#{boat[:length]} spaces long)."
        sleep(1) if !fast
        prompt = TTY::Prompt.new
        direction = prompt.select("Choose the direction for the boat:", %w(Horizontal Vertical))
        puts "Direction: #{direction}"
        sleep(0.2) if !fast
        puts "Thank you. Now please enter the board space for the start of the boat (e.g. B3):"
        space = gets.chomp
        rowcol = Board.space_to_row_col(space)
        # checks validity of format (e.g. 'A2')
        loop do
            if rowcol
                break
            else
                sleep(0.2) if !fast
                puts "That input is invalid. Please enter the space in the format 'b4', for example:"
                space = gets.chomp
                rowcol = Board.space_to_row_col(space)
            end
        end
        # checks that there are no overlapping boats and that the boat doesn't run off the page
        validity = valid?(boat[:length], rowcol[0], rowcol[1], direction)
        loop do
            if validity
                break
            else
                sleep(0.2) if !fast
                puts "That is an invalid space to put your boat. It either goes off the page or runs into another boat."
                sleep(1) if !fast
                puts "Please enter a new starting space for your boat:"
                space = gets.chomp
                rowcol = Board.space_to_row_col(space)
                begin
                    validity = valid?(boat[:length], rowcol[0], rowcol[1], direction)
                rescue
                    validity = false
                end
            end
        end
        # adds the boat to the board and shows the board to the user
        add_boat(boat, rowcol[0], rowcol[1], direction)
        puts "Thanks. Here is your board currently:"
        sleep(1) if !fast
        puts
        print_board
        puts
    end

    # places the computer's boat on the board (used within the place_boat_instructions method)
    def place_boat_comp(boat)
        row = rand(8)
        column = rand(8)
        direction = rand(2)
        direction == 0 ? direction = "Horizontal" : direction = "Vertical"
        loop do
            test = valid?(boat[:length], row, column, direction)
            if test
                break
            else
                row = rand(8)
                column = rand(8)
                direction = rand(2)
            end
        end
        add_boat(boat, row, column, direction)
    end

    # Adds the user's boat to the board
    def add_boat(boat, row, column, direction)
        for i in 1..boat[:length]
            @board[row][column] = boat[:letter]
            direction == "Horizontal" ? column += 1 : row += 1
        end
    end

    # Prints the board
    def print_board
        puts "    A B C D E F G H"
        puts "    _ _ _ _ _ _ _ _"
        for i in 1..8
            puts "#{i} | #{@board[i-1].join(" ")}"
        end
    end
end