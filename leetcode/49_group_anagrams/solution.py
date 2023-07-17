# Given an array of strings strs, group the anagrams together. You can return the answer in any order.

# An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

# Example 1:

# Input: strs = ["eat","tea","tan","ate","nat","bat"]
# Output: [["bat"],["nat","tan"],["ate","eat","tea"]]

# Example 2:

# Input: strs = [""]
# Output: [[""]]

# Example 3:

# Input: strs = ["a"]
# Output: [["a"]]

# Constraints:

#     1 <= strs.length <= 104
#     0 <= strs[i].length <= 100
#     strs[i] consists of lowercase English letters.


from typing import List
import unittest

class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        hashMap = {}
        
        for s in strs:
            # STRING Runtime 96ms Beats 99.18%of users with Python3
            # Memory Details 19.47mb Beats 95.76%of users with Python3
            # key = ''.join(sorted(s))
            key = tuple(sorted(s)) # not sure if tuple is faster

            if key in hashMap:
                hashMap[key].append(s)
            else:
                hashMap[key] = [s]
        # You can return the answer in any order.
        return list(hashMap.values())

