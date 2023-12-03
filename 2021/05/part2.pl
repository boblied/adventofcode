#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part2.pl Advent of Code 2021 Day 05 Part 2
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use List::Util qw/max/;

use Getopt::Long;
my $Verbose = 0;

GetOptions("verbose" => \$Verbose);

my @Line;
my $Height = 0;
my $Width  = 0;

while (<>)
{
    chomp;
    my ($x1,$y1,$x2,$y2) = m/(\d+)/g;
    say "($x1,$y1) ($x2,$y2)" if $Verbose;
    $Width  = max($Width,  $x1, $x2);
    $Height = max($Height, $y1, $y2);
    push @Line, [ $x1, $y1, $x2, $y2 ];
}

my @Grid;
push @Grid, [ map { 0 } 0 .. $Width] for 0 .. $Height;

sub showGrid()
{
    printf( "      ");
    printf(" %2d", $_) for 0 .. $Width;
    printf("\n");
    print "------", ("-" x (($Width+1)*3)), "\n";
    
    for my $y ( 0 .. $Height )
    {
        printf("%3d : ", $y);
        printf(" %2d", $Grid[$_][$y]) for 0 .. $Width;
        print "\n";
    }
}

for ( @Line )
{
    my ($x1,$y1,$x2,$y2) = $_->@*;

    if ( $x1 == $x2 )
    {
        if ( $y1 > $y2 ) { ( $y1,$y2) = ($y2,$y1) }
        for my $y ( $y1..$y2 )
        {
            $Grid[$x1][$y]++;
        }
    }
    elsif ( $y1 == $y2 )
    {
        if ( $x1 > $x2 ) { ( $x1,$x2) = ($x2,$x1) }
        for my $x ( $x1..$x2 )
        {
            $Grid[$x][$y1]++;
        }
    }
    else
    {
        my ($x,$y) = ($x1, $y1);
        my $dx = ( $x1 < $x2 ? 1 : -1 );
        my $dy = ( $y1 < $y2 ? 1 : -1 );
        do {
            $Grid[$x][$y]++;
            $x += $dx;
            $y += $dy;
        }
        for 0 .. abs($x2-$x1);
    }
}
# showGrid();

my $intersect = 0;
for my $x ( 0 .. $Width )
{
    for my $y ( 0 .. $Height )
    {
        $intersect++ if ( $Grid[$x][$y] && $Grid[$x][$y] >= 2 )
    }
}
say $intersect;
