#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code Day 09 Part 1 
#=============================================================================

use v5.40;
use FindBin qw($Bin); use lib "$FindBin::Bin/../../lib"; use AOC;

AOC::setup;

# Input only contains 7 cities, so 7! = 5040 is not
# too many to check by brute force.
use Algorithm::Permute;

my %Map;

my $shortest = 0;
while (<>)
{
    my ($orig, $dest, $dist) = (split)[0,2,4];
    $logger->debug( "SETUP $orig TO $dest IS $dist" );
    $Map{$orig}{$dest} = $dist;
    $Map{$dest}{$orig} = $dist;
    $shortest += $dist;
}
$logger->info( "CITY $_" ) for sort keys %Map;

my $p = Algorithm::Permute->new([ keys %Map ]);

while ( my @route = $p->next() )
{
    #$logger->debug( "@route" );
    my $d = follow(@route);
    $logger->debug("$d FOR @route");
    next if $d < 0;
    $shortest = $d if $d < $shortest;
}
say $shortest;

sub follow(@path)
{
    my $dist = 0;
    my $first = shift @path;
    while ( defined(my $next = shift @path) )
    {
        if ( exists $Map{$first}{$next} )
        {
            $dist += $Map{$first}{$next};
        }
        else
        {
            return -1;
        }
        $first = $next;
    }
    return $dist;
}
