#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl Advent of Code 2021 Day 03 Part 2
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use List::Util qw/sum/;

use Getopt::Long;
my $Verbose = 0;

GetOptions("verbose" => \$Verbose);

my @report = <>;
chomp @report;

my $length = length($report[0]);

sub count($rep, $place)
{
    my $one = sum map { substr($_, $place, 1) } $rep->@*;
    my ($most, $least) = ( ( $one > ($#{$rep}/2) ) ? (1,0) : (0,1) );
    return ($most, $least);
}

sub filter($rep, $place, $val)
{
    return [ grep { substr($_, $place, 1) eq $val } $rep->@* ];
}

sub rate($report, $type)
{
    for my $b ( 0 .. length($report->[0]) )
    {
        my ($most, $least) = count($report, $b);
        say "b=$b most=$most least=$least" if $Verbose;

        $report = ( $type eq "oxygen"
                  ? filter($report, $b, $most)
                  : filter($report, $b, $least)
                  );

        last if scalar(@$report) == 1;
    }
    say "$type=$report->[0] ", oct("0b$report->[0]") if $Verbose;
    return oct("0b$report->[0]");
}

my $oxygenRating = rate(\@report, "oxygen");
my $co2Rating    = rate(\@report, "co2");

say $oxygenRating * $co2Rating;
