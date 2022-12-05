require_relative '08_data'
require_relative '08p2_seven_digit_map'
require 'pry'
require 'awesome_print'

def main_sequence(data)
  array_of_lines = raw_data_process(data)
  num_of_decoced_digits_total = 0
  sum = 0
  array_of_lines.each do |line|
    sum += breakdown_each_line(line)
  end
  ap sum
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
  seven_digit_map = SevenDigitMap.new

  ten_codes_sorted_by_code_length = words_array[0, 10].sort_by(&:size)
  seven_digit_map.decypher(ten_codes_sorted_by_code_length)
  seven_digit_map
end

def grab_four_encoded_digits(words_array)
  four_digits_array = []
  4.times do |i|
    four_digits_array << words_array[-4 + i]
  end
  four_digits_array
end

def breakdown_each_line(line)
  words_array = line.scan(/\w+/)

  seven_digit_map = map_ten_digits(words_array)
  ap sum = seven_digit_map.decode_message(words_array[-4, 4])
  sum
end

main_sequence(CAL_DATA)
