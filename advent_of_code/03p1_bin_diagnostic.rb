require_relative '03_data'
require 'pry'

def power_consumption
  gamma_rate * epsilon_rate
end

def most_common_bit(bit_hash, bit_criteria=nil)
  if bit_hash[:zero_count] < bit_hash[:one_count]
    '1'
  elsif bit_hash[:zero_count] > bit_hash[:one_count]
    '0'
  elsif bit_hash[:zero_count] == bit_hash[:one_count]
    most_common_bit_tie(bit_criteria)
  else
    puts "error in calculating most common bit"
  end
end

def most_common_bit_tie(scenario)
  case scenario
  when 'oxy'
    '1'
  when 'co2'
    '1' # This became redundant since we rely only on most common and opposite
  else
    puts 'ties calc scenario error'
  end
end


def bits_counter(bits_column)
  hash = {
    zero_count: 0,
    one_count: 0
  }

  bits_column.each do |bit|
    case bit
    when '0'
      hash[:zero_count] += 1
    when '1'
      hash[:one_count] += 1
    else
      puts 'error'
    end
  end
  hash
end

def column_extraction(data, column_number)
  bits_column = []
  data.each do |binary_num|
    bits_column.push(binary_num[column_number]) # replace w position
  end
  bits_counter(bits_column)
end

def binary_extraction
  bit_num = ''
  BIN_DATA.first.length.times do |x|
    zeros_and_ones_hash = column_extraction(BIN_DATA, x)
    most_common_bit = most_common_bit(zeros_and_ones_hash)
    bit_num.concat(most_common_bit)
  end
  bit_num
  # binding.pry
end

def gamma_rate_calc
  binary_extraction
end

def epsilon_rate_calc
  replacements = {
    '0' => '1',
    '1' => '0'
  }
  gamma_rate_calc.gsub(Regexp.union(replacements.keys), replacements)
end

p "Gamma rate: #{gamma_rate_calc.to_i(2)}"
p "Epsilon rate: #{epsilon_rate_calc.to_i(2)}"
p "power consumption of the submarine: #{gamma_rate_calc.to_i(2) * epsilon_rate_calc.to_i(2)}"
