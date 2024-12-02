#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 06 Part 1
#=============================================================================

use v5.40;

use Data::Dumper;

my @grid;
for ( 1 .. 1000 )
{
    push @grid, [ (false) x 1000 ]
}

while (<>)
{
    my @instr = split;
    my $action = $instr[-4];
    my @upLeft = split(",", $instr[-3]);
    my @lowRht = split(",", $instr[-1]);

    # say "$action (@upLeft) (@lowRht)";

    for my $row ( $upLeft[0] .. $lowRht[0] )
    {
        for my $col ( $upLeft[1] .. $lowRht[1] )
        {
            if    ( $action eq "on" ) { $grid[$row][$col] = true }
            elsif ( $action eq "off") { $grid[$row][$col] = false }
            else  { $grid[$row][$col] = !$grid[$row][$col] }
        }
    }
}

use List::Util qw/sum/;
my $on = 0;
for my $r ( 0 .. 999 )
{
    $on += sum($grid[$r]->@*);
}
say $on;
