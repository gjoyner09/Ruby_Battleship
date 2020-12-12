def print_board_outside_class(board)
    puts "    A B C D E F G H"
    puts "    _ _ _ _ _ _ _ _"
    for i in 1..8
        puts "#{i} | #{board[i-1].join(" ")}"
    end
end