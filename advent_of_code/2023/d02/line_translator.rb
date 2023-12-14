# Description: Round assessor
class LineTranslator
  def initialize(input)
    @input = input
  end

  def call
    { game_number => subsets }
  end

  private

  def game_number
    @input[/Game (\d+):/, 1].to_i
  end

  def subsets
    substrings = @input.sub(/Game \d+: /, '').split(';').map(&:strip)
    result = []
    substrings.each { |sub| result << SubSetTranslator.new(sub).call }
    result
  end
end
