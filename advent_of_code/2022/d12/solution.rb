require File.join(__dir__, '../lib/my_colorize')
require File.join(__dir__, '../lib/neighbour_check')

include MyColorize
include NeighbourCheck

def solution_pt1(input)
  # input
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

class Hill
  attr_reader :map, :start, :end
  attr_accessor :alt

  def initialize(map:, start_pos:, end_pos:)
    @map = map
    @start = start_pos
    @end = end_pos
    @alt = 'a'
  end

  def climb
    path_stack = [start]
    check_neighbours(start, path_stack) 
  end

  def check_neighbours(current_pos, path_so_far)
  neighbours_coords = NeighbourCheck.all(map, current_pos.first, current_pos.last)
 
  neighbours_coords.each do |coordinates|
    neighbour_alt = get_value_of_the_cell(coordinates)
    binding.pry if neighbour_alt  == 'E'
    
    alt_comparator = alt <=>  neighbour_alt
    case alt_comparator
    when 1
      next
      binding.pry
    when -1
      path_so_far << coordinates
      alt =   neighbour_alt
      # check_neighbours(coordinates, path_so_far)
    when 0
      # binding.pry
      next
    else
      binding.pry
    end
    
  end
end

  def get_value_of_the_cell(coordinates)
    map[coordinates.first][coordinates.last]
  end
end

def hill = @hill

def prep_data(input)
  buffer = []
  input
    .lines
    .map(&:strip)
    .each_with_index do |line, i|
      buffer << line.split('')
      @start_pos = [i, find_start_column(line)] if find_start_column(line)
      @end_pos = [i, find_end_column(line)] if find_end_column(line)
    end
  @hill = Hill.new(
    map: buffer,
    start_pos: @start_pos,
    end_pos: @end_pos
  )
end

def find_start_column(line)
  line.index('S')
end

def find_end_column(line)
  line.index('E')
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
