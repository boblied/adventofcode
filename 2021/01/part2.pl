#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part2.pl Advent of Code 2021 Day 01 Part 2
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;

use List::Util qw/sum/;

use Getopt::Long;
my $Verbose = 0;

GetOptions("verbose" => \$Verbose);

my @msmt = <>;
chomp(@msmt);

my $increase = 0;
for ( my $i = 0 ; $i < @msmt-3 ; $i++ )
{
    my $win1 = sum @msmt[($i  ) .. ($i+2)];
    my $win2 = sum @msmt[($i+1) .. ($i+3)];
    $increase++ if $win2 > $win1;
}

say $increase;
