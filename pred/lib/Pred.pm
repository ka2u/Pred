package Pred;

use strict;
use warnings;

use base 'Mojolicious';
#use Data::Model::Driver::DBI;
#use Pred::DB::User;
#use Pred::DB::Project;
#use Pred::DB::Story;
#use Pred::DB::Task;
#use Pred::DB::HaveProject;
use Pred::DB;

# schema
__PACKAGE__->attr(db => sub { Pred::DB->new });
#__PACKAGE__->attr(user => sub { Pred::DB::User->new });
#__PACKAGE__->attr(project => sub { Pred::DB::Project->new });
#__PACKAGE__->attr(story => sub { Pred::DB::Story->new });
#__PACKAGE__->attr(task => sub { Pred::DB::Task->new });
#__PACKAGE__->attr(have_project => sub { Pred::DB::HaveProject->new });

# This method will run once at server start
sub startup {
    my $self = shift;

    #my $driver = Data::Model::Driver::DBI->new(
    #    dsn => 'dbi:mysql:host=localhost:database=pred',
    #    username => 'pred',
    #    password => 'password',
    #);
    #$self->db->set_base_driver($driver);
    #$self->user->set_base_driver($driver);
    #$self->project->set_base_driver($driver);
    #$self->story->set_base_driver($driver);
    #$self->task->set_base_driver($driver);
    #$self->have_project->set_base_driver($driver);

    # Routes
    my $r = $self->routes;

    # Default route
    $r->route('/:controller/:action/:id')->to('example#welcome', id => 1);
}

1;
