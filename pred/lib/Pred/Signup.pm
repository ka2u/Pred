package Pred::Singup;

use strict;
use warnings;

use base 'Mojolicious::Controller';
use String::Random qw(random_string);
use Digest::SHA::PurePerl;

sub new {
    my $self = shift;
    $self->render;
}

sub register {
    my $self = shift;

    # salt is 8 character
    my $salt = random_string("........");
    my $pass = $self->req->param("password");
    my $hashed = sha512_hex($salt . $pass);

    $self->render();
}

1;
