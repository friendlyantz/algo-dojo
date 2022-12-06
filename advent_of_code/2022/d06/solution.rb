def solution_pt1(input)
  input
    .chomp
    .then { |data| find_packets(data, 4) }
end

def solution_pt2(input)
  input
    .chomp
    .then { |data| find_packets(data, 14) }
end

def find_packets(data, packet_size)
  data
    .chars
    .each_cons(packet_size)
    .with_index
    .find { |chars, i| chars.uniq.length == packet_size }
    .last + packet_size
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
