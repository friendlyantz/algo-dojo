# frozen_string_literal: true

module NeighbourYieldLateral
  def self.all(data, (i, j))
    yield [i - 1, j] if i.positive? # top
    yield [i + 1, j] if i < data.length - 1 # bottom
    yield [i, j - 1] if j.positive? # left
    yield [i, j + 1] if j < data.first.length - 1 # right
  end
end
