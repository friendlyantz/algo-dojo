# 104. Maximum Depth of Binary Tree

# Given the root of a binary tree, return its maximum depth.

# A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

# Example 1:

# Input: root = [3,9,20,null,null,15,7]
# Output: 3

# Example 2:

# Input: root = [1,null,2]
# Output: 2

# Constraints:

#     The number of nodes in the tree is in the range [0, 104].
#     -100 <= Node.val <= 100

def TreeNode(val=0, left=None, right=None):
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        # LEETCODE STATS are unstable
        # Runtime Details 69ms Beats 5.55%of users with Python3
        # Memory Details 18.89mb Beats 13.18%of users with Python3
        #
        # TIME 49ms Beats 91.97%of users with Python3
        # Memory Details 18.70mb Beats 63.15%of users with Python3
        def maxDepth_helper(node):
            # PRE RECURSE
            if node is None:
                return 0
            # RECURSE
            left_depth = maxDepth_helper(node.left)
            right_depth = maxDepth_helper(node.right)
            # We can combine RECURSE action with POST RECUSE action below, but
            # it's more readable to do it this way
            # and seems like MEM gets cleaned up anyways

            # POST RECURSE
            max_depth = max(left_depth, right_depth)

            return max_depth + 1
        return maxDepth_helper(root)