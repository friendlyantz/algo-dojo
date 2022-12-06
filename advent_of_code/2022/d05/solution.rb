def solution_pt1(input)
  input
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

def separate_inputs(input)
  input.split("\n\n")
end

def translate_to_data_structure(input)
  hash = {}
  input.lines.each do |line|
    line.chars.each_with_index do |c, i|
      next unless ((i - 1) % 4).zero? && c.scan(/[A-Z]/).any?

      i = i / 4 + 1 unless i == 1
      hash[i] ||= []
      hash[i] = hash[i].insert(0, c)
    end
  end
  hash
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
