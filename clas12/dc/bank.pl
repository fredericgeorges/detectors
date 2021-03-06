#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use bank;

use strict;
use warnings;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   bank.pl <configuration filename>\n";
 	print "   Will define the CLAS12 Drift Chambers (dc) bank\n";
 	print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
	exit;
}

# If not pring the help
# Make sure the argument list is correct
if( scalar @ARGV != 1)
{
	help();
	exit;
}

# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

# Variable Type is two chars.
# The first char:
#  R for raw integrated variables
#  D for dgt integrated variables
#  S for raw step by step variables
#  M for digitized multi-hit variables
#  V for voltage(time) variables
#
# The second char:
# i for integers
# d for doubles

my $bankId   = 1300;
my $bankname = "dc";

sub define_bank
{
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",      1,  "Di", "sector index");
	insert_bank_variable(\%configuration, $bankname, "superlayer",  2,  "Di", "superlayer index");
	insert_bank_variable(\%configuration, $bankname, "layer",       3,  "Di", "layer index");
	insert_bank_variable(\%configuration, $bankname, "wire",        4,  "Di", "wire index");
	insert_bank_variable(\%configuration, $bankname, "LR",          5,  "Di", "Left/Right: -1 (right) if the track is between the beam and the closest wire");
	insert_bank_variable(\%configuration, $bankname, "doca",        6,  "Dd", "2D distance between closest track step to the wire hit");
	insert_bank_variable(\%configuration, $bankname, "sdoca",       7,  "Dd", "smeared doca");
	insert_bank_variable(\%configuration, $bankname, "time",        8,  "Dd", "doca / drift velocity in each region 53, 26, 36 um/ns");
	insert_bank_variable(\%configuration, $bankname, "stime",       9,  "Dd", "sdoca / drift velocity in each region");
	insert_bank_variable(\%configuration, $bankname, "hitn",       99,  "Di", "hit number");
}



define_bank();


1;