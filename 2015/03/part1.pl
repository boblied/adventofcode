#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 03 Part 1
#=============================================================================

use v5.40;

my %house = ( 0 => { 0 => 1 } );

my $x = 0; my $y = 0;

while (<>)
{
    chomp;
    my @move = split //;
    for ( @move )
    {
        if    ( $_ eq '>' ) { $x++ }
        elsif ( $_ eq '<' ) { $x-- }
        elsif ( $_ eq '^' ) { $y++ }
        elsif ( $_ eq 'v' ) { $y-- }

        $house{$x}{$y}++
    }
}

my $visit = 0;
for my $col ( keys %house )
{
    $visit += scalar(keys %{$house{$col}});
}

say $visit;
