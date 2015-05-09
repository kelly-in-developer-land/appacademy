class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def add_child(node)
    @children << node
    node.parent=(self)
  end

  def bfs(node_value)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      if current_node.value == node_value
        return current_node
      else
        queue += current_node.children
      end
    end
  end

  def children
    @children
  end

  def dfs(node_value)
    return self if node_value == @value
    return nil if @children == []

    @children.each do |child|
      child_children = child.dfs(node_value)
      return child_children if child_children
    end
    nil
  end

  def parent
    @parent
  end

  def parent=(node)
    if @parent && @parent != node
      @parent.children.delete(self)
    end

    @parent = node
    unless @parent == nil || @parent.children.include?(self)
      @parent.children << self
    end
  end

  def remove_child(node)
    if @children.include?(node)
      @children.delete(node)
      node.parent = nil
    else
      raise Exception
    end
  end

  def trace_path_back
    current_node = self
    trace_path = []
    until current_node == nil
      trace_path << current_node
      current_node = current_node.parent
    end
    trace_path
  end

  def value
    @value
  end

  #
  def inspect
    @value = value
  end

end
