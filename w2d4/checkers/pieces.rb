require 'colorize'

class Piece

  TOP_PAWN_MOVE_DIRECTIONS = [[1, 1], [1, -1]]
  BOTTOM_PAWN_MOVE_DIRECTIONS = [[-1, 1], [-1, -1]]
  KING_MOVE_DIRECTIONS = TOP_PAWN_MOVE_DIRECTIONS + BOTTOM_PAWN_MOVE_DIRECTIONS

  attr_reader :color, :status, :symbol

  def initialize(color, status)
    @symbol = :♥
    @color = color
    @status = status
  end

  # any Piece can only move on its diagonals
  # a pawn can only move ahead
  # once a pawn gets to the end it becomes a @king
  # a @king can move backwards or forwards

  def perform_slide
  end

  def perform_jump
    # should remove jumped piece from board
  end

  def legal?
  end

  def need_promotion?
  end

  def move_dirs
  end

  def perform_moves!(sequence)
    # sequence is one slide, or one+ jumps
    # should perform moves one at a time
    # raise InvalidMoveError if a sequence fails
    # if the sequence is one move long, try sliding before trying jumping
    # if the sequence is multiple moves, every move must be a jump
    # should not try to restore original board if sequence fails...
  end

  def valid_move_sequence?
    # calls perform_moves! on a duped Piece/Board
    # true if no error raised, else false
    # use begin/rescue/else
  end

  def perform_moves
    # checks valid_move_sequence
    # calls perform_moves! or raises error
  end

  def inspect
    @piece
  end

end
