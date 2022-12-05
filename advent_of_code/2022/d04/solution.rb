def solution_pt1(input)
  input
    .lines
    .map { |data| prep(data) }
    .map { |data| full_overlap?(data) }
    .then { |data| data.count true }
end

def solution_pt2(_input)
  'implementation'
end

def prep(input)
  input
    .split(',')
    .map! do |data|
      pair_of_ints = data.split('-').map(&:to_i)
      pair_of_ints.first..pair_of_ints.last
    end
end

def full_overlap?(array_of_ranges)
  range_one = array_of_ranges.map(&:to_a).first
  range_two = array_of_ranges.map(&:to_a).last
  overlap = range_one & range_two
  overlap.eql?(range_one) || overlap.eql?(range_two)
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
