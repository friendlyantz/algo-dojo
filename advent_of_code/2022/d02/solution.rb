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

def solution_pt2(_input)
  'implementation'
  # .then { |data| binding.pry }
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
