require_relative '09_data'
require 'pry'
require 'awesome_print'
require 'matrix'

def generate_mtrix(data)
  matrix = []
  data.each_line do |entry|
    matrix << entry.strip.chars.map(&:to_i)
  end
  matrix
end

def find_low_points(matrix)
  low_points = []
  matrix.each_with_index do |_line, y|
    this_line_low_pts = case y
                        when 0
                          this_line_scan(nil, matrix[y], matrix[y + 1], y)[:array_of_low_pts]
                        else
                          this_line_scan(matrix[y - 1], matrix[y], matrix[y + 1], y)[:array_of_low_pts]
                        end
    low_points += this_line_low_pts
  end
  low_points
end

def this_line_scan(above_line, this_line, below_line, y = nil)
  array_of_low_pts = []
  array_of_low_pts_x_y = []
  this_line.each_with_index do |char, x|
    prev_char = x != 0 ? this_line[x - 1] : 9
    next_char = this_line[x + 1] || 9
    above_char = above_line ? above_line[x] : 9
    below_char = below_line ? below_line[x] : 9
    surround_chars = [prev_char, above_char, next_char, below_char]

    if char < surround_chars.min
      array_of_low_pts << char
      array_of_low_pts_x_y << [x, y]
    end
  end

  { array_of_low_pts: array_of_low_pts,
    array_of_low_pts_x_y: array_of_low_pts_x_y }
end

def low_points_risk_factor(array_of_low_points)
  array_of_low_points.map! { |el| el += 1 }.sum
end

def main_sequence_pt1(data)
  matrix = generate_mtrix(data)
  low_points = find_low_points(matrix)
  low_points_risk_factor(low_points)
end

# =========
def find_low_points_coord(matrix)
  low_points = []
  matrix.each_with_index do |_line, y|
    this_line_low_pts_coordinates = case y
                                    when 0
                                      this_line_scan(nil, matrix[y], matrix[y + 1], y)[:array_of_low_pts_x_y]
                                    else
                                      this_line_scan(matrix[y - 1], matrix[y], matrix[y + 1], y)[:array_of_low_pts_x_y]
                                    end
    low_points += this_line_low_pts_coordinates
  end
  low_points
end

def find_pool_coords(_bottom_coord, _matrix)
  check_left
  check
end

def main_sequence_pt2(data)
  matrix = generate_mtrix(data)
  low_points = find_low_points_coord(matrix)

  binding.pry
end

ap main_sequence_pt1(BIN_DATA)
