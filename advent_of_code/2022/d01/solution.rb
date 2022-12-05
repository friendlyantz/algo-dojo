def solution_pt1(input)
  input
    .then { |data| prep_and_condense(data) }
    .then { |data| calculate_cals_per_elf(data) }
    .then { |data| p data.max }
end

def solution_pt2(input)
  input
    .then { |data| prep_and_condense(data) }
    .then { |data| calculate_cals_per_elf(data) }
    .then { |data| p data.max(3).sum }
end

def prep_and_condense(data)
  data
    .split("\n\n")
    .map(&:split)
end

def calculate_cals_per_elf(data)
  data
    .map do |set_of_calories|
      set_of_calories.map(&:to_i).sum
    end
end
