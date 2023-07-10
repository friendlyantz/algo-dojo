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
  # LEETCODE stats: 
  # Runtime: 73 - 100ms - fluctuates 8-85% better than other submissions 
  # Memory Usage: 211(80%better) - 211.2MB(le bad) - fluctuates a lot, 0-80% better than other submissions
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

def plus_one(digits)
  # naive implementation using ruby join and split
  # Trust this uses some C magic, and it beats the above solution
  # still timeframe / mem are very close and good for both
  # Runtime:75 - 84 ms -  50 - 85% better than other submissions maxed at 7
  # Memory Usage: 210.9-211.1 MB- from 30% to 97% better than other submissions
  digits.join.to_i.next.to_s.split('').map(&:to_i)
end

RSpec.describe 'Solution' do
  let(:input_one) { [1, 2, 3] }
  let(:input_two) { [9, 9] }
  it 'returns incremented big num as an array of digits' do
    expect(plus_one(input_one)).to eq([1, 2, 4])
    expect(plus_one(input_two)).to eq [1, 0, 0]
  end
end
