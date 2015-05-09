require 'colorize'

class Board
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
    duped_board = Board.new
    piece_list = find_pieces(:black) + find_pieces(:white)
    piece_list.each do |piece|
      new_piece = piece.piece_dup(duped_board)
      duped_board[new_piece.position] = new_piece
    end

    duped_board
  end

  def display
    system "clear"
    puts ""
    puts "    a  b  c  d  e  f  g  h".light_magenta
    @grid.each_index do |y|
      print " #{8 - y} ".light_magenta
      @grid[y].each_index do |x|
        background_color = (y + x).even? ? :magenta : :blue
        if @grid[y][x] == nil
          print "   ".colorize(:background => background_color)
        else
          if @grid[y][x].color == :black
            print " #{@grid[y][x].symbol} ".colorize(:color => :black, :background => background_color)
          else
            print " #{@grid[y][x].symbol} ".colorize(:color => :white, :background => background_color)
          end
        end
      end
      print " #{8 - y} ".light_magenta
      print "\n"
    end
    puts "    a  b  c  d  e  f  g  h".light_magenta
    puts ""
    puts "White in check? #{in_check?(:white).to_s.capitalize}!"
    puts "Black in check? #{in_check?(:black).to_s.capitalize}!"
    puts "White in checkmate? #{in_checkmate?(:white).to_s.capitalize}!"
    puts "Black in checkmate? #{in_checkmate?(:black).to_s.capitalize}!"
  end

  def find_pieces(color)
    @grid.flatten.compact.select { |object| object.color == color }
  end

  def in_check?(color)
    king = find_pieces(color).find{ |object| object.class == King }
    other_player = (color == :white ? :black : :white)
    other_player_all_moves = find_all_moves(other_player)
    other_player_all_moves.include?(king.position)
  end

  def in_checkmate?(color)
    move_list = []
    find_pieces(color).each do |piece|
      move_list += piece.valid_moves
    end
    in_check?(color) && move_list.empty?
  end

  def on_board?(position)
    position.all? { |x| x.between?(0,7) }
  end

  def update(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
    self[end_pos].moved = true
    self[end_pos].position = end_pos
  end

private


  def find_all_moves(color)
    all_pieces = find_pieces(color)
    all_moves = []
    all_pieces.each do |piece|
      all_moves = all_moves + piece.move_dirs
    end

    all_moves.compact
  end
end
