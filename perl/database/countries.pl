#!/usr/bin/perl
use strict;
use warnings;
use DBI;

open IN, "countries.txt" or die " can not read file $_.txt: $!";

my $host = "localhost";
my $database = "adsb";
my $user = "aDsB134256";
my $pw = "Byrg097Jbc";

my $dsn = "DBI:mysql:database=$database;host=$host";

my $dbh = DBI->connect($dsn, $user, $pw) or die "can not connect $!\n";
my $sth = $dbh->prepare(q{insert into countries
                            (id,name)
			    values (?,?)
			    })
			  or die "unable to prepare query:".$dbh->errstr."\n";

while (<IN>){
  chomp;
  my ($id,$name) = /(.{2})\b.\b(.*)/;
  $sth->execute($id,$name) or die
			  "unable to execute query:".$dbh->errstr."\n";
  printf "%s %s\n", $id,$name;
}
close IN;
