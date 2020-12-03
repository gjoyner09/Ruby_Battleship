class Board

    attr_accessor :board, :carrier, :battleship, :destroyer, :submarine, :patrol_boat

    # Sets up a blank board
    def initialize
        @board = []
        8.times {@board.push([".", ".", ".", ".", ".", ".", ".", "."])}
        @carrier = {length: 5, letter: "C", name: "carrier"}
        @battleship = {length: 4, letter: "B", name: "battleship"}
        @destroyer = {length: 3, letter: "D", name: "destroyer"}
        @submarine = {length: 3, letter: "S", name: "submarine"}
        @patrol_boat = {length: 2, letter: "P", name: "patrol boat"}
    end

    def space_to_row_col(space)
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

    # Determines if a desired boat placement is valid
    def valid?(length, row, column, direction)
        begin
            for i in 1..length
                if @board[row][column] != "."
                    return false
                else
                    direction == "horizontal" ? column += 1 : row += 1
                end
            end
        rescue
            return false
        end
        return true
    end

    def place_boat_instructions(boat)
        puts "Let's place your #{boat[:name]} (#{boat[:length]} spaces long)."
        puts "Please state whether you want the #{boat[:name]} to be placed in a horizontal or vertical fashion:"
        direction = gets.chomp.downcase
        loop do
            if direction == "horizontal" || direction == "vertical"
                break
            else
                puts "That input is invalid. Please enter either 'horizontal' or 'vertical':"
                direction = gets.chomp.downcase
            end
        end
        puts "Thank you. Now please enter the board space for the start of the boat (e.g. B3):"
        space = gets.chomp
        rowcol = space_to_row_col(space)
        loop do
            if rowcol
                break
            else
                puts "That input is invalid. Please enter the space in the format 'b4', for example:"
                space = gets.chomp
                rowcol = space_to_row_col(space)
            end
        end
        validity = valid?(boat[:length], rowcol[0], rowcol[1], direction)
        loop do
            if validity
                break
            else
                puts "That is an invalid space to put your boat. It either goes off the page or runs into another boat."
                puts "Please enter a new starting space for your boat:"
                space = gets.chomp
                rowcol = space_to_row_col(space)
                validity = valid?(boat[:length], rowcol[0], rowcol[1], direction)
            end
        end
        add_boat(boat, rowcol[0], rowcol[1], direction)
        puts "Thanks. Here is your board currently:"
        puts
        print_board
        puts
    end

    # Adds a boat to the board
    def add_boat(boat, row, column, direction)
        for i in 1..boat[:length]
            @board[row][column] = boat[:letter]
            direction == "horizontal" ? column += 1 : row += 1
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