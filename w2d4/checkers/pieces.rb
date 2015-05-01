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
  end

  def assess_horizontal(end_pos)
    return -1 if @position[1] > end_pos[1]
    return 1 if @position[1] < end_pos[1]
  end

  def legal?(end_pos)
    vertical = assess_vertical(end_pos)
    horizontal = assess_horizontal(end_pos)
    # why can't the king move?
    unless @kinged
      return false if (@color == :yellow && vertical == 1)
      return false if (@color == :red && vertical == -1)
    end
    return false unless @board[end_pos].nil?
    return false unless end_pos.all? { |pos| pos.between?(0, 7) }
    unless is_jump?(end_pos)
      return false if end_pos != [@position[0] + vertical, @position[1] + horizontal]
    else
      jump_pos = [@position[0] + vertical, @position[1] + horizontal]
      other_color = (@color == :yellow ? :red : :yellow)
      return false unless @board[jump_pos].color == other_color
      return false if end_pos != [jump_pos[0] + vertical, jump_pos[1] + horizontal]
    end

    true
  end

  def legal_sequence?(sequence)
    # begin
      slides = []
      sequence.each { |pos| slides << pos unless is_jump?(pos) }
      if sequence.length > 1 && !slides.empty?
        raise InvalidMoveError.new
      end
      test_board = @board.board_dup
      test_me = test_board[self.position]
      test_me.perform_moves!(sequence)
    # rescue InvalidMoveError => e
    #   puts "Invalid move for piece at #{@position}!"
    #   retry
    # end

    true
  end

  def perform_moves(sequence)
    unless legal_sequence?(sequence)
      raise InvalidMoveError.new
    end
    perform_moves!(sequence)
  end

  def is_jump?(to_pos)
    @position[0] + 2 == to_pos[0] || @position[0] - 2 == to_pos[0]
  end

  def single_move(to_pos)
    is_jump?(to_pos) ? perform_jump(to_pos) : perform_slide(to_pos)
  end

  def perform_moves!(sequence)

    return single_move(sequence.shift) if sequence.length == 1
    current_pos = @position
    next_pos = sequence.shift
    until sequence.empty?
      current_pos.single_move(next_pos)
      current_pos = next_pos
    end
    # do you need the board argument everywhere??
    # if the sequence is one move long, try sliding before trying jumping
    # should not try to restore original board if sequence fails
  end

  def perform_jump(end_pos)
    vertical = assess_vertical(end_pos)
    horizontal = assess_horizontal(end_pos)
    unless legal?(end_pos)
      raise InvalidMoveError.new
    end
    jump_pos = [@position[0] + vertical, @position[1] + horizontal]
    @board[jump_pos] = nil
    @board.update(self, @position, end_pos)
    @position = end_pos
    promote
  end

  def perform_slide(end_pos)
    vertical = assess_vertical(end_pos)
    horizontal = assess_horizontal(end_pos)
    unless legal?(end_pos)
      raise InvalidMoveError.new
    end
    @board.update(self, @position, end_pos)
    @position = end_pos
    promote
  end

  def promote
    @kinged = true if @color == :yellow && @position[0] == 0
    @kinged = true if @color == :red && @position[0] == 7
    @symbol = :♠ if @kinged
  end

  def inspect
    @piece
  end

end
