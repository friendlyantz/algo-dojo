# Given a string s containing just the characters '(', ')', '{', '}', '[' and
# ']', determine if the input string is valid.
#
# An input string is valid if:
#
#     Open brackets must be closed by the same type of brackets.
#     Open brackets must be closed in the correct order.
#     Every close bracket has a corresponding open bracket of the same type.
#
#  
#
# Example 1:
#
# Input: s = "()"
# Output: true
#
# Example 2:
#
# Input: s = "()[]{}"
# Output: true
#
# Example 3:
#
# Input: s = "(]"
# Output: false
#
#  
#
# Constraints:
#
#     1 <= s.length <= 104
#     s consists of parentheses only '()[]{}'.
#
#
import unittest

class Solution:
    def isValid(self, s: str) -> bool:
        # Runtime39 ms Beats 93.56% Memory16.3 MB Beats 54.46%
        stack = []
        for c in s:
            if c == "(" or c == "[" or c == "{":
                stack.append(c)
            elif c == ")":
                if len(stack) == 0 or stack[-1] != "(":
                    return False
                stack.pop()
            elif c == "]":
                if len(stack) == 0 or stack[-1] != "[":
                    return False
                stack.pop()
            elif c == "}":
                if len(stack) == 0 or stack[-1] != "{":
                    return False
                stack.pop()
        if len(stack) != 0:
            return False
        return True

class TestSolution(unittest.TestCase):
    def test_isValid(self):
        s = Solution()

        # Test empty string
        self.assertTrue(s.isValid(""))

        # Test single pair of brackets
        self.assertTrue(s.isValid("()"))
        self.assertTrue(s.isValid("[]"))
        self.assertTrue(s.isValid("{}"))

        # Test multiple pairs of brackets
        self.assertTrue(s.isValid("()[]{}"))
        self.assertTrue(s.isValid("{[]}"))
        self.assertTrue(s.isValid("{[()]}"))

        # Test invalid input
        self.assertFalse(s.isValid("("))
        self.assertFalse(s.isValid(")"))
        self.assertFalse(s.isValid("["))
        self.assertFalse(s.isValid("]"))
        self.assertFalse(s.isValid("{"))
        self.assertFalse(s.isValid("}"))
        self.assertFalse(s.isValid("(]"))
        self.assertFalse(s.isValid("([)]"))
        self.assertFalse(s.isValid("{{}"))
        self.assertFalse(s.isValid("}{"))

if __name__ == '__main__':
    unittest.main()
