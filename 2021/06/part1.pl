#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl Advent of Code 2021 Day 06 Part 1
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;

use Data::Dumper; $Data::Dumper::Sortkeys=1; $Data::Dumper::Indent=0;

use Getopt::Long;
my $Verbose = 0;
GetOptions("verbose" => \$Verbose);

my @Population = (0) x 9;
$Population[$_]++ for split ",", <>;


for my $day ( 1..256 )
{
    my @nextDay = (0) x 9;

    $nextDay[8]  = $Population[0];
    $nextDay[7]  = $Population[8];
    $nextDay[6]  = $Population[7] + $Population[0];
    $nextDay[5]  = $Population[6];
    $nextDay[4]  = $Population[5];
    $nextDay[3]  = $Population[4];
    $nextDay[2]  = $Population[3];
    $nextDay[1]  = $Population[2];
    $nextDay[0]  = $Population[1];

    @Population = @nextDay;
}

use List::Util qw/sum/;
say sum @Population;
