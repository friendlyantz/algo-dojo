def solution_pt1(input)
  input
  # .then { |data| binding.pry }
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

def separate_commands_with_their_outputs(input)
  input
    .split('$')
    .map(&:lines)[1..-1]
    .map! { |line| line.map(&:chomp) }
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
