# frozen_string_literal: true

# --- Day 14: Extended Polymerization ---
#
# The incredible pressures at this depth are starting to put a strain
# on your submarine. The submarine has polymerization equipment that
# would produce suitable materials to reinforce the submarine, and the
# nearby volcanically-active caves should even have the necessary
# input elements in sufficient quantities.
#
# The submarine manual contains instructions for finding the optimal
# polymer formula; specifically, it offers a polymer template and a
# list of pair insertion rules (your puzzle input). You just need to
# work out what polymer would result after repeating the pair
# insertion process a few times.
#
# For example:
#
# NNCB
#
# CH -> B
# HH -> N
# CB -> H
# NH -> C
# HB -> C
# HC -> B
# HN -> C
# NN -> C
# BH -> H
# NC -> B
# NB -> B
# BN -> B
# BB -> N
# BC -> B
# CC -> N
# CN -> C
#
# The first line is the polymer template - this is the starting point
# of the process.
#
# The following section defines the pair insertion rules. A rule like
# AB -> C means that when elements A and B are immediately adjacent,
# element C should be inserted between them. These insertions all
# happen simultaneously.
#
# So, starting with the polymer template NNCB, the first step simultaneously considers all three pairs:
#
#     The first pair (NN) matches the rule NN -> C, so element C is inserted between the first N and the second N.
#     The second pair (NC) matches the rule NC -> B, so element B is inserted between the N and the C.
#     The third pair (CB) matches the rule CB -> H, so element H is inserted between the C and the B.
#
# Note that these pairs overlap: the second element of one pair is the
# first element of the next pair. Also, because all pairs are
# considered simultaneously, inserted elements are not considered to
# be part of a pair until the next step.
#
# After the first step of this process, the polymer becomes NCNBCHB.
#
# Here are the results of a few steps using the above rules:
#
# Template:     NNCB
# After step 1: NCNBCHB
# After step 2: NBCCNBBBCBHCB
# After step 3: NBBBCNCCNBBNBNBBCHBHHBCHB
# After step 4: NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB
#
# This polymer grows quickly. After step 5, it has length 97; After
# step 10, it has length 3073. After step 10, B occurs 1749 times, C
# occurs 298 times, H occurs 161 times, and N occurs 865 times; taking
# the quantity of the most common element (B, 1749) and subtracting
# the quantity of the least common element (H, 161) produces 1749 -
# 161 = 1588.
#
# Apply 10 steps of pair insertion to the polymer template and find
# the most and least common elements in the result. What do you get if
# you take the quantity of the most common element and subtract the
# quantity of the least common element?
#
require 'ruby-progressbar'

class Polymerization
  attr_reader :template, :rules

  def initialize(input)
    input = input.lines.map(&:chomp)
    @template = input.shift
    input.shift
    @rules = input.map! { _1.split ' -> ' }
  end

  def solve_part_one
    polymerize(10)
  end

  def solve_part_two
    polymerize(40)
  end

  def polymerize(times)
    steps(times)
    @template.split('').tally.values.max - @template.split('').tally.values.min
  end

  def steps(number)
    number.times do
      step
    end
  end

  def step
    find_matching_rules
      .then { |instructions| follow(instructions) }
  end

  def find_matching_rules
    rules.select do |e|
      template.include? e.first
    end
  end

  def follow(instructions)
    progress = ProgressBar.create(total: @template.size + 1, title: 'instruction')
    poly = []
    @template.split('').each_cons(2).with_index do |pair, i|
      if char = instructions.find { _1.first.eql?(pair.join) }.last
        pair.insert(1, char)
      end

      pair.shift unless i.zero?

      progress.increment
      poly << pair
    end
    @template = poly.flatten.join
  end
end

class FastPolymerization < Polymerization
  def initialize(input)
    input = input.lines.map(&:chomp)
    @template = input.shift.split('').each_cons(2).tally
    input.shift
    @rules = input.map! { _1.split ' -> ' }
  end

  def step
    count_matching_rules
      .then { |instructions| follow(instructions) }
  end

  def count_matching_rules
    rules.select do |r|
      if  num = template[r.first.split('')]
        r.size.eql?(3) ? r[2] = num : r << num

      end
    end
  end

  def follow(instructions)
    poly = {}
    @template.each do |k, _v|
      next unless hash_material = instructions.find { _1.first.eql?(k.join) }

      if poly[[k.first, hash_material[1]]]
        poly[[k.first, hash_material[1]]] += hash_material.last
      else
        poly[[k.first, hash_material[1]]] = hash_material.last
      end

      if poly[[hash_material[1], k.last]]
        poly[[hash_material[1], k.last]] += hash_material.last
      else
        poly[[hash_material[1], k.last]] = hash_material.last
      end
    end
    @template = poly
  end

  def polymerize(times)
    steps(times)

    poly = {}
    @template.each_with_index do |hash, i|
      if i.zero?
        poly[hash.first.first] = hash.last
        poly[hash.first.last] = hash.last
      elsif poly[hash.first.last]
        poly[hash.first.last] += hash.last
      else
        poly[hash.first.last] = hash.last
      end
    end

    poly.values.max - poly.values.min
  end
end

if __FILE__ == $0
  input = File.read(ARGV.first)
  poly = Polymerization.new(input)
  puts 'legacy poly'
  puts poly.solve_part_one
  fast_poly = FastPolymerization.new(input)
  puts 'fast poly'
  puts fast_poly.dup.solve_part_one
  puts fast_poly.dup.solve_part_two
end
