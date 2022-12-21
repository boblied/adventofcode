# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Clock.pm
#=============================================================================
# Copyright (c) 2022, Bob Lied
#=============================================================================
# Description:
#=============================================================================

package Clock;

use v5.36;
use Moo;

has time => ( is => 'rw', default => 0 );

sub tick($self)
{
    $self->{time} = ($self->{time} + 1) % 240;
}

1;