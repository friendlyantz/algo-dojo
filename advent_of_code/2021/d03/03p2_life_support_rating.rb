require_relative '03_data'
require_relative '03p1_bin_diagnostic'
require 'pry'

def life_support_rating(oxygen_generator_rating, co2_scrubber_rating)
  oxygen_generator_rating * co2_scrubber_rating
end

def filter_run(data, bit_criteria, curren_col_id)
  filtered_data = []

  data.each do |_row|
    case bit_criteria
    when 'oxy'
      bit_hash = column_extraction(data, curren_col_id)
      filtered_data << _row if _row[curren_col_id] == most_common_bit(bit_hash, bit_criteria)
    when 'co2'
      # TODO
      bit_hash = column_extraction(data, curren_col_id)
      filtered_data << _row if _row[curren_col_id] != most_common_bit(bit_hash, bit_criteria)
    else
      puts 'error'
    end
  end

  filtered_data
end

def method_name; end

def filtering(data, bit_criteria)
  counter = data.length
  curren_col_id = 0
  loop do
    return puts 'time elapsed' if counter.zero?

    counter -= 1
    data = filter_run(data, bit_criteria, curren_col_id)
    curren_col_id += 1

    break if data.length == 1
  end
  puts "dec filtered result for #{bit_criteria}: #{data.first.to_i(2)}"
  data.first.to_i(2)
end

oxy = filtering(BIN_DATA, 'oxy')
co2 = filtering(BIN_DATA, 'co2')
p life_support_rating(oxy, co2)
