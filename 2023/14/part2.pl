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

use List::Util qw/max/;
use AOC::Grid;

AOC::setup();

$logger->info("START");

exit( ! runTest() ) if $DoTest;

my $Grid;
my $Height;
my $Width;

$Grid = readInput();
$logger->info("Grid: $Height x $Width", showAofS($Grid));

$Grid = spinCycle($Grid);
say loadVal($Grid);

sub rotate($grid)
{
    $grid = transposeAofS($grid);
    $Height = $grid->$#*;
    $Width = length($grid->[0]) -1;
}

my $CycleCount = 0;
sub spinCycle($grid)
{
    # North
    $grid = rotate($grid);
    $grid->[$_] = roll($grid->[$_]) for 0 .. $Height;
    # West
    $grid = rotate($grid);
    $grid->[$_] = roll($grid->[$_]) for 0 .. $Height;
    # South
    $grid = rotate($grid);
    $grid->[$_] = roll($grid->[$_]) for 0 .. $Height;
    # East
    $grid = rotate($grid);
    $grid->[$_] = roll($grid->[$_]) for 0 .. $Height;

    $CycleCount++;
    return $grid;
}

sub loadVal($grid)
{
    # Count boulders in each column
    my $answer = 0;
    for my $col ( 0 .. $Width )
    {
        my $n = grep /O/, map { substr($grid->[$_], $col, 1) } 0 .. $Height;
        my $val = $n * ($Width - $col + 1);
        $answer += $val;
        $logger->info("Column $col: n=$n val=$val");
    }
    return $answer;
}

sub readInput()
{
    my @map;
    while (<>)
    {
        chomp;
        push @map, $_;
    }
    # Assume square
    $Height = $#map;
    $Width  = length($map[0]) - 1;
    return \@map;
}

sub roll($s)
{
    use English;
    my $t = $s;
    while ( $s =~ /([^#]+)/g )
    {
        #$logger->debug("Run is [$1], [$LAST_MATCH_START[1] to $LAST_MATCH_END[1]] ends at ", pos $s);
        (my $rock   = $1) =~ tr/.//d;
        (my $ground = $1) =~ tr/O//d;
        my $len = $LAST_MATCH_END[1] - $LAST_MATCH_START[1];
        substr($t, $LAST_MATCH_START[1], $len, "$rock$ground");
    }
    $logger->debug("Roll: [$s] => [$t]");
    return $t;
}

$logger->info("FINISH");

sub runTest()
{
    use Test2::V0;
    is (roll("OO.O.O..##"), "OOOO....##", "roll");
    is (roll("...OO....O"), "OOO.......", "roll");
    done_testing();
}
