require_relative '06_data'
require 'pry'
require 'awesome_print'

class Mother
  attr_reader :life_timer_state

  def initialize(life_timer_state)
    @life_timer_state = life_timer_state
  end

  def live_one_day
    if @life_timer_state > 0
      @life_timer_state -= 1
      false
    elsif @life_timer_state == 0
      
      reproduce if @life_timer_state == 0
    else
      p 'error'
    end
  end

  def reproduce
    @life_timer_state = 6
    spawn_a_child
  end
  
  def spawn_a_child
    return Mother.new(9) # FIXME adding 1 to debug / makework
  end
end

def starter_fish_pool(data)
  fish_pool = []
  data.each do |age|
    puts "generating fish"
    fish_pool << Mother.new(age)
  end
  fish_pool
end


def main_sequence(data)
  puts 'lala'
  
  fish_pool = data
  256.times do |day|
    # break if day == 3

    puts "After day #{day + 1}"

    fish_pool.each_with_index do |fish_age, i|
      
        if fish_age > 0
          fish_pool[i] -= 1
        elsif fish_age == 0
          fish_pool[i] = 6
          fish_pool << 9
          
          
        else
          p 'error'
        end
      
    end
    ap fish_pool.size
    puts "---------SUNSET----------"
  end
end

# main_sequence(CAL_DATA)
# main_sequence(BIN_DATA)

# __________________
# inspired by Tom's Solution https://github.com/tomdalling/advent_of_code_2021/blob/main/bin/day6_2.rb

INPUTS = BIN_DATA.tally

def next_gen(gen)
  {}.tap do |wip_hash|
    
    
    zeros_count = gen.fetch(0, 0)
    (1..8).each do |ttl|
      wip_hash[ttl-1] = gen.fetch(ttl, 0)
    end
    binding.pry unless wip_hash.empty?
    # binding.pry
    wip_hash[6] = wip_hash.fetch(6, 0) + zeros_count
    wip_hash[8] = zeros_count
    
  end
end

this_gen = INPUTS
256.times do |idx|
  this_gen = next_gen(this_gen)
end

puts this_gen.values.sum
