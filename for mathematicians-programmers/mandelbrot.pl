#!/usr/bin/perl
#creates a png image of a mandelbrot set
use strict;
use warnings;
use GD;

my $x;
my $xx;
my $y;
my $yy;
my $cx;
my $cy;
my $hx;
my $hy;
my $iteration;

my $max_iterations 	= 100;
my $magnify			= 1;
my $final_magnify	= 1;
my $total_frames	= 1;
my $height 			= 1000;
my $width  			= 1000;

for(my $frame=1; $frame<=$total_frames; $frame++){
	print "\nDrawing Frame ".$frame."...";
	my $im = new GD::Image($width,$height,1);
	my $blue = $im->colorAllocate(0,0,100);
	my $white= $im->colorAllocate(255,255,255);
	$im->setAntiAliased($blue);

	my $x_draw = 0;
	my $y_draw = 0;
	for($hy=1; $hy<=$height; $hy++){
		for($hx=1; $hx<=$width; $hx++){
			$cx = (($hx/$width)-.5)/$magnify*3-.7;
			$cy = (($hy/$height)-.5)/$magnify*3;
			$x=0;
			$y=0;
			for($iteration=1;$iteration<$max_iterations; $iteration++){
				$xx = $x*$x-$y*$y+$cx;
				$y  = 2*$x*$y+$cy;
				$x  = $xx;
				if($x*$x+$y*$y>100){
					$iteration = 999999;
				}
			}
			if($iteration < 999999){
				$im->setPixel($x_draw,$y_draw,gdAntiAliased);
			}
			else {
				$im->setPixel($x_draw,$y_draw,$white);
			}
			if($x_draw == $width-1){
				$x_draw = 0;
				$y_draw++;
			}
			else{
				$x_draw++;
			}
		}
	}
	#$magnify = $magnify+($final_magnify-$magnify)*($frame/$total_frames);
	open IMAGE, "+>frame-".$frame.".png";
	print IMAGE $im->png;
}