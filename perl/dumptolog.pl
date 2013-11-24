#!/usr/bin/perl
use strict;
use warnings;

require "adsb.pm";
require "cmask.pm";

#
# global settings
# ads-b decoder port and
# log files
#
my $adsbport = shift || "/dev/ttyACM0";
my $live = 0;
if ($adsbport eq '/dev/ttyACM0') {
  $live = 1;
}

open IN, $adsbport or die "Can not open source for reading: $!\n";
binmode(IN);
my $decoded_log = "/dev/null";
my $encoded_log = "/dev/null";
my $aq1_log = "/dev/null";
my $aq0_log = "/dev/null";
my $time = 0;

#
# function to control PIC decoder
#
sub control {
  my $act = shift;
  my $chan = shift || *CTRL;
  for ($act) {
    $_ eq "stop" && print $chan "#43-00\n";
    $_ eq "start" && print $chan "#43-02\n";
  }
}

if ($live){
  $decoded_log = "decoded.log";
  $encoded_log = "encoded.log";
  $aq1_log = "aq1.log";
  $aq0_log = "aq0.log";
  open CTRL,">$adsbport" or die "Can not open source to control: $!\n";
}
#
# open decoder for write and read
# open log files for raw and decoded data
#
open EL, ">>$encoded_log" or die "Can not open encoded log: $!\n";
open DL, ">>$decoded_log" or die "Can not open decoded log: $!\n";
# open AQ1L, ">>$aq1_log" or die "Can not open encoded log: $!\n";
# open AQ0L, ">>$aq0_log" or die "Can not open encoded log: $!\n";

if ($live) {
  control("stop"); # stop PIC decoder

#
# wait until PIC-decoder stops
#
  while (<IN>){
    chomp $_;
    if ($_ =~ /#43-00/) {
      last;
    }
  }

  control("start"); # initiate (start) PIC decoder

  #
  # process input from ads-b decoder
  #
  foreach (*EL,*DL) {
    select($_);
    $| = 1;
  }
  select(STDOUT);
}

sub meprint {
  my ($squitter,$df) = @_;
  my ($alt, $ais, $vsign, $vrate, $cpr_form, $cpr_lat, $cpr_long,
      $sp_west, $sp_south, $grspeed, $airspeed, $heading, $turn, $track)
	                                    = me($squitter,$df);
  if ( $alt ) { printf " ALT:%d", $alt; }
  if ( $grspeed ) { printf " GSP:%d", $grspeed; } 
  if ( $airspeed ) { printf " ASP:%d", $airspeed; } 
  if ( $heading ) { printf " HD:%03d", $heading; } 
  if ( $vrate ) {
    if ($vsign ) { $vrate *= (-1); }
    printf " VR:%d", $vrate; }
  if ( $turn ) { printf " T:%d", $turn; } 
  if ( $track ) { printf " TR:%d", $track; } 
  if (( $cpr_form != 2 ) && $cpr_lat && $cpr_long ) { 
    printf " %d %d %d", $cpr_form, $cpr_lat, $cpr_long; } 
  if ( $ais ) { printf " AIS:%s", $ais; } 
}

while (<IN>) {
  chomp($_);
  if ( $live )  {
    $time = time;
  } else {
    $time = (split (/;/,$_))[1];
  }
  if ($_ =~ /\*(.*);/) {
#    print EL "$_\n";

    my $squitter = $1;
    my @squitter = strtochar($squitter);
    my $df = type(\@squitter);
    my $icao = icao($df,\@squitter);
    my $grounded = 0;
    if (($df != 11) && ($icao)) {
      print EL "$_";
      my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)
                                              =localtime($time);
      printf EL "%d;%4d-%02d-%02d %02d:%02d:%02d\n",
                  $time,$year+1900,$mon+1,$mday,$hour,$min,$sec;
      printf "DF%02d %X", $df, $icao; 
      printf " %4d-%02d-%02d %02d:%02d:%02d",
                  $year+1900,$mon+1,$mday,$hour,$min,$sec;
    if (($df > 16) && ($df < 22 )) {
      meprint(\@squitter,$df);
      if ( $df == 20) { printf " ALT:%d", alt(\@squitter, $df) };
      if ( $df == 21) { printf " ID:%04d", squawk(\@squitter) };
    }elsif($df == 4) {
      my $ca = ca(\@squitter);
      $grounded = ($ca & 1);
      printf " ALT:%d", alt(\@squitter,$df);
    }elsif($df == 5) {
      my $ca = ca(\@squitter);
      $grounded = ($ca & 1);
      printf " ID:%04d", squawk(\@squitter);
    }elsif ($df == 0 || $df == 16){
      my ($vs, $ri, $vmax) = aas(\@squitter, $df);
      $grounded = $vs;
      printf " ALT:%d", alt(\@squitter,$df);
      if ( $vmax ) { printf " Vmax:%d", $vmax; }
    }

#    if ($df > 15) {
#      if ($df == 20 || $df == 21) {
#        printf " AIS:%s", ais(\@squitter);
#      }
#    }
    if ($grounded) { print " GND"; }
    printf " %s\n", icaotocountry(\$icao);
    }
  } elsif ($_ =~ /\r?(#.*)/) {
    printf "CM: $1\n";
  }
}

# 
# close all open files
#
close IN;
close CTRL;
close EL;
close DL;
