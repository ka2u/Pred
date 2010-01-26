package Pred::Util;

use strict;
use warnings;
use base 'Mojo::Base';
use Digest::SHA::PurePerl qw/sha256_hex/;


sub hash {
    my ($self, $salt, $pass) = @_;

    return sha256_hex($salt, $pass);
}

1;
