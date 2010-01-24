package Pred::DB::HaveProject;

use strict;
use warnings;
use base 'Data::Model';
use Data::Model::Schema;

install_model have_project => schema {
    key [qw/user_id project_id/];
    columns qw/user_id project_id/;
};

1;
