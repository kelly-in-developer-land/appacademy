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

  def display
    system 'clear'
    @grid.each_index do |row_idx|
      @grid[row_idx].each_index do |col_idx|
        tile = @grid[row_idx][col_idx]
        tile_color = ((row_idx + col_idx).even? ? :black : :light_black)
        unless tile.nil?
          print " #{tile.symbol}  ".colorize(:color => tile.color, :mode => :bold, :background => tile_color)
        else
          print "    ".colorize(:background => tile_color)
        end
      end
      print "\n"
    end
  end

  def update
  end

end
