#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl Advent of Code 2021 Day 05 Part 1
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use List::Util qw/max/;

use Getopt::Long;
my $Verbose = 0;

GetOptions("verbose" => \$Verbose);

my @Line;
my $Height = 0;
my $Width  = 0;

while (<>)
{
    chomp;
    my ($x1,$y1,$x2,$y2) = m/(\d+)/g;
    say "($x1,$y1) ($x2,$y2)" if $Verbose;
    # Horizontal or vertical only
    next unless $x1 == $x2 || $y1 == $y2;

    $Width  = max($Width,  $x1, $x2);
    $Height = max($Height, $y1, $y2);
    push @Line, [ $x1, $y1, $x2, $y2 ];
}

my @Grid;
push @Grid, [ map { 0 } 0 .. $Width] for 0 .. $Height;

for ( @Line )
{
    my ($x1,$y1,$x2,$y2) = $_->@*;
    if ( $x1 > $x2 ) { ( $x1,$x2) = ($x2,$x1) }
    if ( $y1 > $y2 ) { ( $y1,$y2) = ($y2,$y1) }

    for my $x ( $x1 .. $x2 )
    {
        for my $y ( $y1 .. $y2 )
        {
            $Grid[$x][$y]++;
        }
    }
}

my $intersect = 0;
for my $x ( 0 .. $Width )
{
    for my $y ( 0 .. $Height )
    {
        $intersect++ if ( $Grid[$x][$y] && $Grid[$x][$y] >= 2 )
    }
}
say $intersect;
