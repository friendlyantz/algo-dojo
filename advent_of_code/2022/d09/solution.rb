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

def update_pos(object, new_row, new_col)
  object.pos = [new_row, new_col]
  move_tail(object)
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
  follow(head) if head.tail
end

def move_tail?(head)
  tail = head.tail

  return false unless tail

  return true if (tail.pos.first - head.pos.first).abs > 1
  return true if (head.pos.first - tail.pos.first).abs > 1
  return true if (tail.pos.last - head.pos.last).abs > 1
  return true if (head.pos.last - tail.pos.last).abs > 1

  false
end

SIZE = 100
CTR = SIZE / 2

def generate_matrix
  a = []
  SIZE.times do
    a << Array.new(SIZE * 2, 0)
  end
  a
end

def render
  matrix = generate_matrix.dup
  snake.each do |el|
    matrix[CTR + el.pos.first][CTR + el.pos.last] = el.title
  end

  MyColorize.print_out matrix
  # sleep(0.2)
end

def follow(head)
  return unless move_tail?(head)

  # =================
  #  REDNERING
  # =================
  # render

  head.tail.pos[0] += head.pos[0] <=>  head.tail.pos[0]
  head.tail.pos[1] += head.pos[1] <=>  head.tail.pos[1]

  # binding.pry if head.tail.eql? @tail

  upd_visited_list if head.tail.eql? @tail

  follow(head.tail)
end

def upd_visited_list
  @tail.visited << tail.pos.dup
end

def move_head_right(steps)
  steps.times do
    update_pos(
      head,
      head.pos[0],
      head.pos[1] + 1
    )
    move_tail(head)
  end
end

def move_head_up(steps)
  steps.times do
    update_pos(
      head,
      head.pos[0] -= 1,
      head.pos[1]
    )
    move_tail(head)
  end
end

def move_head_left(steps)
  steps.times do
    update_pos(
      head,
      head.pos[0],
      head.pos[1] -= 1
    )
    move_tail(head)
  end
end

def move_head_down(steps)
  steps.times do
    update_pos(
      head,
      head.pos[0] += 1,
      head.pos[1]
    )
    move_tail(head)
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
