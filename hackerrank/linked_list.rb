# https://www.hackerrank.com/challenges/30-linked-list/problem?isFullScreen=true
class Node
  attr_accessor :data, :next

  def initialize(data)
    @data = data
    @next = nil
  end
end

# --------- SOLUTION
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

  # ------ DISPLAY METHOD
  def display(head)
    current = head
    while current
      print current.data, ' '
      current = current.next
    end
  end
end

mylist = Solution.new
head = nil
T = gets.to_i
for i in 1..T
  data = gets.to_i
  head = mylist.insert(head, data)
end
mylist.display(head)
