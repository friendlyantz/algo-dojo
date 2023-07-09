# frozen_string_literal: true

def solution(array)
  stack = []
  buffer = 0
  array.each_cons(2) do |a, b|
    if a < b
      buffer += (b - a)
    elsif a > b
      stack << buffer
      buffer = 0
    end
  end

  stack << buffer
  stack.sum
end

puts solution([7, 1, 5, 3, 2, 6, 4])
puts solution([1, 2, 3, 4, 5])
