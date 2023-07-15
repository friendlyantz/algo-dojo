# https://leetcode.com/problems/diameter-of-binary-tree/

# Given the root of a binary tree, return the length of the diameter of the tree.

# The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.

# The length of a path between two nodes is represented by the number of edges between them.

# Example 1:

# Input: root = [1,2,3,4,5]
# Output: 3
# Explanation: 3 is the length of the path [4,2,1,3] or [5,2,1,3].

# Example 2:

# Input: root = [1,2]
# Output: 1

# Constraints:

#     The number of nodes in the tree is in the range [1, 104].
#     -100 <= Node.val <= 100

def TreeNode(val=0, left=None, right=None):
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


from typing import Optional
import pdb
class Solution:
    def diameterOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        # LEETCODE STATS
        # Runtime Details 58ms Beats 72.03%of users with Python3
        # Memory Details 18.70mb Beats 45.46%of users with Python3
        self.diameter = 0 # diameter is the longest(MAX) path!!! not just max width

        if not root.left and not root.right:
            return 0

        def maxDia_helper(node):
            # PRE RECURSE
            if not node:
                return 0
            path_from_parent = 1

            # RECURSE
            left_d = maxDia_helper(node.left)
            right_d = maxDia_helper(node.right)

            # POST RECURSE
            # update max width if we beat it
            self.diameter = max(self.diameter, left_d + right_d)
            # choose the widest child and add parent link
            return max(left_d, right_d) + path_from_parent

        maxDia_helper(root)
        return self.diameter
