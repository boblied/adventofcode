#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl Advent of Code 2023 Day 09 Part 1
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Log::Log4perl qw(:easy);

use Getopt::Long;
my $DoTest  = 0;
my $DoDebug = 0;

my $logger = Log::Log4perl->get_logger();
Log::Log4perl->easy_init($INFO);
$logger->info("START");
my %DBLEVEL = ( 1 => $INFO, 2 => $DEBUG, 3 => $TRACE,
                i => $INFO, d => $DEBUG, t => $TRACE, );

GetOptions("test" => \$DoTest, "debug:i" => \$DoDebug);
say "$DoDebug, $DBLEVEL{$DoDebug}";
$logger->level($DBLEVEL{$DoDebug}) if $DoDebug;
exit(!runTest()) if $DoTest;

sub runTest
{
    use Test2::V0;

    is(0, 1, "FAIL");

    done_testing;
}
