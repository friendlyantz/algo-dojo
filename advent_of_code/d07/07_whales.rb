require_relative '07_data'
require 'pry'
require 'awesome_print'

def main_sequence(crabs)
  table_of_fuel_tests = []
  crabs.length.times do |i|
    p "--------------------running test # #{i+1}--------------------"
    fuel_consumed_this_test = 0
    crabs.each do |crab|
      diff = [crab, i].max - [crab, i].min
      puts "Move from #{crab} to #{i}. cost of fuel: #{diff}"
      fuel_consumed_this_test += diff
      ap "fuel_consumed_this_test: #{fuel_consumed_this_test}"
    end 
    table_of_fuel_tests << fuel_consumed_this_test
  end
  ap table_of_fuel_tests.min
end

main_sequence(BIN_DATA)
