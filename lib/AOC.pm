#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# AOC -- Advent of Code boilerplate and conveniences
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================

package AOC;
use v5.38;

use Exporter;
our @ISA = qw/Exporter/;
our @EXPORT = qw/$logger/;

our $logger;

my $DoTest  = 0;
my $DoDebug = 0;

sub setup()
{
    use Log::Log4perl qw(:easy);
    use Getopt::Long;

    $logger = Log::Log4perl->get_logger();
    Log::Log4perl->easy_init({
            level => $WARN,
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n"
        });

    my %DBLEVEL = ( 1 => $INFO, 2 => $DEBUG, 3 => $TRACE,
        i => $INFO, d => $DEBUG, t => $TRACE, );

    GetOptions("test" => \$DoTest, "debug:s" => \$DoDebug);
    $logger->level($DBLEVEL{$DoDebug}) if $DoDebug;
}

sub doTest()
{
    exit(!runTest()) if $DoTest;
}

sub runTest
{
    use Test2::V0;
    is(0, 1, "FAIL");
    done_testing;
}

1;
