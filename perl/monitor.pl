#!/usr/bin/perl
use strict;
use warnings;
use POSIX ();
use FindBin ();
use File::Basename ();
use File::Spec::Functions;

$|=1;

# make the daemon cross-platform, so exec always calls the script
# itself with the right path, no matter how the script was invoked.
my $script = File::Basename::basename($0);
my $SELF = catfile $FindBin::Bin, $script;

# POSIX unmasks the sigprocmask properly
my $sigset = POSIX::SigSet->new();
my $action = POSIX::SigAction->new('sigHUP_handler',
                                   $sigset,
                                   &POSIX::SA_NODEFER);
POSIX::sigaction(&POSIX::SIGHUP, $action);

sub sigHUP_handler {
    exec($SELF, @ARGV) or die "Couldn't restart: $!\n";
}

require "adsb.pm";
require "cmask.pm";
require "dlat.pm";

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

open IN,"<",$adsbport or die "Can not open source for reading: $!\n";
open NL,">>","database/notlisted.log"
                      or die "Can not open source for reading: $!\n";
binmode(IN);
my $decoded_log = "/dev/null";
my $encoded_log = "/dev/null";
my $aq1_log = "/dev/null";
my $aq0_log = "/dev/null";
my $time = 0;
my %planes_temp = ();
my %planes = ();
my ($planes_now,$planes_max) = (0,0);
my $lasttime = time;
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
  foreach (*EL) {
    select($_);
    $| = 1;
  }
  select(STDOUT);
}

sub medecode {
  my ($squitter,$df,$plane) = @_;
  my ($alt, $ais, $vsign, $vrate, $cpr_form, $cpr_lat, $cpr_lng,
      $sp_west, $sp_south, $grspeed, $airspeed, $heading, $turn, $track)
	                                    = me($squitter,$df);
  if ( $alt ) { $$plane{alt} = $alt; }
  if ( $grspeed ) { $$plane{gsp} =  $grspeed; } 
  if ( $airspeed ) { $$plane{asp} =  $airspeed; } 
  if ( $heading ) { $$plane{hd} = $heading; } 
  if ($grspeed || $airspeed) {
    if ($vsign ) { $vrate *= (-1); }
    $$plane{vr} = $vrate;
  }
  if ( $track ) { $$plane{tr} =  $track; } 
  if ($cpr_lat && $cpr_lng ) { 
    $$plane{cpr}[$cpr_form][0] = $cpr_lat;
    $$plane{cpr}[$cpr_form][1] = $cpr_lng;
    $$plane{cpr}[$cpr_form][2] = time;
    if (
#        ($cpr_form != 2 ) &&
        (abs($$plane{cpr}[0][2] - $$plane{cpr}[1][2]) < 10) && # delay < 10 sec
        $$plane{cpr}[0][0] &&
        $$plane{cpr}[0][1] &&
        $$plane{cpr}[1][0] &&
        $$plane{cpr}[1][1]
       ) {
       ($$plane{lat},$$plane{lng}) = 
          getpos ($$plane{cpr},$cpr_form);
     }
  }
  if ( $ais ) { $$plane{ais} = $ais; } 
}

#
# get plane model ICAO code
#
sub getmodel {
  my ($icao) = @_;
  open PLANES,"<","database/icao24plus.txt"
             or die "Can not open source for reading: $!\n";
  while (my $line = <PLANES>) {
    chomp $line;
    my @plane = split /\t/,$line;
    chomp($plane[0]);
    if (hex($plane[0]) == $icao) {
      chomp $plane[2];
      close PLANES;
      return $plane[2];
      last;
    }
  }
  open NLIN,"database/notlisted.log"
             or die "Can not open not listed planes file for reading: $!\n";
  while ( my $line = <NLIN> ) {
    chomp $line;
    if (hex($line) == $icao) {
      close PLANES;
      close NLIN;
      return '';
    }
  }
  printf NL "%06X\n", $icao;
  close PLANES;
  close NLIN;
  return '';
}

