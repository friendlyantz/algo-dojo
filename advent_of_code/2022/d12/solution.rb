def solution_pt1(input)
  # input
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

class Hill
  attr_reader :map, :start, :end

  def initialize(map:, start_pos:, end_pos:)
    @map = map
    @start = start_pos
    @end = end_pos
  end
end

def hill
  @hill
end

def prep_data(input)
  buffer = []
  input
    .lines
    .map(&:strip)
    .each_with_index do |line, i|
      buffer << line.split('')
      @start_pos = [i, find_start_column(line)] if find_start_column(line)
      @end_pos = [i, find_end_column(line)] if find_end_column(line)
    end
  @hill = Hill.new(
    map: buffer,
    start_pos: @start_pos,
    end_pos: @end_pos
  )
end

def find_start_column(line)
  line.index('S')
end

def find_end_column(line)
  line.index('E')
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
