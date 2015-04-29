require_relative 'piece_requires'
require 'colorize'

class Board
  #
  # COLUMNS = {
  #   a => 0,
  #   b => 1,
  #   c => 2,
  #   d => 3,
  #   e => 4,
  #   f => 5,
  #   g => 6,
  #   h => 7
  # }

  # REMEMBER TO USE THIS
  # col, row = pos
  # @grid[8-row][COLUMNS[col]]

  attr_accessor :grid

  def initialize(grid = Array.new(8) { Array.new(8) })
    @grid = grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, thing)
    row, col = pos
    @grid[row][col] = thing
  end

  def board_dup
    Board.new(@grid.deep_dup)
  end

  def in_checkmate?(color)
    in_check?(color) && find_all_moves(color).empty?
  end

  def display
    puts "    a  b  c  d  e  f  g  h"
    @grid.each_index do |y|
      print " #{8 - y} "
      @grid[y].each_index do |x|
        if @grid[y][x] == nil
          print " _ "
        else
          if @grid[y][x].color == :black
            print " #{@grid[y][x].symbol} ".yellow
          else
            print " #{@grid[y][x].symbol} ".green
          end
        end
      end
      print " #{8 - y} "
      print "\n"
    end
    puts "    a  b  c  d  e  f  g  h"
  end

  def in_check?(color)
    king_pos = find_king(color)
    color == :white ? other_player = :black : other_player = :white
    other_player_valid_moves = find_all_moves(other_player)
    other_player_valid_moves.include?(king_pos)
  end

  def on_board?(position)
    position.all? { |x| x.between?(0,7) }
  end

  def update(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

private

  def find_king(color)
    @grid.each_index do |y|
      @grid[y].each_index do |x|
        current_object = @grid[y][x]
        next if current_object == nil
        return current_object.position if current_object.symbol == :K && current_object.color == color
      end
    end
  end


  def find_colors(color)
    piece_list = []
    @grid.each_index do |y|
      @grid[y].each_index do |x|
        current_object = @grid[y][x]
        next if current_object == nil
        piece_list << current_object if current_object.color == color
      end
    end
    piece_list
  end

  def find_all_moves(color)
    all_pieces = find_colors(color)
    all_valid_moves = []
    all_pieces.each do  |piece|
      all_valid_moves << piece.move_dirs
    end
    all_valid_moves
  end

end

class Array
  def deep_dup
    dup = []
    self.each { |el| dup << (el.is_a?(Array) ? el.deep_dup : el) }
    dup
  end
end

board = Board.new
board.grid[5][4] = King.new([5,4], board, :black)
board.grid[5][5] = Rook.new([5,5], board, :white)
board.grid[5][3] = Rook.new([5,3], board, :white)
p board.grid[5][4].valid_moves
board.display
