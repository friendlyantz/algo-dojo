# frozen_string_literal: true

require 'pry'
require File.join(__dir__, '../lib/my_colorize')
require File.join(__dir__, '../lib/neighbour_yield_lateral')
require File.join(__dir__, '../lib/visualisation.rb')

class SolutionOne
  attr_reader :start, :finish, :alt_map
  attr_accessor :nav_map, :visited

  def initialize(input)
    @nav_map = [] # map with explored path
    generate_nav_map(input)
    @alt_map = [] # map with altitudes
    generate_alt_map
    @start = [0, 0]
    @finish = [0, 0]
    set_start_and_finish
    @visited = {}
  end

  def generate_nav_map(input)
    input.lines do |line|
      nav_map << line.chomp.chars
    end
  end

  def generate_alt_map
    nav_map.each do |line|
      alt_map <<
        line.map do |x|
          case x
          when 'S' then 0
          when 'E' then 27
          else          x.ord - 96
          end
        end
    end
  end

  def set_start_and_finish
    alt_map.each_with_index do |x, idx|
      x.each_with_index do |y, idy|
        @finish = [idx, idy] if y == 27
        @start = [idx, idy] if y == 0
      end
    end
  end

  def run
    step(start, 0)
    visited["#{finish[0]}:#{finish[1]}"]
  end

  def step(current_position, steps)
    x, y = current_position
    return visited if !visited["#{x}:#{y}"].nil? && steps >= visited["#{x}:#{y}"]

    visited["#{x}:#{y}"] = steps
    current = alt_map[x][y]
    return visited if current == 27

    nav_map[x][y] = '#'
    print(nav_map)

    NeighbourYieldLateral.all(alt_map, [x, y]) do |dx, dy|
      alt = alt_map[dx][dy] || 30
      step([dx, dy], steps + 1) if alt - current < 2 || (current == 25 && alt == 27)
    end

    nav_map[x][y] = alt_map[x][y].zero? ? 'S' : (alt_map[x][y] + 96).chr # cleanup '#' visited marker when coming back
    print(nav_map)

    visited
  end

  def print(nav_map)
    Visualisation.print_grid(
      nav_map,
      centre_x: 21, centre_y: 35, x_dim: 42, y_dim: 170,
      # sleep: 0.01,
      spacer: ' ',
      colour_char: '#', colour: :red
    )
  end
end

def solution_pt1(input)
  SolutionOne.new(input).run
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
  # puts solution_pt2(input)
end
