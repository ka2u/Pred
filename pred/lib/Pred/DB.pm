package Pred::DB;

use strict;
use warnings;
use base 'Data::Model';
use Data::Model::Schema;
use Data::Model::Driver::DBI;

my $driver = Data::Model::Driver::DBI->new(
    dsn => 'dbi:mysql:host=localhost:database=pred',
    username => 'pred',
    password => 'password',
);

base_driver $driver;

install_model users => schema {
    key 'id';
    column id => int => { auto_increment => 1, required => 1, unsigned => 1, };
    columns qw/name password salt e_mail admin/;
};
install_model have_project => schema {
    key [qw/user_id project_id/];
    columns qw/user_id project_id/;
};
install_model project => schema {
    key 'id';
    column id => int => { auto_increment => 1, required => 1, unsigned => 1, };
    columns qw/name description/;
};
install_model story => schema {
    key 'id';
    column id => int => { auto_increment => 1, required => 1, unsigned => 1, };
    columns qw/project_id user_id short_description description point priority done/;
};
install_model task => schema {
    key 'id';
    column id => int => { auto_increment => 1, required => 1, unsigned => 1, };
    columns qw/story_id description/;
};

1;
