#!/bin/bash

ADSB_DIR="/home/asidorov/perl/adsb"

if ping -c1 193.34.81.25
then
  if ssh -f 193.34.81.25 pwd
  then
    if [ -f $ADSB_DIR/encoded.log ]
    then
      mv $ADSB_DIR/encoded.log $ADSB_DIR/encoded.log.old
      kill -HUP `ps -aef | grep monitor.pl | grep -v grep | awk '{print $2}'`
      svn ci $ADSB_DIR -m "Logrotate update"
    fi
  fi
fi
