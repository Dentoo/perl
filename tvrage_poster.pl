#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use XML::Simple;
   my $imageid="1";
   my $content = get $ARGV[0];
   if ($content =~ /src='http:\/\/images.tvrage.com\/shows\/(.*?)'><\/div>/){
   $imageid = ${1};
   $imageid =~ s/^/http:\/\/images.tvrage.com\/shows\//g;
   print "TVRage poster image URL: $imageid \n";
   }elsif ($imageid==1){
   print "No Imageid found \n";
   }