#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;
use Fcntl;
use POSIX;
use IO::Select;

my @sockets = IO::Select->new();
my $port = shift || 7777;

my $server_sock = IO::Socket::INET->new(
			LocalPort => $port,
			Listen => 5,
			Proto => 'tcp',
			Reuse => 1) 
		or die "Can not create socket $!";

print "Server started on port $port\n";

my $pid;
if (!defined($pid = fork)) {
    print "cannot fork: $!";
    return;
} elsif ($pid) {
    print "begat $pid\n";

while (my $connection = $server_sock->accept()) {
  print "New client connected\n";
  @sockets->add($connection);
}
}

open (INPUT,"/dev/ttyACM0") or die "Can not open ADS-B: $!";
my $line;
while ($line = <INPUT>) {
  foreach my $socket (@sockets) {
    select glob($socket);
    $| = 1;
    print $line;
  }
  print STDOUT $line;
}
