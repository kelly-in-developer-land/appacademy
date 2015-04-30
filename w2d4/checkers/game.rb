require_relative 'board'
require 'colorize'

class Game

  def initialize
    @board = Board.new
    populate(:red, 0)
    populate(:yellow, 5)
  end

  def play
    @board.display
    # gameplay
    # do getch stuff somewhere...
  end

  private

    def populate(color, first_row_idx)

      i = first_row_idx
      until i == first_row_idx + 3
        @board.grid[i].each_with_index do |tile, col_idx|
            @board.grid[i][col_idx] = Piece.new(color, :pawn) if (i + col_idx).even?
        end
        i += 1
      end
    end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
