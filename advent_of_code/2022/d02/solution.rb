SHAPE_WEIGHT = {
  rock: 1,
  paper: 2,
  scissors: 3
}

OUTCOME_WEIGHT = {
  loss: 0,
  draw: 3,
  win: 6
}

OPPONENT_HAND_MAPPING = {
  'A' => :rock,
  'B' => :paper,
  'C' => :scissors
}

OUR_HAND_MAPPING = {
  'X' => :rock,
  'Y' => :paper,
  'Z' => :scissors
}

OUR_STRATEGY_MAPPING = {
  'X' => :loss,
  'Y' => :draw,
  'Z' => :win
}

RULES = {
  rock: {
    rock: :draw,
    paper: :loss,
    scissors: :win
  },
  paper: {
    rock: :win,
    paper: :draw,
    scissors: :loss
  },
  scissors: {
    rock: :loss,
    paper: :win,
    scissors: :draw
  }
}

def solution_pt1(input)
  input
    .then { |data| prep(data) }
    .map { |data| calc_round_outcome(data) }
    .then { |data| data.sum }
end

def solution_pt2(input)
  input
    .then { |data| prep(data) }
    .map { |data| calc_round_outcome_pt2(data) }
    .then { |data| data.sum }
end

def prep(data)
  data.lines
      .map(&:strip)
      .map(&:split)
end

def calc_round_outcome(data)
  SHAPE_WEIGHT[OUR_HAND_MAPPING[data.last]] + OUTCOME_WEIGHT[win_loss_or_draw?(data)]
end

def win_loss_or_draw?(data)
  opponent_hand = OPPONENT_HAND_MAPPING[data.first]
  our_hand = OUR_HAND_MAPPING[data.last]
  RULES[our_hand][opponent_hand]
end

def calc_round_outcome_pt2(data)
  SHAPE_WEIGHT[our_hand_to_play(data)] + OUTCOME_WEIGHT[do_we_need_to_loose_win_or_draw?(data)]
end

def do_we_need_to_loose_win_or_draw?(data)
  OUR_STRATEGY_MAPPING[data.last]
end

def our_hand_to_play(data)
  opponent_hand = OPPONENT_HAND_MAPPING[data.first]
  our_strategy = OUR_STRATEGY_MAPPING[data.last]
  RULES.find do |_k, v|
    v[opponent_hand] == our_strategy
  end.first
end

if __FILE__ == $PROGRAM_NAME
  raise 'please provide input file destination' if ARGV.empty?

  input = File.read(ARGV.first)
  puts 'part 1 solution'
  puts solution_pt1(input)

  puts '==============='
  puts 'part 2 solution'
  puts solution_pt2(input)
end
