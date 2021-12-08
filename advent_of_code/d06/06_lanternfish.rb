require_relative '06_data'
require 'pry'
require 'awesome_print'

# class Mother
#   def self.phone_kids
#     ObjectSpace.each_object(Class)
#                .select { |klass| klass < self }
#                .each { |descendant| descendant.phone }
#   end
# end

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
    Mother.new(9) # FIXME: adding 1 to debug / makework
  end
end

def starter_fish_pool(data)
  fish_pool = []
  data.each do |age|
    puts 'generating fish'
    fish_pool << Mother.new(age)
  end
  fish_pool
end

def main_sequence(data)
  puts 'lala'
  fish_pool = starter_fish_pool(data)
  80.times do |day|
    puts "After day #{day + 1}"
    fish_pool.each do |fish|
      spawn = fish.live_one_day

      fish_pool << spawn if spawn
    end
    ap fish_pool.size
    puts '---------SUNSET----------'
  end
end

# main_sequence(CAL_DATA)
main_sequence(BIN_DATA)