#
# print out plane hash
#
sub printplane {
  my ($plane) = @_;
  printf " %4s",$$plane{model};
  printf " %s", $$plane{ccode};
  printf " %8s",$$plane{ais};
  printf " %5d", $$plane{alt}; 
  if ($$plane{asp}) {
    printf " %*d",3, $$plane{asp};
  } else {
    printf " %*d",3, $$plane{gsp};
  }
  printf " %03d", $$plane{hd};
  printf " %9.6f", $$plane{lat};
  printf " %10.6f", $$plane{lng};
  printf " %04d", $$plane{id};
  if ($$plane{vr}) { printf " %+5d", $$plane{vr}; }
              else { printf " %5s", ''; }
  if ($$plane{ri}) {
    printf " %2d", $$plane{ri};
  } else {
    printf " %2s", '';
  }
}

while (<IN>) {
  chomp($_);
  if ( $live )  {
    $time = time;
    for (keys %planes) {
      if ((time - $planes{$_}{timest}) > 300) {
        delete $planes{$_};
      }
    }

    for (keys %planes_temp) {
      if ((time - $planes_temp{$_}{timest}) > 300) {
        delete $planes_temp{$_};
      }
    }
  } else {
    $time = (split (/;/,$_))[1];
  }
  if ($_ =~ /\*(.{14,28});/) {

    my $squitter = $1;
    my @squitter = strtochar($squitter);
    my $df = type(\@squitter);
    my $icao = icao($df,\@squitter);
    next unless ($icao);
    if (exists $planes{$icao}) {
      $planes{$icao}{timest} = time; 
    } else {
      my($country,$ccode) = icaotocountry(\$icao);
      if (exists $planes_temp{$icao}) {
        $planes{$icao} = {
          id => 0,                             # sqwauk
          ais => '',                           # flight
          country => $country,                 # country
          ccode => $ccode,                     # country short notation
          alt => 0,                            # altitude
          hd => 0,                             # heading
          tr => 0,                             # track  
          vr => 0,                             # vertical rate
          gsp => 0,                            # ground speed
          asp => 0,                            # air speed
          cpr => [                             # CPR
                   [0,0,0],                    # cpr0 latitude, longitude, time
	           [0,0,0],                    # cpr1 latitude, longitude, time
                 ],
          lat => 0,                            # latitude
          lng => 0,                            # longitude
          gnd => 0,                            # is on the ground
	  ri => 0,                             # 
	  vmax => 0,                           # maximum speed
	  model => getmodel($icao),                     # ICAO model code
          timest => time,                      # timestamp
        };
        delete $planes_temp{$icao};
      } else {
        $planes_temp{$icao} = { timest => time };
        next;
      } 
    }
    if ($df != 11) {
      print EL "$_";
      printf EL "%d;\n", $time;
      if (($df > 16) && ($df < 22 )) {
        medecode(\@squitter,$df,$planes{$icao});
        if ( $df == 20) { $planes{$icao}{alt} =  alt(\@squitter, $df) };
        if ( $df == 21) { $planes{$icao}{id} = squawk(\@squitter) };
      }elsif($df == 4) {
        my $fs = ca(\@squitter);
        $planes{$icao}{gnd} = ($fs & 1);
        $planes{$icao}{alt} =  alt(\@squitter, $df);
      }elsif($df == 5) {
        my $fs = ca(\@squitter);
        $planes{$icao}{gnd} = ($fs & 1);
        $planes{$icao}{id} = squawk(\@squitter);
      }elsif ($df == 0 || $df == 16){
        my ($vs, $ri, $vmax) = aas(\@squitter, $df);
        $planes{$icao}{gnd} = $vs;
        $planes{$icao}{alt} =  alt(\@squitter, $df);
        $planes{$icao}{ri} = $ri;
      }

    unless ((time - $lasttime) < 5) {  # print out aircraft list every 5 sec
      $lasttime = time;
      system("clear");
      foreach (sort(keys(%planes))) {
        printf "%06X", $_;
        printplane ($planes{$_});
        printf " %3d\n", (time - $planes{$_}{timest});
      }
      my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)
                                             =localtime($time);
      $planes_now = scalar keys %planes;
      if ($planes_now > $planes_max ) { $planes_max = $planes_now; }
      printf "LAST UPDATE: %4d-%02d-%02d %02d:%02d:%02d ",
                    $year+1900,$mon+1,$mday,$hour,$min,$sec;
      printf "AICRAFTS: NOW: %d MAX: %d\n", $planes_now, $planes_max;
    }
    if (!$live) { select (undef,undef,undef,0.01); }
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
close NL;
