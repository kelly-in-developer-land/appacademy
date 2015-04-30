require_relative 'players'
require_relative 'board'

class Game

  attr_reader :board

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
            @board.grid[i][col_idx] = Piece.new(color, @board, [i, col_idx]) if (i + col_idx).even?
        end
        i += 1
      end
    end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  player_pink = Player.new(:yellow)
  player_yellow = Player.new(:red)
  game.play
end
