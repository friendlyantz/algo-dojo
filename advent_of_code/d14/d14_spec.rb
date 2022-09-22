# frozen_string_literal: true

require_relative 'd14'
require 'pry'

RSpec.describe Polymerization do
  let(:input) do
    <<~HEREDOC
      NNCB

      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> klj
    HEREDOC
  end

  let(:poly) { described_class.new }
  describe 'initialization' do
    it 'initializes the object with correct variables' do
      expect(poly).to be_an_instance_of(described_class)
    end
  end
end
