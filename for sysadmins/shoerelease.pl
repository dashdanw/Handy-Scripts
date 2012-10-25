#checks to see if a new shoe release has happened,and emails client based on that
#!/usr/bin/perl
use strict;
use Net::SMTP::TLS;
use WWW::Mechanize;

my $mech = WWW::Mechanize->new();
my $changed = undef;

sub sendEmail
{
	my ($to, $from, $subject, $message) = @_;
	my $mailer = new Net::SMTP::TLS(  
		'smtp.gmail.com',  
		Hello   =>      'smtp.gmail.com',  
		Port    =>      587,  
		User    =>      'dashdanw',  
		Password=>      'xxx'); 
	$mailer->mail($from);  
	$mailer->to($to);  
	$mailer->data;  
	$mailer->datasend($subject);  
	$mailer->dataend; 
	$mailer->quit;
}
sub checkURL
{
	my $url = $_[0];
	$mech->get($url);
	my $content = $mech->content;
	return $content;
}
while(!$changed){
	if(substr(lc checkURL("https://twitter.com/#!/nikestore"),3000)=~/air\ yeezy/){
		sendEmail('shaun@sneakerwatch.com','dashdanw@gmail.com','Air Yeezy!','nike mentioned Air Yeezy');
		$changed = "changed";
		print 'found!';
	}
	else{
		my @timeData = localtime(time);
		my $time = "$timeData[2]:$timeData[1]:$timeData[0] $timeData[4]/$timeData[3]/" . ($timeData[5] + 1900);
		print "has not changed yet \n";
		print "date is:\t\t\t$time\n\n";
		sleep 120;
	}
}
