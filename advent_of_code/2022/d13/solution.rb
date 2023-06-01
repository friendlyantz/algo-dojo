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
    input
      .split("\n\n")
      .then do |data|
      data.map do |pair|
        p = pair
            .split("\n")
            .map { |string| eval(string) }
        @pairs[p] = nil
      end
    end
  end

  def validate
    pairs.each_pair.map do |packet, _ordered|
      return pairs[packet] = true if packet.first.empty?

      packet.first
            .zip(packet.last)
            .each do |pair|
              pairs[packet] = ordered?(pair) ? true : false
            end
    end
  end

  def ordered?(pair)
    case [pair.first.class, pair.last.class]
    when [Integer, Integer]
      pair.first <= pair.last
    when [Integer, NilClass]
      false
    when [Integer, Array]
      pair[0] = [pair.first]
      ordered?(pair)
    when [Array, Integer]
      pair[1] = [pair.last]
      ordered?(pair)
    when [Array, Array]
      compare_arrays(pair)
    else
      binding.pry # TODO cleanup
    end
  end

  def compare_arrays(pair)
    pair.first.each do |integer|
      pair.last.each do |integer2|
        next if integer <= integer2

        return false
      end
    end
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
