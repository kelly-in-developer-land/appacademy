require_relative 'board'
require_relative 'invalidmoveerror'
require 'colorize'

class Piece

  # UP = -1
  # DOWN = 1
  # RIGHT = 1
  # LEFT = -1

  attr_reader :color, :status, :symbol, :kinged, :position, :board

  def initialize(color, board, position, kinged = false)
    @color = color
    @board = board
    @position = position
    @kinged = kinged
    @symbol = :♥
  end

  def assess_vertical(end_pos)
    return -1 if @position[0] > end_pos[0]
    return 1 if @position[0] < end_pos[0]
    # have to begin/end around a raise
    raise InvalidMoveError.new
  end

  def assess_horizontal(end_pos)
    return -1 if @position[1] > end_pos[1]
    return 1 if @position[1] < end_pos[1]
    # have to begin/end around a raise
    raise InvalidMoveError.new
  end

  def legal_jump?(end_pos)
    vertical = assess_vertical(end_pos)
    horizontal = assess_horizontal(end_pos)

    unless @kinged
      return false if (@color == :yellow && vertical == 1)
      return false if (@color == :red && vertical == -1)
    end

    test_board = @board.board_dup
    return false unless test_board[end_pos].nil?
    return false unless end_pos.all? { |pos| pos.between?(0, 7) }

    jump_pos = [@position[0] + vertical, @position[1] + horizontal]
    other_color = (@color == :yellow ? :red : :yellow)
    return false unless @board[jump_pos].color == other_color

    true
  end

  def legal_sequence?(sequence)
    # calls perform_moves! on a duped Piece/Board
    # true if no error raised, else false
    # use begin/rescue/else
  end

  def legal_slide?(end_pos)

    vertical = assess_vertical(end_pos)
    horizontal = assess_horizontal(end_pos)

    unless @kinged
      return false if (@color == :yellow && vertical == 1)
      return false if (@color == :red && vertical == -1)
    end

    test_board = @board.board_dup
    return false unless test_board[end_pos].nil?
    return false unless end_pos.all? { |pos| pos.between?(0, 7) }

    current_pos = [@position[0] + vertical, @position[1] + horizontal]
    until current_pos == end_pos
      current_pos = [current_pos[0] + vertical, current_pos[1] + horizontal]
      return false unless test_board[current_pos].nil?
      return false unless current_pos.all? { |pos| pos.between?(0, 7) }
    end

    true
  end

  # def move_dirs
  # end

  def perform_moves
    # have to begin/end around a raise
    raise InvalidMoveError.new unless legal_sequence?(sequence)
    perform_moves!(sequence, board = @board.board_dup)
  end

  def perform_moves!(sequence)
    # sequence is one slide, or one+ jumps
    # should perform moves one at a time
    # raise InvalidMoveError if a sequence fails
    # if the sequence is one move long, try sliding before trying jumping
    # if the sequence is multiple moves, every move must be a jump
    # should not try to restore original board if sequence fails...
  end

  def perform_jump(end_pos)
    vertical = assess_vertical(end_pos)
    horizontal = assess_horizontal(end_pos)

    # have to begin/end around a raise
    raise InvalidMoveError.new unless legal_jump?(end_pos)
    start_pos = @position
    jump_pos = [start_pos[0] + vertical, start_pos[1] + horizontal]
    @board[jump_pos] = nil

    @position = end_pos
    @board.update(self, start_pos, end_pos)
    promote
  end

  def perform_slide(end_pos)
    vertical = assess_vertical(end_pos)
    horizontal = assess_horizontal(end_pos)

    # have to begin/end around a raise
    raise InvalidMoveError.new unless legal_slide?(end_pos)
    current_pos = @position
    until current_pos == end_pos
      @position = current_pos
      prev_pos = current_pos
      current_pos = [current_pos[0] + vertical, current_pos[1] + horizontal]
      @board.update(self, prev_pos, current_pos)
    end

    @position = end_pos
    @board.update(self, prev_pos, end_pos)
    promote
  end

  def promote
    @kinged = true if @color == :yellow && @position[0] == 0
    @kinged = true if @color == :pink && @position[0] == 7
  end

  # def is_a_jump?(end_pos)
  #   @position[0] + end_pos[0] ............... 1
  # end
  #
  # def is_a_slide?(end_pos)
  #   @position[0] + end_pos[0] ............... 1
  # end

  def inspect
    @piece
  end

end
