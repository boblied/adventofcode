#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl
#=============================================================================
# Copyright (c) 2022, Bob Lied
#=============================================================================

use v5.36;

use lib ".";
use Chamber;
use Piece;

my $PieceCount = 0;
my $MaxPiece = 2022;

my @Jet;

while ( (<>) )
{
    chomp;
    push @Jet, split '';
}

say "Number of jets: ", scalar @Jet;

my $c = Chamber->new();

while ( $PieceCount++ < 12 )
{
    my $p = Piece::next();

    say "Drop #$PieceCount: $p->{id}";
    $c->dropPiece($p);
    $c->show();
    my $canFall = 1;
    while ( $canFall )
    {
        if ( @Jet )
        {
            my $j = shift @Jet;
            say "Jet: $j";
            $c->doJet($j);
        }
        $canFall = $c->fall();
        say "Fall: ", $canFall;
    }
    $c->show;
}

say $c->getTop();
