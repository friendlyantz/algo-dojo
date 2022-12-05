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

def solution_pt1(input)
  input
    .then { |data| prep(data) }
    # .then { |data| binding.pry }
end

def solution_pt2(_input)
  'implementation'
end

def prep(data)
  data.lines.map(&:strip)
end
