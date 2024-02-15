# frozen_string_literal: true
# Description: Round assessor
class LimitAssessor
  LIMITS = {
    red: 12,
    green: 13,
    blue: 14,
  }.freeze

  def initialize(hash)
    @red = hash[:red]
    @green = hash[:green]
    @blue = hash[:blue]
  end

  def call
    return false if @red > LIMITS[:red]
    return false if @green > LIMITS[:green]
    return false if @blue > LIMITS[:blue]

    true
  end
end
