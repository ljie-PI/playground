<?php
//php will return 0 when int operation overlows, but the bc* methods won't overlow. So we need to implement the overflow
function overflow_long($value)
{
	$max_int = bcsub(bcpow(2, 63), 1);
	$int_span = bcpow(2, 64);
	$min_int = bcsub(bcadd($max_int, 1), $int_span);
	$mod_value = bcmod($value, $int_span);
	if (bccomp($mod_value, $max_int) > 0) {
		return bcsub($mod_value, $int_span);
	} elseif (bccomp($mod_value, $min_int) < 0) {
		return bcadd($mod_value, $int_span);
	} else {
		return $mod_value;
	}
}
