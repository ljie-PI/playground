#!/usr/bin/perl -w
use JSON;

@skip_keys = qw(active_model dev_override_path exploration_bucket_ids last_training_run_status segment_max segment_size hist_score_threshold last_training_run_status market_size max_exploration_size spsg_seedlist_location_hdfs spsg_seedlist_size model_key initial_score_threshold seedlist_location_hdfs msg_for_offgrid message replacement_model_path);
@skip_zero_keys = qw(tconv tuconv);
while (<>) {
	chomp;
	@fields = split(/\t/);
	print $fields[0], "\n";
	$json_str = $fields[1];
	$json_ref = decode_json($json_str);

	for $key (sort keys %$json_ref) {
		if ($key ~~ @skip_keys) {
			next;
		}
		$val_ref = $json_ref->{$key};
		if (ref $val_ref eq 'ARRAY') {
			print "\t";
			print $key . " <=> " . join(',', sort @$val_ref) . "\n";
		} elsif (ref $val_ref eq '') {
			if ($key ~~ @skip_zero_keys && $val_ref == 00) {
				next;
			}
			print "\t";
			print $key . " <=> " . $val_ref . "\n";
		}
	}
}
