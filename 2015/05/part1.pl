#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 05 Part 1
#=============================================================================

use v5.40;

my $nice = 0;
while (<>)
{
    my $isNice = true;
    chomp;
    $isNice &&= length($_ =~ s/[^aeiou]+//gr) >= 3;
    $isNice &&= m/(.)\1/;
    $isNice &&= $_ !~ m/ab|cd|pq|xy/;

    if ( $isNice ) { $nice++; say "   NICE: $_" }
    else           {          say "NAUGHTY: $_" }
}

say $nice;
