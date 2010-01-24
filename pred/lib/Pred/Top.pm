package Pred::Top;

use strict;
use warnings;

use base 'Mojolicious::Controller';

sub index {
    my $self = shift;
    $self->render;
}

sub login {
    my $self = shift;
    $self->render;
}

sub logout {
    my $self = shift;
    $self->render;
}

1;
