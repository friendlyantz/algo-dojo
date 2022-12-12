require File.join(__dir__, '../lib/my_colorize')
require File.join(__dir__, '../lib/neighbour_check')

include MyColorize
include NeighbourCheck

class Node
  attr_accessor :visited, :pos

  def initialize(visited = nil)
    @pos = nil
    @visited = visited
  end
end

def solution_pt1(input)
  input
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
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

private

def prep_data(input)
  input.split("\n").map(&:split).map { |pair| [pair.first, pair.last.to_i] }
end

def determine_matrix_size(preped_data)
  width = 1
  max_width = 1
  height = 1
  max_height = 1
  preped_data.each do |pair|
    case pair.first
    when 'R'
      width += pair.last
    when 'L'
      width -= pair.last
    when 'U'
      height += pair.last
    when 'D'
      height -= pair.last
    end
    max_width = width if width > max_width
    max_height = height if height > max_height
  end
  [max_height, max_width]
end

def generate_matrix(height, width)
  @matrix = Array.new(height) { Array.new(width) }
end

def matrix # rubocop:disable Style/TrivialAccessors
  @matrix
end

def head
  @head ||= Node.new
end

def tail
  @tail ||= Node.new
end

def place_figures_to_start
  update_pos(head, matrix.size - 1, 0)
  update_pos(tail, matrix.size - 1, 0)
  update_matrix_for_start
end

def update_matrix_for_start
  matrix[head.pos.first][head.pos.last] = [head, tail]
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
end

def move_tail
  follow if move_tail?
end

def move_tail?
  prox_cell_coords = NeighbourCheck.all(matrix, tail.pos.first, tail.pos.last)
  prox_cell_coords.each do |coord|
    next if matrix[coord.first][coord.last].nil?
    return false unless matrix[coord.first][coord.last].nil?
  end
  true
end

def horizontal_diff_check
  (tail.pos[1] - head.pos[1]).abs > 1
end

def follow
  tail.pos[0] += head.pos[0] <=> tail.pos[0]
  tail.pos[1] += head.pos[1] <=> tail.pos[1]
end

def move_head_right(steps)
  steps.times do
    shift_element(head)
    last_head_pos = head.pos
    # update_pos(head, head.pos.first, head.pos.last + 1)
    head.pos[1] += 1
    insert_into_matrix(head)

    shift_element(tail)
    move_tail
    insert_into_matrix(tail)
  end
end

def move_head_up(steps)
  steps.times do
    shift_element(head)
    last_head_pos = head.pos

    # update_pos(head, head.pos.first - 1, head.pos.last)
    head.pos[0] -= 1
    insert_into_matrix(head)
  end
end

def move_head_left(steps)
  steps.times do
    shift_element(head)
    # update_pos(head, head.pos.first, head.pos.last - 1)
    head.pos[1] -= 1
    insert_into_matrix(head)
  end
end

def move_head_down(steps)
  steps.times do
    shift_element(head)
    # update_pos(head, head.pos.first + 1, head.pos.last)
    head.pos[0] += 1
    insert_into_matrix(head)
  end
end

def shift_element(element)
  get_cell(element)
    .shift
  matrix[element.pos.first][element.pos.last] = nil if matrix[element.pos.first][element.pos.last].empty?
end

def insert_into_matrix(element)
  if get_cell(element).nil?
    matrix[element.pos.first][element.pos.last] = [element]
  else
    binding.pry # TODO
    get_cell(element) << [element]
  end
end

def get_cell(element)
  matrix[element.pos.first][element.pos.last]
end
