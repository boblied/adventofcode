#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl Advent of Code 2021 Day 08 Part 1
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;

my $count = 0;
while (<>)
{
    my ($junk, $want) = split " [|] ";
    my $n = grep { $_ == 2 || $_ == 3 || $_ == 4 || $_ == 7 }
        map { length($_) } split(" ", $want);
    $count += $n;
}
say $count;
