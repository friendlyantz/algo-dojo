require File.join(__dir__, '../lib/colorize')

include MyColorize

def solution_pt1(input)
  # input
  # .then { |data| generate_map(data) }
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

class TreeMap
  attr_reader :matrix

  def initialize(data)
    @matrix = generate_map(data)
  end

  def generate_map(data)
    data.lines.map do |line|
      line.chars.map do |n|
        {
          value: n.to_i,
          visible?: false
        }
      end
    end
  end
end

def scan_horizontally(_matrix, _line_num)
  scan_left
  # scan right
end

def scan_left(tree_map, line_num)
  stack = []
  max_height = hight_of_the_tallest_tree_in_line(tree_map.matrix[line_num])
  tree_map.matrix[line_num]
          .each_cons(2)
          .with_index do |(prev_cell, next_cell), i|
    if (stack.max || 0).eql?(max_height) && (stack.max || 0) >= next_cell[:value]
      prev_cell[:visible?] = true
      return tree_map
    end

    stack << next_cell[:value]
    stack << prev_cell[:value] if i.eql? 0
  end
end


def scan_right(tree_map, line_num)
  stack = []
  max_height = hight_of_the_tallest_tree_in_line(tree_map.matrix[line_num])
  tree_map.matrix[line_num].reverse
          .each_cons(2)
          .with_index do |(prev_cell, next_cell), i|
    if (stack.max || 0).eql?(max_height) && (stack.max || 0) >= next_cell[:value]
      prev_cell[:visible?] = true
      return tree_map
    end

    stack << next_cell[:value]
    stack << prev_cell[:value] if i.eql? 0
  end
end

def hight_of_the_tallest_tree_in_line(line)
  line.map { _1[:value] }.max
end
if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    raise 'please provide input file destination as an argument following script name when executing this file'
  end

  input = File.read(ARGV.first)
  MyColorize.print_out(
    generate_map(input)
    .map { _1.map { |i| i[:value] } }
  )
  puts 'part 1 solution'
  puts solution_pt1(input)

  puts '==============='
  puts 'part 2 solution'
  puts solution_pt2(input)
end
