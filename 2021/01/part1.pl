#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl Advent of Code Day 01 part 1
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;


use Getopt::Long;
my $Verbose = 0;

GetOptions("verbose" => \$Verbose);

my $increase = 0;
my $previous;
while (<>)
{
    chomp;
    $increase++ if ( $previous && $_ > $previous );
    $previous = $_;
}
say $increase;
