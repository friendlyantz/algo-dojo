class Node
  attr_accessor :data, :children, :parent, :next

  def initialize(data)
    @data = data
    @children = []
  end
end

class Stacker
  def insert(parent, data)
    if parent.nil?
      Node.new(data)
    else
      parent.children << node = Node.new(data)
      node
    end
  end
end
