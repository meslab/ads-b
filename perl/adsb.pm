use POSIX qw/floor/;

#
# converts string to array of chars
#
sub strtochar {
  my @char = unpack "(a)*", shift;
  return @char; 
}

#
# CRC 112bit generator
#
sub crc112 {
  my ($squitter) = @_;
  my $poly = hex('FFFA0480');
  my $data = (
              (hex(@{$squitter}[0]) << 28) | 
	      (hex(@{$squitter}[1]) << 24) |
	      (hex(@{$squitter}[2]) << 20) |
              (hex(@{$squitter}[3]) << 16) | 
              (hex(@{$squitter}[4]) << 12) | 
	      (hex(@{$squitter}[5]) << 8) |
	      (hex(@{$squitter}[6]) << 4) |
               hex(@{$squitter}[7])
	     );
  my $data1 = (
              (hex(@{$squitter}[8]) << 28) | 
              (hex(@{$squitter}[9]) << 24) | 
              (hex(@{$squitter}[10]) << 20) | 
	      (hex(@{$squitter}[11]) << 16) |
	      (hex(@{$squitter}[12]) << 12) |
	      (hex(@{$squitter}[13]) << 8) |
	      (hex(@{$squitter}[14]) << 4) |
	       hex(@{$squitter}[15])
	     );
  my $data2 = (
              (hex(@{$squitter}[16]) << 28) | 
              (hex(@{$squitter}[17]) << 24) | 
              (hex(@{$squitter}[18]) << 20) | 
	      (hex(@{$squitter}[19]) << 16) |
	      (hex(@{$squitter}[20]) << 12) |
	      (hex(@{$squitter}[21]) << 8)
	     );

  foreach (1..88) {
    if (($data & hex('80000000')) != 0) { $data = ($data ^ $poly); }
    $data = ($data << 1);
    if (($data1 & hex('80000000')) != 0) { $data = ($data | 1); }
    $data1 = ($data1 << 1);
    if (($data2 & hex('80000000')) != 0) { $data1 = ($data1 | 1); }
    $data2 = ($data2 << 1);
  }
  
  return ($data >> 8);
}

#
# CRC 56bit generator
#
sub crc56 {
  my ($squitter) = @_;
  my $poly = hex('FFFA0480');
  my $data = (
              (hex(@{$squitter}[0]) << 28) |
              (hex(@{$squitter}[1]) << 24) |
              (hex(@{$squitter}[2]) << 20) |
              (hex(@{$squitter}[3]) << 16) |
              (hex(@{$squitter}[4]) << 12) |
              (hex(@{$squitter}[5]) << 8) |
              (hex(@{$squitter}[6]) << 4) |
              (hex(@{$squitter}[7]))
              );
  foreach (1..32) {
    if (($data & hex('80000000'))!= 0) { $data = ($data ^ $poly); }
    $data = ($data << 1);
  }
  return ($data >> 8);
}

sub getcrc {
  my ($squitter, $df) = @_;
  if ($df < 16) {
    return crc56($squitter);
  } else {
    return crc112($squitter);
  }
}

#
# IC (interrogator code) generator
#
sub ic {
  my ($squitter) = @_;
  my $ic = ((hex(@{$squitter}[2]) << 1) | (hex(@{$squitter}[3]) >> 3)); 

  return $ic;
}

#
# Mode A code generator
#
sub ma_code {
  my ($squitter) = @_;

  my $m = ((hex(@{$squitter}[6]) >> 2) & 1);
  my $q = (hex(@{$squitter}[6]) & 1);

  my $c1 = (hex(@{$squitter}[4]) & 1);
  my $a1 = ((hex(@{$squitter}[5]) >> 3) & 1);
  my $c2 = ((hex(@{$squitter}[5]) >> 2) & 1);
  my $a2 = ((hex(@{$squitter}[5]) >> 1) & 1);
  my $c4 = (hex(@{$squitter}[5])  & 1);
  my $a4 = ((hex(@{$squitter}[6]) >> 3) & 1);
  my $b1 = ((hex(@{$squitter}[6]) >> 1) & 1);
  my $d1 = $q;
  my $b2 = ((hex(@{$squitter}[7]) >> 3) & 1);
  my $d2 = ((hex(@{$squitter}[7]) >> 2) & 1);
  my $b4 = ((hex(@{$squitter}[7]) >> 1) & 1);
  my $d4 = (hex(@{$squitter}[7]) & 1);

  return ($c1,$a1,$c2,$a2,$c4,$a4,$b1,$d1,$b2,$d2,$b4,$d4,$m,$q);
}

