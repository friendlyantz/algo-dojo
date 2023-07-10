# frozen_string_literal: true

# Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:

#     Each row must contain the digits 1-9 without repetition.
#     Each column must contain the digits 1-9 without repetition.
#     Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without repetition.

# Note:

#     A Sudoku board (partially filled) could be valid but is not necessarily solvable.
#     Only the filled cells need to be validated according to the mentioned rules.
#     i.e 1
#     Input: board =
# [["5","3",".",".","7",".",".",".","."]
# ,["6",".",".","1","9","5",".",".","."]
# ,[".","9","8",".",".",".",".","6","."]
# ,["8",".",".",".","6",".",".",".","3"]
# ,["4",".",".","8",".","3",".",".","1"]
# ,["7",".",".",".","2",".",".",".","6"]
# ,[".","6",".",".",".",".","2","8","."]
# ,[".",".",".","4","1","9",".",".","5"]
# ,[".",".",".",".","8",".",".","7","9"]]
# Output: true
#
# Example 2:

# Input: board =
# [["8","3",".",".","7",".",".",".","."]
# ,["6",".",".","1","9","5",".",".","."]
# ,[".","9","8",".",".",".",".","6","."]
# ,["8",".",".",".","6",".",".",".","3"]
# ,["4",".",".","8",".","3",".",".","1"]
# ,["7",".",".",".","2",".",".",".","6"]
# ,[".","6",".",".",".",".","2","8","."]
# ,[".",".",".","4","1","9",".",".","5"]
# ,[".",".",".",".","8",".",".","7","9"]]
# Output: false
# Explanation: Same as Example 1, except with the 5 in the top left corner being modified to 8. Since there are two 8's in the top left 3x3 sub-box, it is invalid.

# Constraints:

#     board.length == 9
#     board[i].length == 9
#     board[i][j] is a digit 1-9 or '.'.

def neighbour_yeild(data, line, column)
  i, j = line, column
  yield [i, j] # self
  yield [i - 1, j - 1] if i > 0 && j > 0 # top-left
  yield [i - 1, j] if i > 0 # top
  yield [i - 1, j + 1] if i > 0 && j < data.first.length - 1 # top-right
  yield [i + 1, j] if i < data.length - 1 # bottom
  yield [i + 1, j - 1] if i < data.length - 1 && j > 0 # bottom-left
  yield [i + 1, j + 1] if i < data.length - 1 && j < data.first.length - 1 # bottom-right
  yield [i, j - 1] if j > 0 # left
  yield [i, j + 1] if j < data.first.length - 1 # right
end

def is_valid_sudoku(board)
  # GOOD Runtime: 93 - 104 ms 66-92% better
  # BAD Memory Usage: 211.1 -211.2 MB 0-45% better - Fluctuates, narrow band
  # 1. check lines
  board.each do |line|
    line = line.dup
    line.delete('.') # note, deleting is important,
    # otherwise uniq will not work with nil
    return false unless line.uniq == line
  end

  # 2. check columns
  9.times do |column_index|
    column = board.map { |line| line[column_index] }
    column.delete('.')
    return false unless column.uniq == column 
  end

  # 3. check 3x3 sub-boxes
  3.times do |i|
    3.times do |j|
      stack = []
      column = 1 + j*3
      line = 1 + i*3
      neighbour_yeild(board, line, column) do |dline, dcolumn|
        stack << board[dline][dcolumn]
      end

      stack.delete('.')
      return false unless stack.uniq == stack
    end
  end

  return true
end

RSpec.describe 'Solution' do
  let(:input_one) do
    [
      ['5', '3', '.', '.', '7', '.', '.', '.', '.'],
      ['6', '.', '.', '1', '9', '5', '.', '.', '.'],
      ['.', '9', '8', '.', '.', '.', '.', '6', '.'],
      ['8', '.', '.', '.', '6', '.', '.', '.', '3'],
      ['4', '.', '.', '8', '.', '3', '.', '.', '1'],
      ['7', '.', '.', '.', '2', '.', '.', '.', '6'],
      ['.', '6', '.', '.', '.', '.', '2', '8', '.'],
      ['.', '.', '.', '4', '1', '9', '.', '.', '5'],
      ['.', '.', '.', '.', '8', '.', '.', '7', '9']
    ]
  end
  let(:input_two) do
   
    [
      ['8', '3', '.', '.', '7', '.', '.', '.', '.'],
      ['6', '.', '.', '1', '9', '5', '.', '.', '.'],
      ['.', '9', '8', '.', '.', '.', '.', '6', '.'],
      ['8', '.', '.', '.', '6', '.', '.', '.', '3'],
      ['4', '.', '.', '8', '.', '3', '.', '.', '1'],
      ['7', '.', '.', '.', '2', '.', '.', '.', '6'],
      ['.', '6', '.', '.', '.', '.', '2', '8', '.'],
      ['.', '.', '.', '4', '1', '9', '.', '.', '5'],
      ['.', '.', '.', '.', '8', '.', '.', '7', '9']
    ]
  end

  it 'returns incremented big num as an array of digits' do
    expect(is_valid_sudoku(input_one)).to eq true
    expect(is_valid_sudoku(input_two)).to eq false
  end
end
