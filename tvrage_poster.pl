#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use XML::Simple;
# Check so that all arguments needed are there
if (@ARGV == 0) {
print "You must add a link to a tvrage tv show \n";
exit;
}
if ($ARGV[0] !~ /http/i){
print "You must enter a link with http \n";
exit;
}
# Get the tvshow poster url from tvrage url
   my $imageid="1";
   my $content = get $ARGV[0];
   if ($content =~ /src='http:\/\/images.tvrage.com\/shows\/(.*?)'><\/div>/){
   $imageid = ${1};
   $imageid =~ s/^/http:\/\/images.tvrage.com\/shows\//g;
   print "TVRage poster image URL: $imageid \n";
   }elsif ($imageid==1){
   print "No Imageid found \n";
   }
