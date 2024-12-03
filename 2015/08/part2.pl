#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 08 Part 2 
#=============================================================================

use v5.40;

my $inSize = 0;
my $outSize = 0;
while (<>)
{
    chomp;
    $inSize += length($_);
    say " IN: $_\t| ", length($_);
    s/(["\\])/\\$1/g;
    say "OUT: $_\t| ", length($_);
    $outSize += length($_) + 2;
}

say "in=$inSize out=$outSize";
say $outSize - $inSize;
