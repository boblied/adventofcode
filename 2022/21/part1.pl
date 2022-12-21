#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl
#=============================================================================
# Copyright (c) 2022, Bob Lied
#=============================================================================

# This is going to be a recursive-descent parser. Eventually.

use v5.36;
use lib ".";

use Parse;

readInput();

my %SymbolTable;
my %Parser;


sub readInput()
{
    while (<>)
    {
        chomp;
        my ($var, $left, $op, $right) = m/(\w+): (\w+) ([-\+\*\/]) (\w+)/;

        if ( not defined $op )
        {
            my $(name, $value) = m/(\w+): (\d+)/;
            $SymbolTable{$var} = $left;
        }
        else
        {
            $Parser{$var} = Parse->new(name => $var, left => $left, op => $op, right => $right);
        }
    }
}
