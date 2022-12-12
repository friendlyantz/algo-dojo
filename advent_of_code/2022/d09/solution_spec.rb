require File.join(__dir__, 'solution')

require 'pry'
require 'awesome_print'

RSpec.describe 'Solutions' do
  let(:example_input) { File.read(File.join(__dir__, 'ie_input')) }
  let(:custom_input) { File.read(File.join(__dir__, 'input')) }

  describe 'Part 1' do
    #
    # --- Day 9: Rope Bridge ---

    # This rope bridge creaks as you walk along it. You aren't sure how old it is, or whether it can even support your weight.

    # It seems to support the Elves just fine, though. The bridge spans a gorge which was carved out by the massive river far below you.

    # You step carefully; as you do, the ropes stretch and twist. You decide to distract yourself by modeling rope physics; maybe you can even figure out where not to step.

    # Consider a rope with a knot at each end; these knots mark the head and the tail of the rope. If the head moves far enough away from the tail, the tail is pulled toward the head.

    # Due to nebulous reasoning involving Planck lengths, you should be able to model the positions of the knots on a two-dimensional grid. Then, by following a hypothetical series of motions (your puzzle input) for the head, you can determine how the tail will move.

    # Due to the aforementioned Planck lengths, the rope must be quite short; in fact, the head (H) and tail (T) must always be touching (diagonally adjacent and even overlapping both count as touching):

    # ....
    # .TH.
    # ....

    # ....
    # .H..
    # ..T.
    # ....

    # ...
    # .H. (H covers T)
    # ...

    # If the head is ever two steps directly up, down, left, or right from the tail, the tail must also move one step in that direction so it remains close enough:

    # .....    .....    .....
    # .TH.. -> .T.H. -> ..TH.
    # .....    .....    .....

    # ...    ...    ...
    # .T.    .T.    ...
    # .H. -> ... -> .T.
    # ...    .H.    .H.
    # ...    ...    ...

    # Otherwise, if the head and tail aren't touching and aren't in the same row or column, the tail always moves one step diagonally to keep up:

    # .....    .....    .....
    # .....    ..H..    ..H..
    # ..H.. -> ..... -> ..T..
    # .T...    .T...    .....
    # .....    .....    .....

    # .....    .....    .....
    # .....    .....    .....
    # ..H.. -> ...H. -> ..TH.
    # .T...    .T...    .....
    # .....    .....    .....

    # You just need to work out where the tail goes as the head follows a series of motions. Assume the head and the tail both start at the same position, overlapping.

    # For example:

    # R 4
    # U 4
    # L 3
    # D 1
    # R 4
    # D 1
    # L 5
    # R 2

    # This series of motions moves the head right four steps, then up four steps, then left three steps, then down one step, and so on. After each step, you'll need to update the position of the tail if the step means the head is no longer adjacent to the tail. Visually, these motions occur as follows (s marks the starting position as a reference point):

    # == Initial State ==

    # ......
    # ......
    # ......
    # ......
    # H.....  (H covers T, s)

    # == R 4 ==

    # ......
    # ......
    # ......
    # ......
    # TH....  (T covers s)

    # ......
    # ......
    # ......
    # ......
    # sTH...

    # ......
    # ......
    # ......
    # ......
    # s.TH..

    # ......
    # ......
    # ......
    # ......
    # s..TH.

    # == U 4 ==

    # ......
    # ......
    # ......
    # ....H.
    # s..T..

    # ......
    # ......
    # ....H.
    # ....T.
    # s.....

    # ......
    # ....H.
    # ....T.
    # ......
    # s.....

    # ....H.
    # ....T.
    # ......
    # ......
    # s.....

    # == L 3 ==

    # ...H..
    # ....T.
    # ......
    # ......
    # s.....

    # ..HT..
    # ......
    # ......
    # ......
    # s.....

    # .HT...
    # ......
    # ......
    # ......
    # s.....

    # == D 1 ==

    # ..T...
    # .H....
    # ......
    # ......
    # s.....

    # == R 4 ==

    # ..T...
    # ..H...
    # ......
    # ......
    # s.....

    # ..T...
    # ...H..
    # ......
    # ......
    # s.....

    # ......
    # ...TH.
    # ......
    # ......
    # s.....

    # ......
    # ....TH
    # ......
    # ......
    # s.....

    # == D 1 ==

    # ......
    # ....T.
    # .....H
    # ......
    # s.....

    # == L 5 ==

    # ......
    # ....T.
    # ....H.
    # ......
    # s.....

    # ......
    # ....T.
    # ...H..
    # ......
    # s.....

    # ......
    # ......
    # ..HT..
    # ......
    # s.....

    # ......
    # ......
    # .HT...
    # ......
    # s.....

    # ......
    # ......
    # HT....
    # ......
    # s.....

    # == R 2 ==

    # ......
    # ......
    # .H....  (H covers T)
    # ......
    # s.....

    # ......
    # ......
    # .TH...
    # ......
    # s.....

    # After simulating the rope, you can count up all of the positions the tail visited at least once. In this diagram, s again marks the starting position (which the tail also visited) and # marks other positions the tail visited:

    # ..##..
    # ...##.
    # .####.
    # ....#.
    # s###..

    # So, there are 13 positions the tail visited at least once.

    # Simulate your complete hypothetical series of motions. How many positions does the tail of the rope visit at least once?

    describe 'implementation' do
      let(:preped_data) do
        [['R', 4], ['U', 4], ['L', 3], ['D', 1], ['R', 4], ['D', 1], ['L', 5], ['R', 2]]
      end
      it 'preps data by interpreting input lines' do
        expect(prep_data(example_input)).to eq preped_data
      end

      it 'determins the width and height of future map matrix based on input' do
        expect(determine_matrix_size(preped_data)).to  eq [5, 6]
      end

      it 'can generate matrix of the map' do
        matrix = generate_matrix(6, 6)
        expect(matrix).to eq [
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ]
      end

      describe 'movement' do
        let(:expected) do
          [
            [nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil]
          ]
        end

        before do
          generate_matrix(
            determine_matrix_size(preped_data).first,
            determine_matrix_size(preped_data).last
          )
        end

        describe 'field preparation and placing start figures' do
          it '#matrix' do
            expect(matrix).to eq expected
          end

          it 'generates HEAD and TAIL objects' do
            expect(head).to  be_a Node
            expect(tail).to  be_a Node
          end

          it 'places HEAD and TAIL to the bottom right corner' do
            place_figures_to_start
            expect(matrix.last.first).to eq(
              [head, tail]
            )
          end
        end

        describe 'HEAD' do
          before do
            place_figures_to_start
          end

          it 'moves head correctly after 1st instruction' do
            move_head(preped_data[0])
            expect(matrix).to eq(
              [
                [nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil],
                [[tail], nil, nil, nil, [head], nil]
              ]
            )
          end

          it 'moves head correctly after 2nd instruction' do
            move_head(preped_data[0])
            move_head(preped_data[1])
            expect(matrix).to eq(
              [
                [nil, nil, nil, nil, [head], nil],
                [nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil],
                [[tail], nil, nil, nil, nil, nil]
              ]
            )
          end
        end
      end
    end

    describe 'final result for pt1' do
      context 'example input data' do
        it 'returns correct result' do
          pending 'pt1 implementation'
          expect(solution_pt1(example_input)).to eq 13
        end
      end

      context 'custom input data' do
        it 'returns correct result' do
          pending 'pt1 implementation'
          expect(solution_pt1(custom_input)).to eq true
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
        expect(solution_pt2(example_input)).to eq true
      end
    end

    context 'custom input data' do
      it 'returns correct result' do
        pending 'pt2 implementation'
        expect(solution_pt2(custom_input)).to eq true
      end
    end
  end
end
