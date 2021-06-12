class Solution
  def initialize
    @stack = []
    @queue = []
  end

  def push_character(char)
    @stack.push(char)
    # print @stack
  end

  def enqueue_character(char)
    @queue.unshift(char)
  end

  def pop_character
    # p @stack
    @stack.shift
  end

  def dequeue_character
    # p @queue
    @queue.shift
  end
end
