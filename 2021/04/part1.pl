#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl Advent of Code 2021 Day 04 Part 1
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# 
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Data::Dumper; $Data::Dumper::Sortkeys = 1;

use List::Util qw/all sum/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my @Move;
my @Board;
my @Number;
{
    local $/ = "";
    my $mv = <>;
    chomp($mv);
    @Move = split(",", $mv);
    # say "Moves: ", Dumper(\@Move);

    while (<> )
    {
        chomp;
        onBoard($_, \@Board, \@Number);
    }

    say "Done loading" if $Verbose;
}

say play(\@Board, \@Move, \@Number);

sub score($board, $move)
{
    my $sum = sum grep { $_ ne "X" } map { $_->@* } $board->@*;
    return $sum * $move;
}

sub play($board, $move, $number)
{
    for my $m ( $move->@* )
    {
        for ( $number->[$m]->@* )
        {
            my ($b, $r, $c) = $_->@*;
            say "$m on board $b at ($r, $c)" if $Verbose;

            $board->[$b][$r][$c] = "X";

            my @row = $board->[$b][$r]->@*;
            return score($board->[$b], $m) if ( all { $_ eq "X" } @row );

            my @col = map { $board->[$b][$_][$c] } 0 .. 4;
            return score($board->[$b], $m) if ( all { $_ eq "X" } @col );
        }
    }
}

sub onBoard($str, $board, $number)
{
    my @b;
    for my $row ( split("\n", $str) )
    {
        push @b, [ split(" ", $row) ];
    }
    #say "board", Dumper(\@b);
    push @{$board}, \@b;

    # For each number on the board, remember its location
    for my $r ( 0 .. $#b )
    {
        for my $c ( 0 .. $b[$r]->$#* )
        {
            my $n = $b[$r][$c];
            push @{$number->[$n]}, [ $board->$#*, $r, $c ];
        }
    }
}

sub runTest
{
    use Test2::V0;

    is(0, 1, "FAIL");

    done_testing;
}