#
# Mode E code generator
#
sub me_code {
  my ($squitter) = @_;

  my $m = 0;
  my $q = (hex(@{$squitter}[11]) & 1);

  my $c1 = ((hex(@{$squitter}[10]) >> 3) & 1);
  my $a1 = ((hex(@{$squitter}[10]) >> 2) & 1);
  my $c2 = ((hex(@{$squitter}[10]) >> 1) & 1);
  my $a2 = (hex(@{$squitter}[10]) & 1);
  my $c4 = ((hex(@{$squitter}[11]) >> 3) & 1);
  my $a4 = ((hex(@{$squitter}[11]) >> 2) & 1);
  my $b1 = ((hex(@{$squitter}[11]) >> 1) & 1);
  my $d1 = $q;
  my $b2 = ((hex(@{$squitter}[12]) >> 3) & 1);
  my $d2 = ((hex(@{$squitter}[12]) >> 2) & 1);
  my $b4 = ((hex(@{$squitter}[12]) >> 1) & 1);
  my $d4 = (hex(@{$squitter}[12]) & 1);

  return ($c1,$a1,$c2,$a2,$c4,$a4,$b1,$d1,$b2,$d2,$b4,$d4,$m,$q);
}

#
# squawk generator
#
sub squawk {
  my ($squitter) = @_;
  my ($c1,$a1,$c2,$a2,$c4,$a4,$b1,$d1,$b2,$d2,$b4,$d4,$m,$q)
                                       = ma_code($squitter);
  my $code = (($a4 << 2) | ($a2 << 1) | $a1) * 1000 +
             (($b4 << 2) | ($b2 << 1) | $b1) * 100 +
             (($c4 << 2) | ($c2 << 1) | $c1) * 10 +
             (($d4 << 2) | ($d2 << 1) | $d1);
  return $code;
}

#
# decode gray code into binary
#
sub graytobin {
  my ($squitter) = @_;
  my ($c1,$a1,$c2,$a2,$c4,$a4,$b1,$d1,$b2,$d2,$b4,$d4,$m,$q)
                                       = ma_code($squitter);

  my $in = ($d2 << 10) | ($d4 << 9) | ($a1 << 8) | ($a2 << 7) |
           ($a4 << 6) | ($b1 << 5) | ($b2 << 4) | ($b4 << 3) |
           ($c1 << 2) | ($c2 << 1) | $c1 ;
  my $cp = 0;
  my $result = 0;
  my $mask = hex('80');
  
  foreach (1..16) {
    if (($in & $mask) != 0) {
      $cp = !$cp;
    }
    if ($cp) {
      $result = ($result | $mask);
    }
    $mask = ($mask >> 1);
  }
  my $high = ( hex($result) >> 3 );
#  my $low = ( hex($result) & 7 );
  my $sub = ( hex($in) & 7 );
  my $low = 0;
  ($sub == 2) && ($low = 2);
  if ($high%2) {
    ($sub == 4) && ($low = 4);
    ($sub == 6) && ($low = 3);
    ($sub == 3) && ($low = 1);
  } else {
    ($sub == 1) && ($low = 4);
    ($sub == 3) && ($low = 3);
    ($sub == 6) && ($low = 1);
  }

  return ($high,$low,$result,$in);
}

#
# function to get altitude
#
sub alt {
  my ($squitter,$df) = @_;
  my ($c1,$a1,$c2,$a2,$c4,$a4,$b1,$d1,$b2,$d2,$b4,$d4,$m,$q);
  if ($df == 17 ) {
    ($c1,$a1,$c2,$a2,$c4,$a4,$b1,$d1,$b2,$d2,$b4,$d4,$m,$q)
                                       = me_code($squitter);
  } else {
  ($c1,$a1,$c2,$a2,$c4,$a4,$b1,$d1,$b2,$d2,$b4,$d4,$m,$q)
                                       = ma_code($squitter);
  }
  my $alt = 0;
  
  if ($m == 0) {
    if ($q == 0) {
#      $alt = graytobin($squitter)*100 - 1200; 
       my ($high,$low,$result,$in) = graytobin($squitter);
       $alt = $high*500 + $low*100 - 1200;
    } else {
      my $n = ($c1 << 10) | ($a1 << 9) | ($c2 << 8) | ($a2 << 7) |
              ($c4 << 6) | ($a4 << 5) | ($b1 << 4) | ($b2 << 3) |
              ($d2 << 2) | ($b4 << 1) | $d4 ;
      $alt = 25*$n - 1000;
    }
  } else {
     $alt = (($c1 << 10) | ($a1 << 9) | ($c2 << 8) | ($a2 << 7) |
            ($c4 << 6) | ($a4 << 5) | ($b1 << 4) | ($b2 << 3) |
            ($d2 << 2) | ($b4 << 1) | $d4) * 0.31 ;
  }

#  print "MODE:$mode ALT:$alt M:$m Q:$q\n";
  return $alt;
}

