require_relative 'players'
require_relative 'board'

class Game

  attr_reader :board, :turn

  def initialize
    @board = Board.new
    populate(:red, 0)
    populate(:yellow, 5)
    @player_yellow = Player.new(:yellow)
    @player_pink = Player.new(:red)
    @turn = @player_pink
  end

  def play
    @board.display
    until (["Yellow", "Red"]).include?(winner)
        @board.display
        turn_switch
        puts "#{player_name}'s turn!"
        piece = nil
      # begin
        until piece && piece.color == @turn.color
          start_pos, end_pos = @turn.take_turn
          piece = @board[start_pos]
          if piece.nil?
            puts "There's no piece there!"
            next
          end
          if piece.color != @turn.color
            puts "That's not your piece!"
            next
          end
        end
        piece.perform_moves([end_pos])
      # rescue InvalidMoveError => e
      #   puts "Invalid move!"
      #   retry
      # end
    end
    puts "Game over! #{winner} won!"
    # draw conditions!
  end

  def player_name
    (@turn == @player_yellow) ? "Yellow" : "Pink"
  end

  def turn_switch
    @turn = (@turn == @player_yellow ? @player_pink : @player_yellow)
  end

  def winner
    return "Yellow" if @board.find_pieces(:red).empty?
    return "Red" if @board.find_pieces(:yellow).empty?
    "No one"
  end

  private

    def populate(color, first_row_idx)
      # can you do this recursively?
      i = first_row_idx
      until i == first_row_idx + 3
        @board.grid[i].each_with_index do |tile, col_idx|
            @board.grid[i][col_idx] = Piece.new(color, @board, [i, col_idx]) if (i + col_idx).even?
        end
        i += 1
      end
    end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end

# 55 44
