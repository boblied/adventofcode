#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 1 Part 2 
#=============================================================================

use v5.40;

my $floor = 0;
my $pos = 0;
STAIR: while (<>)
{
    chomp;
    for ( split // )
    {
        $pos++;
        if    ( $_ eq '(' ) { $floor++ }
        elsif ( $_ eq ')' ) { $floor-- }

        if ( $floor == -1 )
        {
            last STAIR;
        }
    }
}
say $pos;
