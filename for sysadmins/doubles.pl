#!/usr/bin/perl
use strict;
use Math::BigInt;
use warnings;
#tests efficiency of Math::BigInt library

no warnings 'recursion';

my $limit = $ARGV[0];
my $now = time;
for(my $i = 0;$i<$limit;$i++){
	#print sprintf("%.0f", power(2,$i)) ."\n\n";
	power(2,$i);
}

$now = time - $now;
print "runtime of the inner class implementation method was: ".$now."\n\n\n";

my $now2 = time;
for(my $i = 0;$i<$limit;$i++){
	#print sprintf("%.0f", power2(Math::BigInt->new(2),$i)) ."\n\n";	
	power2(Math::BigInt->new(2),$i);
}

$now2 = time-$now2;
print "runtime of the inner class implementation method was: ".$now2."\n\n\n";
my $diff = $now-$now2;
print "runtime difference was: ".$diff."\n\n\nruntime efficiency increase is equal to %".(($diff/$now)*100)."\n";

sub power{
	my $base 	= $_[0];
	my $pow		= $_[1];

	if($pow > 0){
		my $final = Math::BigInt->new($base)*power($base,$pow-1);
		return $final;
	}
	else{
		return 1;
	}

}
sub power2{
	my $base 	= $_[0];
	my $pow		= $_[1];

	if($pow > 0){
		my $final = $base*power($base,$pow-1);
		return $final;
	}
	else{
		return 1;
	}

}
