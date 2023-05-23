# frozen_string_literal: true

require 'pry'
require File.join(__dir__, '../lib/my_colorize')
require File.join(__dir__, '../lib/neighbour_yield_lateral')
require File.join(__dir__, '../lib/visualisation.rb')

class SolutionOne
  def run(input, _)
    topo_map = []
    grid = []
    input.each_line do |line|
      topo_map <<
        line.chars.map do |x|
          case x
          when 'S' then 0
          when 'E' then 27
          else          x.ord - 96
          end
        end
      grid << line.chars
    end
    start_x = 0
    start_y = 0
    end_x = 0
    end_y = 0
    topo_map.each_with_index do |x, idx|
      x.each_with_index do |y, idy|
        if y == 27
          end_x = idx
          end_y = idy
        end
        if y == 0
          start_x = idx
          start_y = idy
        end
      end
    end
    visited = {}
    step(start_x, start_y, topo_map, grid, 0, visited)
    visited["#{end_x}:#{end_y}"]
  end

  def step(x, y, map, grid, steps, visited)
    return visited if !visited["#{x}:#{y}"].nil? && steps >= visited["#{x}:#{y}"]

    visited["#{x}:#{y}"] = steps
    current = map[x][y]
    return visited if current == 27

    grid[x][y] = '#'
    print(grid)

    up = (y - 1 >= 0 ? map[x][y - 1] : 30)
    down = (y + 1 <= map.first.size - 1 ? map[x][y + 1] : 30)
    left = (x - 1 >= 0 ? map[x - 1][y] : 30)
    right = (x + 1 <= map.size - 1 ? map[x + 1][y] : 30)

    visited = step(x, y - 1, map, grid, steps + 1, visited) if up - current < 2 || (current == 25 && up == 27)
    visited = step(x, y + 1, map, grid, steps + 1, visited) if down - current < 2 || (current == 25 && down == 27)
    visited = step(x - 1, y, map, grid, steps + 1, visited) if left - current < 2 || (current == 25 && left == 27)
    visited = step(x + 1, y, map, grid, steps + 1, visited) if right - current < 2 || (current == 25 && right == 27)

    grid[x][y] =
      if map[x][y].zero?
        'S'
      else
        (map[x][y] + 96).chr
      end
    print(grid)
    visited
  end
  

  def print(grid)
    Visualisation.print_grid(
      grid,
      centre_x: 21, centre_y: 35, x_dim: 42, y_dim: 170,
      # sleep: 0.01,
      spacer: ' ',
      colour_char: '#', colour: :red
    )
  end
end

def solution_pt1(input)
  SolutionOne.new.run(input, nil)
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
