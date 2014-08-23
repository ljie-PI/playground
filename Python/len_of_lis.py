#!/usr/bin/env python

# Given a sequence of integers, find the longest increasing subsequence (LIS).
# You code should return the length of the LIS.
#
# Example
# For [5, 4, 1, 2, 3], the LIS  is [1, 2, 3], return 3
# For [4, 2, 4, 5, 3, 7], the LIS is [4, 4, 5, 7], return 4

def len_of_lis(lst):
    lst_len = len(lst)
    if lst_len == 0:
        return 0
    lis_lst = [1] * lst_len
    i = 0
    while i < lst_len:
        j = 0
        cur_len_of_lis = 0
        while j < i:
            if lst[j] < lst[i]:
                if lis_lst[j] > cur_len_of_lis:
                    cur_len_of_lis = lis_lst[j]
            j += 1
        lis_lst[i] = cur_len_of_lis + 1
        i += 1
    return lis_lst[lst_len - 1]

if __name__ == '__main__':
    list1 = [5, 4, 1, 2, 3]
    assert 3 == len_of_lis(list1)
    list2 = [4, 2, 4, 5, 3, 7]
    assert 4 == len_of_lis(list2)
    print("All test case passed")
