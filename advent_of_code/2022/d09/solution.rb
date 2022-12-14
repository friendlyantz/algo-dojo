require File.join(__dir__, '../lib/my_colorize')

include MyColorize

class Node
  attr_accessor :visited, :pos

  def initialize(visited = [])
    @pos = nil
    @visited = visited
  end
end

def solution_pt1(input)
  input
    .then { |data| prep_data(data) }
    .then { |data| generate_matrix_and_place_figues_to_start(data) }
    .then do |data|
      data.each do |instruction|
        move_head(instruction)
      end
    end
    .then { |_data| tail.visited.uniq.size }
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

def generate_matrix_and_place_figues_to_start(data)
  place_figures_to_start
  data
end


# private

def prep_data(input)
  input.split("\n").map(&:split).map { |pair| [pair.first, pair.last.to_i] }
end
def head
  @head ||= Node.new
end

def tail
  @tail ||= Node.new
end

def place_figures_to_start
  update_pos(head, 0, 0)
  update_pos(tail, 0, 0)

  upd_tail_visited_list
end

def update_pos(object, new_row, new_col)
  object.pos = [new_row, new_col]
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

  # binding.pry if matrix[head.pos.first].size > matrix[0].size
end

def move_tail
  follow if move_tail?
end

def move_tail?
  return true if (tail.pos.first - head.pos.first).abs > 1
  return true if (head.pos.first - tail.pos.first).abs > 1
  return true if (tail.pos.last - head.pos.last).abs > 1
  return true if (head.pos.last - tail.pos.last).abs > 1

  false
end

def follow
  tail.pos[0] += head.pos[0] <=> tail.pos[0]
  tail.pos[1] += head.pos[1] <=> tail.pos[1]
  upd_tail_visited_list
end

def upd_tail_visited_list
  tail.visited << tail.pos.dup
end

def move_tail_and_upd_matrix
  move_tail
end

def move_head_right(steps)
  steps.times do
    head.pos[1] += 1
    move_tail
  end
end

def move_head_up(steps)
  steps.times do
    head.pos[0] -= 1
    move_tail
  end
end

def move_head_left(steps)
  steps.times do
    head.pos[1] -= 1
    move_tail
  end
end

def move_head_down(steps)
  steps.times do
    head.pos[0] += 1
    move_tail
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
