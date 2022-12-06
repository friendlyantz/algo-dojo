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
  stack = ''
  data.chars.each_with_index do |char, i|
    stack = stack[1..-1] if stack.size.eql?(packet_size)
    stack << char

    return i + 1 if stack.chars.uniq.size.eql? packet_size
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
