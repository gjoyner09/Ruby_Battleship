require_relative('board.rb')
require 'colorize'

# method for the computer's turn
def computer_turn(u_b, c_g_b, boats, fast, easy)
    # checks to see if they have an unsunk ship
    a = false
    a = unsunk(a, c_g_b, boats)
    # if there's an outstanding unsunk ship, computer tries to sink it
    if a && !easy
        # computer finds where the unsunk ship is
        str = c_g_b.join
        lett = a[:letter]
        space = str.index(lett)
        x = space / 8
        y = space % 8
        # if the computer has only hit the ship once
        if str.count(lett) == 1
            # randomly picks an empty space above, below, to the right or to the left of the hit space
            loop do
                x = space / 8
                y = space % 8
                loop do
                    dir = rand(4)
                    if dir == 0 && x < 7
                        x += 1
                        break
                    elsif dir == 1 && x > 0
                        x -= 1
                        break
                    elsif dir == 2 && y < 7
                        y += 1
                        break
                    elsif dir == 3 && y > 0
                        y -=1
                        break
                    end
                end
                # updates the board and informs the user of the result
                begin
                    if c_g_b[x][y] == "."
                        result(x, y, u_b, c_g_b, boats, fast)
                        break
                    end
                rescue
                end
            end
        # if the computer has hit the ship multiple times
        else
            # if vertical
            if x+1 < 8 && c_g_b[x+1][y] == lett
                loop do
                    # randomly chooses between guessing above or below the previously guessed spaces
                    random = rand(2)
                    begin
                        if random == 0
                            # guesses the space above (if it exists)
                            if c_g_b[x-1][y] == "." && x > 0
                                result(x-1, y, u_b, c_g_b, boats, fast)
                                break
                            end
                        else
                            # guesses the next empty space below the previously guessed spaces (if it exists)
                            if c_g_b[x+2][y] == lett
                                if c_g_b[x+3][y] == lett
                                    if c_g_b[x+4][y] == "."
                                        result(x+4, y, u_b, c_g_b, boats, fast)
                                        break
                                    end
                                else
                                    if c_g_b[x+3][y] == "."
                                        result(x+3, y, u_b, c_g_b, boats, fast)
                                        break
                                    end
                                end
                            else
                                if c_g_b[x+2][y] == "."
                                    result(x+2, y, u_b, c_g_b, boats, fast)
                                    break
                                end
                            end
                        end
                    # avoids errors for checking on spaces that don't exist
                    rescue
                    end
                end
            # if horizontal
            else
                loop do
                    # randomly decides to guess to the left or right of the prevoiusly guessed spaces
                    random = rand(2)
                    begin
                        # guesses to the left of the previously guessed spaces (if such a space exists)
                        if random == 0
                            if c_g_b[x][y-1] == "."
                                result(x, y-1, u_b, c_g_b, boats, fast)
                                break
                            end
                        # guesses to the right of the previously guessed spaces (if such a space exists)
                        else
                            if c_g_b[x][y+2] == lett
                                if c_g_b[x][y+3] == lett
                                    if c_g_b[x][y+4] == "."
                                        result(x, y+4, u_b, c_g_b, boats, fast)
                                        break
                                    end
                                else
                                    if c_g_b[x][y+3] == "."
                                        result(x, y+3, u_b, c_g_b, boats, fast)
                                        break
                                    end
                                end
                            else
                                if c_g_b[x][y+2] == "."
                                    result(x, y+2, u_b, c_g_b, boats, fast)
                                    break
                                end
                            end
                        end
                    # avoids errors for checking on spaces that don't exist
                    rescue
                    end
                end
            end
        end

    # if no outstanding unsunk ships, or if easy mode, then computer makes a random guess
    else
        # loop until the computer randomly chooses a space that hasn't already been guessed
        loop do
            x = rand(8)
            y = rand(8)
            if c_g_b[x][y] == "."
                result(x, y, u_b, c_g_b, boats, fast)
                break
            end
        end
    end
    # informs the user of the computer's current guessed board
    sleep(1) if !fast
    puts "Here is the computer's guessed board:"
    sleep(2) if !fast
    puts
    print_board_outside_class(c_g_b)
    puts
end

# checks to see if there are any boats that the computer has hit but not yet sunk
def unsunk(a, c_g_b, boats)
    str = c_g_b.join
    boats.each do |x| 
        if str.count(x[:letter]) > 0 && str.count(x[:letter]) < x[:length]
            a = x
        end
    end
    return a
end

# updates the computer's guessed board and informs the user of the result
def result(a, b, u_b, c_g_b, boats, fast)
    lett = u_b[a][b]
    # changes the computer's guessed board
    lett == "." ? c_g_b[a][b] = "x" : c_g_b[a][b] = lett
    sleep(2) if !fast
    puts "The computer guessed #{Board.rowcol_to_space([a,b])}."
    if lett == "."
        sleep(1) if !fast
        puts "The computer's guess was a miss."
    else
        sleep(1) if !fast
        puts "The computer's guess was a hit!"
        boat_arr = boats.select { |x| x[:letter] == lett }
        boat = boat_arr[0]
        sleep(1) if !fast
        puts "The computer hit your #{boat[:name]}."
        str = c_g_b.join
        if str.count(lett) == boat[:length]
            sleep(0.5) if !fast
            puts "The computer has now sunk your #{boat[:name]}."
        end
    end
end