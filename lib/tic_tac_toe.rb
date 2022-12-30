require 'pry'

class TicTacToe
    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
    end

    def display_board
        puts "------------"
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(string)
        index = string.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        if @board[index] == " "
            false
        else 
            true
        end
    end

    def valid_move?(position)
        if position.between?(0,8) && self.position_taken?(position) == false
            true
        end
    end

    def turn_count
        made_moves = @board.tally
        9 - made_moves[" "]
    end

    def current_player
        self.turn_count.even? ? "X" : "O"
    end

    def turn
        player_move = gets
        move_index = self.input_to_index(player_move)
        player = self.current_player
        if self.valid_move?(move_index)
            self.move(move_index, player)
            self.display_board
        else
            self.turn
        end
    end

    def won?
        winning_combo = []
        WIN_COMBINATIONS.map do |i|
            if [@board[i[0]], @board[i[1]], @board[i[2]]] == ["X", "X", "X"] || [@board[i[0]], @board[i[1]], @board[i[2]]] == ["O", "O", "O"]
               winning_combo << i
            end
        end
        if winning_combo.length > 0
            winning_combo[0]
        else
            false
        end
    end

    def full?
        if @board.include?(" ")
            false
        else
            true
        end
    end

    def draw?
        if self.full? && !self.won?
            true
        else
            false
        end
    end

    def over?
        if self.full? || self.won?
            true
        else
            false
        end
    end

    def winner
        if self.won?
            winner = @board[self.won?[0]]
        else
            nil
        end
    end

    def play
        until self.over?
            self.turn
            if self.draw?
                puts "new game?"
            elsif self.won?
                self.winner
            else self.play
            end
        end
    end

end

# board = ["X", "O", "X", "O", "X", "O", "O", "X", "X"]
# board = ["X", " ", " ", " ", " ", " ", " ", " ", " "]
# board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]