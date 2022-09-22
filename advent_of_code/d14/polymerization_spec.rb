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
      CN -> C
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
       %w[CN C]]
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

    context 'with two steps specified' do
      before { poly.steps(2) }

      it 'returns NBCCNBBBCBHCB after 1st step' do
        expect(poly.template).to eq 'NBCCNBBBCBHCB'
      end
    end

    context 'with three steps specified' do
      before { poly.steps(3) }

      it 'returns NBBBCNCCNBBNBNBBCHBHHBCHB after 1st step' do
        expect(poly.template).to eq 'NBBBCNCCNBBNBNBBCHBHHBCHB'
      end
    end

    context 'with four steps specified' do
      before { poly.steps(4) }

      it 'returns NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB after 1st step' do
        expect(poly.template).to eq 'NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB'
      end
    end
  end
end
