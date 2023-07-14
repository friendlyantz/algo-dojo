# Given an array of integers nums which is sorted in ascending order, and an integer target, write a function to search target in nums. If target exists, then return its index. Otherwise, return -1.

# You must write an algorithm with O(log n) runtime complexity.

# Example 1:

# Input: nums = [-1,0,3,5,9,12], target = 9
# Output: 4
# Explanation: 9 exists in nums and its index is 4

# Example 2:

# Input: nums = [-1,0,3,5,9,12], target = 2
# Output: -1
# Explanation: 2 does not exist in nums so return -1

# Constraints:

#     1 <= nums.length <= 104
#     -104 < nums[i], target < 104
#     All the integers in nums are unique.
#     nums is sorted in ascending order.

# Accepted # 1.9M # Submissions # 3.3M # Acceptance Rate # 56.4%

import unittest
from typing import List
import math # might be too slow for LEET

class Solution:
    def search(self, nums: List[int], target: int) -> bool:
        # Runtime
        # Details 244ms Beats 70.71%of users with Python3 Memory Details 17.89mb Beats 70.96%of users with Python3
        head_i = 0
        tail_i = len(nums) - 1
        while head_i <= tail_i: # ez way to do !=, but this will break if 1-element array
            # note the below t - h halfed, then adding the head
            # we can simple do (t + h) // 2, BUT
            # this will break in case of n^31+ as adding big ints can overflow MEM in some languages   
            diff = (tail_i - head_i) // 2
            mid_i = head_i + diff

            if nums[mid_i] == target:
                return mid_i
            elif nums[mid_i] < target:
                head_i = mid_i + 1
            elif nums[mid_i] > target:
                tail_i = mid_i - 1
        return -1


class TestSolution(unittest.TestCase):
    def test_search(self):
        s = Solution()

        # Test case 0
        nums = [5]
        target = 5
        expected_output = 0
        self.assertEqual(s.search(nums, target), expected_output)

        # Test case 1
        nums = [-1,0,3,5,9,12]
        target = 9
        expected_output = 4
        self.assertEqual(s.search(nums, target), expected_output)

        # # Test case 2
        nums = [-1,0,3,5,9,12]
        target = 2
        expected_output = -1
        self.assertEqual(s.search(nums, target), expected_output)

        # # Test case 3
        nums = [1,3,5,7,9]
        target = 7
        expected_output = 3
        self.assertEqual(s.search(nums, target), expected_output)

        # Test case 4
        nums = [1,3,5,7,9]
        target = 4
        expected_output = -1
        self.assertEqual(s.search(nums, target), expected_output)

if __name__ == '__main__':
    unittest.main()