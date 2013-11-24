#!/usr/bin/perl

use strict;
use warnings;

use Socket;
use Fcntl;
use POSIX;
use IO::Select;

my @sockets = IO::Select->new();
my $port = shift || 7777;
my $proto = getprotobyname('tcp');

socket(SOCKET, PF_INET, SOCK_STREAM, $proto)
  or die "Can not open socket: $!";
setsockopt(SOCKET,SOL_SOCKET,SO_REUSEADDR, 1)
  or die "Can not set socket option to SO_REUSEADDR $!";

bind(SOCKET,sockaddr_in($port, INADDR_ANY))
  or die "Can not bind to port $port $!";

listen(SOCKET, 5) or die "Listen $!";

print "Server started on port $port\n";

open (INPUT,"/dev/ttyACM0") or die "Can not open ADS-B: $!";
my $line;
while ($line = <INPUT>) {
  foreach my $socket (<@sockets>) {
    select $socket;
    print $line;
  }
  print STDOUT $line;
}

my ($client_addr, $kid);
while ($client_addr = accept(NEW_SOCKET, SOCKET)) {
  print "New client connected\n";
  @sockets->add(*NEW_SOCKET);
  select STDOUT;
}
