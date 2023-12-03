#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl Advebt of Code 2021 Day 02 Part 1
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;

GetOptions("verbose" => \$Verbose);
my $horiz = 0;
my $depth = 0;
while (<>)
{
    chomp;
    my ($dir, $val) = split " ";
    if    ( m/forward/ ) { $horiz += $val }
    elsif ( m/up/      ) { $depth -= $val }
    elsif ( m/down/    ) { $depth += $val }
}
say $horiz * $depth;
