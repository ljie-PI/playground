import java.lang.Integer;
import java.util.List;
import java.util.ArrayList;
import java.util.PriorityQueue;

public class Top100 {
    private final int topNum = 100;

    public List<Integer> findTop100(List<Integer> inputs) {
        PriorityQueue<Integer> pq = new PriorityQueue<Integer>();
        int i;
        for (i = 0; i < topNum; i++) {
            pq.add(inputs.get(i));
        }
        for (i = topNum; i < inputs.size(); i++) {
            int curEle = inputs.get(i);
            if (pq.peek() < curEle) {
                pq.poll();
                pq.add(curEle);
            }
        }
        List<Integer> results = new ArrayList<Integer>();
        int j = 0;
        while (!pq.isEmpty()) {
            results.add(pq.poll());
            j++;
        }
        return results;
    }
}