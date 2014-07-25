<?php
/**
 * Given an positive integer N, output all of the postive values <=N, and sort 
 * them in alphabeta order.
 */
$n = 314;
$i = 1;
while (1) {
    if ($i <= $n) {
        echo $i, "\n";
        $i *= 10;
    } else {
        $i = floor($i / 10);
        while ($i % 10 == 9) {
            $i = floor($i / 10);
        }
        if ($i != 0) {
            $i++;
        }
    }
    if ($i < 1) {
        break;
    }
}
