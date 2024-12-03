#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 07 Part 1
#=============================================================================

use v5.40;

my %gate;

while (<>)
{
    chomp;
    my @c = split;
    my $out = $c[-1];

    if ( @c == 3 ) # Direct assignment
    {
        $gate{$out} = { left => $c[0], right => undef, op => sub { $_[0] } };
        if ( $c[0] =~ m/\d+/ ) { $gate{$out}{val} = $c[0] }
    }
    elsif ( m/AND/ )
    {
        $gate{$out} = { left => $c[0], right => $c[2], op => sub { $_[0] & $_[1] } };
        if ( $c[0] =~ m/\d+/ ) { $gate{$c[0]}{val} = $c[0] }
        if ( $c[2] =~ m/\d+/ ) { $gate{$c[2]}{val} = $c[2] }
    }
    elsif ( m/OR/  )
    {
        $gate{$out} = { left => $c[0], right => $c[2], op => sub { $_[0] | $_[1] } };
        if ( $c[0] =~ m/\d+/ ) { $gate{$c[0]}{val} = $c[0] }
        if ( $c[2] =~ m/\d+/ ) { $gate{$c[2]}{val} = $c[2] }
    }
    elsif ( m/NOT/ )
    {
        $gate{$out} = { left => $c[1], right => undef,  op => sub { (~$_[0]) & 0xffff } }
    }
    elsif ( m/RSHIFT/ )
    {
        $gate{$out} = { left => $c[0], right => undef, op => sub { $_[0] >> $c[2] } };
        if ( $c[0] =~ m/\d+/ ) { $gate{$c[0]}{val} = $c[0] }
        if ( $c[2] =~ m/\d+/ ) { $gate{$c[2]}{val} = $c[2] }
    }
    elsif ( m/LSHIFT/ )
    {
        $gate{$out} = { left => $c[0], right => undef, op => sub { $_[0] << $c[2] } };
        if ( $c[0] =~ m/\d+/ ) { $gate{$c[0]}{val} = $c[0] }
        if ( $c[2] =~ m/\d+/ ) { $gate{$c[2]}{val} = $c[2] }
    }
}

sub run($g)
{
    return $gate{$g}{val} if ( exists $gate{$g}{val} );

    my $left = $gate{$g}{left};
    if ( defined($left) && !exists $gate{$left}{val} )
    {
        $gate{$left}{val} = run($left);
    }
    my $right = $gate{$g}{right};
    if ( defined($right) && !exists $gate{$right}{val} )
    {
        $gate{$right}{val} = run($right);
    }
    my $opleft  = defined($left)  ? $gate{$left}{val}  : 0;
    my $opright = defined($right) ? $gate{$right}{val} : 0;
    die "g=$g" if ( ! defined($gate{$g}{op}) );
    $gate{$g}{op}->($opleft, $opright);
}

#for ( qw(x y d e f g h i ) )
#{
#    say "$_: ", run($_);
#}

my $firstA = run('a');
say "PART 1: a == $firstA";

# Reset all derived values except for constants and c
for ( keys %gate )
{
    next if m/^\d+$/;
    next if $_ eq 'c';

    delete $gate{$_}{val};
}
$gate{b}{val} = $firstA;

say "PART 2: a == ", run('a');
