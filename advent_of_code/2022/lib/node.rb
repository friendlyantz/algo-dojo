class Node
  attr_accessor :data, :children

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
      parent.children << Node.new(data)
    end
  end
end
