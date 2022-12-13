require File.join(__dir__, '../lib/my_colorize')
require File.join(__dir__, '../lib/neighbour_check')
require 'ruby-progressbar'

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
  puts 'determing matrix size...'
  size = determine_matrix_size(data)
  puts 'determing matrix size COMPLETE'
  generate_matrix(size.first, size.last) # FIXME
  # generate_matri0x(20_000, 20_000) # FIXME
  
  
  place_figures_to_start(data)
  # binding.pry
  puts 'generation complete'
  data
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

def place_figures_to_start(data)
  # FIXME determin start corner?
  case data.first.first
  when 'R' # example input placing it in the corner
    update_pos(head, matrix.size - 1, 0)
    update_pos(tail, matrix.size - 1, 0)
  when 'D' # my example from top right
    update_pos(head, 0, matrix.first.size - 1)
    update_pos(tail, 0, matrix.first.size - 1)
  else # generic input, doubling matrix width and height and placing Head and Tail in the middle
    # WIP
    binding.pry
    
    generate_matrix(matrix.size * 2 + 1, matrix.first.size * 2 + 1) 
    # binding.pry

    update_pos(head, matrix.size/2, matrix.first.size/2)
    update_pos(tail, matrix.size/2, matrix.first.size/2)
  end
    
  tail.visited = [tail.pos.dup]
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
  upd_tail_visited_list
end

def upd_tail_visited_list
  visited = tail.pos.dup
  tail.visited << visited
end

def move_tail_and_upd_matrix
  shift_element(tail)
  move_tail
  insert_into_matrix(tail)
end

def move_head_right(steps)
  steps.times do
    shift_element(head)
    last_head_pos = head.pos
    head.pos[1] += 1
    insert_into_matrix(head)

    move_tail_and_upd_matrix
  end
end

def move_head_up(steps)
  steps.times do
    shift_element(head)
    last_head_pos = head.pos

    head.pos[0] -= 1
    insert_into_matrix(head)

    move_tail_and_upd_matrix
  end
end

def move_head_left(steps)
  steps.times do
    shift_element(head)
    head.pos[1] -= 1
    insert_into_matrix(head)

    move_tail_and_upd_matrix
  end
end

def move_head_down(steps)
  steps.times do
    shift_element(head)
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
    # this will fly since we rely on shifting 1st element which is normal snake behaviour
    # binding.pry
    get_cell(element) << [element]
  end
  # render_matrix
  # matrix
 end

def replace_element_with_abbr(matrix_dup)
  matrix_dup.map! { |line| line.map { |item| item = 0} }
  
  if tail.pos == head.pos
    matrix_dup[tail.pos.first][tail.pos.last] = 5
  else
    matrix_dup[tail.pos.first][tail.pos.last] = 1
    matrix_dup[head.pos.first][head.pos.last] = 9
  end
  matrix_dup
end

def render_matrix
  matrix_dup = matrix.dup
  replace_element_with_abbr(matrix_dup)
  
  MyColorize.print_out matrix_dup

  puts <<~HEREDOC












  HEREDOC
  sleep(0.2)
end


def get_cell(element)
  binding.pry unless matrix[element.pos.first]

  matrix[element.pos.first][element.pos.last]
end
