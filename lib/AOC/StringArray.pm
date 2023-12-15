# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Grid.pm
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Description: Convenience functions for handling a matrix represented
# as an array of strings, e.g.
# [ "0.#.#.",
#   ".l..33" ]
#=============================================================================

package AOC::StringArray;

use v5.38;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(showAofS transposeAofS getColAofS);
our @EXPORT_OK = qw();

sub showAofS($aOfs)
{
    my $height = $aOfs->$#*;
    my $width  = length($aOfs->[0]) - 1;
    my $colFormat = " %2s" x ($width+1);
    my $s = "\n";

    $s .= sprintf("      $colFormat\n", 0 .. $width);
    $s .=         "    + " . (" --" x ($width+1)) . "+\n";
    for my $row ( 0 .. $height )
    {
        $s .= sprintf(" %2s |$colFormat | %-2s\n", $row,
            split("", $aOfs->[$row]), $row);
    }
    $s .=          "    + " . (" --" x ($width+1)) . "+\n";
    $s .= sprintf( "      $colFormat\n", 0 .. $width);
}

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

sub getColAofS($m, $col)
{
    my $height = $m->$#*;

    return (map { substr($m->[$_], $col, 1) } 0 .. $m->$#*);
}

1;
