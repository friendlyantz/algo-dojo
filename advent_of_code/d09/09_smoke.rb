require_relative '09_data'
require 'pry'
require 'awesome_print'


def data_prep(data)
  array_of_lines = []
  data.each_line do |entry|
    array_of_lines << entry.strip!.to_i
  end
  array_of_lines
end

def main_sequence(data)
  
end