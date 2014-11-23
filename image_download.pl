#!/usr/bin/env perl
use strict;
use warnings;
use LWP::Simple;

# Downloads either any image from url or the tvrage tv show image by the tvshow url
# Usage: Enter the url to an image on the web and it will download it.
# Example: ./image_download.pl 'http://url.com/image.jpg'
# (Also works on Facebook image url's)
# Enter url to tvrage show and it returns the url to and downloads the tvshow poster

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
        	print "I do not recognize that link to be a tvrage url, will try anyway...\n";
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

sub image {

# Download image to a specified location
        my $location = "/root/test/general/downloads"; # Change to your download dir

	my $imageurl=$ARGV[0];
	my $epoc = time();

	if ($imageurl =~ m/.*(\.(jpg|png|gif)$|gda__=.*$|.*jpg\?oh=.*$)/i)
	{
		print "Downloading...\n";
	
	my $name = $imageurl;
# Remove all except the actual filename from url
	$name =~ s/^.*\/(.*?)$/$1/gi;
# If it is a facebook image url give it a random filename
	$name =~ s/^.*(__gda__|jpg\?oh=).*$/$epoc.jpg/i;
# Download the image file
	my $code = getstore($imageurl, "$location/$name");
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
			}
	else
			{
		print "Your url must end with .jpg, .png or .gif or be a Facebook image url\n";
			}
}


if ($ARGV[0] =~ m/^.*tvrage.*$/i){
	tvr();
	}
	else
	{
	image()
	}
