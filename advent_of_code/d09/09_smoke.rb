require_relative '09_data'
require 'pry'
require 'awesome_print'
require 'matrix'

def generate_mtrix(data)
  matrix = []
  data.each_line do |entry|
    matrix << entry.strip.split('').map(&:to_i)
  end
  matrix
end

def find_low_points(matrix)
  low_points = []
  matrix.each_with_index do |_line, i|
    this_line_low_pts = this_line_scan(matrix[i - 1], matrix[i], matrix[i + 1])
    low_points += this_line_low_pts
  end
  low_points
end

def this_line_scan(above_line, this_line, below_line)
  result = []
  this_line.each_with_index do |char, i|
    prev_char = i != 0 ? this_line[i - 1] : 9
    next_char = this_line[i + 1] || 9
    above_char = above_line ? above_line[i] : 9
    below_char = below_line ? below_line[i] : 9
    surround_chars = [prev_char, above_char, next_char, below_char]

    result << char if char < surround_chars.min
  end
  result
end

def low_points_risk_factor(array_of_low_points)
  array_of_low_points.map! {|el| el += 1}.sum
end
