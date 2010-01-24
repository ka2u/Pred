package Pred::Dashboard;

use strict;
use warnings;

use base 'Mojolicious::Controller';

sub index {
    my $self = shift;

    $self->render;
}

1;
