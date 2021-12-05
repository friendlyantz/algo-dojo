require_relative '04_data'
require 'pry'
require 'ap'
# require 'awesome_print'
data = CAL_DATA
drawing_numbers = data.shift.split(',')
card_raw_data = data
class Card
  attr_reader :id, :card_nums

  def initialize(id, card_nums)
    @id = id
    @card_nums = card_nums
  end

  def bingo
    puts "Bingo!!! Card with #{id}"
  end

  def bingo_check(_magic_number)
    p 'checking....'
  end
end

class CardNum
  attr_accessor :crossed

  def initialize(x, y, num)
    @x = x
    @y = y
    @num = num
    @crossed = false
  end

  def cross
    self.crossed = true
  end
end

def card_num_mapping(numbers)
  array = []
  5.times do |x|
    5.times do |y|
      array << CardNum.new(x, y, numbers.shift)
    end
  end
  array
end

def merge_nums_to_cards(data)
  cards = []
  card_id = 0o01
  until data.empty?
    card_nums = data.shift(25)
    array_of_card_nums = card_num_mapping(card_nums)
    cards << Card.new(card_id, array_of_card_nums)
    card_id += 1
  end
  cards
end

def game_main_sequence(array_of_cards, drawing_numbers)
  drawing_numbers.each do |drawed_number|
    puts "rolling #{drawed_number}"

    assess_cards(array_of_cards, drawed_number)
  end
end

def assess_cards(array_of_cards, _magic_num)
  array_of_cards.each do |card|
    p "assessing card: #{card.id}"
    
    binding.pry
    
  end
end

cards = merge_nums_to_cards(card_raw_data)
assess_cards(cards, 6)
