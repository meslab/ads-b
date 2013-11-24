#!/usr/bin/perl
use strict;
use warnings;
use DBI;

open IN, "icao24plus.txt" or die " can not read file $_.txt: $!";

my $host = "localhost";
my $database = "adsb";
my $user = "aDsB134256";
my $pw = "Byrg097Jbc";

my $dsn = "DBI:mysql:database=$database;host=$host";

my $dbh = DBI->connect($dsn, $user, $pw) or die "can not connect $!\n";
my $sth = $dbh->prepare(q{select aircraft.reg, model.icao, model.name
                          from aircraft,model
                          where aircraft.icao = ?
			  and aircraft.model_id = model.id
			  limit 1
                          })
			  or die "unable to prepare query:".$dbh->errstr."\n";

sub trim {
  my $string = shift;
  $string=~ s/^\s+//;
  $string=~ s/\s+$//;
  return $string;
}

sub uniq {
  my ($list,$uniq) = @_;
  my %seen = ();
  @{$uniq} = grep { ! $seen{$_}++ } @{$list};  
}

while (<IN>){
  chomp($_);
  my ($icao,$reg,$mshort,$mlong) = split /\t/, $_;
  next unless defined $mshort;
  if ($icao && $reg && $mshort) {
    $reg = trim(uc $reg);
    $mshort = trim(uc $mshort);
    $mlong = trim($mlong);
    chomp($icao);
    $icao = trim($icao);
    my @mlong = split / /, $mlong;
    $mlong = '';
    for (@mlong) {
      $_ =~ s/\./-/;
      if ($_ =~ /([-\/\(0-9]|\b\S{1,4}\b)/) {
        $_ = uc $_; 
      }else{
        $_ = ucfirst lc $_;
      }
      $mlong = $mlong . ' ' . $_;
    }
    $mlong = trim($mlong);
    $sth->execute((hex($icao)))
			  or die "unable to execute query:".$dbh->errstr."\n";
    while (my $result = $sth->fetchrow_arrayref) {
#      $result->[0] = trim($result->[0]);
#      $result->[1] = trim($result->[1]);
      
      printf "%06X %4s %8s %s\n", 
             hex($icao),$result->[1],$result->[0],$result->[2];
    }
  }
}

close IN;
