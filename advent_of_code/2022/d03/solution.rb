def solution_pt1(input)
  input
    .split
    .map { |data| breakdown_rucksack(data) }
    .map { |data| find_overlaps(data) }
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

def find_overlaps(data_array)
  case data_array.size
  when 2
    data_array.first.chars & data_array.last.chars
  when 3
    data_array[0].chars & data_array[1].chars & data_array[2].chars
  end
end

def get_priority_score(letter)
  map = {}
  'a'.upto('z').each_with_index { |l, i| map[l] = i + 1 }
  'A'.upto('Z').each_with_index { |l, i| map[l] = i + 27 }
  map[letter]
end

def separate_into_groups_of_three(input)
  groups = []
  group_buffer = []
  input.split.each_with_index do |line, i|
    group_buffer << line
    if (i + 1) % 3 == 0
      groups << group_buffer
      group_buffer = []
    end
  end

  groups
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
