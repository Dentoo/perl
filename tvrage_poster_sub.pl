
#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use XML::Simple;
my $_=$ARGV[0];

sub tvrageposter {
   my $imageid;
   my $content = get $_;
   if ($content =~ /src='http:\/\/images.tvrage.com\/shows\/(.*?)'><\/div>/){
   my $imageid = ${1};
   $imageid =~ s/^/http:\/\/images.tvrage.com\/shows\//g;
   print "TVRage poster image URL: $imageid \n";
   }elsif ($imageid == 0){
   print "No Imageid found \n";
   }
}

print tvrageposter;
exit;