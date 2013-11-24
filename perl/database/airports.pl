#!/usr/bin/perl
use strict;
use warnings;
use DBI;

#open IN, "airports.csv" or die " can not read file $_.txt: $!";

my $host = "localhost";
my $database = "adsb";
my $user = "aDsB134256";
my $pw = "Byrg097Jbc";

my $dsn = "DBI:mysql:database=$database;host=$host";

my $dbh = DBI->connect($dsn, $user, $pw) or die "can not connect $!\n";
my $sth_sel = $dbh->prepare(q{select icao from
                            airports group by icao having
			    count(icao) > 1 })
			  or die "unable to prepare query:".$dbh->errstr."\n";
my $sth_del = $dbh->prepare(q{DELETE from adsb.airports 
                          where icao=? limit 1 })
			  or die "unable to prepare query:".$dbh->errstr."\n";

#while (<IN>){
#  my ($icao,$iata,$name,$city,$country,$lat,$lng,$alt) = split /,/,$_;
#  if ($iata) {
#    $sth_up->execute($icao,$iata) or warn
#			  "unable to execute query:".$dbh->errstr."\n";
#  }
#  printf "%s %s %s %s\n", $iata,$icao,$name,$location;
#}
#close IN;

$sth_sel->execute
	  or die "unable to execute query:".$dbh->errstr."\n";
while (my $aref = $sth_sel->fetchrow_arrayref) {
  $sth_del->execute($aref->[0])
	  or die "unable to execute query:".$dbh->errstr."\n";
  print $aref->[0],"\n";
}

