# frozen_string_literal: true

class Solution
  def initialize(input)
    @input = input
  end

  def solution_pt1
    map = convert_input_to_map
    SymbolLocator
      .new(map)
      .call
      .then { |symbol_coordinates| NumberFinder.new(map, symbol_coordinates).call }
      .sum
  end

  def solution_pt2
    map = convert_input_to_map
    GearLocator
      .new(map)
      .call
      .then { |symbol_coordinates| NumberFinder.new(map, symbol_coordinates, gears: true).call }
      .sum
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

  def convert_input_to_map
    @input
      .lines
      .map(&:strip)
      .map(&:chars)
      .map { |data| data.map { |char| convert(char) } }
  end

  private

  def convert(char)
    case char
    in '.' then nil
    in /\d/ then char.to_i
    in _ then char
    end
  end
end
