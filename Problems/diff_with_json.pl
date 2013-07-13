#!/usr/local/bin/perl
use warnings;
use strict;
use Getopt::Long;
use JSON;

my %options = ();
GetOptions ("expect=s" => \$options{expect},
			"actual=s" => \$options{actual},
			"separator=s" => \$options{separator},
			"json_field=s" => \$options{json_field});

open(EXP, "<", $options{expect});
open(ACT, "<", $options{actual});

my @exp_lines = ();
while (<EXP>) {
	chomp;
	push(@exp_lines, $_);
}

my @act_lines = ();
while (<ACT>) {
	chomp;
	push(@act_lines, $_);
}

if (scalar(@exp_lines) != scalar(@act_lines)) {
	print "contains different number of lines in " . $options{expect} . " and " . $options{actual}, "\n";
	exit 1;
}

my $sep = $options{separator};
for (my $i=0; $i<scalar(@exp_lines); $i++) {
	my @exp_line_parts = split(/$sep/, $exp_lines[$i]);
	my @act_line_parts = split(/$sep/, $act_lines[$i]);
	if (scalar(@exp_line_parts) != scalar(@act_line_parts)) {
		print "contains different number of fields in " . $exp_lines[$i] . " and " . $act_lines[$i], "\n";
		exit 1;
	}
	for (my $j=0; $j<scalar(@exp_line_parts); $j++) {
		if ($j != $options{json_field} - 1) {
			if ($exp_line_parts[$j] ne $act_line_parts[$j]) {
				my $cur_field = $j + 1;
				print "not equal for ${cur_field}th fields in line $i\n";
				exit 1;
			}
		} else {
			my $exp_json_obj_ref = decode_json($exp_line_parts[$j]);
			my $act_json_obj_ref = decode_json($act_line_parts[$j]);
			unless (&obj_equal($exp_json_obj_ref, $act_json_obj_ref)) {
				print "the json objects are not same\n";
				print "expected: " . $exp_line_parts[$j], "\n";
				print "actual: " . $act_line_parts[$j], "\n";
				exit 1;
			}
		}
	}
}

sub obj_equal {
	my ($exp_obj, $act_obj) = @_;
	my $result = 1;
	return 0 if ref($exp_obj) ne ref($act_obj);
	if (ref($exp_obj) eq 'HASH') {
		my @exp_keys = keys(%$exp_obj);
		my @act_keys = keys(%$act_obj);
		$result = 0 unless &obj_equal(\@exp_keys, \@act_keys);
		for my $key (@exp_keys) {
			$result = 0 unless &obj_equal($exp_obj->{$key}, $act_obj->{$key});
		}
	} elsif (ref($exp_obj) eq 'ARRAY') {
		$result = 0 if scalar(@$exp_obj) != scalar(@$act_obj);
		for (my $i=0; $i<scalar(@$exp_obj); $i++) {
			$result = 0 unless &obj_equal($exp_obj->[$i], $act_obj->[$i]);
		}
	} elsif (ref($exp_obj) eq 'SCALAR') {
		$result = ($$exp_obj eq $$act_obj);
	} elsif (ref($exp_obj) eq '') {
		$result = ($exp_obj eq $act_obj);
	} else {
		$result = 0;
	}

	$result;
}
