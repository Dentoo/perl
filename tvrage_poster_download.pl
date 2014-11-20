#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use XML::Simple;
# Download tvrage poster for tv show to a specified location

my $location"/root/test/posters"; # Change to your download dir

# Check so that all arguments needed are there
  if (@ARGV == 0) {
  print "You must add a link to a tvrage tv show \n";
  exit;
  }
  if ($ARGV[0] !~ /http/i){
  print "You must enter a link with http \n";
  exit;
  }
# Get the poster id and make download link.
   my $imageid="1";
   my $content = get $ARGV[0];
   if ($content =~ /src='http:\/\/images.tvrage.com\/shows\/(.*?)'><\/div>/){
   $imageid = ${1};
   $imageid =~ s/^/http:\/\/images.tvrage.com\/shows\//g;
   print "TVRage poster image URL: $imageid \n";
# Download the poster   
   system "wget --restrict-file-names=nocontrol -P '$location' $imageid";
   }elsif ($imageid==1){
   print "No Imageid found \n";
   }
