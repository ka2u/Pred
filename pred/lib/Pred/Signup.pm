package Pred::Signup;

use strict;
use warnings;

use base 'Mojolicious::Controller';
use String::Random qw/random_string/;
use Digest::SHA::PurePerl qw/sha256_hex/;

sub newuser {
    my $self = shift;
    $self->render;
}

sub register {
    my $self = shift;

    # salt is 10 character
    my $salt = random_string("cccccccccc");
    my $pass = $self->req->param("password");
    my $hashed = sha256_hex($salt, $pass);

    $self->render;
}

1;
