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
our @EXPORT = qw(loadFile);
our @EXPORT_OK = qw(loadFile);

sub new
{
    my $class = shift;
    $class = ref($class) || $class;
    my $self = {
        _grid => [],
        _height => 0,
        _width => 0,
    };
    bless $self, $class;
    return $self;
}

sub grid($self)   { $self->{_grid} }
sub height($self) { $self->{_height} }
sub width($self)  { $self->{_width} }

sub get($self, $row, $col) { $self->{_grid}->[$row][$col] }

sub isValidRow($self, $row) { $row >= 0 && $row <= $self->{_height} }
sub isValidCol($self, $col) { $col >= 0 && $col <= $self->{_width}  }
sub isInbounds($self, $row, $col)
{
    $self->isValidRow($row) && $self->isValidCol($col)
}

sub set($self, $row, $col, $val) { $self->{_grid}[$row][$col] = $val; return $self; }

sub show($self)
{
    my $grid = $self->{_grid};
    my $height = $self->{_height};
    my $width  = $self->{_width};
    my $colFormat = " %2s" x ($width+1);
    my $s = "\n";

    $s .= sprintf("     $colFormat\n", 0 .. $width);
    $s .=         "   + " . (" --" x ($width+1)) . "+\n";
    for my $row ( 0 .. $height )
    {
        $s .= sprintf(" %2s |$colFormat | %-2s\n", $row, $grid->[$row]->@*, $row);
    }
    $s .=          "   + " . (" --" x ($width+1)) . "+\n";
    $s .= sprintf( "     $colFormat\n", 0 .. $width);
    return $s;
}

sub loadGrid
{
    my $g = AOC::Grid->new();
    while (<>)
    {
        chomp;
        push @{$g->{_grid}}, [ split // ];
    }
    $g->{_height} = $g->{_grid}->$#*;
    $g->{_width}  = $g->{_grid}->[0]->$#*;
    return $g;
}

sub makeGrid($height, $width, $val)
{
    my @g;
    push @g, [ ($val) x ($width+1) ] for 0 .. $height;
    my $grid = AOC::Grid->new();
    $grid->{_grid} = \@g;
    $grid->{_height} = $height;
    $grid->{_width}  = $width;
    return $grid;
}

1;
