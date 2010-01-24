package Pred::DB::Group;

use strict;
use warnings;
use base 'Data::Model';
use Data::Model::Schema;
use Data::Model::Driver::DBI;

install_model groups => schema {
    key 'id';
    columns qw/id name/;
};

1;
