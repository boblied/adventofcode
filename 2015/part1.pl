#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 04 Part 1
#=============================================================================

use v5.40;
use Digest::MD5 qw/md5_hex/;

my $key = shift // "iwrupvqb";

my $start = shift;
my $finish = shift;

my $need5 = true; my $need6 = true;

while ( $start <= $finish && ($need5 || $need6) )
{
    my $prefix = substr( md5_hex($key, $start), 0, 6);
    if ( $need6 && $prefix eq "000000" )
    {
        say "6zero: $start";
        $need6 = false;
    }
    elsif ( $need5 && substr($prefix, 0, 5) eq "00000" )
    {
        say "5zero: $start";
        $need5 = false;
    }
    $start++;
    say STDERR "++$start++" if ( $start % 10_000_000 == 0 );
}
