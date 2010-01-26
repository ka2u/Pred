package Pred::Signup;

use strict;
use warnings;

use base 'Mojolicious::Controller';
use String::Random qw/random_string/;

sub newuser {
    my $self = shift;
    $self->render;
}

sub register {
    my $self = shift;

    # salt is 10 character
    my $salt = random_string('cccccccccc');
    my $pass = $self->req->param("password");
    my $hashed = $self->app->util->hash($salt, $pass);
    my $data = {
       name => $self->req->param('name'), 
       password => $hashed,
       salt => $salt,
       e_mail => $self->req->param('e_mail'),
    };
    $self->app->db->set(
        users => $data
    );

    $self->render($data);
}

1;
