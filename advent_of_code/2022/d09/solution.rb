require File.join(__dir__, '../lib/my_colorize')
require 'pry'

include MyColorize

class Node
  attr_accessor :visited, :pos, :tail, :title

  def initialize(visited: [[0, 0]], tail: nil, title: nil)
    @pos = [0, 0]
    @visited = visited
    @tail = tail
    @title = title
  end
end

def solution_pt1(input)
  input
    .then { |data| prep_data(data) }
    .then { |data| generate_snake(data, 1) }
    .then do |data|
      data.each { |instruction| move_head(instruction) }
    end
    .then { tail.visited.uniq.size }
end

def solution_pt2(input)
  input
    .then { |data| prep_data(data) }
    .then { |data| generate_snake(data, 9) }
    .then do |data|
      data.each { |instruction| move_head(instruction) }
    end
    .then { |_data| tail.visited.uniq.size }
end

def generate_snake(data, tail_size)
  tail_size.downto(0) do |i|
    case i
    when tail_size
      @tail = Node.new(title: tail_size)
      snake << tail
    when 0
      @head = Node.new(title: 10, tail: snake.last)
      snake << @head
    else
      snake << Node.new(tail: snake.last, title: i)
    end
  end

  data
end

def prep_data(input)
  input.split("\n").map(&:split).map { |pair| [pair.first, pair.last.to_i] }
end

def snake
  @snake ||= []
end

def head
  @head ||= Node.new(tail: tail)
end

def tail
  @tail ||= Node.new
end

def upd_head_position(new_row, new_col)
  head.pos = [new_row, new_col]
  move_tail(head)
end

def move_head(instruction)
  case instruction.first
  when 'R'
    move_head_right(instruction.last)
  when 'L'
    move_head_left(instruction.last)
  when 'U'
    move_head_up(instruction.last)
  when 'D'
    move_head_down(instruction.last)
  end
end

def move_tail(head)
  follow(head)
end

def move_tail?(head)
  return false unless tail = head.tail

  return true if (tail.pos.first - head.pos.first).abs > 1
  return true if (head.pos.first - tail.pos.first).abs > 1
  return true if (tail.pos.last - head.pos.last).abs > 1
  return true if (head.pos.last - tail.pos.last).abs > 1

  false
end

# =======================
# Debugging / visualising
SIZE = 100
CTR = SIZE / 2
# =======================

# Debugging / visualising
def generate_matrix
  a = []
  SIZE.times do
    a << Array.new(SIZE * 2, 0)
  end
  a
end

# Debugging / visualising
def render
  matrix = generate_matrix.dup
  snake.each do |el|
    matrix[CTR + el.pos.first][CTR + el.pos.last] = el.title
  end

  MyColorize.print_out matrix
  # sleep(0.2)
end

def follow(node)
  return unless move_tail?(node)

  # =================
  # render # REDNERING / DEBUG
  # =================

  node.tail.pos[0] += node.pos[0] <=>  node.tail.pos[0]
  node.tail.pos[1] += node.pos[1] <=>  node.tail.pos[1]

  upd_visited_list if node.tail.eql? @tail

  follow(node.tail)
end

def upd_visited_list
  @tail.visited << tail.pos.dup
end

def move_head_right(steps)
  steps.times do
    upd_head_position(
      head.pos[0],
      head.pos[1] + 1
    )
  end
end

def move_head_up(steps)
  steps.times do
    upd_head_position(
      head.pos[0] -= 1,
      head.pos[1]
    )
  end
end

def move_head_left(steps)
  steps.times do
    upd_head_position(
      head.pos[0],
      head.pos[1] -= 1
    )
  end
end

def move_head_down(steps)
  steps.times do
    upd_head_position(
      head.pos[0] += 1,
      head.pos[1]
    )
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    raise 'please provide input file destination as an argument following script name when executing this file'
  end

  input = File.read(ARGV.first)
  puts 'part 1 solution'
  puts solution_pt1(input)

  puts '==============='
  puts 'part 2 solution'
  puts solution_pt2(input)
end
