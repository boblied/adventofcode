#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 10 Part 1
#=============================================================================

use v5.40;
use FindBin qw($Bin); use lib "$FindBin::Bin/../../lib"; use AOC;
AOC::setup;

my $s = shift // "1113122113";
my $TURN = shift // 40;     # Takes >20 minutes to run for 50 turns

for my $turn ( 1 .. $TURN )
{
    $logger->info("TURN $turn length(s)=", length($s));

    my $t = "";
    while ( $s =~ s/((^.)\2*)//g )
    {
        $t .= length($1).$2;
        $logger->debug( "$turn:\t$1\t=> $t" );
    }
    $s = $t;
}
say length($s);
