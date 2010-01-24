package Pred::DB::User;

use strict;
use warnings;
use base 'Data::Model';
use Data::Model::Schema;
use Data::Model::Driver::DBI;

install_model users => schema {
    key 'id';
    column id => int => {
        required => 1,
        unsigned => 1,
        auto_increment => 1,
    };
    columns qw/name password salt e_mail admin/;
};

1;
