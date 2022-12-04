module NeighbourCheck
  def self.all(data, i, j)
    neighbours = []

    neighbours << [i - 1, j] if i > 0 # top
    neighbours << [i - 1, j - 1] if i > 0 && j > 0 # top-left
    neighbours << [i - 1, j + 1] if i > 0 && j < data.first.length - 1 # top-right
    neighbours << [i + 1, j] if i < data.length - 1 # bottom
    neighbours << [i + 1, j - 1] if i < data.length - 1 && j > 0 # bottom-left
    neighbours << [i + 1, j + 1] if i < data.length - 1 && j < data.first.length - 1 # bottom-right
    neighbours << [i, j - 1] if j > 0 # left
    neighbours << [i, j + 1] if j < data.first.length - 1 # right

    neighbours
  end
end
