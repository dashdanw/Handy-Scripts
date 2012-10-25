#!/usr/bin/perl
#logs on to facebook
use strict;
use WWW::Scripter;
use HTTP::Cookies;

my $outfile = "out.htm";
my $url = "http://www.facebook.com/";
my $username = 'dashdanw@yahoo.com';
my $password = "xxx"; 

my $mech = WWW::Scripter->new();

$mech->cookie_jar(HTTP::Cookies->new());
$mech->get($url);

$mech->form_name('login_form');
$mech->field(email => $username);
$mech->field(pass => $password);
$mech->click();

$mech->use_plugin('Ajax');

#$mech->get("http://www.facebook.com/groups/104835899600986/");

#$mech->eval('window.scrollTo(100,document.body.scrollHeight)');

#$url = $mech->find_link(text=>'See More Stories');
#$mech->get($url);
my $output_page = $mech->content();


my $outfile;

open(OUTFILE, ">$outfile");
open(TEST, ">>landingpage.html");

print OUTFILE "$output_page";
print TEST "$output_page";
#print $output_page;

close(OUTFILE);
close(TEST);
