#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl Advent of Code 2021 Day 07 Part 1
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;
use builtin qw/ceil floor/; no warnings "experimental::builtin";

use List::Util qw/sum max min/;

use Getopt::Long;
my $Verbose = 0;
GetOptions("verbose" => \$Verbose);

my @crab = sort { $a <=> $b } split ",", <>;

my $mean = sum(@crab) / @crab;
my $median = @crab[  $#crab/2 ];

# say "mean=$mean median=$median";

sub d($v, $x)
{
    sum map { abs($v->[$_] - $x) } 0 .. $v->$#*;
}

# for my $x ( 0 .. (max @crab) )
# {
#     say d(\@crab, $x), " : $x";
# }

say min map { d(\@crab, $_) } 0 .. max(@crab);
