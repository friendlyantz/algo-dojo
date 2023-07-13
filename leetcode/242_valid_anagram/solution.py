import unittest

class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        # easy way
        # return sorted(s) == sorted(t)

        # proper ways
        # LEETSTATS
        # Runtime62 ms Beats 76.65% Memory16.9 MB Beats 64.65%
        if len(s) != len(t):
            return False 

        s_hash, t_hash = {}, {}
        for i in s:
            s_hash[i] = s_hash[i] + 1 if s_hash.get(i) else 1

        # separate loops are not really needed since we teset the size above,
        # but for clarity I like to keep it SOLIDish
        for i in t:
            # note default 0 in 'get' safe
            t_hash[i] = 1 + t_hash.get(i, 0)

        for k, v in s_hash.items():
            if k not in t_hash or v != t_hash[k]: 
                return False

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
        result = s.isAnagram("aacc", "cacc")
        self.assertFalse(result)

if __name__ == '__main__':
    unittest.main()
