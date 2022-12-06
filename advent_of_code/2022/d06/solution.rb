def solution_pt1(input)
  input
    .chomp
    .then { |data| find_packets(data) }
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

def find_packets(data)
  int = 0
  stack = ''
  data.chars.each_with_index do |char, i|
    stack = stack[1..-1] if stack.size.eql?(4)
    stack << char

    if stack.chars.uniq.size.eql? 4
      int = i + 1
      break
    end
  end
  int
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
