#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# part1.pl Advent of Code 2023 Day 12 Part 1
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";
use FindBin qw($Bin); use lib "$FindBin::Bin/../../lib"; use AOC;
AOC::setup;

use Data::Dumper; $Data::Dumper::Sortkeys=1; $Data::Dumper::Indent=0;
use List::Util qw/all sum0/;

$logger->info("START");

my $ComboCount = 0;

while (<>)
{
    chomp;
    my ($rep, @groups) = split /[ ,]/;

    my @report = split //, $rep;
    $logger->info("[@report], (@groups)");

    waysToFit(\@report, @groups);
}

sub canFit($report, $seq, $where)
{
    my ($lower, $upper) = ($where, $where + $seq -1);
    return [] if $upper > $report->$#*;

    # All the covered positions must not be dots
    # Can't be adjacent to a known
    if (    ($lower == 0            || $report->[$lower-1] ne '#' )
         && ($upper == $report->$#* || $report->[$upper+1] ne '#' )
         && all { $_ ne "." } $report->@[$lower .. $upper]
     )
    {
        return [$lower, $upper];
    }
    return [];
}

sub findSeqPossibility($report, $seq, $begin = 0)
{

    my @place;
    for (my $where = $begin; $where <= $report->$#*; $where++ )
    {
        my $range = canFit($report, $seq, $where);
        push @place, $range if scalar(@$range);
    }
    return \@place;
}

sub waysToFit($report, @group)
{
    for my $place ( findSeqPossibility($report, $group[0])->@* )
    {
        $logger->info("Top level: $group[0] at $place->@*");
        count($report, \@group, 1, $place->[1]+2, "++");
    }
    say "ComboCount=$ComboCount";
}

sub count($report, $groups, $level, $bound, $indent)
{
    $logger->debug("${indent}count(report,groups,$level,$bound)");
    if ( $level > $groups->$#* )
    {
        $logger->debug("${indent}___ Base case for $level, count=$ComboCount");
        return 1;
    }

    $logger->debug("${indent}Look for $groups->[$level] at >= $bound");
    my $places = findSeqPossibility($report, $groups->[$level], $bound);
    if ( scalar(@$places) == 0 )
    {
        $logger->debug("${indent}Can't place $groups->[$level] past $bound");
        return 0;
    }
    if ( $level == $groups->$#* )
    {
        $ComboCount += scalar(@$places);
        $logger->info("${indent}Placed last group, count=$ComboCount");
        return;
    }

    for my $place ( $places->@* )
    {
        $logger->info("${indent}Level $level: found $groups->[$level] at $place->@*");
        count($report, $groups, $level+1, $place->[1]+2, "++$indent");
    }
}


$logger->info("FINISH");
