import unittest

# A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.
#
# Given a string s, return true if it is a palindrome, or false otherwise.
#
#  
#
# Example 1:
#
# Input: s = "A man, a plan, a canal: Panama"
# Output: true
# Explanation: "amanaplanacanalpanama" is a palindrome.
#
# Example 2:
#
# Input: s = "race a car"
# Output: false
# Explanation: "raceacar" is not a palindrome.
#
# Example 3:
#
# Input: s = " "
# Output: true
# Explanation: s is an empty string "" after removing non-alphanumeric characters.
# Since an empty string reads the same forward and backward, it is a palindrome.
#
#  
#
# Constraints:
#
#     1 <= s.length <= 2 * 105
#     s consists only of printable ASCII characters.
#

class Solution:
    def isPalindrome(self, s: str) -> bool:
        # Runtime68 ms 41.3% Beats Memory22.2 MB Beats 6.77%
        s = ''.join(c.lower() for c in s if c.isalnum())
        head_i = 0
        tail_i = len(s) - 1

        while head_i <= tail_i:
            if s[head_i] != s[tail_i]:
                return False
            head_i += 1
            tail_i -= 1

        return True

import unittest

class TestSolution(unittest.TestCase):
    def test_is_palindrome(self):
        s = Solution()
        self.assertTrue(s.isPalindrome("A man, a plan, a canal: Panama"))
        self.assertTrue(s.isPalindrome("racecar"))
        self.assertTrue(s.isPalindrome("A Santa at NASA"))
        self.assertTrue(s.isPalindrome("Was it a car or a cat I saw?"))
        self.assertTrue(s.isPalindrome("No 'x' in Nixon"))
        self.assertTrue(s.isPalindrome(""))
        
    def test_not_palindrome(self):
        s = Solution()
        self.assertFalse(s.isPalindrome("race a car"))
        self.assertFalse(s.isPalindrome("hello world"))
        self.assertFalse(s.isPalindrome("Python is awesome"))
        self.assertFalse(s.isPalindrome("This is not a palindrome"))
        self.assertFalse(s.isPalindrome("1234567890"))
        
if __name__ == '__main__':
    unittest.main()
