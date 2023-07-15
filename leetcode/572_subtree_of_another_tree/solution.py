# 572. Subtree of Another Tree

# Given the roots of two binary trees root and subRoot, return true if there is a subtree of root with the same structure and node values of subRoot and false otherwise.

# A subtree of a binary tree tree is a tree that consists of a node in tree and all of this node's descendants. The tree tree could also be considered as a subtree of itself.

# Example 1:

# Input: root = [3,4,5,1,2], subRoot = [4,1,2]
# Output: true

# Example 2:

# Input: root = [3,4,5,1,2,null,null,null,null,0], subRoot = [4,1,2]
# Output: false

# Constraints:

#     The number of nodes in the root tree is in the range [1, 2000].
#     The number of nodes in the subRoot tree is in the range [1, 1000].
#     -104 <= root.val <= 104
#     -104 <= subRoot.val <= 104

import unittest

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

from typing import Optional

class Solution:
    def isSubTree(self, root: Optional[TreeNode], subRoot: Optional[TreeNode]) -> bool:
        def rootDepth(node):
            # PRE
            # circuit breaker
            if node is None:
                return False
            status = False
            if node.val == subRoot.val:
               status = comparator(node, subRoot) 

            # REC
            if status is False:
                status = rootDepth(node.left)
                if status is False:
                    status = rootDepth(node.right)

            # POST
            return status
        
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

        return rootDepth(root)

class TestSolution(unittest.TestCase):
    def test_identical_trees(self):
        root = TreeNode(1, TreeNode(2), TreeNode(3))
        subRoot = TreeNode(1, TreeNode(2), TreeNode(3))
        s = Solution()
        self.assertTrue(s.isSubTree(root, subRoot))

    def test_subtree(self):
        root = TreeNode(3, TreeNode(4, TreeNode(1), TreeNode(2)), TreeNode(5))
        subRoot = TreeNode(4, TreeNode(1), TreeNode(2))
        s = Solution()
        self.assertTrue(s.isSubTree(root, subRoot))

    def test_not_subtree(self):
        root = TreeNode(3, TreeNode(4, TreeNode(1), TreeNode(2)), TreeNode(5))
        subRoot = TreeNode(4, TreeNode(1), TreeNode(3))
        s = Solution()
        self.assertFalse(s.isSubTree(root, subRoot))

if __name__ == '__main__':
    unittest.main()
