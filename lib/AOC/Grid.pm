# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Grid.pm
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package AOC::Grid;

use v5.38;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(transposeAofS);
our @EXPORT_OK = qw();

# Transpose a grid that's represented as an array of strings
sub transposeAofS($m)
{
    my @t;
    my $width = length($m->[0]);

    for (my $c = 0 ; $c < $width ; $c++ )
    {
        push @t, join "", map { substr($_, $c, 1) } $m->@*;
    }
    return \@t;
}

1;
