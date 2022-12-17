require File.join(__dir__, '../lib/my_colorize')
require 'pry'

include MyColorize

def solution_pt1(input)
  input
    .then { |data| prep_data(data) }
    .then { |data| cycle_through_instructions(data) }
    .then { |_data| array_of_signals.sum }
end

def solution_pt2(input)
  input
    .then { |data| prep_data(data) }
    .then { |data| cycle_through_instructions(data) }
    .then { colorize_to_terminal }
end

def colorize_to_terminal
  MyColorize.print_out crt
  'see terminal render'
end

def x_register_inc(arg)
  @x_register += arg
end

def crt
  @crt ||= generate_crt
end

def generate_crt
  a = []
  6.times do
    a << Array.new(40, 0)
  end
  a
end

def cycle_count_inc(arg)
  @cycle_count += arg
  set_line_and_column
  check_cycle_for_pt1

  render_pixel
end

def render_pixel
  crt[line_num][column_num] = if cycle_matches_pixel_range?
                                8
                              else
                                1
                              end
end

def cycle_matches_pixel_range?
  [column_num - 1, column_num, column_num + 1].include? @x_register
end

def set_line_and_column
  if [0, 40, 80, 120, 160, 200].map(&:next).index(@cycle_count)
    @line_num = [0, 40, 80, 120, 160, 200].map(&:next).index(@cycle_count)
    @column_num_offset = 40 * @line_num
  end
end

def line_num
  @line_num ||= 0
end

def column_num
  result = @cycle_count - @column_num_offset - 1
  result >= 0 ? result : 0
end

def check_cycle_for_pt1
  array_of_signals << @cycle_count * @x_register if [20, 60, 100, 140, 180, 220].include?(@cycle_count)
end

def array_of_signals # rubocop:disable Style/TrivialAccessors
  @array_of_signals
end

def cycle_through_instructions(data)
  @cycle_count = 0
  @x_register = 1
  @array_of_signals = []
  data
    .each_with_index do |arg, _i|
    if arg == 0
      cycle_count_inc(1)
      next
    end

    increment_x_reg(arg)
  end
  nil
end

def increment_x_reg(arg)
  cycle_count_inc(1)
  cycle_count_inc(1)
  x_register_inc(arg)
end

def prep_data(data)
  data.lines.map(&:chomp).map do |line|
    line == 'noop' ? 0 : line.split.last.to_i
  end
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
