#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use XML::Simple;
# Usage: ./tvrage_poster_sub.pl http://www.tvrage.com/showname

# Check so that all arguments needed are there
if (@ARGV == 0) {
print "\nPlease add the url to a tvrage tv show. \n\nUsage example: ./tvrage_poster_sub.pl http://www.tvrage.com/Big_Brother\n\n";
exit;
}
if ($ARGV[0] !~ /^http/i){
print "You must enter an url beginning with http. \n";
exit;
}

# Subroutine for tvrage poster url
sub tvrageposter {
my $imageid="not found";
my $content = get $_[0];
if ($content =~ /src='http:\/\/images.tvrage.com\/shows\/(.*?)'><\/div>/){
my $imageid = ${1};
$imageid =~ s/^/http:\/\/images.tvrage.com\/shows\//g;
print "TVRage poster image URL: $imageid \n";
}elsif ($imageid eq "not found"){
print "No Imageid found \n";
}
}

# Use function with the argument passed to it
print tvrageposter($ARGV[0]);

# Exit
exit;

