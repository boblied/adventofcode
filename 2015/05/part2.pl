#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 05 Part 2
#=============================================================================

use v5.40;

my $nice = 0;
while (<>)
{
    my $isNice = true;
    chomp;

    if ( m/(..).*\1/ ) { say "$_: repeats [$1]" } else { $isNice = false }

    if ( m/((.).(\2))/ ) { say "$_: triplet [$1]" } else { $isNice = false }

    $nice++ if $isNice;
}

say $nice;
