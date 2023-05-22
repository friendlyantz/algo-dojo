module NeighbourYield
  def self.all(data, (i, j))
    yield [i - 1, j] if i > 0 # top
    yield [i + 1, j] if i < data.length - 1 # bottom
    yield [i, j - 1] if j > 0 # left
    yield [i, j + 1] if j < data.first.length - 1 # right
  end
end
