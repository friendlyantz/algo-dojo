def solution_pt1(input)
  input
    .split
    .map { |data| breakdown_rucksack(data) }
    .map { |data| find_overlaps(data.first, data.last) }
    .map { |data| data.map { |letter| get_priority_score(letter) } }
    .flatten.sum
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

def get_priority_score(letter)
  map = {}
  'a'.upto('z').each_with_index { |l, i| map[l] = i + 1 }
  'A'.upto('Z').each_with_index { |l, i| map[l] = i + 27 }
  map[letter]
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
