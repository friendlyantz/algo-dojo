# Description: Round assessor
class SubSetTranslator
  CUBES = {
    red: 0,
    green: 0,
    blue: 0
  }.freeze

  def initialize(input)
    @input = input
  end

  def call
    @input.split(',').map(&:strip).each_with_object(CUBES.dup) do |cube, hash|
      count, colour = cube.split(' ')
      hash[colour.to_sym] = count.to_i
    end
  end
end
