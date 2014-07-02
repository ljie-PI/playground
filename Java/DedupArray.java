/**
 * Write a function to remove duplicated objects from an array. Preserve the order.
 * For example, if the input array is [1, 5, 4, 2, 7, 2, 6, 5], the result should be [1, 5, 4, 2, 7, 6].
 * The implementation should be optimized for executing speed.
 */

import sun.jvm.hotspot.utilities.Assert;

import java.lang.Integer;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class DedupArray {

    public List<Integer> dedup(List<Integer> inputs) {
        Set<Integer> exists = new HashSet<Integer>();
        List<Integer> result = new ArrayList<Integer>();
        for (int ele : inputs) {
            if (!exists.contains(ele)) {
                exists.add(ele);
                result.add(ele);
            }
        }
        return result;
    }

}
