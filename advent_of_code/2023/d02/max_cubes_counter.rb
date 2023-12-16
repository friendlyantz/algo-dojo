# Description: Round assessor
class MaxCubesCounter
  def initialize(input)
    @input = input

    @counter = {
      red: 0,
      green: 0,
      blue: 0
    }
  end

  def call
    @input.values.first.map do |subsets|
      update_counter(subsets)
    end

    { @input.keys.first => @counter }
  end

  private

  def update_counter(subsets)
    @counter[:red] = subsets[:red] if subsets[:red] > @counter[:red]
    @counter[:green] = subsets[:green] if subsets[:green] > @counter[:green]
    @counter[:blue] = subsets[:blue] if subsets[:blue] > @counter[:blue]
  end
end
