# frozen_string_literal: true

# You are given a large integer represented as an integer array digits, where each digits[i] is the ith digit of the integer. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading 0's.

# Increment the large integer by one and return the resulting array of digits.

# Example 1:

# Input: digits = [1,2,3]
# Output: [1,2,4]
# Explanation: The array represents the integer 123.
# Incrementing by one gives 123 + 1 = 124.
# Thus, the result should be [1,2,4].

# Example 2:

# Input: digits = [4,3,2,1]
# Output: [4,3,2,2]
# Explanation: The array represents the integer 4321.
# Incrementing by one gives 4321 + 1 = 4322.
# Thus, the result should be [4,3,2,2].

# Example 3:

# Input: digits = [9]
# Output: [1,0]
# Explanation: The array represents the integer 9.
# Incrementing by one gives 9 + 1 = 10.
# Thus, the result should be [1,0].

# Constraints:

#     1 <= digits.length <= 100
#     0 <= digits[i] <= 9
#     digits does not contain any leading 0's.

def plus_one(digits)
  # reverse - reverse with break, to avoid looping through all elements
  # LEETCODE stats: 80-85% better than other submissions TIME and MEM
  # Runtime: 73 ms
  # Memory Usage: 211 MB
  digits.reverse!
  digits.size.times do |i|
    if (digits[i]) == 9
      digits[i] = 0
      digits << 1 if i == digits.size - 1
    else
      digits[i] += 1
      break
    end
  end
  digits.reverse!
end

RSpec.describe 'Solution' do
  let(:input_one) { [1, 2, 3] }
  let(:input_two) { [9, 9] }
  it 'returns incremented big num as an array of digits' do
    expect(plus_one(input_one)).to eq([1, 2, 4])
    expect(plus_one(input_two)).to eq [1, 0, 0]
  end
end
