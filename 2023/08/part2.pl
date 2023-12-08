#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part2.pl Advent of Code Day 08 Part 2
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;
use builtin qw/trim true false/; no warnings "experimental::builtin";

use List::Util qw/all/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest = 0;
GetOptions("verbose" => \$Verbose, "test" => \$DoTest);
exit(!runTest()) if $DoTest;

my @Step;
{ @Step = split "", trim(my $s = <>); } # First line, directions

my %Graph;
while (<>)
{
    chomp;
    next if $_ eq "";
    my ($node, $left, $right) = m/([A-Z]+)/g;
    $Graph{$node} = { L => $left, R => $right };
}

my @Start = grep /A\Z/, keys %Graph;
my @Node = @Start;

say "Start: @Start" if $Verbose;

sub allZ($nodes) { ($nodes->$#* + 1 ) == grep /Z\Z/, $nodes->@* }

my $step = 0;
my $count = 0;
while ( ! allZ(\@Node) )
{
    my $dir = $Step[$step++];
    $step = 0 if $step == scalar(@Step);
    $count++; print STDERR "." if ($count % 1000000) == 0;

    @Node = map { $_->{$dir} } @Graph{@Node};
    # say "$count [ @Start ] -$dir-> [ @Node ]" if $Verbose;
    if ( $Verbose )
    {
        my $zCount = grep /Z\Z/, @Node;
        say "Z=$zCount at $count for [ @Node ]" if $Verbose and $zCount > 2;
    }
}
say "@Node" if $Verbose;
say $count;

########################################
sub runTest
{
    use Test2::V0;
    no warnings "experimental::builtin";
    is( allZ([ qw(ABC) ]),         false, "Not Z, single");
    is( allZ([ qw(ABZ) ]),         true,  "Is Z, single");
    is( allZ([ qw(ABC DEF GHI) ]), false, "Not Z, none of 3");
    is( allZ([ qw(ABC DEZ GHI) ]), false, "Not Z, 1 of 3");
    is( allZ([ qw(ABZ DEZ GHZ) ]), true,  "Is Z, 1 of 3");
    done_testing;
}
