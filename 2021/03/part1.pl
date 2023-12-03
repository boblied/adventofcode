#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl Advent of Code 2021 Day 03 Part 1
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

my @report = <>;
chomp @report;

my $length = length($report[0]);

my $gamma;
for my $b ( 0 .. $length-1 )
{
    my $oneCount = 0;
    for ( @report )
    {
        $oneCount += substr($_, $b, 1);
    }
    $gamma .= ( $oneCount > (@report/2 ) ? "1" : "0" );
}
(my $epsilon = $gamma) =~ tr/01/10/;

print "gamma=$gamma epsilon=$epsilon" if $Verbose;

$gamma = oct("0b$gamma");
$epsilon = oct("0b$epsilon");
say "gamma=$gamma epsilon=$epsilon" if $Verbose;

say $gamma * $epsilon;
