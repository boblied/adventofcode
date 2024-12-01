#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 03 Part 2
#=============================================================================

use v5.40;

my %house = ( 0 => { 0 => 1 } );

my @santa = ( [0,0], [0,0] );

my $who = 0;

while (<>)
{
    chomp;
    my @move = split //;
    for ( @move )
    {
        if    ( $_ eq '>' ) { $santa[$who][0]++ }
        elsif ( $_ eq '<' ) { $santa[$who][0]-- }
        elsif ( $_ eq '^' ) { $santa[$who][1]++ }
        elsif ( $_ eq 'v' ) { $santa[$who][1]-- }

        $house{$santa[$who][0]}{$santa[$who][1]}++;

        $who = ($who + 1) % 2;
    }
}

my $visit = 0;
for my $col ( keys %house )
{
    $visit += scalar(keys %{$house{$col}});
}

say $visit;
