#!/usr/bin/env perl
use strict;
use warnings;
use LWP::Simple;

sub tvr {
# Download tvrage poster for tv show to a specified location
        my $location = "/root/test/general/downloads"; # Change to your download dir

# Check so that all arguments needed are there
        if (@ARGV == 0) {
                print "You must add a link to a tvrage tv show \n";
                exit;
                        }
        if ($ARGV[0] !~ /http/i){
                print "You must enter a link with http \n";
                exit;
                        }
        if ($ARGV[0] !~ m/^.*tvrage.*$/i){
                print "I do not recognize that link to be a tvrage url, will try anyway...\n$
                        }

# Get the poster id and make download link.
        my $imageid="1";
        my $content = get $ARGV[0];
        if ($content =~ /src='http:\/\/images.tvrage.com\/shows\/(.*?)'><\/div>/){
        $imageid = ${1};
        $imageid =~ s/^/http:\/\/images.tvrage.com\/shows\//g;
        print "TVRage poster image URL: $imageid \n";
        # Download the poster
        my $name = $imageid;
        $name =~ s/^.*\/(.*?)$/$1/gi;
        my $code = getstore($imageid, "$location/$name");

        if ($code == 200) {
                print "Success\n";
        }
        elsif ($code == 404){
                print "Error 404 No such file\n";
                exit;
        }
        else {
                print "Failed $!\n";
                exit;
        }
        print "Finished downloading $name to $location\n";

        }elsif ($imageid==1){
        print "No Imageid found \n";
        }
}


tvr();