#
# returns message type from squitter
#
sub type {
  my ($squitter) = @_;
  my $df = ((hex(@{$squitter}[0]) << 1) | (hex (@{$squitter}[1]) >> 3));
  if ($df > 23 ) { $df = (hex(@{$squitter}[0]) >> 2); }
  return $df;
}

#
# returns capability field
#
sub ca {
  my ($squitter) = @_;
  my $ca = ((hex(@{$squitter}[0])) & 7);
  return $ca;
}

#
# ICAO generator
#
sub icao {
  my ($df,$squitter) = @_;
  my $icao = '';
  my $crc = 0;
  if ($df == 11 || $df == 17) {
    $icao = hex(join('',@{$squitter}[2..7]));
  } else {
    $crc = getcrc($squitter,$df);
    if ($df < 16) {
      my $ap = (
             (hex(@{$squitter}[8]) << 20 ) |
             (hex(@{$squitter}[9]) << 16 ) |
             (hex(@{$squitter}[10]) << 12 ) |
             (hex(@{$squitter}[11]) << 8 ) |
             (hex(@{$squitter}[12]) << 4 ) |
             hex(@{$squitter}[13])
	    );
      $icao = ($ap ^ $crc);
    }elsif ($df < 22) {
      my $ap = (
             (hex(@{$squitter}[22]) << 20 ) |
             (hex(@{$squitter}[23]) << 16 ) |
             (hex(@{$squitter}[24]) << 12 ) |
             (hex(@{$squitter}[25]) << 8 ) |
             (hex(@{$squitter}[26]) << 4 ) |
             hex(@{$squitter}[27])
	    );
      $icao = ($ap ^ $crc);
   }
  }

  return $icao;
}

#
# Air-to-air message decode
#
sub aas {
  my ($squitter, $df) = @_;
  my $ri = 0;
  my $vmax = 0;
  my $vs = (( hex(@{$squitter}[1]) & 4) >> 2 ); 
  $ri = ((( hex(@{$squitter}[3]) & 7) << 1) |
         ( hex(@{$squitter}[4]) >> 3 ));
  if (($ri & 8) && ($ri ^ 15)) {
    $vmax = 75*( 1 << ($ri - 9 ));
  }
#  $ri == 9 && ($vmax = 75);
#  $ri == 10 && ($vmax = 150);
#  $ri == 11 && ($vmax = 300);
#  $ri == 12 && ($vmax = 600);
#  $ri == 13 && ($vmax = 1200);
#  $ri == 14 && ($vmax = '1200+');

  if (($df == 0) || ($df == 16)) {
    return ($vs, $ri, $vmax);
  } 
}

#
# IA-5 convertion
#
sub ia5 {
  my $ch = shift;
  my $letter = '';
  if ($ch  == 32 ) { 
    $letter = ' ';
  } elsif (($ch >> 4) == 3 ) {
    $letter = ($ch & 15);
  } elsif (($ch >0) && ($ch <27)) {
    my @al = (A..Z);
    $letter =  $al[($ch & 31) - 1];
  }
  return $letter;
}

#
# AIS - aircraft identification code
#
sub ais {
  my ($squitter) = @_;
  my ($bds1,$bds2) = getbds($squitter);
  if (($bds1 == 2) && ($bsd2 == 0)){
    my @ch;
    $ch[0] = ((hex(@{$squitter}[10]) << 2) |
             ((hex(@{$squitter}[11])) >> 2));
    $ch[1] = (((hex(@{$squitter}[11]) & 3 ) << 4) |
             (hex(@{$squitter}[12])));
    $ch[2] = ((hex(@{$squitter}[13]) << 2) |
             ((hex(@{$squitter}[14])) >> 2));
    $ch[3] = (((hex(@{$squitter}[14]) & 3 ) << 4) |
             (hex(@{$squitter}[15])));
    $ch[4] = ((hex(@{$squitter}[16]) << 2) |
             ((hex(@{$squitter}[17])) >> 2));
    $ch[5] = (((hex(@{$squitter}[17]) & 3 ) << 4) |
             (hex(@{$squitter}[18])));
    $ch[6] = ((hex(@{$squitter}[19]) << 2) |
             ((hex(@{$squitter}[20])) >> 2));
    $ch[7] = (((hex(@{$squitter}[20]) & 3 ) << 4) |
             (hex(@{$squitter}[21])));
    my $ais = '';
    foreach (@ch){
      $ais .= ia5($_);
    }
    return $ais;
    } else {
    return '';
  } 
}

