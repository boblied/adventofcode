#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# part1.pl Advent of Code 2023 Day 17 Part 1
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";
use FindBin qw($Bin); use lib "$FindBin::Bin/../../lib"; use AOC;
AOC::setup;
use AOC::Grid;
use Crucible;

$logger->info("START");

my $Map = AOC::Grid::loadGrid();
$logger->info( $Map->show );

my $heatLos = findPath($Map);
say $heatLoss;

sub findPath($map)
{
    my $crucible = Crucible->new(0,0);
}

$logger->info("FINISH");
