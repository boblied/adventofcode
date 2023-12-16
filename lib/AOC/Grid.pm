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

sub grid($self) { return $self->{_grid} }
sub height($self) { return $self->{_height} }
sub width($self) { return $self->{_width} }

sub loadFile
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

1;
