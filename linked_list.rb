class Node
  attr_accessor :data, :next

  def initialize(data)
    @data = data
    @next = nil
  end
end

class Solution
  def insert(head, value)
    # Complete this method
    if !head.nil?
      # puts @data
      node = head
      node = node.next until node.next.nil?
      node.next = Node.new(value)
    else
      head = Node.new(value)
    end
    head
  end
end
