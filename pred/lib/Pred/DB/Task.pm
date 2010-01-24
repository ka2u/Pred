package Pred::DB::Task;

use strict;
use warnings;
use base 'Data::Model';
use Data::Model::Schema;
use Data::Model::Driver::DBI;

install_model task => schema {
    key 'id';
    column => int => {
        required => 1,
        unsigned => 1,
        auto_increment => 1,
    };
    columns qw/story_id description/;
};

1;
