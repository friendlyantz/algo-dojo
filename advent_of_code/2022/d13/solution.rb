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
      packet.first
            .zip(packet.last)
            .each do |pair|
              pairs[packet] = ordered?(pair) ? true : false
            end
    end
  end

  def ordered?(pair)
    return compare_integers(pair) if pair.first.is_a?(Integer) && pair.last.is_a?(Integer)

    pair[0] = [pair.first] if pair.first.is_a?(Integer) && pair.last.is_a?(Array)
    pair[1] = [pair.last] if pair.first.is_a?(Array) && pair.last.is_a?(Integer)
    return compare_arrays(pair) if pair.first.is_a?(Array) && pair.last.is_a?(Array)
  end

  def compare_arrays(pair)
    pair.first.each do |integer|
      pair.last.each do |integer2|
        next if integer <= integer2

        return false
      end
    end
  end

  def compare_integers(pair)
    return false unless pair.first <= pair.last

    true
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
