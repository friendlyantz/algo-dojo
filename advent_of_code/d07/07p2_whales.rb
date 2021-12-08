require_relative '07_data'
require 'pry'
require 'awesome_print'

def main_sequence(crabs)
  table_of_fuel_tests = []
  crabs.length.times do |i|
    p "--------------------running test for pos# #{i}--------------------"
    fuel_consumed_this_test = 0
    crabs.each do |crab|
      operator = i <=> crab
      crab_fuel = 0
      distance = [crab, i].max - [crab, i].min
      case operator
      when 1
        # crab pos smaller
        distance.times do |booster|
          crab_fuel += booster + 1
        end
      when -1
        distance.times do |booster|
          crab_fuel += booster + 1
        end
        # crab pos larger
      when 0
        ap 'no fuel consumed'
      else
        p 'error with operator'
      end
      # puts "Move from #{crab} to #{i}. cost of fuel: #{crab_fuel}"
      fuel_consumed_this_test += crab_fuel
    end
    ap "fuel_consumed_this_test: #{fuel_consumed_this_test}"
    table_of_fuel_tests << fuel_consumed_this_test
  end
  ap table_of_fuel_tests.min
end

main_sequence(BIN_DATA)
