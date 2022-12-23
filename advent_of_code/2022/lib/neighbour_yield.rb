module NeighbourYield
  def self.all(data, (i, j))
    yield [i - 1, j] if i > 0 # top
    yield [i - 1, j - 1] if i > 0 && j > 0 # top-left
    yield [i - 1, j + 1] if i > 0 && j < data.first.length - 1 # top-right
    yield [i + 1, j] if i < data.length - 1 # bottom
    yield [i + 1, j - 1] if i < data.length - 1 && j > 0 # bottom-left
    yield [i + 1, j + 1] if i < data.length - 1 && j < data.first.length - 1 # bottom-right
    yield [i, j - 1] if j > 0 # left
    yield [i, j + 1] if j < data.first.length - 1 # right
  end
end
