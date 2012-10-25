#!/usr/bin/perl
#creates frames which zoom in on a red-blue spiral
use strict;
use warnings;
no warnings 'recursion';
use GD;

my $total_frames = 999;
zoomIn("test.png",$total_frames,1);

# call as zoomIn(file_to_zoom,total_video_frames,time_interval,zoom_amount)
sub zoomIn{
	my $frame 			= $_[1];
	my $frame_number	= $frame - $total_frames + 1;
	print "processing frame ".$frame_number."\n";
	my $zoom 			= $_[2];
	my $imagefile 		= $_[0];

	my $original 	= GD::Image->newFromPng($imagefile);
	my $orig_w		= $original->width;
	my $orig_h 		= $original->height;
	
	my $current = new GD::Image($original->width,$original->height);
	my $copy_area	= $current->width - $zoom*2;
	$current->copyResized($original,0,0,$zoom,$zoom,$orig_w,$orig_h,$copy_area,$copy_area);
	open FILE, "+>zoom_frame_".$frame_number.".png";
	binmode FILE;
	print FILE $current->png(0);
	close FILE;
	if($frame >= 1){
		zoomIn("zoom_frame_".$frame_number.".png",$frame-1,$zoom);
	}
	else{
		exit;
	}

}