package Pred::DB::Project;

use strict;
use warnings;
use base 'Data::Model';
use Data::Model::Schema;

install_model project => schema {
    key 'id';
    column id => int => {
        required => 1,
        unsigned => 1,
        auto_increment => 1,
    };
    columns qw/name description/;
};

1;
