# frozen_string_literal: true

require File.join(__dir__, 'solution')

require 'pry'
require 'awesome_print'

RSpec.describe 'Solutions' do
  let(:example_input) { File.read(File.join(__dir__, 'data/ie_input')) }
  let(:custom_input) { File.read(File.join(__dir__, 'data/input')) }

  describe 'Part 1' do
    #
    # --- Day 3: Gear Ratios ---

    # You and the Elf eventually reach a gondola lift station; he says the gondola lift will take you up to the water source, but this is as far as he can bring you. You go inside.

    # It doesn't take long to find the gondolas, but there seems to be a problem: they're not moving.

    # "Aaah!"

    # You turn around to see a slightly-greasy Elf with a wrench and a look of surprise. "Sorry, I wasn't expecting anyone! The gondola lift isn't working right now; it'll still be a while before I can fix it." You offer to help.

    # The engineer explains that an engine part seems to be missing from the engine, but nobody can figure out which one. If you can add up all the part numbers in the engine schematic, it should be easy to work out which part is missing.

    # The engine schematic (your puzzle input) consists of a visual representation of the engine. There are lots of numbers and symbols you don't really understand, but apparently any number adjacent to a symbol, even diagonally, is a "part number" and should be included in your sum. (Periods (.) do not count as a symbol.)

    # Here is an example engine schematic:

    # 467..114..
    # ...*......
    # ..35..633.
    # ......#...
    # 617*......
    # .....+.58.
    # ..592.....
    # ......755.
    # ...$.*....
    # .664.598..

    # In this schematic, two numbers are not part numbers because they are not adjacent to a symbol: 114 (top right) and 58 (middle right). Every other number is adjacent to a symbol and so is a part number; their sum is 4361.

    # Of course, the actual engine schematic is much larger. What is the sum of all of the part numbers in the engine schematic?

    describe 'convert_input_to_map' do
      it 'converts single line input to matrix map' do
        expect(Solution.new('467..114..').convert_input_to_map).to eq(
          [[4, 6, 7, nil, nil, 1, 1, 4, nil, nil]],
        )
      end

      it 'converts input to matrix map' do
        expect(Solution.new("467..114..\n...*......\n..35..633.\n").convert_input_to_map).to eq(
          [
            [4, 6, 7, nil, nil, 1, 1, 4, nil, nil],
            [nil, nil, nil, '*', nil, nil, nil, nil, nil, nil],
            [nil, nil, 3, 5, nil, nil, 6, 3, 3, nil],
          ],
        )
      end

      expecation = [
        [4, 6, 7, nil, nil, 1, 1, 4, nil, nil],
        [nil, nil, nil, '*', nil, nil, nil, nil, nil, nil],
        [nil, nil, 3, 5, nil, nil, 6, 3, 3, nil],
        [nil, nil, nil, nil, nil, nil, '#', nil, nil, nil],
        [6, 1, 7, '*', nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, '+', nil, 5, 8, nil],
        [nil, nil, 5, 9, 2, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, 7, 5, 5, nil],
        [nil, nil, nil, '$', nil, '*', nil, nil, nil, nil],
        [nil, 6, 6, 4, nil, 5, 9, 8, nil, nil],
      ]

      it 'converts input to matrix map' do
        expect(Solution.new(example_input).convert_input_to_map).to eq(expecation)
      end
    end

    describe 'SymbolLocator' do
      input =
        [
          [4, 6, 7, nil, nil, 1, 1, 4, nil, nil],
          [nil, nil, nil, '*', nil, nil, nil, nil, nil, nil],
          [nil, nil, 3, 5, nil, nil, 6, 3, 3, nil],
          [nil, nil, nil, nil, nil, nil, '#', nil, nil, nil],
          [6, 1, 7, '*', nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, '+', nil, 5, 8, nil],
          [nil, nil, 5, 9, 2, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, 7, 5, 5, nil],
          [nil, nil, nil, '$', nil, '*', nil, nil, nil, nil],
          [nil, 6, 6, 4, nil, 5, 9, 8, nil, nil],
        ]
      expecation = [
        [1, 3], [3, 6], [4, 3], [5, 5], [8, 3], [8, 5],
      ]
      it 'get coordinates of symbols' do
        expect(SymbolLocator.new(input).call).to eq expecation
      end
    end

    describe 'NumberFinder' do
      context "with simple input (one '*' symbol)" do
        map =
          [
            [4,   6,   7,   nil, nil, 1,   1,   4,   nil, nil],
            [nil, nil, nil, '*', nil, nil, nil, nil, nil, nil],
            [nil, nil, 3,   5,   nil, nil, 6,   3,   3, nil],
          ]

        coordinates = [[1, 3]]
        expecation = [467, 35]
        it 'get coordinates of symbols' do
          expect(NumberFinder.new(map, coordinates).call).to eq expecation
        end
      end

      context 'with multiple symbols input' do
        map = [
          [4, 6, 7, nil, nil, 1, 1, 4, nil, nil],
          [nil, nil, nil, '*', nil, nil, nil, nil, nil, nil],
          [nil, nil, 3, 5, nil, nil, 6, 3, 3, nil],
          [nil, nil, nil, nil, nil, nil, '#', nil, nil, nil],
          [6, 1, 7, '*', nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, '+', nil, 5, 8, nil],
          [nil, nil, 5, 9, 2, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, 7, 5, 5, nil],
          [nil, nil, nil, '$', nil, '*', nil, nil, nil, nil],
          [nil, 6, 6, 4, nil, 5, 9, 8, nil, nil],
        ]

        coordinates = [
          [1, 3], [3, 6], [4, 3], [5, 5], [8, 3], [8, 5],
        ]
        expecation = [467, 35, 633, 617, 592, 664, 755, 598]
        it 'get coordinates of symbols' do
          expect(NumberFinder.new(map, coordinates).call).to eq expecation
        end
      end
    end

    describe 'final result for pt1' do
      context 'with example input data' do
        it 'returns correct result - sum of found numbers' do
          expect(Solution.new(example_input).solution_pt1).to eq 4361
        end
      end

      context 'with custom input data' do
        it 'returns correct result' do
          expect(Solution.new(custom_input).solution_pt1).to eq 520_019
        end
      end
    end
  end

  describe 'Part 2' do
    #
    # --- Part Two ---

    # The engineer finds the missing part and installs it in the engine! As the engine springs to life, you jump in the closest gondola, finally ready to ascend to the water source.

    # You don't seem to be going very fast, though. Maybe something is still wrong? Fortunately, the gondola has a phone labeled "help", so you pick it up and the engineer answers.

    # Before you can explain the situation, she suggests that you look out the window. There stands the engineer, holding a phone in one hand and waving with the other. You're going so slowly that you haven't even left the station. You exit the gondola.

    # The missing part wasn't the only issue - one of the gears in the engine is wrong. A gear is any * symbol that is adjacent to exactly two part numbers. Its gear ratio is the result of multiplying those two numbers together.

    # This time, you need to find the gear ratio of every gear and add them all up so that the engineer can figure out which gear needs to be replaced.

    # Consider the same engine schematic again:

    # 467..114..
    # ...*......
    # ..35..633.
    # ......#...
    # 617*......
    # .....+.58.
    # ..592.....
    # ......755.
    # ...$.*....
    # .664.598..

    # In this schematic, there are two gears. The first is in the top left; it has part numbers 467 and 35, so its gear ratio is 16345. The second gear is in the lower right; its gear ratio is 451490. (The * adjacent to 617 is not a gear because it is only adjacent to one part number.) Adding up all of the gear ratios produces 467835.

    # What is the sum of all of the gear ratios in your engine schematic?

    describe 'GearLocator' do
      input =
        [
          [4, 6, 7, nil, nil, 1, 1, 4, nil, nil],
          [nil, nil, nil, '*', nil, nil, nil, nil, nil, nil],
          [nil, nil, 3, 5, nil, nil, 6, 3, 3, nil],
          [nil, nil, nil, nil, nil, nil, '#', nil, nil, nil],
          [6, 1, 7, '*', nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, '+', nil, 5, 8, nil],
          [nil, nil, 5, 9, 2, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, 7, 5, 5, nil],
          [nil, nil, nil, '$', nil, '*', nil, nil, nil, nil],
          [nil, 6, 6, 4, nil, 5, 9, 8, nil, nil],
        ]
      expecation = [
        [1, 3], [4, 3], [8, 5],
      ]
      it 'get coordinates of symbols' do
        expect(GearLocator.new(input).call).to eq expecation
      end
    end

    context 'with example input data' do
      it 'returns correct result' do
        pending 'pt2 implementation'
        expect(Solution.new(example_input).solution_pt2).to eq 467_835
      end
    end

    context 'with custom input data' do
      it 'returns correct result' do
        pending 'pt2 implementation'
        expect(Solution.new(custom_input).solution_pt2).to eq true
      end
    end
  end
end
