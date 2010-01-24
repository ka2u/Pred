package Pred::DB::Story;

use strict;
use warnings;
use base 'Data::Model';
use Data::Model::Schema;
use Data::Model::Driver::DBI;

install_model story => schema {
    key 'id';
    columns qw/id project_id user_id short_description description point start_date release_date priority done/;
};

1;
