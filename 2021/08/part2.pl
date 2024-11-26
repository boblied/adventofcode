#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part2.pl Advent of Code 2021 Day 08 part 2
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;
use builtin qw/trim true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub runTest
{
    use Test2::V0;

    is(0, 1, "FAIL");
ZZ
    done_testing;
}

while (<>)
{
    chomp;
    my ($s, $d) = split " [|] ";

    my @signal = split(" ", trim($s));
    my @digit  = split(" ", trim($d));


}
