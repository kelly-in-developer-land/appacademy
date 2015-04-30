require 'byebug'
class SlidingPieces < Pieces

  ORTHOGONAL = [
    [0, 1],
    [1, 0],
    [0, -1],
    [-1 ,0]
  ]

  DIAGONAL = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ]

  def moves(directions)
    valid_moves_array = []
    directions.each do |coordinates|
      pos = [@position[0] + coordinates[0], @position[1] + coordinates[1]]
      while @board.on_board?(pos)
        board_pos = @board[pos]
        unless board_pos.nil?
          valid_moves_array << pos unless board_pos.color == @color
          break
        end
        valid_moves_array << pos
        pos = [pos[0] + coordinates[0], pos[1] + coordinates[1]]
      end
    end

    valid_moves_array
  end


end
