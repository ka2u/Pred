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

    my $itr = $self->app->db->get(
        users => { 
            where => [name => $self->req->param('id')] 
        },
    );

    if ($itr->has_next) {
        my $user = $itr->next;
        my $hashed = $self->app->util->hash(
            $user->salt, 
            $self->req->param('password'));

        if ($user->password eq $hashed) {
            $self->redirect_to('/dashboard/index');
            return;
        }
    }

    $self->redirect_to('/top/index');
}

sub logout {
    my $self = shift;
    $self->render;
}

1;
