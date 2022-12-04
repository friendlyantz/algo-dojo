require_relative '08_data'
require 'pry'
require 'awesome_print'

def main_sequence(data)
  array_of_lines = raw_data_process(data)
  num_of_decoced_digits_total = 0
  array_of_lines.each do |line|
    num_of_decoced_digits_total += breakdown_each_line(line)
  end
  ap '___________TOTAL______________'
  ap num_of_decoced_digits_total
end

def raw_data_process(data)
  ap ' cleaning data'
  array_of_lines = []
  data.each_line do |entry|
    array_of_lines << entry.strip!
  end
  array_of_lines
end

def map_ten_digits(words_array)
  {}.tap do |hash|
    10.times do |i|
      current_str = words_array[i]
      case current_str.size
      when 2
        hash[1] = current_str
      when 4
        hash[4] = current_str
      when 3
        hash[7] = current_str
      when 7
        hash[8] = current_str
      end
    end
  end
end

def map_four_digits(words_array)
  four_digits_array = []
  4.times do |i|
    four_digits_array << words_array[-4 + i]
  end
  four_digits_array
end

def investigate_single_digit(one_four_seven_eight_hash, tested_digit)
  case tested_digit.size
  when 2
    one_four_seven_eight_hash[1].chars.uniq.sort == tested_digit.chars.sort
  when 4
    one_four_seven_eight_hash[4].chars.uniq.sort == tested_digit.chars.sort
  when 7
    one_four_seven_eight_hash[8].chars.uniq.sort == tested_digit.chars.sort
  when 3
    one_four_seven_eight_hash[7].chars.uniq.sort == tested_digit.chars.sort
  else
    p 'not 1478'
    false
  end
  
end


def investigate_four_digits_for_matches(one_four_seven_eight_hash, four_digits_array)
  num_of_decoced_digits_in_this_line = 0
  four_digits_array.each do |tested_digit|
    puts "testing_digit: #{tested_digit}..."
    num_of_decoced_digits_in_this_line += 1 if investigate_single_digit(one_four_seven_eight_hash, tested_digit)
    p "num_of_decoced_digits_in_this_line: #{num_of_decoced_digits_in_this_line}"
  end

  ap num_of_decoced_digits_in_this_line
  return num_of_decoced_digits_in_this_line
end

def breakdown_each_line(line)
  words_array = line.scan(/\w+/)

  one_four_seven_eight_hash = map_ten_digits(words_array)
  four_digits_array = map_four_digits(words_array)

  num_of_decoced_digits_in_this_line = investigate_four_digits_for_matches(one_four_seven_eight_hash, four_digits_array)
  # _______
end

# main_sequence(CAL_DATA)
main_sequence(BIN_DATA)
