import unittest

class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        return True

class TestSolution(unittest.TestCase):
    def test_containsDuplicate_true(self):
        s = Solution()
        result = s.isAnagram("anagram", "nagaram")
        self.assertTrue(result)
        
    def test_containsDuplicate_false(self):
        s = Solution()
        result = s.isAnagram("cat", "rat")
        self.assertFalse(result)

if __name__ == '__main__':
    unittest.main()
