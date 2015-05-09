require './intro_algorithms.rb'
require 'byebug'

class KnightPathFinder

  MOVE_DIFFS = [
    [2, 1],
    [-2, 1],
    [2, -1],
    [-2, -1],
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2]
  ]

  def self.valid_moves(position)
    moves = MOVE_DIFFS.map do |diff|
      [position[0] + diff[0], position[1] + diff[1]]
    end

    moves.select do |move|
      move.all? { |coord| coord.between?(0, 7) }
    end
  end

  def initialize(starting_position)
    @starting_position = starting_position
    @visited_positions = [starting_position]
    @starting_node = PolyTreeNode.new(@starting_position)
  end

  def build_move_tree
    queue = [@starting_node]

    until queue.empty?
      current_position = queue.shift
      # byebug
      new_move_positions(current_position.value).each do |position|
        current_child = PolyTreeNode.new(position)
        current_position.add_child(current_child)
        queue << current_child
      end
    end
  end

  def find_path(end_position)
    self.build_move_tree
    @starting_node.bfs(end_position).trace_path_back.reverse
  end

  def new_move_positions(pos)
    new_positions = KnightPathFinder.valid_moves(pos).reject do |square|
      @visited_positions.include?(square)
    end
    @visited_positions += new_positions
    new_positions
  end

end



if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new([0, 0])
  p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
  p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
end
