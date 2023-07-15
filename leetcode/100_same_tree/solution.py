# Given the roots of two binary trees p and q, write a function to check if they are the same or not.

# Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.

# Example 1:

# Input: p = [1,2,3], q = [1,2,3]
# Output: true

# Example 2:

# Input: p = [1,2], q = [1,null,2]
# Output: false

# Example 3:

# Input: p = [1,2,1], q = [1,1,2]
# Output: false

# Constraints:

#     The number of nodes in both trees is in the range [0, 100].
#     -104 <= Node.val <= 104

import unittest

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        # Runtime # Details # 33ms # Beats 98.73%of users with Python3
        # Memory # Details # 16.34mb # Beats 57.90%of users with Python3
        def comparator(node_a, node_b):
            # PRE
            if node_a is False or node_b is False:
                return False

            if node_a is None and node_b is None:
                return True
            elif node_a is None or node_b is None:
                return False

            if node_a.val != node_b.val:
                return False
            # REC
            l_result = comparator(node_a.left, node_b.left)
            r_result = comparator(node_a.right, node_b.right)
            # POST
            return l_result and r_result
        return comparator(p, q)

class TestSolution(unittest.TestCase):
    def test_same_tree(self):
        p = TreeNode(1, TreeNode(2), TreeNode(3))
        q = TreeNode(1, TreeNode(2), TreeNode(3))
        s = Solution()
        self.assertTrue(s.isSameTree(p, q))

    def test_different_tree(self):
        p = TreeNode(1, TreeNode(2))
        q = TreeNode(1, None, TreeNode(2))
        s = Solution()
        self.assertFalse(s.isSameTree(p, q))

    def test_different_values(self):
        p = TreeNode(1, TreeNode(2), TreeNode(1))
        q = TreeNode(1, TreeNode(1), TreeNode(2))
        s = Solution()
        self.assertFalse(s.isSameTree(p, q))

    def test_empty_trees(self):
        p = None
        q = None
        s = Solution()
        self.assertTrue(s.isSameTree(p, q))

    def test_one_empty_tree(self):
        p = TreeNode(1)
        q = None
        s = Solution()
        self.assertFalse(s.isSameTree(p, q))


if __name__ == '__main__':
    unittest.main()
