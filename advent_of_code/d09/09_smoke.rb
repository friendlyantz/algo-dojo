require_relative '09_data'
require 'pry'
require 'awesome_print'

def data_prep(data)
  array_of_lines = []
  data.each_line do |entry|
    array_of_lines << entry.strip!.to_i
  end
  array_of_lines
end

def find_low_points(_array_of_lines)
  [1]
end

def low_points_risk_factor(array_of_low_points); end
