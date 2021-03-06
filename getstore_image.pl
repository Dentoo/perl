#!/usr/bin/perl
use strict;
use warnings;
use LWP::Simple;

# Usage: Enter the url to an image on the web and it will store it the scripts location.
# Example: ./getstore_image.pl 'http://url.com/image.jpg'
# (Also works on Facebook image url's)

#### Config ######

my $dir = "/root/test/new/downloads";  # Image storage dir

##################

my $imageurl=$ARGV[0];
my $epoc = time();

sub main {
        if ($imageurl =~ m/.*(\.(jpg|png|gif)$|gda__=.*$|.*jpg\?oh=.*$)/i)
        {

        print "Downloading...\n";

        my $name = $imageurl;

        # Remove all except the actual filename from url
        $name =~ s/^.*\/(.*?)$/$1/gi;

        # If it is a facebook image url give it a random filename
        $name =~ s/^.*(__gda__|jpg\?oh=).*$/$epoc.jpg/i;

        # Download the image file
        my $code = getstore($imageurl, "$dir/$name");

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

        print "Finished downloading $name to $dir\n";
        }
        else
        {
                print "Your url must end with .jpg, .png or .gif or be a Facebook image url\n";
        }
}

main();
