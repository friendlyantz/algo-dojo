# frozen_string_literal: true

# scans lines for digits
class LineCalibrator
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

  private

  def find_first_digit
    @line.chars do |char|
      @char_one = char if @char_one.nil? && char.match?(/\d/)
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
