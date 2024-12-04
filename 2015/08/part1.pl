#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  Advent of Code 2015 Day 08 Part 1
#=============================================================================

use v5.40;

my $codeSize = 0;
my $memSize = 0;
while (<>)
{
    chomp;
    #say " IN: $_\t| ", length($_) ;
    $codeSize += length($_);
    s/^"//; s/"$//;
    s/\\["\\]/Q/g;
    s/\\x[0-9a-f][0-9a-f]/X/g;
    #say "OUT: $_\t| ", length($_);
    $memSize += length($_);
}
say $codeSize - $memSize;
