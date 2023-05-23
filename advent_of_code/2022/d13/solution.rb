require 'pry'
def solution_pt1(input)
  # input
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

class DistressSignal
  attr_reader :pairs

  def initialize(input)
    prep_data input
  end

  def prep_data(input)
    @pairs = {}
    a = input
        .split("\n\n")
        .map { |line| @pairs[line.split("\n").map { |i| i[1..-2].split(',') }] = nil }
  end

  def validate
    pairs.each_pair.map do |packet, ordered|
      packet.first
            .zip(packet.last)
            .each do |pair|
              break unless compare(pair)

              pairs[packet] = true
            end
    end
  end

  def compare(pair)
    return true if pair.first == pair.last
    return true if pair.first > pair.last

    false
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
