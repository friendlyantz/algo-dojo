# frozen_string_literal: true

class Solution
  def initialize(input)
    @input = prep_data(input)
  end

  def solution_pt1
    @input
      .map { |data| [data.keys.first, find_overlap(data.values.first)] }
      .map { |_game_no, data| 2**(data.size - 1) if data.any? }
      .then { |data| data.compact.sum }
  end

  def solution_pt2
    counter = 0
    @input
      .map { |data| [data.keys.first, find_overlap(data.values.first)] }
      .map do |game_no, data|
      recursion(game_no, data, counter)
    end
    .then { |data| binding.pry; data }
  .sum
  end

  private

  def recursion(game_no, data, counter)
    # PRE
    return 0 unless data.any?

    original_card_count = 1
    games_unlocked = (game_no + 1..game_no + data.size).to_a

    # REC
    recursion_counter = games_unlocked.map do |game_no|
      original_card_count += 1
      new_data = find_overlap(
        @input.find { |data|  data[game_no] }&.values&.first
      )

      next unless new_data

      recursion(game_no, new_data, counter)
    rescue
      binding.pry
    end
    binding.pry


    counter += recursion_counter.sum

    # POST
  end

  def prep_data(input)
    input
      .lines
      .map(&:strip)
      .map { |data| { game_number(data) => subsets(data) } }
  end

  def game_number(input)
    input[/Card\s+\d+:\s/][/\d+/].to_i
  end

  def subsets(input)
    substrings = input.sub(/Card\s+\d+: /, '').split('|').map(&:strip)
    substrings.map { _1.split(/\s+/) }
  end

  def find_overlap(two_sets)
    return [] unless two_sets
    two_sets[0] & two_sets[1]
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    raise 'please provide input file destination as an argument following script name when executing this file'
  end

  input = File.read(ARGV.first)
  puts 'part 1 solution'
  puts Solution.new(input).solution_pt1

  puts '==============='
  puts 'part 2 solution'
  puts Solution.new(input).solution_pt2
end
