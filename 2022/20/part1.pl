#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# part1.pl
#=============================================================================
# Copyright (c) 2022, Bob Lied
#=============================================================================

use v5.36;

use File::Slurper qw/read_lines/;

sub show($m, $hdr=1)
{
    my $len = scalar(@$m);
    if ( $hdr ) { printf("%3d ", $_) for ( 0 .. $len-1 ); print "\n" };
    printf("%3d ", $_) for $m->@*; print "\n";
}

sub mix($in, $out)
{
    my $len = scalar(@$in);

    show($in);

    my $i = 0;
    my $posInOut = 0;
    while ( $i < $len )
    {
        my $rotate = $in->[$i];
        my $newPos = ($i + $rotate + ( $rotate < 0 ? -1 : 0 )) % $len;

        say "rot $rotate at i=$i (out=$posInOut) new=$newPos";

        # Insert at new pos
        splice(@$out, $newPos, 0, $rotate);
        print "INSERT: "; show $out, 0;


        # Delete at old position. If we inserted before i, i moved up
        splice(@$out, ( $newPos < $posInOut ? $posInOut+1 : $posInOut), 1);
        print "DELETE: "; show($out, 0);

        if ( $newPos < $i )
        {
            ++$i;
            --$posInOut;
        }
        $i++;
        $posInOut++;
    }
}

my @MessageInput;
my @Message;
for ( @ARGV )
{
    @MessageInput = map { $_+0 } read_lines($_);
}
@Message = @MessageInput;

mix(\@MessageInput, \@Message);

if ( @Message > 10 )
{
    say "HEAD:  @MessageInput[0..9]";
    say "Tail  @MessageInput[-10..-1]";
}
else
{
    say "IN:  @MessageInput";
    say "OUT: @Message";
}
