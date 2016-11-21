#!/usr/bin/perl
# http://www.crimecitymafia.com mafia code auto-bumper
# Michael Craze
# 20130304
use strict;
use warnings;
use WWW::Mechanize;

# To get the following value, you have to go through the source code of the site
# and find the hidden form input field named bk, the value will need to be 
# copied and pasted below.
my $bk = "f22f8cea8023e53d82c1ea51ee38b746";

# Read mafia codes from codes.txt and store in @codes array
my $code_file = "codes.txt";
open(FH, "< $code_file") or die "Can't open $code_file for read: $!";
my @codes=();
while(<FH>){
	if($_ =~ m/\d\d\d-\d\d\d-\d\d\d/){
		push(@codes, $_);
	}
}
close FH or die "Cannot close $code_file: $!";

my $url = "http://www.crimecitymafia.com/";
my $m = WWW::Mechanize->new( agent => 'Apple-iPhone4C1/901.406'); # iphone 4s
while(1){
	for(my $i=0; $i < scalar(@codes); $i++){
		#my $wait_time = int(rand(60)); # random int [0,60]
		$m->get($url);
		$m->form_number(2);
		$m->field('package', '1');
		$m->field('bk', $bk);
		$m->field('code', $codes[$i]);
		$m->submit();
		#my $response = $m->submit();
		#print $response->content();
	}
	sleep(3600);
}
