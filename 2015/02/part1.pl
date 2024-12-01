#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code Day 02 Part 1
#=============================================================================

use v5.40;
use List::Util qw/min sum/;

my $wrap = 0;
while (<>)
{
    my ($l, $w, $h) = split /x/;

    my @side = ( $l*$w, $w*$h, $l*$h );

    my $small = min @side;

    my $area  = sum($small, map {2*$_} @side );

    $wrap += $area;
}

say $wrap;
