#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# part1.pl Advent of Code 2023 Day 13 Part 1
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";
use FindBin qw($Bin); use lib "$FindBin::Bin/../../lib"; use AOC;
AOC::setup;

$logger->info("START");

my @Patterns;

local $/ = ""; # Paragraph mode
while (<>)
{
    chomp;

    my @pattern;
    for my $row ( split("\n", $_) )
    {
        push @pattern, [ split(//, $row) ];
    }
    my $height = $#pattern;
    my $width  = $pattern[0]->$#*;

    # All patterns have odd numbers of rows and columns.
    if ( ($height % 2) == 1 || ($width % 2) == 1 )
    {
        die "pattern $. has even dimension $height x $width";
    }
    $logger->info("Pattern $.: ", $#pattern, ' x ', $pattern[0]->$#*);

    my $left = vertReflect(\@pattern, $height, $width);
    my $above = horizReflect(\@pattern, $height, $width);

    say "Vertical: $left, Horizontal: $above";
}

sub vertReflect($pattern, $height, $width)
{
    # Find possible axis of reflection by looking diagonally
    for my $axis ( 1 .. $width-1 )
    {
        my $isReflection = true;
        my $row = 0;
        my ($left, $right) = ($axis, $axis+1);
        while ( $left >= 0 && $right <= $width && $isReflection )
        {
            $isReflection = $pattern->[$row][$left] eq $pattern->[$row][$right];
            $row++;
            $left--; $right++;
        }
        next unless $isReflection;

        my $range;
        if ( $left == 0 )          { $range = $axis }
        elsif ( $right == $width ) { $range = $right - $axis }

        # We have a possible axis, verify that every row reflects around it.
        $isReflection = true;
        for ( my $row = 0 ; $row <= $height && $isReflection ; $row++ )
        {
            $isReflection = isSymmetric($pattern->[$row], $axis, $range);
        }
        return ($axis+1) if $isReflection;

    }
    return 0;
}

sub isSymmetric($list, $axis, $range)
{
    use List::Util qw/pairwisea all/;
    my @left  =         $list->@[$axis-$range+1 .. $axis];
    my @right = reverse $list->@[$axis+1        .. $axis + $range];

    return all { $_ } pairwise { $a eq $b } @left, @right
}

sub horizReflect($pattern, $height, $width)
{
    return 0;
}


$logger->info("FINISH");
