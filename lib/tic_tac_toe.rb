class TicTacToe
    attr_accessor :winning_player, :board

    def initialize(board=nil) #set up @board instance variable, at the start of each game/instance, it sets the state of the board
        @board = board || Array.new(9, " ") #state of board is array with 9 elements " " represents an empty cell on the board
        @winning_player = nil
    end

    WIN_COMBINATIONS = [ #class constant is nested array of all the combinations you can win with
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,4,8],
        [2,4,6],
        [0,3,6],
        [1,4,7],
        [2,5,8]
    ]

    def display_board #define method prints current board representation based on @board instance variable
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input_string) #user inputs a number 1-9. method corresponds that number with the board spaces 0-8.
        user_input_string.to_i - 1
    end

    def move(index_number_that_user_chooses, players_token = "X") #players token "X" or "O" defaults to "X"
        @board[index_number_that_user_chooses] = players_token
    end

    def position_taken?(index) #method to evaluate users desired move against the board, check to see if the position is occupied. 
        #it will check index values and run after #input_to_index. 
        #when passed an index value for a desired move, check to see if that position on the @board is vacant, or has "X" or "O"
        #if position is free method returns false position is not taken. otherwise return true, position is taken. 
        if ((@board[index] == "X") || (@board[index] == "O")) 
            return true
        else 
            return false#if board index equals X or equals O then true and the position is taken. 
        end
    end

    def valid_move?(index) #method takes position and checks if it is a valid move. 
        #return true if valid, false or nil if not. 
        # valid if 1. present on game board aka spot 0-8 and 2. not already filled with "X" or "O"
        if index.between?(0,8) && !position_taken?(index)
            return true
        end
    end

    def turn_count #return # of turns that have been played based on @board variable
        turn_number_counter = 0
        @board.each do |board_cell| 
            if (board_cell == "X") || (board_cell ==  "O")
                turn_number_counter += 1
            end
        end
        turn_number_counter
    end

    def turn #encapsulate the logic of a single complete turn:
        puts "Please enter 1-9:" # 1. ask the user for their move by specifying a position 1-9
        user_input = gets.chomp # 2. receive users input
        index = input_to_index(user_input) # 3. translate that input into an index value
        token = current_player
        if valid_move?(index) # 4. if move is valid, make the move and display the board
            move(index, token) 
            display_board   
        else 
            turn # 5. if move is invalid, ask for a new move until a valid move is received
        end
    end
   
    def current_player # use turn_count method to determind if it is "X" or "O"s turn
        if turn_count % 2 == 0 
            "X" 
        else 
            "O"
        end
    end

    def won? # return false/nil if there is no win combo present 
            # or return the winning combination indexes as an array if there is a win. (use WIN_COMBINATIONS)
        x_index = []
        o_index = []
        winner = false
        winner_x= []
        winner_y= []

        @board.each_with_index do |value, index|
            if value == "X"
                x_index << index
            elsif value == "O"
                o_index << index
            end
        end
        
        WIN_COMBINATIONS.each do |winning_array|
            if (winning_array - x_index).empty?
                winner = winning_array
                @winning_player = "X"
            elsif(winning_array - o_index).empty?
                winner = winning_array
                @winning_player = "O"
            end
        end
        return winner
    end

    def full? # return true if every element on board contains X or O
        @board.all? { |board_cell| board_cell == "X" || board_cell ==  "O" }
    end

    def draw? # board is full
        !won? && full?
    end

    def over? # return true if the board has been won or is a draw
        if won? || draw? || full?
            return true
        else !won? || !draw? || !full? && turn_count <= 8
            return false
        end
    end

    def winner # given a winning @board, return X or O has won the game
       won?
        return @winning_player
    end

    #******PLAY
    def play # responsible for the game loop: 
        while (over?) == false # until game is over
            turn # take turns
        end
        if won? 
            puts "Congratulations #{winner}!" # end
        else draw?
            puts "Cat's Game!"
        end
    # if the game was won
    #     congratulate the winnter
    # else if the game was a draw
    #     tell the players it ended in a draw
    # end
    end
end


