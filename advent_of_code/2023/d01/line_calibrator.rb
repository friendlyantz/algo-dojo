# frozen_string_literal: true

# scans lines for digits
class LineCalibrator
  NUMS = %w[
    one two three four five six seven eight nine
  ].freeze

  def initialize(line)
    @line = line
    @char_one = nil
    @char_two = nil
  end

  def call
    find_first_digit
    find_second_digit
    (@char_one + @char_two).to_i
  end

  def call_two
    nums = []
    @line.size.times do |i|
      nums << (@line[i..]).match(/#{NUMS.join('|')}|\d/, 0)
    end
    nums.delete nil
    @char_one = nums.first[0]
    @char_one = NUMS.index(@char_one).next.to_s if NUMS.index(@char_one)
    @char_two = nums.last[0]
    @char_two = NUMS.index(@char_two).next.to_s if NUMS.index(@char_two)

    (@char_one + @char_two).to_i
  end

  private

  def find_first_digit
    @line.chars do |char|
      if @char_one.nil? && char.match?(/\d/)
        @char_one = char
        true
      end
    end
  end

  def find_second_digit
    @line.reverse.chars do |char|
      if @char_two.nil? && char.match?(/\d/)
        @char_two = char
        break
      end
    end
  end
end
