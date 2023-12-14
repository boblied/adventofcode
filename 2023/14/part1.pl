#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# part1.pl Advent of Code 2023 Day 14 Part 1
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";
use FindBin qw($Bin); use lib "$FindBin::Bin/../../lib"; use AOC;
AOC::setup;

$logger->info("START");

my $Grid;
my $Height;
my $Width;

readInput();
$logger->info("Grid: $Height x $Width", showGrid($Grid));

sub readInput()
{
    my @map;
    while (<>)
    {
        chomp;
        push @map, $_;
    }

    $Grid = transpose(\@map);
    $Height = $Grid->$#*;
    $Width  = length($Grid->[0]);
}


sub transpose($m)
{
    my @t;
    my $width = length($m->[0]);

    for (my $c = 0 ; $c < $width ; $c++ )
    {
        push @t, join "", map { substr($_, $c, 1) } $m->@*;
    }
    return \@t;
}

sub condense($s)
{
}

$logger->info("FINISH");
