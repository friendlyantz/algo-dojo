def solution_pt1(input)
  input
end

def solution_pt2(_input)
  'implementation'
end

def breakdown_rucksack(input)
  input
    .chars
    .each_slice(input.length / 2)
    .map(&:join)
end

def find_overlaps(item_1, item_2)
  item_1.chars & item_2.chars
end


if __FILE__ == $PROGRAM_NAME
  raise 'please provide input file destination' if ARGV.empty?

  input = File.read(ARGV.first)
  puts 'part 1 solution'
  puts solution_pt1(input)

  puts '==============='
  puts 'part 2 solution'
  puts solution_pt2(input)
end
