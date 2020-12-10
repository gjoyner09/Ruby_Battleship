require_relative('board.rb')

def computer_turn(u_b, c_g_b, boats)
    puts 1
    # checks to see if they have an unsunk ship
    a = false
    unsunk(a, c_g_b, boats)

    puts 2
    puts a
    # if there's an outstanding unsunk ship, computer tries to sink it
    if a
        puts 3
        str = c_g_b.join
        space = (str =~ /bar/)
        a = space / 8
        b = space % 8
        if str.count(unsunk[:letter]) == 1
            puts 4
            loop do
                dir = rand(4)
                case dir
                    when 0 then a += 1
                    when 1 then a -= 1
                    when 2 then b += 1
                    when 3 then b -= 1
                end
                begin
                    if c_g_b[a][b] == "."
                        result(a,b, u_b, c_g_b, boats)
                        break
                    end
                rescue
                end
            end
        else
            puts 5
            lett = $u_b[a][b]
            if c_g_b[a+1][b] == lett
                loop do
                    random = rand(2)
                    begin
                        if random == 0
                            if c_g_b[a-1][b] != "."
                                result(a-1, b, u_b, c_g_b, boats)
                                break
                            end
                        else
                            if c_g_b[a+2][b] == lett
                                if c_g_b[a+3][b] == lett
                                    result(a+4, b, u_b, c_g_b, boats)
                                    break
                                else
                                    result(a+3, b, u_b, c_g_b, boats)
                                    break
                                end
                            else
                                result(a+2, b, u_b, c_g_b, boats)
                                break
                            end
                        end
                    rescue
                    end
                end
            else
                puts 6
                loop do
                    random = rand(2)
                    begin
                        if random == 0
                            if c_g_b[a][b-1] != "."
                                result(a-1, b, u_b, c_g_b, boats)
                                break
                            end
                        else
                            if c_g_b[a][b+2] == lett
                                if c_g_b[a][b+3] == lett
                                    result(a, b+4, u_b, c_g_b, boats)
                                    break
                                else
                                    result(a, b+3, u_b, c_g_b, boats)
                                    break
                                end
                            else
                                result(a, b+2, u_b, c_g_b, boats)
                                break
                            end
                        end
                    rescue
                    end
                end
            end
        end

    # if no outstanding unsunk ships, then computer makes a random guess
    else
        puts 7
        loop do
            a = rand(8)
            b = rand(8)
            if c_g_b[a][b] == "."
                result(a, b, u_b, c_g_b, boats)
                break
            end
        end
    end
end

def unsunk(a, c_g_b, boats)
    str = c_g_b.join
    boats.each do |x| 
        if str.count(x[:letter]) > 0 && str.count(x[:letter]) < x[:length]
            a = x
        end
    end
    return a
end

def result(a, b, u_b, c_g_b, boats)
    lett = u_b[a][b]
    c_g_b[a][b] = lett
    puts "The computer guessed #{Board.rowcol_to_space([a,b])}."
    if lett == "."
        puts "The computer's guess was a miss."
    else
        puts "The computer's guess was a hit!"
        boat = boats.select { |x| x[:letter] == lett }
        puts "The computer hit your #{boat[:name]}."
        str = c_g_b.join
        if str.count(lett) == boat[:length]
            puts "The computer has now sunk your #{boat[:name]}."
        end
    end
end