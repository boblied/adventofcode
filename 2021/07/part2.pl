#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part2.pl Advent of Code 2021 Day 07 Part 2
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;
use builtin qw/ceil floor/; no warnings "experimental::builtin";

use List::Util qw/sum max min/;

my @crab = sort { $a <=> $b } split ",", <>;

my $mean = sum(@crab) / @crab;
my $median = @crab[  $#crab/2 ];

# say "mean=$mean median=$median";

# Mathematically, it's somewhere around the mean or median,
# but we're just going to brute force look at all the possibilities.

sub fuel($v, $x)
{
    sum map { my $d = abs($v->[$_] - $x); $d*($d+1)/2 } 0 .. $v->$#*;
}

say min map { fuel(\@crab, $_) } 0 .. max(@crab);
