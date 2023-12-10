# frozen_string_literal: true

module NeighbourCheck
  def self.all(data, i, j)
    neighbours = []

    neighbours << [i - 1, j] if i.positive? # top
    neighbours << [i - 1, j - 1] if i.positive? && j.positive? # top-left
    neighbours << [i - 1, j + 1] if i.positive? && j < data.first.length - 1 # top-right
    neighbours << [i + 1, j] if i < data.length - 1 # bottom
    neighbours << [i + 1, j - 1] if i < data.length - 1 && j.positive? # bottom-left
    neighbours << [i + 1, j + 1] if i < data.length - 1 && j < data.first.length - 1 # bottom-right
    neighbours << [i, j - 1] if j.positive? # left
    neighbours << [i, j + 1] if j < data.first.length - 1 # right

    neighbours
  end
end
