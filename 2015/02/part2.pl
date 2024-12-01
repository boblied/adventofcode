#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code Day 02 Part 2
#=============================================================================

use v5.40;
use List::Util qw/min sum/;

my $ribbon = 0;
while (<>)
{
    my ($l, $w, $h) = split /x/;

    my @side = ( 2*($l+$w), 2*($l+$h), 2*($w+$h) );

    my $small = min @side;
    my $vol = $l * $w * $h;

    $ribbon += $small + $vol;
}

say $ribbon;
