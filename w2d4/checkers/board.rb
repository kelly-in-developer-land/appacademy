require_relative 'pieces'
require 'colorize'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, assignment)
    row, col = pos
    @grid[row][col] = assignment
  end

  def board_dup
    dup = Board.new

    piece_dup_proc = Proc.new do |piece|
      dup[piece.position] = Piece.new(piece.color, self, [piece.position])
    end

    find_pieces(:red).each &piece_dup_proc
    find_pieces(:yellow).each &piece_dup_proc

    dup
  end

  def display
    system 'clear'
    puts ""
    print "     0   1   2   3   4   5   6   7 \n"
    @grid.each_index do |row_idx|
      print "#{row_idx}  "
      @grid[row_idx].each_index do |col_idx|
        piece = @grid[row_idx][col_idx]
        tile_color = ((row_idx + col_idx).even? ? :black : :light_black)
        unless piece.nil?
          print " #{piece.symbol}  ".colorize(:color => piece.color, :mode => :bold, :background => tile_color)
        else
          print "    ".colorize(:background => tile_color)
        end
      end
      print "  #{row_idx}"
      puts ""
    end
    print "     0   1   2   3   4   5   6   7 \n"
    puts ""
  end

  def find_pieces(color)
    @grid.flatten.compact.select { |piece| piece.color == color }
  end

  def update(piece, start_pos, end_pos)
    self[end_pos] = piece
    self[start_pos] = nil
  end

  def inspect
    @piece
  end

end
