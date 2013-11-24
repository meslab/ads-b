#
# ICAO to country
#
sub icaotocountry {
  my $icao = shift;
  my $country = "UFO";
  my $cshrt = "??";

  if (( $$icao >> 12) == 1792 ) { $country = "Afghanistan"; $cshrt = "AF"; }
  if (( $$icao >> 10) == 5124 ) { $country = "Albania"; $cshrt = "AL"; }
  if (( $$icao >> 15) == 20 ) { $country = "Algeria"; $cshrt = "DZ"; }
  if (( $$icao >> 12) == 144 ) { $country = "Angola"; $cshrt = "AD"; }
  if (( $$icao >> 10) == 808 ) { $country = "Antigua and Barbuda"; $cshrt = "AG"; }
  if (( $$icao >> 18) == 56 ) { $country = "Argentina"; $cshrt = "AR"; }
  if (( $$icao >> 10) == 6144 ) { $country = "Armenia"; $cshrt = "AM"; }
  if (( $$icao >> 18) == 31 ) { $country = "Australia"; $cshrt = "AU"; }
  if (( $$icao >> 15) == 136 ) { $country = "Austria"; $cshrt = "AT"; }
  if (( $$icao >> 10) == 6146 ) { $country = "Azerbaijan"; $cshrt = "AZ"; }
  if (( $$icao >> 12) == 168 ) { $country = "Bahamas"; $cshrt = "BS"; }
  if (( $$icao >> 12) == 2196 ) { $country = "Bahrain"; $cshrt = "BH"; }
  if (( $$icao >> 12) == 1794 ) { $country = "Bangladesh"; $cshrt = "BD"; }
  if (( $$icao >> 10) == 680 ) { $country = "Barbados"; $cshrt = "BB"; }
  if (( $$icao >> 10) == 5184 ) { $country = "Belarus"; $cshrt = "BY"; }
  if (( $$icao >> 15) == 137 ) { $country = "Belgium"; $cshrt = "BE"; }
  if (( $$icao >> 10) == 684 ) { $country = "Belize"; $cshrt = "BZ"; }
  if (( $$icao >> 10) == 592 ) { $country = "Benin"; $cshrt = "BJ"; }
  if (( $$icao >> 10) == 6656 ) { $country = "Bhutan"; $cshrt = "BT"; }
  if (( $$icao >> 12) == 3732 ) { $country = "Bolivia"; $cshrt = "BO"; }
  if (( $$icao >> 10) == 5196 ) { $country = "Bosnia and Herzegovina"; $cshrt = "BA"; }
  if (( $$icao >> 10) == 192 ) { $country = "Botswana"; $cshrt = "BW"; }
  if (( $$icao >> 18) == 57 ) { $country = "Brazil"; $cshrt = "BR"; }
  if (( $$icao >> 10) == 8788 ) { $country = "Brunei Darussalam"; $cshrt = "BN"; }
  if (( $$icao >> 15) == 138 ) { $country = "Bulgaria"; $cshrt = "BG"; }
  if (( $$icao >> 12) == 156 ) { $country = "Burkina Faso"; $cshrt = "BF"; }
  if (( $$icao >> 12) == 50 ) { $country = "Burundi"; $cshrt = "BI"; }
  if (( $$icao >> 12) == 1806 ) { $country = "Cambodia"; $cshrt = "KH"; }
  if (( $$icao >> 12) == 52 ) { $country = "Cameroon"; $cshrt = "CM"; }
  if (( $$icao >> 18) == 48 ) { $country = "Canada"; $cshrt = "CA"; }
  if (( $$icao >> 10) == 600 ) { $country = "Cape Verde"; $cshrt = "CV"; }
  if (( $$icao >> 12) == 108 ) { $country = "Central African Republic"; $cshrt = "CF"; }
  if (( $$icao >> 12) == 132 ) { $country = "Chad"; $cshrt = "TD"; }
  if (( $$icao >> 12) == 3712 ) { $country = "Chile"; $cshrt = "CL"; }
  if (( $$icao >> 18) == 30 ) { $country = "China"; $cshrt = "CN"; }
  if (( $$icao >> 12) == 172 ) { $country = "Colombia"; $cshrt = "CO"; }
  if (( $$icao >> 10) == 212 ) { $country = "Comoros"; $cshrt = "KM"; }
  if (( $$icao >> 12) == 54 ) { $country = "Congo"; $cshrt = "CG"; }
  if (( $$icao >> 10) == 9220 ) { $country = "Cook Islands"; $cshrt = "CK"; }
  if (( $$icao >> 12) == 174 ) { $country = "Costa Rica"; $cshrt = "CR"; }
  if (( $$icao >> 12) == 56 ) { $country = "Côte d\'Ivoire"; $cshrt = "CI"; }
  if (( $$icao >> 10) == 5127 ) { $country = "Croatia"; $cshrt = "HR"; }
  if (( $$icao >> 12) == 176 ) { $country = "Cuba"; $cshrt = "CU"; }
  if (( $$icao >> 10) == 4896 ) { $country = "Cyprus"; $cshrt = "CY"; }
  if (( $$icao >> 15) == 147 ) { $country = "Czech Republic"; $cshrt = "CZ"; }
  if (( $$icao >> 15) == 228 ) { $country = "Democratic People\'s Republic of Korea"; $cshrt = "KP"; }
  if (( $$icao >> 12) == 140 ) { $country = "Democratic Republic of the Congo"; $cshrt = "CD"; }
  if (( $$icao >> 15) == 139 ) { $country = "Denmark"; $cshrt = "DK"; }
  if (( $$icao >> 10) == 608 ) { $country = "Djibouti"; $cshrt = "DJ"; }
  if (( $$icao >> 12) == 196 ) { $country = "Dominican Republic"; $cshrt = "DO"; }
  if (( $$icao >> 12) == 3716 ) { $country = "Ecuador"; $cshrt = "EC"; }
  if (( $$icao >> 15) == 2 ) { $country = "Egypt"; $cshrt = "EG"; }
  if (( $$icao >> 12) == 178 ) { $country = "El Salvador"; $cshrt = "SV"; }
  if (( $$icao >> 12) == 66 ) { $country = "Equatorial Guinea"; $cshrt = "GQ"; }
  if (( $$icao >> 10) == 2056 ) { $country = "Eritrea"; $cshrt = "ER"; }
  if (( $$icao >> 10) == 5188 ) { $country = "Estonia"; $cshrt = "EE"; }
  if (( $$icao >> 12) == 64 ) { $country = "Ethiopia"; $cshrt = "ET"; }
  if (( $$icao >> 12) == 3208 ) { $country = "Fiji"; $cshrt = "FJ"; }
  if (( $$icao >> 15) == 140 ) { $country = "Finland"; $cshrt = "FI"; }
  if (( $$icao >> 18) == 14 ) { $country = "France"; $cshrt = "FR"; }
  if (( $$icao >> 12) == 62 ) { $country = "Gabon"; $cshrt = "GA"; }
  if (( $$icao >> 12) == 154 ) { $country = "Gambia"; $cshrt = "GM"; }
  if (( $$icao >> 10) == 5200 ) { $country = "Georgia"; $cshrt = "GE"; }
  if (( $$icao >> 18) == 15 ) { $country = "Germany"; $cshrt = "DE"; }
  if (( $$icao >> 12) == 68 ) { $country = "Ghana"; $cshrt = "GH"; }
  if (( $$icao >> 15) == 141 ) { $country = "Greece"; $cshrt = "GR"; }
  if (( $$icao >> 10) == 816 ) { $country = "Grenada"; $cshrt = "GD"; }
  if (( $$icao >> 12) == 180 ) { $country = "Guatemala"; $cshrt = "GT"; }
  if (( $$icao >> 12) == 70 ) { $country = "Guinea"; $cshrt = "GN"; }
  if (( $$icao >> 10) == 288 ) { $country = "Guinea-Bissau"; $cshrt = "GW"; }
  if (( $$icao >> 12) == 182 ) { $country = "Guyana"; $cshrt = "GY"; }
  if (( $$icao >> 12) == 184 ) { $country = "Haiti"; $cshrt = "HT"; }
  if (( $$icao >> 12) == 186 ) { $country = "Honduras"; $cshrt = "HN"; }
  if (( $$icao >> 15) == 142 ) { $country = "Hungary"; $cshrt = "HU"; }
  if (( $$icao >> 12) == 1228 ) { $country = "Iceland"; $cshrt = "IS"; }
  if (( $$icao >> 18) == 32 ) { $country = "India"; $cshrt = "IN"; }
  if (( $$icao >> 15) == 276 ) { $country = "Indonesia"; $cshrt = ""; }
  if (( $$icao >> 15) == 230 ) { $country = "Iran, Islamic Republic of"; $cshrt = "IR"; }
  if (( $$icao >> 15) == 229 ) { $country = "Iraq"; $cshrt = "IQ"; }
  if (( $$icao >> 12) == 1226 ) { $country = "Ireland"; $cshrt = "IE"; }
  if (( $$icao >> 15) == 231 ) { $country = "Israel"; $cshrt = "IL"; }
  if (( $$icao >> 18) == 12 ) { $country = "Italy"; $cshrt = "IT"; }
  if (( $$icao >> 12) == 190 ) { $country = "Jamaica"; $cshrt = "JM"; }
  if (( $$icao >> 18) == 33 ) { $country = "Japan"; $cshrt = "JP"; }
  if (( $$icao >> 15) == 232 ) { $country = "Jordan"; $cshrt = "JO"; }
  if (( $$icao >> 10) == 6668 ) { $country = "Kazakhstan"; $cshrt = "KZ"; }
  if (( $$icao >> 12) == 76 ) { $country = "Kenya"; $cshrt = "KE"; }
  if (( $$icao >> 10) == 12856 ) { $country = "Kiribati"; $cshrt = "KI"; }
  if (( $$icao >> 12) == 1798 ) { $country = "Kuwait"; $cshrt = "KW"; }
  if (( $$icao >> 10) == 6148 ) { $country = "Kyrgyzstan"; $cshrt = "KG"; }
  if (( $$icao >> 12) == 1800 ) { $country = "Lao People\'s Democratic Republic"; $cshrt = "LA"; }
  if (( $$icao >> 10) == 5131 ) { $country = "Latvia"; $cshrt = "LV"; }
  if (( $$icao >> 15) == 233 ) { $country = "Lebanon"; $cshrt = "LB"; }
  if (( $$icao >> 10) == 296 ) { $country = "Lesotho"; $cshrt = "LS"; }
  if (( $$icao >> 12) == 80 ) { $country = "Liberia"; $cshrt = "LR"; }
  if (( $$icao >> 15) == 3 ) { $country = "Libyan Arab Jamahiriya"; $cshrt = "LY"; }
  if (( $$icao >> 10) == 5135 ) { $country = "Lithuania"; $cshrt = "LT"; }
  if (( $$icao >> 10) == 4928 ) { $country = "Luxembourg"; $cshrt = "LU"; }
  if (( $$icao >> 12) == 84 ) { $country = "Madagascar"; $cshrt = "MG"; }
  if (( $$icao >> 12) == 88 ) { $country = "Malawi"; $cshrt = "MW"; }
  if (( $$icao >> 15) == 234 ) { $country = "Malaysia"; $cshrt = "MY"; }
  if (( $$icao >> 10) == 360 ) { $country = "Maldives"; $cshrt = "MV"; }
  if (( $$icao >> 12) == 92 ) { $country = "Mali"; $cshrt = "ML"; }
  if (( $$icao >> 10) == 4936 ) { $country = "Malta"; $cshrt = "MT"; }
  if (( $$icao >> 10) == 9216 ) { $country = "Marshall Islands"; $cshrt = "MH"; }
  if (( $$icao >> 10) == 376 ) { $country = "Mauritania"; $cshrt = "MR"; }
  if (( $$icao >> 10) == 384 ) { $country = "Mauritius"; $cshrt = "MU"; }
  if (( $$icao >> 15) == 26 ) { $country = "Mexico"; $cshrt = "MX"; }
  if (( $$icao >> 10) == 6660 ) { $country = "Micronesia, Federated States of"; $cshrt = "FM"; }
  if (( $$icao >> 10) == 4944 ) { $country = "Monaco"; $cshrt = "MC"; }
  if (( $$icao >> 10) == 6664 ) { $country = "Mongolia"; $cshrt = "MN"; }
  if (( $$icao >> 15) == 4 ) { $country = "Morocco"; $cshrt = "MA"; }
  if (( $$icao >> 12) == 6 ) { $country = "Mozambique"; $cshrt = "MZ"; }
  if (( $$icao >> 12) == 1796 ) { $country = "Myanmar"; $cshrt = "MM"; }
  if (( $$icao >> 10) == 2052 ) { $country = "Namibia"; $cshrt = "NA"; }
  if (( $$icao >> 10) == 12840 ) { $country = "Nauru"; $cshrt = "NR"; }
  if (( $$icao >> 12) == 1802 ) { $country = "Nepal"; $cshrt = "NP"; }
  if (( $$icao >> 15) == 144 ) { $country = "Netherlands, Kingdom of the"; $cshrt = "NL"; }
  if (( $$icao >> 15) == 400 ) { $country = "New Zealand"; $cshrt = "NZ"; }
  if (( $$icao >> 12) == 192 ) { $country = "Nicaragua"; $cshrt = "NI"; }
  if (( $$icao >> 12) == 98 ) { $country = "Niger"; $cshrt = "NE"; }
  if (( $$icao >> 12) == 100 ) { $country = "Nigeria"; $cshrt = "NG"; }
  if (( $$icao >> 15) == 143 ) { $country = "Norway"; $cshrt = "NO"; }
  if (( $$icao >> 10) == 7216 ) { $country = "Oman"; $cshrt = "OM"; }
  if (( $$icao >> 15) == 236 ) { $country = "Pakistan"; $cshrt = "PK"; }
  if (( $$icao >> 10) == 6672 ) { $country = "Palau"; $cshrt = "PW"; }
  if (( $$icao >> 12) == 194 ) { $country = "Panama"; $cshrt = "PA"; }
  if (( $$icao >> 12) == 2200 ) { $country = "Papua New Guinea"; $cshrt = "PG"; }
  if (( $$icao >> 12) == 3720 ) { $country = "Paraguay"; $cshrt = "PY"; }
  if (( $$icao >> 12) == 3724 ) { $country = "Peru"; $cshrt = "PE"; }
  if (( $$icao >> 15) == 235 ) { $country = "Philippines"; $cshrt = "PH"; }
  if (( $$icao >> 15) == 145 ) { $country = "Poland"; $cshrt = "PL"; }
  if (( $$icao >> 15) == 146 ) { $country = "Portugal"; $cshrt = "PT"; }
  if (( $$icao >> 10) == 424 ) { $country = "Qatar"; $cshrt = "QA"; }
  if (( $$icao >> 15) == 227 ) { $country = "Republic of Korea"; $cshrt = "KR"; }
  if (( $$icao >> 10) == 5139 ) { $country = "Republic of Moldova"; $cshrt = "MD"; }
  if (( $$icao >> 15) == 148 ) { $country = "Romania"; $cshrt = "RO"; }
  if (( $$icao >> 20) == 1 ) { $country = "Russian Federation"; $cshrt = "RU"; }
  if (( $$icao >> 12) == 110 ) { $country = "Rwanda"; $cshrt = "RW"; }
  if (( $$icao >> 10) == 12848 ) { $country = "Saint Lucia"; $cshrt = "LC"; }
  if (( $$icao >> 10) == 752 ) { $country = "Saint Vincent and the Grenadines"; $cshrt = "VC"; }
  if (( $$icao >> 10) == 9224 ) { $country = "Samoa"; $cshrt = "WS"; }
  if (( $$icao >> 10) == 5120 ) { $country = "San Marino"; $cshrt = "SM"; }
  if (( $$icao >> 10) == 632 ) { $country = "Sao Tome and Principe"; $cshrt = "ST"; }
  if (( $$icao >> 15) == 226 ) { $country = "Saudi Arabia"; $cshrt = "SA"; }
  if (( $$icao >> 12) == 112 ) { $country = "Senegal"; $cshrt = "SN"; }
  if (( $$icao >> 10) == 464 ) { $country = "Seychelles"; $cshrt = "SC"; }
  if (( $$icao >> 10) == 472 ) { $country = "Sierra Leone"; $cshrt = "SL"; }
  if (( $$icao >> 15) == 237 ) { $country = "Singapore"; $cshrt = "SG"; }
  if (( $$icao >> 10) == 5143 ) { $country = "Slovakia"; $cshrt = "SK"; }
  if (( $$icao >> 10) == 5147 ) { $country = "Slovenia"; $cshrt = "SI"; }
  if (( $$icao >> 10) == 8796 ) { $country = "Solomon Islands"; $cshrt = "SB"; }
  if (( $$icao >> 12) == 120 ) { $country = "Somalia"; $cshrt = "SO"; }
  if (( $$icao >> 15) == 1 ) { $country = "South Africa"; $cshrt = ""; }
  if (( $$icao >> 18) == 13 ) { $country = "Spain"; $cshrt = "ES"; }
  if (( $$icao >> 15) == 238 ) { $country = "Sri Lanka"; $cshrt = "LK"; }
  if (( $$icao >> 12) == 124 ) { $country = "Sudan"; $cshrt = "SD"; }
  if (( $$icao >> 12) == 200 ) { $country = "Suriname"; $cshrt = "SR"; }
  if (( $$icao >> 10) == 488 ) { $country = "Swaziland"; $cshrt = "SZ"; }
  if (( $$icao >> 15) == 149 ) { $country = "Sweden"; $cshrt = "SE"; }
  if (( $$icao >> 15) == 150 ) { $country = "Switzerland"; $cshrt = "CH"; }
  if (( $$icao >> 15) == 239 ) { $country = "Syrian Arab Republic"; $cshrt = "SY"; }
  if (( $$icao >> 10) == 5204 ) { $country = "Tajikistan"; $cshrt = "TJ"; }
  if (( $$icao >> 15) == 272 ) { $country = "Thailand"; $cshrt = "TH"; }
  if (( $$icao >> 10) == 5192 ) { $country = "Republic of Macedonia"; $cshrt = "MK"; }
  if (( $$icao >> 12) == 136 ) { $country = "Togo"; $cshrt = "TG"; }
  if (( $$icao >> 10) == 12852 ) { $country = "Tonga"; $cshrt = "TO"; }
  if (( $$icao >> 12) == 198 ) { $country = "Trinidad and Tobago"; $cshrt = "TT"; }
  if (( $$icao >> 15) == 5 ) { $country = "Tunisia"; $cshrt = "TN"; }
  if (( $$icao >> 15) == 151 ) { $country = "Turkey"; $cshrt = "TR"; }
  if (( $$icao >> 10) == 6150 ) { $country = "Turkmenistan"; $cshrt = "TM"; }
  if (( $$icao >> 12) == 104 ) { $country = "Uganda"; $cshrt = "UG"; }
  if (( $$icao >> 15) == 161 ) { $country = "Ukraine"; $cshrt = "UA"; }
  if (( $$icao >> 12) == 2198 ) { $country = "United Arab Emirates"; $cshrt = "AE"; }
  if (( $$icao >> 18) == 16 ) { $country = "United Kingdom"; $cshrt = "GB"; }
  if (( $$icao >> 12) == 128 ) { $country = "United Republic of Tanzania"; $cshrt = "TZ"; }
  if (( $$icao >> 20) == 10 ) { $country = "United States"; $cshrt = "US"; }
  if (( $$icao >> 12) == 3728 ) { $country = "Uruguay"; $cshrt = "UY"; }
  if (( $$icao >> 10) == 5151 ) { $country = "Uzbekistan"; $cshrt = "UZ"; }
  if (( $$icao >> 10) == 12864 ) { $country = "Vanuatu"; $cshrt = "VU"; }
  if (( $$icao >> 15) == 27 ) { $country = "Venezuela"; $cshrt = "VE"; }
  if (( $$icao >> 15) == 273 ) { $country = "Viet Nam"; $cshrt = "VN"; }
  if (( $$icao >> 12) == 2192 ) { $country = "Yemen"; $cshrt = "YE"; }
  if (( $$icao >> 12) == 138 ) { $country = "Zambia"; $cshrt = "ZM"; }
  if (( $$icao >> 10) == 16 ) { $country = "Zimbabwe"; $cshrt = "ZW"; }
  if (( $$icao >> 15) == 152 ) { $country = "Yugoslavia"; $cshrt = "YU"; }
  if (( $$icao >> 15) == 480 ) { $country = "ICAO (1)"; $cshrt = "I1"; }
  if (( $$icao >> 10) == 8804 ) { $country = "ICAO (2)"; $cshrt = "I2"; }
  if (( $$icao >> 10) == 15396 ) { $country = "ICAO (2)"; $cshrt = "I2"; }

  return ($country,$cshrt);
}

1;
