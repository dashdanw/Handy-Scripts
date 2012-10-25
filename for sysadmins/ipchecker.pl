#!/usr/bin/perl
#this script should be added to cron or another type of periodic system
#must have Email::Send installed
#must have Email::Send::Gmail installed 
#change emails and password to your emails for self-email, works with sending to other peoples email as well
use warnings;
use strict;
use LWP::Simple;
use Email::Send;
use Email::Send::Gmail;
use Email::Simple::Creator; # or other Email::

open OLDIP, "<", ".currentip.tmp"; #open the file with the old IP

if((my $old_ip = <OLDIP>) != -1){
	exec("curl -o currentip.tmp http://automation.whatismyip.com/n09230945.asp");
	exit;
}

my $new_ip = get("http://automation.whatismyip.com/n09230945.asp");
if($new_ip ne $old_ip){
	my $email = Email::Simple->create(
	    header => [
	        From    => 'dashdanw@gmail.com',
	        To      => 'dashdanw@mail.com',
	        Subject => 'Your IP has changed to '.$new_ip,
	    ],
	    body => "It's true!, our IP has changed to ".$new_ip.". DEAL WITH IT",
	);
	my $sender = Email::Send->new(
	{  
		mailer      => 'Gmail',
		mailer_args => [
			username => 'dashdanw@gmail.com',
			password => 'XXXXXX',
		]
	}
	);
  eval { $sender->send($email) };
  die "Error sending email: $@" if $@;
	exec("curl -o currentip.tmp http://automation.whatismyip.com/n09230945.asp");
}
else{
	print "ip is the same\n";
}
