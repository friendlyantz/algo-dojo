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
    ap map_points.select { |pt| pt.overlap_stat > 1 }
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

def line_direction_check(coord)
  if coord[0] == coord[2]
    'vertical'
  elsif coord[1] == coord[3]
    'horizontal'
  else
    puts 'error'
  end
end

def horizontal_mapping(coord, vent_map)
  p coord
  y = coord[1]
  x = coord[0]
  x_stop = coord[2]
  if x < x_stop
    length = x_stop - x + 1
    p '➡️ - right'
    length.times do
      vent_map.find_on_map_and_mark(x, y)
      x += 1
    end
  elsif x > x_stop
    length = x - x_stop + 1
    p '⬅️ - left'

    length.times do
      vent_map.find_on_map_and_mark(x, y)
      x -= 1
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
  if y_coord < y_stop
    length = y_stop - y_coord + 1
    p '⬇️ - descending, depth ++'
    length.times do
      vent_map.find_on_map_and_mark(x, y_coord)
      y_coord += 1
    end
  elsif y_coord > y_stop
    length = y_coord - y_stop + 1
    p '⬆️ - ascending, depth --'
    length.times do
      vent_map.find_on_map_and_mark(x, y_coord)
      y_coord -= 1
    end
  else
    raise 'cant determine direction'
  end
end

def mark_points(line_data, vent_map)
  line_data.each do |line|
    case line_direction_check(line)
    when 'horizontal'
      p 'mapping horizontal'
      horizontal_mapping(line, vent_map)
    when 'vertical'
      p 'mapping vertical'
      vertical_mapping(line, vent_map)
    else
      p 'error'
    end
  end
end

def main_sequence(raw_data)
  vent_map = VentMap.new
  data = raw_data_preparation(raw_data)
  processed_data = filter_horiz_vert_lines(data)
  mark_points(processed_data, vent_map)
  vent_map.find_overlaps
end

# main_sequence(CAL_DATA)
main_sequence(BIN_DATA)
