# frozen_string_literal: true

# --- Day 15: Chiton ---
#
# You've almost reached the exit of the cave, but the walls are
# getting closer together. Your submarine can barely still fit,
# though; the main problem is that the walls of the cave are covered
# in chitons, and it would be best not to bump any of them.
#
# The cavern is large, but has a very low ceiling, restricting your
# motion to two dimensions. The shape of the cavern resembles a
# square; a quick scan of chiton density produces a map of risk level
# throughout the cave (your puzzle input). For example:
#
# 1163751742
# 1381373672
# 2136511328
# 3694931569
# 7463417111
# 1319128137
# 1359912421
# 3125421639
# 1293138521
# 2311944581
#
# You start in the top left position, your destination is the bottom
# right position, and you cannot move diagonally. The number at each
# position is its risk level; to determine the total risk of an entire
# path, add up the risk levels of each position you enter (that is,
# don't count the risk level of your starting position unless you
# enter it; leaving it adds no risk to your total).
#
# Your goal is to find a path with the lowest total risk. In this
# example, a path with the lowest total risk is highlighted here:
#
# 1163751742
# 1381373672
# 2136511328
# 3694931569
# 7463417111
# 1319128137
# 1359912421
# 3125421639
# 1293138521
# 2311944581
#
# The total risk of this path is 40 (the starting position is never entered, so its risk is not counted).
#
# What is the lowest total risk of any path from the top left to the bottom right?
class Chiton
  attr_reader :map, :nodes

  def initialize(input)
    @map = input.split.map { _1.split('').map(&:to_i) }
    @nodes = {}
    list_nodes
    @min_risk_score = 999
  end

  def filter_paths
    path = []
    build_paths
      .flatten.compact
      .each_slice(2).to_a
      .chunk { _1.eql?(['#', '#']) }
      .each do |_eql, arr|
        next if arr == [['#', '#']]

        path << arr
      end
    path
  end

  def map_paths(paths)
    paths.map do |path|
      map_path(path)
    end
  end

  def map_path(path)
    path.map do |i|
      map[i.first][i.last]
    end
  end

  def calc_paths(paths)
    map_paths(paths).map(&:sum)
  end

  def calc_path(path)
    map_path(path).sum
  end

  def calc_risk(key)
    map[key.first][key.last]
  end

  def solve_puzzle_one
    filter_paths
      .then { |data| calc_paths(data) }
      .then { |data| data.min + @map[-1][-1] - @map[0][0] }
  end

  private

  def list_nodes
    map.each_with_index do |line, i|
      line.each_with_index do |_char, j|
        nodes[[i, j]] ||= []
        # top
        # nodes[[i, j]] << [i - 1, j] if i > 0
        # bottom
        nodes[[i, j]] << [i + 1, j] if i < @map.length - 1
        # left
        # nodes[[i, j]] << [i, j - 1] if j > 0
        # right
        nodes[[i, j]] << [i, j + 1] if j < @map.first.length - 1
      end
    end
  end

  def build_paths(key = [0, 0], path_so_far = [], risk = 0)
    risk += calc_risk(key)
    return nil if risk >= @min_risk_score

    if key == [@map.first.size - 1, @map.size - 1]
      @min_risk_score = risk if risk < @min_risk_score
      return path_so_far + ['#', '#']
    end

    connections = nodes[key]

    connections.map do |name|
      next if name == [0, 0]
      next if path_so_far.include?(name)

      build_paths(name, path_so_far + [key], risk)
    end
  end
end
if __FILE__ == $PROGRAM_NAME
  input = File.read(ARGV.first)
  object = Chiton.new(input)
  puts 'Puzzle One solution'
  puts object.dup.solve_puzzle_one
end