#
# get BDS
sub getbds {
  my ($squitter) = @_;
  my $bds1 = hex(@{$squitter}[8]);
  my $bds2 = hex(@{$squitter}[9]);

  return ($bds1,$bds2);
}
#
# ME extended squitter decode
#
sub me {
  my ($squitter,$df) = @_;
  my $type = ((hex(@{$squitter}[8]) << 1) | (hex (@{$squitter}[9]) >> 3));
  my $subtype = ((hex(@{$squitter}[9])) & 7);
#  printf " T:%d ST:%d", $type, $subtype;
  my $alt = 0;
  my $lat = 0;
  my $long = 0;
  my $vrate = 0;
  my $vsign = 0;
  my $cpr_form = 2;
  my $cpr_lat = 0;
  my $cpr_long = 0;
  my $sp_west = 0;
  my $sp_south = 0;
  my $dir_west = 0;
  my $dir_south = 0;
  my $airspeed = 0;
  my $grspeed = 0;
  my $heading = 0;
  my $turn = 0;
  my $ais = '';
  my $track = 0;
  my $tr_stat = 0;
  if (
      (($type > 0) && ($type < 5)) || ($df == 20) || ($df == 21)
     ) {
    $ais = ais($squitter);
  } elsif (
      ($type == 0) ||
      (($type > 8) && ($type < 19)) ||
      (($type > 19) && ($type < 23))
      ) {
    $alt = alt($squitter,$df);
    $cpr_form = ((hex(@{$squitter}[13]) & 4) >> 2 );
    $cpr_lat = (
                 ((hex(@{$squitter}[13]) & 3) << 15) |
                  (hex(@{$squitter}[14]) << 11) |
                  (hex(@{$squitter}[15]) << 7) |
                  (hex(@{$squitter}[16]) << 3) |
                 (hex(@{$squitter}[17]) >> 1)
                 );
    $cpr_long = (
                 ((hex(@{$squitter}[17]) & 1) << 16) |
                  (hex(@{$squitter}[18]) << 12) |
                  (hex(@{$squitter}[19]) << 8) |
                  (hex(@{$squitter}[20]) << 4) |
                   hex(@{$squitter}[21])
                 );
  } elsif (
      (($type > 4) && ($type < 9)) 
     ) {
    $tr_stat = (hex(@{$squitter}[11]) >> 3 );
    $track = (
              ((hex(@{$squitter}[11]) & 7 ) << 4 ) |
              hex(@{$squitter}[12])
	     );
    $track = $track * 2.8125;
    if ( $tr_stat ) { $track = 360 - $track; }
    $cpr_form = ((hex(@{$squitter}[13]) & 4) >> 2 );
    $cpr_lat = (
                 ((hex(@{$squitter}[13]) & 3) << 15) |
                  (hex(@{$squitter}[14]) << 11) |
                  (hex(@{$squitter}[15]) << 7) |
                  (hex(@{$squitter}[16]) << 3) |
                 (hex(@{$squitter}[17]) >> 1)
                );
    $cpr_long = (
                 ((hex(@{$squitter}[17]) & 1) << 16) |
                  (hex(@{$squitter}[18]) << 12) |
                  (hex(@{$squitter}[19]) << 8) |
                  (hex(@{$squitter}[20]) << 4) |
                   hex(@{$squitter}[21])
                 );
  } elsif ( $type == 19 ){
    if (($subtype == 1) || ($subtype == 2)) {
      $dir_west = ((hex(@{$squitter}[11]) & 4 ) >> 2);
      $sp_west = (
                 ((hex(@{$squitter}[11]) & 3 ) << 8) |
                  (hex(@{$squitter}[12]) << 4) |
                  hex(@{$squitter}[13])
                 );
      if (($subtype == 2) && ($sp_west > 0)) {
        $sp_west = (($sp_west -1)*4)+1;
      }
      --$sp_west;
      if ( $dir_west) { $sp_west = $sp_west*(-1); }
      $dir_south = ((hex(@{$squitter}[14]) & 8 ) >> 3);
      $sp_south = (
                 ((hex(@{$squitter}[14]) & 7 ) << 7) |
                  (hex(@{$squitter}[15]) << 3) |
                  (hex(@{$squitter}[16]) >> 1)
		  );
      if (($subtype == 2) && ($sp_south > 0)) {
        $sp_south = (($sp_south -1)*4)+1;
      }
      --$sp_south;
      if ( $dir_south ) { $sp_south = $sp_south*(-1); }
      $grspeed = sqrt($sp_west**2 + $sp_south**2);
      $heading = atan2($sp_west,$sp_south)*180/3.14159265;
      if ($heading < 0) { $heading = 360 + $heading ; }
    }
    if (($subtype == 3) || ($subtype == 4)) {
      $head_stat = ((hex(@{$squitter}[11]) & 4 ) >> 2);
      $heading = (
                 ((hex(@{$squitter}[11]) & 3 ) << 8) |
                  (hex(@{$squitter}[12]) << 4) |
                  hex(@{$squitter}[13])
                 );
      if ($heading) { $heading = $heading*360/1024/3.14159265; };
      $airspeed_type = ((hex(@{$squitter}[14]) & 8 ) >> 3);
      $airspeed = (
                 ((hex(@{$squitter}[14]) & 7 ) << 7) |
                  (hex(@{$squitter}[15]) << 3) |
                  (hex(@{$squitter}[16]) >> 1)
		  );
      if (($subtype == 4) && ($airspeed > 0)) {
        $airspeed = (($airspeed - 1)*4)+1;
      }
    }
    $vsign = ((hex(@{$squitter}[17]) & 8) >> 3);
    $vrate = (
              ((hex(@{$squitter}[17]) & 7) << 6) |
              (hex(@{$squitter}[18]) << 2) |
	      (hex(@{$squitter}[19]) >> 2 )
	     );
    if ($vrate) { $vrate = ($vrate - 1) * 64;} # ft/min
    $turn = (hex(@{$squitter}[19]) & 3 );
  }
  return ($alt, $ais, $vsign, $vrate, $cpr_form, $cpr_lat, $cpr_long,
          $sp_west, $sp_south, $grspeed, $airspeed, $heading, $turn,
	  $track);
}
#
# return fixed latitude
#
sub fixed_lat {
  my $lat = shift;
  if ($lat > 90) { return $lat - 360; }
  if ($lat < (-90)) { return $lat + 360; }
  return $lat;
}

