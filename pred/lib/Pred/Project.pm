package Pred::Project;

use strict;
use warnings;

use base 'Mojolicious::Controller';
use Data::Dumper;

sub input {
    my $self = shift;
    $self->render;
}

sub add {
    my $self = shift;

    my $data = {
        name => $self->req->param('name'),
        description => $self->req->param('description'),
    };

    my $row = $self->app->db->set( 'project' => $data ); 
    $self->app->db->set(
        have_project => {
            user_id => $self->app->db->get(users => { where => [ name => 'ka2u' ] })->next->id,
            project_id => $row->id,
        }
    );
    $self->render($data);
}

1;
