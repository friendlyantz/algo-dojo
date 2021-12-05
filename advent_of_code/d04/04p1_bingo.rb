require_relative '04_data'
require 'pry'
require 'ap'
# require 'awesome_print'
data = CAL_DATA
drawing_numbers = data.shift.split(',')
card_raw_data = data
class Card
  attr_reader :id, :card_nums
  attr_accessor :line_sums, :col_sums

  def initialize(id, card_nums)
    @id = id
    @card_nums = card_nums

    @line_sums = [0, 0, 0, 0, 0]
    @col_sums = [0, 0, 0, 0, 0]
  end

  def bingo
    puts "Bingo!!! Card with #{id}"
  end

  def bingo_check(_magic_number)
    p 'checking....'
  end
end

class CardNum
  attr_reader :x, :y, :num
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

def assess_cards(array_of_cards, magic_num)
  array_of_cards.each do |card|
    p "assessing card: #{card.id}"
    crossed_card = cross_nums_in_card(card, magic_num)

    5.times do |x|
      5.times do |y|
        this_loop_card_num = crossed_card.card_nums.select do |element|
          element.x == x && element.y == y && element.crossed
        end
        this_loop_card_num = this_loop_card_num.first.num unless this_loop_card_num.empty?

        card.line_sums[x] += 1
        card.col_sums[y] += 1
      end
    end

    # binding.pry

    unless card.col_sums.select { |e| e == 5 }.empty? || card.line_sums.select { |e| e == 5 }.empty?
      puts "bingo!!! YOLOOO. card# #{card.id} won"
      break
    end
  end
end

def cross_nums_in_card(card, magic_num)
  card.card_nums.each do |card_num|
    card_num.cross if card_num.num == magic_num
  end
  card
end

def bingo_check; end

cards = merge_nums_to_cards(card_raw_data)

drawing_numbers.each do |magic_num|
  p magic_num
  assess_cards(cards, magic_num)
end
