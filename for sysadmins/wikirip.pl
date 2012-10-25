#!usr/bin/perl
#parses a list of the format First###Last!!!uniqueid
#finds them on wikipedia and downloads their highest rez picture, first or last can be null
use WWW::Mechanize;
use Image::Grab;
use strict;

my $pre = "http://en.wikipedia.org/wiki/Special:Search?search=";
my $mid = "+";
my $post = "&go=Go";

open FILE, "wikirip.lst" or die $!;
open LOGFILE, ">>wikirip.log" or die $!;
chdir "img";

#www::mechanize instantiation
my $m = WWW::Mechanize->new();
#fake user agent so wikipedia doesnt think its a bot
$m->agent( 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-us) AppleWebKit/533.17.8 (KHTML, like Gecko) Version/5.0.1 Safari/533.17.8' );

sub wikiImage 
{
	my $tmpimgurl = $_[0];
	while(chop($tmpimgurl) ne "/"){
	#chops thumb name off of url
	}
	my $find = "/thumb/";
	my $replace = "/";
	$find = quotemeta $find; # escape regex metachars if present

	$tmpimgurl =~ s/$find/$replace/g;

	return $tmpimgurl;
}
sub lastresort{
	my $tmpc = $_[0];
	my $tmpimgurl = "";
	my @split = split(/<img/,$tmpc);
	my @splitone = split(/src="/,$split[2]);
	my @splittwo = split(/"/,$splitone[1]);
	$tmpimgurl = 'http:' . $splittwo[0];

	my$tmpfinal = lc substr($tmpimgurl,-3);
	my $tmpsubdomain = lc substr($tmpimgurl,7,3);
	my $i = 0;
	while($tmpsubdomain eq "bit" && $i<5){
		$i++;
		my @splitone = split(/src="/,$split[3+$i]);
		my @splittwo = split(/"/,$splitone[1]);
		$tmpimgurl = 'http:' . $splittwo[0];

		my$tmpfinal = lc substr($tmpimgurl,-3);
		my $tmpsubdomain = lc substr($tmpimgurl,7,3);
	}
	return $tmpimgurl;

}

while(my $line = <FILE>){
	#string manipulation to seperate out names and ids
	my @nameandid = split(/!!!/,$line);
	my $idno = $nameandid[1];
	my $fullname = $nameandid[0];
	my @fullnames = split(/###/,$fullname);
	my $firstname = $fullnames[0];
	my $lastname = $fullnames[1];

	#crafting the url and getting the search contents
	my $url = $pre . $firstname . $mid . $lastname . $post;
	$m->get($url);
	my @imageurls = $m->images;
	my $c = $m->content;

	my $imgurl = 'http:' . $imageurls[0]->URI();

	$imgurl = wikiImage($imgurl);

	my $final = lc substr($imgurl,-3);
	my $subdomain = lc substr($imgurl,7,3);
	my $i = 0;
	outer:{ while((($final eq "svg" || $final eq "ges") || $subdomain eq "bit")&& $i<6){
		$i++;

		if($imageurls[$i]){
			$imgurl = 'http:' . $imageurls[$i]->URI();
		}
		else{
			$imgurl = lastresort($c);
			last outer;
		}
		$imgurl = wikiImage($imgurl);
		# $m->get($imgurl);
		# my $imgcontent = $m->content;
		# print $imgcontent;
		$final = lc substr($imgurl,-3);	
		$subdomain = lc substr($imgurl,7,3);
		if(($final ne "jpg" && $final ne "png" && $final ne "gif" && $final ne "peg") || $subdomain eq "bit"){
			$imgurl = "";
		}

	}}

	# $imgurl = 'http:' . $splittwo[0];

	# #print $imgurl . "\n";
	# #$image = grab(URL=>'http://www.example.com/test.gif');
	# open OFILE, ">test.txt" or die $!;
	# print OFILE $imgurl . "\n:";
	# close OFILE;
	my $ext = "";
	for(my $index = 0; $index < 15 && $ext eq "";$index++){
		if(substr($imgurl,$index*-1,1) eq "."){
			$ext = substr($imgurl,$index*-1);
		}
	}
	chomp($idno);
	my $imgname = "";
	if($firstname && $firstname ne " "){
		$imgname = $firstname . "-" . $lastname . "&" . $idno . $ext;
		#print $imgname;
	}
	else{
		$imgname = $lastname . "&" . $idno . $ext;
		#print "else loop";
	}
	#print "downloading " . $firstname . "'s wiki photo\n";
	# my $pic = new Image::Grab;
	# $pic->url($imgurl);
 # 	$pic->grab;
	# open(IMAGE, ">./img/".$imgname) or die $imgname . ": $!";
	# binmode IMAGE;  # for MSDOS derivations.
	# print IMAGE $pic->image;
	# close IMAGE;
	my $cmd = 'wget -O "' . $imgname . '" "' . $imgurl . '"';
	my $result = system($cmd);
	print $cmd . "\n";
	print LOGFILE $cmd . "\n" . $result . "\n";

}
print LOGFILE "**************************\n\n\nENDOFLOG\n\n\n**************************\n";
close(LOGFILE);
close(FILE);

