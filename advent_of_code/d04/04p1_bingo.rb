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

  def cross_nums_in_card(magic_num)
    card_nums.each do |card_num|
      if card_num.num == magic_num
        p card_num
        p "xxxxxx ---> crossing #{magic_num}" if card_num.cross
      end
    end
    self
  end

  def bingo_check(magic_num)
    if line_sums.include?(5) || col_sums.include?(5)
      puts '________________________________'
      puts "bingo!!! YOLOOO. card# #{id} won. magic num was: #{magic_num}"
      puts '________________________________'
    end
  end

  def update_line_and_col_sum_trackers(_magic_number)
    5.times do |x|
      5.times do |y|
        this_loop_card_num = card_nums.select do |element|
          element.x == x && element.y == y && element.crossed
        end

        next if this_loop_card_num.empty?

        # puts "looping x: #{x}, y: #{y}"

        # binding.pry

        # TODO: double up calc issue
        # binding.pry
        line_sums[x] += 1
        col_sums[y] += 1
      end
    end

    # binding.pry
    p line_sums
    p col_sums
    # break
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

def assess_cards(array_of_cards, magic_num)
  array_of_cards.each do |card|
    p "assessing card: #{card.id}"
    card.cross_nums_in_card(magic_num)

    card.update_line_and_col_sum_trackers(magic_num)

    card.bingo_check(magic_num)
  end
end

def game_main_sequence(array_of_cards, drawing_numbers)
  drawing_numbers.each do |drawed_number|
    puts '~~~~~~~~~~~~~~~~~~~~~~~~'
    puts "rolling #{drawed_number}"

    assess_cards(array_of_cards, drawed_number)
  end
end

cards = merge_nums_to_cards(card_raw_data)

game_main_sequence(cards, drawing_numbers)
