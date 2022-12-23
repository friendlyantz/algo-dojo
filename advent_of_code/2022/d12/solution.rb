require 'pqueue' # https://en.wikipedia.org/wiki/Priority_queue#Dijkstra's_algorithm
require 'set'
require File.join(__dir__, '../lib/my_colorize')
require File.join(__dir__, '../lib/neighbour_check')
require File.join(__dir__, '../lib/neighbour_yield')

include MyColorize
include NeighbourCheck
include NeighbourYield

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
    @shortcut = [[start]]
  end

  def climb
    visited = Set.new
    
    until heap.empty?
      position, trail_length = heap.pop 
      next unless visited.add?(position)

      value_of_position = get_value_of_the_cell(position)

      if value_of_position == "E"
        h = heap.dup
        h.each_pop { |e| @shortcut << e.first }
 
        return trail_length
      end
      
      NeighbourYield.all(map, position) do |x, y|
        if can_step?(position, [x, y])
          # binding.pry if value_of_position.match?(/[c-z]/)
          heap.push([[x,y], trail_length += 1])
        end
      end
    end
  end

  def can_step?(current_pos, next_pos)
    current_alt = get_value_of_the_cell(current_pos)
    return true if current_alt == 'S'
    
    next_alt = get_value_of_the_cell(next_pos)
    return false if next_alt == 'S'
    return true if next_alt == 'E'
    
    return true if current_alt <= next_alt
    
    false
  end

  def heap
    @heap ||= PQueue.new([[start, trail_length = 0]]) do |a, b|
      a.last < b.last
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
