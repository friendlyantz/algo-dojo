# frozen_string_literal: true

require_relative 'polymerization'
require 'pry'
require 'super_diff/rspec'

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

  let(:poly) { described_class.new(input) }

  describe 'initialization' do
    let(:expected_rules) do
      [%w[CH B],
       %w[HH N],
       %w[CB H],
       %w[NH C],
       %w[HB C],
       %w[HC B],
       %w[HN C],
       %w[NN C],
       %w[BH H],
       %w[NC B],
       %w[NB B],
       %w[BN B],
       %w[BB N],
       %w[BC B],
       %w[CC N],
       %w[CN klj]]
    end

    it 'initializes the object with correct variables' do
      expect(poly).to be_an_instance_of(described_class)
      expect(poly.template).to eq 'NNCB'
      expect(poly.rules).to eq(expected_rules)
    end
  end

  describe 'polymerization' do
    it 'find_matching_rules' do
      expect(poly.find_matching_rules).to eq(
        [%w[CB H], %w[NN C], %w[NC B]]
      )
    end

    context 'with only one step specified' do
      before { poly.step }

      it 'returns NCNBCHB after 1st step' do
        expect(poly.template).to eq 'NCNBCHB'
      end
    end
  end
end
