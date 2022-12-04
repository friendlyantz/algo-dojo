require_relative '07_data'
require 'pry'
require 'awesome_print'

def main_sequence(crabs)
  table_of_fuel_tests = []
  crabs.length.times do |i|
    fuel_consumed_this_test = 0
    crabs.each do |crab|
      crab_fuel = 0
      distance = [crab, i].max - [crab, i].min
      if i != crab
        distance.times do |booster|
          crab_fuel += booster + 1
        end
      end
      fuel_consumed_this_test += crab_fuel
    end
    table_of_fuel_tests << fuel_consumed_this_test
  end
  ap table_of_fuel_tests.min
end

main_sequence(BIN_DATA)
