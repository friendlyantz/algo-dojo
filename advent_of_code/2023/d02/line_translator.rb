# Description: Round assessor
class LineTranslator
  CUBES = {
    red: 0,
    green: 0,
    blue: 0
  }.freeze

  def initialize(input)
    game_number = input[/Game (\d+):/, 1].to_i
  end

  def call; end
end
