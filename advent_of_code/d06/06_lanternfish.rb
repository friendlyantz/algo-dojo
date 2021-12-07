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
  attr_accessor :phoned

  @phoned = false
  
  def initialize(life_timer_state)
    # @children = []
    @life_timer_state = life_timer_state
  end

  # def self.inherited(subclass)
  #   puts "creating... #{subclass}"
  #   # @children << subclass
  # end

  def live_one_day
    if @life_timer_state > 0
      @life_timer_state -= 1
      false
    elsif @life_timer_state == 0
      
      reproduce if can_reproduce?
      # binding.pry
      
      # @life_timer_state = 8
    else
      p 'error'
    end

  end

  def reproduce
    reset_timer_after_reproduce
    spawn_a_child
  end
  
  def spawn_a_child
    ap 'spawning...'
    return Mother.new(8)
  end

  def can_reproduce?

    @life_timer_state == 0
    
  end
  
  def reset_timer_after_reproduce
    @life_timer_state = 6
  end
  
  

  def self.phone_kids
    puts "Calling...#{@children}"
    @children.each do |child|
      child.phoned = true
      # binding.pry
    end
  end
end

# class Child < Mother
#   @phoned = false

#   class << self
#     attr_accessor :phoned
#   end

#   def self.phone
#     self.phoned = true
#   end
# end

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
  fish_pool = starter_fish_pool(data)
  18.times do |day|
    puts "After day #{day + 1}"
    fish_pool.each do |fish|
      
      # binding.pry
      
     spawn = fish.live_one_day
      
      ap spawn if spawn
      
      fish_pool << spawn if spawn
    end
    ap fish_pool.size
    puts "---------SUNSET----------"
  end
end

main_sequence(CAL_DATA)
