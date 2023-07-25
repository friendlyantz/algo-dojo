# Given an integer array nums of unique elements, return all possible
# subsets
# (the power set).
#
# The solution set must not contain duplicate subsets. Return the solution in any order.
#
#  
#
# Example 1:
#
# Input: nums = [1,2,3]
# Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
#
# Example 2:
#
# Input: nums = [0]
# Output: [[],[0]]
#
#  
#
# Constraints:
#
#     1 <= nums.length <= 10
#     -10 <= nums[i] <= 10
#     All the numbers of nums are unique.
#
import unittest
import ipdb

class Solution:
    def subsets(self, nums: list[int]) -> list[list[int]]:
        ipdb.set_trace()
        pass

class TestSolution(unittest.TestCase):
    def test_subsets(self):
        # Test case 1
        nums = [1, 2, 3]
        expected_output = [[], [1], [2], [3], [1, 2], [1, 3], [2, 3], [1, 2, 3]]
        s = Solution()
        self.assertEqual(s.subsets(nums), expected_output)

        # Test case 2
        nums = [0]
        expected_output = [[], [0]]
        s = Solution()
        self.assertEqual(s.subsets(nums), expected_output)

        # Test case 3
        nums = [1, 2]
        expected_output = [[], [1], [2], [1, 2]]
        s = Solution()
        self.assertEqual(s.subsets(nums), expected_output)

if __name__ == '__main__':
    unittest.main()
