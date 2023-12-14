# frozen_string_literal: true

require File.join(__dir__, 'solution')

require 'pry'
require 'awesome_print'

RSpec.describe 'Solutions' do
  let(:example_input) { File.read(File.join(__dir__, 'ie_input')) }
  let(:custom_input) { File.read(File.join(__dir__, 'input')) }

  describe 'Part 1' do
    # --- Day 2: Cube Conundrum ---

    # You're launched high into the atmosphere! The apex of your trajectory just barely reaches the surface of a large island floating in the sky. You gently land in a fluffy pile of leaves. It's quite cold, but you don't see much snow. An Elf runs over to greet you.

    # The Elf explains that you've arrived at Snow Island and apologizes for the lack of snow. He'll be happy to explain the situation, but it's a bit of a walk, so you have some time. They don't get many visitors up here; would you like to play a game in the meantime?

    # As you walk, the Elf shows you a small bag and some cubes which are either red, green, or blue. Each time you play this game, he will hide a secret number of cubes of each color in the bag, and your goal is to figure out information about the number of cubes.

    # To get information, once a bag has been loaded with cubes, the Elf will reach into the bag, grab a handful of random cubes, show them to you, and then put them back in the bag. He'll do this a few times per game.

    # You play several games and record the information from each game (your puzzle input). Each game is listed with its ID number (like the 11 in Game 11: ...) followed by a semicolon-separated list of subsets of cubes that were revealed from the bag (like 3 red, 5 green, 4 blue).

    # For example, the record of a few games might look like this:

    # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    # Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    # Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    # Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    # Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

    # In game 1, three sets of cubes are revealed from the bag (and then put back again). The first set is 3 blue cubes and 4 red cubes; the second set is 1 red cube, 2 green cubes, and 6 blue cubes; the third set is only 2 green cubes.

    # The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?

    # In the example above, games 1, 2, and 5 would have been possible if the bag had been loaded with that configuration. However, game 3 would have been impossible because at one point the Elf showed you 20 red cubes at once; similarly, game 4 would also have been impossible because the Elf showed you 15 blue cubes at once. If you add up the IDs of the games that would have been possible, you get 8.

    # Determine which games would have been possible if the bag had been loaded with only 12 red cubes, 13 green cubes, and 14 blue cubes. What is the sum of the IDs of those games?

    describe 'SubSetTranslator' do
      expectation = { red: 4, green: 0, blue: 3 }
      it 'returns HashMap of cube colours and counts' do
        expect(SubSetTranslator.new(
          '3 blue, 4 red'
        ).call).to eq expectation
      end
    end

    describe 'LineTranslator' do
      context 'with multiple subsets' do
        expectation = { 1 => [{ red: 4, green: 0, blue: 3 },
                              { red: 1, green: 2, blue: 6 },
                              { red: 0, green: 2, blue: 0 }] }

        it 'returns HashMap of cube colours and counts' do
          expect(LineTranslator.new(
            'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green'
          ).call).to eq expectation
        end
      end

      context 'with only 1 subset' do
        expectation = { 2 => [{ red: 4, green: 0, blue: 3 }] }
        it 'returns HashMap of cube colours and counts' do
          expect(LineTranslator.new(
            'Game 2: 3 blue, 4 red'
          ).call).to eq expectation
        end
      end
    end

    describe 'LimitAssessor' do
      it 'returns false if the game over/in the limit' do
        expect(LimitAssessor.new({ red: 12, green: 13, blue: 14 }).call).to eq false
      end

      it 'returns true if the game under the limit' do
        expect(LimitAssessor.new({ red: 11, green: 12, blue: 13 }).call).to eq true
      end
    end

    describe 'final result for pt1' do
      context 'with example input data' do
        it 'returns correct result' do
          pending 'pt1 implementation'
          expect(Solution.new(example_input).solution_pt1).to eq true
        end
      end

      context 'with custom input data' do
        it 'returns correct result' do
          pending 'pt1 implementation'
          expect(Solution.new(custom_input).solution_pt1).to eq true
        end
      end
    end
  end

  describe 'Part 2' do
    #
    # DESCRIPTION Part 2
    #
    context 'example input data' do
      it 'returns correct result' do
        pending 'pt2 implementation'
        expect(Solution.new(example_input).solution_pt2).to eq true
      end
    end

    context 'custom input data' do
      it 'returns correct result' do
        pending 'pt2 implementation'
        expect(Solution.new(custom_input).solution_pt2).to eq true
      end
    end
  end
end
