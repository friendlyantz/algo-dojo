require File.join(__dir__, '../lib/colorize')
include MyColorize

def solution_pt1(input)
  # input
  # .then { |data| generate_map(data) }
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

def generate_map(data)
  data.lines.map do |line|
    line.chars.map do |n|
      {
        value: n.to_i,
        visible?: false
      }
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    raise 'please provide input file destination as an argument following script name when executing this file'
  end

  input = File.read(ARGV.first)
  MyColorize.print_out(
    generate_map(input)
    .map { _1.map { |i| i[:value] } }
  )
  puts 'part 1 solution'
  puts solution_pt1(input)

  puts '==============='
  puts 'part 2 solution'
  puts solution_pt2(input)
end
