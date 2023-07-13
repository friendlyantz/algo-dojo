import unittest
from typing import List

class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:
        hash_set = set()
        for i in nums:
            if i in hash_set:
                return True
            hash_set.add(i)

        return False

class TestSolution(unittest.TestCase):
    def test_containsDuplicate_true(self):
        s = Solution()
        result = s.containsDuplicate([1, 2, 3, 1])
        self.assertTrue(result)
        
    def test_containsDuplicate_false(self):
        s = Solution()
        result = s.containsDuplicate([1, 2, 3])
        self.assertFalse(result)

if __name__ == '__main__':
    unittest.main()