#
# returns the lowest positive mod value
#
sub pmod {
  my ($x,$y) = @_;
  my $res = $x % $y;
  if ($x < 0) { return $x + $y; };
  return $y;
}

#
# return latitude and longitude
#
sub getpos {
  my ($cpr,$cpr_form) = @_;
  my $div = (1 << 17);
  my $adl0 = 6; # 360/60
  my $adl1 = 360/59;
  my (@rlat,@nl,$ni,$nlt,$lngt);
  
  my $j = floor(((59*$$cpr[0][0] - 60*$$cpr[1][0])/$div) + 0.5 );
  
  $rlat[0] = fixed_lat($adl0 * (($j%60) + $$cpr[0][0]/$div));
  $rlat[1] = fixed_lat($adl1 * (($j%59) + $$cpr[1][0]/$div));
  
  if ((abs($rlat[0]) > 90) || (abs($rlat[1]) > 90)) { return (0,0); }
  
  $nl[0] = nl($rlat[0]);
  $nl[1] = nl($rlat[1]);
  if ($nl[0] != $nl[1]) { return (0,0); }
  
  my $lat = $rlat[$cpr_form];

  if ($cpr_form) {
    $ni = $nl[1] - 1;
    $nlt = $nl[1];
    $lngt = $$cpr[1][1];
  } else {
    $ni = $nl[0];
    $nlt = $nl[0];
    $lngt = $$cpr[0][1];
  }

  if ($ni < 1) { $ni = 1; }
  my $dlng = 360/$ni;
  my $m = floor((($$cpr[0][1]*($nlt-1) - $$cpr[1][1]*$nlt)/$div) + 0.5);
  my $lng = $dlng*(pmod($m,$ni) + $lngt/$div);

  return ($lat, $lng);
}

1;
