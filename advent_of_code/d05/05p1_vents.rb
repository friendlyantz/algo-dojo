require_relative '05_data'
require 'pry'
require 'awesome_print'

class VentMap
  attr_reader :map_points

  def initialize
    @map_points = []
  end

  def find_on_map_and_mark(x, y)
    point = map_points.find { |pt| pt.x == x && pt.y == y }

    if point
      point.mark
    else
      map_points << MapPoint.new(x, y)
    end
  end

  def find_overlaps
    ap selection = map_points.select { |pt| pt.overlap_stat > 1 }
    ap selection.length
  end
end

class MapPoint
  attr_reader :x, :y
  attr_accessor :overlap_stat

  def initialize(x, y)
    @x = x
    @y = y
    @overlap_stat = 1
  end

  def mark
    self.overlap_stat += 1
    "mappont marked x: #{x}, y: #{y},overlap_stat: #{overlap_stat} "
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
    coord = line.scan(/\d+/)
    filtered_array << coord.map(&:to_i) if coord[0] == coord[2] || coord[1] == coord[3]
  end
  filtered_array
end

# def filter_horiz_vert_and_dia_lines(data)
#   filtered_array = []
#   data.each do |line|
#     coord = line.scan(/\d+/).map(&:to_i)
#     filtered_array << coord.map(&:to_i) if coord[0] == coord[2] || coord[1] == coord[3] || diagonal_check(coord)
#   end
#   filtered_array
# end

def convert_to_i(data)
  data.map do |line|
    line.scan(/\d+/).map!(&:to_i)
  end
end

def diagonal_check(coord)
  x_pair = [coord[0], coord[2]]
  y_pair = [coord[1], coord[3]]

  x_pair.max - x_pair.min == y_pair.max - y_pair.min
end

def horizontal_mapping(coord, vent_map)
  p coord
  y = coord[1]
  x = coord[0]
  x_stop = coord[2]
  if operator = x_stop <=> x
    length = [x_stop, x].max - [x_stop, x].min + 1
    length.times do
      vent_map.find_on_map_and_mark(x, y)
      x += operator
    end
  else
    raise 'cant determine direction for hor mapping'
  end
end

def vertical_mapping(coord, vent_map)
  p coord
  x = coord[0]
  y_coord = coord[1]
  y_stop = coord[3]
  if operator = y_stop <=> y_coord
    length = [y_stop, y_coord].max - [y_stop, y_coord].min + 1
    length.times do
      vent_map.find_on_map_and_mark(x, y_coord)
      y_coord += operator
    end
  else
    raise 'cant determine direction'
  end
end

def mark_points(line_data, vent_map)
  line_data.each do |coord|
    if coord[1] == coord[3]
      p 'mapping horizontal'
      horizontal_mapping(coord, vent_map)
    elsif coord[0] == coord[2]
      p 'mapping vertical'
      vertical_mapping(coord, vent_map)
    elsif diagonal_check(coord)
      p 'mapping dia'
      # TODO
      # vertical_mapping(coord, vent_map)
    else
      puts 'error, no case found----------------'
    end
  end
end

def main_sequence(raw_data)
  vent_map = VentMap.new
  data = raw_data_preparation(raw_data)
  # processed_data = filter_horiz_vert_lines(data)
  # processed_data = filter_horiz_vert_and_dia_lines(data)
  processed_data = convert_to_i(data)
  mark_points(processed_data, vent_map)
  vent_map.find_overlaps
end

# main_sequence(CAL_DATA)
main_sequence(BIN_DATA)
