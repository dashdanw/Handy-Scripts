#!/usr/bin/perl
#creates a png of a red-blue spiral
use GD;
use strict;
use warnings;

my $width 	= 1200;
my $height 	= 1200;
my $im = new GD::Image($width,$height);

my $white 		= $im->colorAllocate(255,255,255);
my $black 		= $im->colorAllocate(0,0,0);  
my $red 		= $im->colorAllocate(255,0,0);      
my $blue 		= $im->colorAllocate(0,0,255);
my $transparent = $im->colorAllocate(255,255,255);

# $im->transparent($transparent);
# $im->interlaced('true');



$im->filledRectangle(0,0,$width-1,$height-1,$black);

$im->setThickness(50);
$im->rectangle(0,0,$width-1,$height-1,$white);


$im->setThickness(1);
# # Draw a blue oval
# $im->arc(50,50,95,75,0,360,$blue);

# # And fill it with red
# $im->fill(50,50,$red);

#blue spiral
my $radius = 0;
for(my $i=1; $i<$width; $i+=.1){
	$radius+=2;
	if($radius == 360){
		$radius = 1;	
	}
	$im->arc($width/2,$height/2,$i,$i,$radius,$radius+2,$blue);
}

#red spiral
$radius = 179;
for(my $i=1; $i<$width; $i+=.1){
	$radius+=2;
	if($radius == 360){
		$radius = 1;	
	}
	$im->arc($width/2,$height/2,$i,$i,$radius,$radius+2,$red);
}

# $radius = 0;
# for(my $i=1; $i<$width; $i+=.3){
# 	$radius+=2;
# 	if($radius == 360){
# 		$radius = 1;	
# 	}
# 	$im->arc($width/2,$height/2,$i,$i,$radius,$radius+2,$blue);
# }

open IMAGE, "+>test.png";
print IMAGE $im->png;