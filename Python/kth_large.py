#!/usr/bin/env python

# Get the top k-st number from two sorted array. Expect O(logN) time

def kth_large_recur(list1, begin1, end1,
                    list2, begin2, end2,
                    k):
    if begin1 > end1:
        return list2[begin2 + k - 1]
    if begin2 > end2:
        return list1[begin1 + k - 1]
    mid1 = (end1 + begin1) / 2
    mid2 = (end2 + begin2) / 2
    if list1[mid1] <= list2[mid2]:
        if k <= (mid1 - begin1) + (mid2 - begin2) + 1:
            return kth_large_recur(list1, begin1, end1,
                                   list2, begin2, mid2 - 1,
                                   k)
        else:
            return kth_large_recur(list1, mid1 + 1, end1,
                                   list2, begin2, end2,
                                   k - (mid1 + 1 - begin1))
    else:
        if k <= (mid1 - begin1) + (mid2 - begin2) + 1:
            return kth_large_recur(list1, begin1, mid1 - 1,
                                   list2, begin2, end2,
                                   k)
        else:
            return kth_large_recur(list1, begin1, end1,
                                   list2, mid2 + 1, end2,
                                   k - (mid2 + 1 - begin2))

def kth_large(list1, list2, k):
    len1 = len(list1)
    len2 = len(list2)
    if len1 + len2 < k:
        return False
    end1 = k > len1 and len1 - 1 or k - 1
    end2 = k > len2 and len2 - 1 or k - 1
    return kth_large_recur(list1, 0, end1,
                           list2, 0, end2,
                           k)

if __name__ == '__main__':
    list1 = [1, 4, 5, 7, 8]
    list2 = [2, 4, 6, 9, 12, 25]
    list3 = [7, 9, 12, 15, 17, 18, 19, 20, 21, 22, 23]
    assert 8 == kth_large(list1, list2, 8)
    assert 4 == kth_large(list1, list2, 3)
    assert 7 == kth_large(list1, list3, 5)
    assert 20 == kth_large(list1, list3, 13)
    assert False == kth_large(list1, list2, 1000)
    print("All test case passed")
