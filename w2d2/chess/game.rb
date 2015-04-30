require 'yaml'
require_relative 'piece_requires'

class Game

  attr_accessor :board, :turn

  def initialize(board = nil, turn_color = :white)
    @board = Board.new
    populate(0, :black)
    populate(7, :white)
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @turn = nil
    turn_color == :white ? @turn = @player1 : @turn = @player2
  end

  def play
    @board.display
    until @board.in_checkmate?(@turn.color)
      start_pos, end_pos = @turn.take_turn(@board.find_pieces(@turn.color))
      if start_pos == "save" or end_pos == "save"
        self.save
        puts "Game saved! Quitting."
        exit
      end
      if start_pos == "quit" or end_pos == "quit"
        exit
      else
        @board.update(start_pos, end_pos)
        @board.display
        turn_switch
      end
    end
    turn_switch
    puts "Game over! #{@turn.color.to_s.capitalize} won!".green
  end

  def save
    @current_time = Time.now
    File.open('chess_last_game.yml', 'w') do |f|
      f.puts self.to_yaml
    end
    puts "Game saved.".green
    puts "Do you want to quit? Y/N"
    print "> "
    @quit = gets.chomp.downcase == 'y'
  end

private

  def populate(start_row, color)
    back_pieces = [ Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    @board.grid[start_row].each_index do |idx|
      @board.grid[start_row][idx] = back_pieces[idx].new([start_row, idx], @board, color)
    end
    pawn_row = (color == :white ? start_row - 1 : start_row + 1)
    @board.grid[pawn_row].each_index do |idx|
      @board.grid[pawn_row][idx] = Pawn.new([pawn_row, idx], @board, color)
    end
  end

  def turn_switch
    @turn == @player2 ? @turn = @player1 : @turn = @player2
  end
end


if __FILE__ == $PROGRAM_NAME
  if File.exist?('chess_last_game.yml')
    game = YAML.load_file('chess_last_game.yml')
    system "rm chess_last_game.yml"
  else
    game = Game.new
  end
  game.play
end

# w f2 f3
# b e7 e5
# w g2 g4
# b d8 h4
