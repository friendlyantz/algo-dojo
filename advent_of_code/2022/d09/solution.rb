require File.join(__dir__, '../lib/my_colorize')

include MyColorize

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
  matrix = Array.new(height) { Array.new(width) }
end
