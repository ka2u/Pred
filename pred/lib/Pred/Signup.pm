package Pred::Singup;

use strict;
use warnings;

use base 'Mojolicious::Controller';

sub new {
    my $self = shift;
    $self->render;
}

sub register {
    my $self = shift;
    $self->render;
}

1;
