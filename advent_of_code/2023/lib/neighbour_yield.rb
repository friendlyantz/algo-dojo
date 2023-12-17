# frozen_string_literal: true

# i - line (y), j - column (x)
module NeighbourYield
  def self.all(data, (i, j))
    yield [i - 1, j] if i.positive? # top
    yield [i - 1, j - 1] if i.positive? && j.positive? # top-left
    yield [i - 1, j + 1] if i.positive? && j < data.first.length - 1 # top-right
    yield [i + 1, j] if i < data.length - 1 # bottom
    yield [i + 1, j - 1] if i < data.length - 1 && j.positive? # bottom-left
    yield [i + 1, j + 1] if i < data.length - 1 && j < data.first.length - 1 # bottom-right
    yield [i, j - 1] if j.positive? # left
    yield [i, j + 1] if j < data.first.length - 1 # right
  end
end
