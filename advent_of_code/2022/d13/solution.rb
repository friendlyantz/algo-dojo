require 'pry'

def solution_pt1(input)
  ds = DistressSignal.new(input)

  ds.validate

  sum = 0
  ds.packet_pairs.each.with_index do |hash, i|
    sum += (i + 1) if hash.last
  end
  sum
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

class DistressSignal
  attr_reader :packet_pairs

  def initialize(input)
    prep_data input
  end

  def prep_data(input)
    @packet_pairs = input.split("\n\n").map do |pair|
      p = pair.split("\n").map { |string| eval(string) }
      [p, nil]
    end.to_h
  end

  def validate
    packet_pairs.each_key do |packet|
      if packet.first.empty?
        packet_pairs[packet] = true
        next
      end

      result = nil

      packet.first.zip(packet.last).each do |pair|
        result = ordered?(pair)
        break unless result
      end

      packet_pairs[packet] = result
    end
  end

  def ordered?(pair)
    a, b = pair
    case [a, b]
    in [Integer, Integer]
      a <= b
    in [Integer, NilClass]
      false
    in [Array, NilClass]
      false
    in [Integer, Array]
      ordered?([[a], b])
    in [Array, Integer]
      ordered?([a, [b]])
    in [Array, Array]
      return false if a.any? && b.empty?
      return true if a.empty?

      compare_arrays(a, b)
    else
      binding.pry # TODO:
    end
  end

  def compare_arrays(l, r)
    l = l.dup
    r = r.dup
    result = nil

    while l.any? && r.any?
      a = l.shift
      b = r.shift

      result = ordered?([a, b])
      return false unless result
    end
    result
    # ordered?([l_head, r_head])
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
