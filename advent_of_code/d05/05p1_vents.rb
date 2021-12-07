require_relative '05_data'
require 'pry'
require 'ap'

# class VentMap
# end

class MapPoint
  attr_reader :x, :y, :num
  attr_accessor :overlap_stat

  def initialize(x, y)
    @x = x
    @y = y
    @overlap_stat = 0
  end

  def overlap
    return if overlap_stat

    self.overlap_stat += 1
  end
end

def raw_data_preparation(raw_data)
  raw_data = raw_data.split(/\n/)
  raw_data.shift
  data = raw_data.each { |line| line.strip! }
end

def filter_horiz_vert_lines(data)
  filtered_array = []
  data.each do |line|
    coord = line.scan(/\d/)
    filtered_array << coord.map(&:to_i) if coord[0] == coord[2] || coord[1] == coord[3]
  end
  filtered_array
end

def line_direction_check(coord)
  if coord[0] == coord[2]
    'horizontal'
  elsif coord[1] == coord[3]
    'vertical'
  else
    puts 'error'
  end
end

def horizontal_mapping(coord)
  p coord
  x_start = coord[1]
  x_stop = coord[3]
  if x_start < x_stop
    p '⬆️ - ascending'
    10.times do
      if x_start == x_stop
        p "exiting loop. y: #{x_start}"

        break
      end
      p x_start += 1
    end

  elsif x_start > x_stop
    p '⬇️ - descending'
    99.times do
      if x_start == x_stop
        p "exiting loop. y: #{x_start}"

        break
      end
      p x_start -= 1
    end
  else
    raise 'cant determine direction'

  end
  # binding.pry
end

def vertical_mapping(coord); end

def map_points(line_data)
  line_data.each do |line|
    case line_direction_check(line)
    when 'horizontal'
      p 'mapping horizontal'
      horizontal_mapping(line)
    when 'vertical'
      p 'mapping vertical'
      vertical_mapping(line)
    else
      p 'error'
    end
  end
end

def main_sequence(raw_data)
  data = raw_data_preparation(raw_data)
  processed_data = filter_horiz_vert_lines(data)
  array_of_point = map_points(processed_data)
end

main_sequence(CAL_DATA)
