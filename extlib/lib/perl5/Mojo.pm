# Copyright (C) 2008-2010, Sebastian Riedel.

package Mojo;

use strict;
use warnings;

use base 'Mojo::Base';

use Carp 'croak';
use Mojo::Client;
use Mojo::Commands;
use Mojo::Home;
use Mojo::Log;
use Mojo::Transaction::Single;

__PACKAGE__->attr(
    build_tx_cb => sub {
        sub {
            my $tx = Mojo::Transaction::Single->new;
            $tx->res->headers->header('X-Powered-By' => 'Mojo (Perl)');
            return $tx;
          }
    }
);
__PACKAGE__->attr(client => sub { Mojo::Client->new });
__PACKAGE__->attr(home   => sub { Mojo::Home->new });
__PACKAGE__->attr(log    => sub { Mojo::Log->new });

# Oh, so they have internet on computers now!
our $VERSION = '0.999915';

sub new {
    my $self = shift->SUPER::new(@_);

    # Home
    $self->home->detect(ref $self);

    # Log directory
    $self->log->path($self->home->rel_file('log/mojo.log'))
      if -w $self->home->rel_file('log');

    return $self;
}

# Bart, stop pestering Satan!
sub handler { croak 'Method "handler" not implemented in subclass' }

# Start command system
sub start {
    my $class = shift;

    # We can be called on class or instance
    $class = ref $class || $class;

    # We are the application
    $ENV{MOJO_APP} ||= $class;

    # Start!
    Mojo::Commands->start(@_);
}

1;
__END__

=head1 NAME

Mojo - The Web In A Box!

=head1 SYNOPSIS

    use base 'Mojo';

    # All the complexities of CGI, FastCGI and HTTP get reduced to a
    # single method call!
    sub handler {
        my ($self, $tx) = @_;

        # Request
        my $method = $tx->req->method;
        my $path   = $tx->req->url->path;

        # Response
        $tx->res->headers->content_type('text/plain');
        $tx->res->body("$method request for $path!");
    }

=head1 DESCRIPTION

L<Mojo> provides a flexible runtime environment for Perl web frameworks.
It is a great basis for implementing your own framework.

Also included in the distribution is an MVC web framework named
L<Mojolicious>, which also supports a simplified single file mode through
L<Mojolicious::Lite>.

Currently this distribution has no requirements besides Perl 5.8.1.

=head2 The Mojo Stack

    .------------------------------------------------------------.
    |                                                            |
    |   Application  .-------------------------------------------'
    |                | .-------------------. .-------------------.
    |                | |    Mojolicious    | | Mojolicious::Lite |
    '----------------' '-------------------' '-------------------'
    .------------------------------------------------------------.
    |                           Mojo                             |
    '------------------------------------------------------------'
    .------------------. .------------------. .------------------.
    |        CGI       | |      FastCGI     | |     HTTP 1.1     |
    '------------------' '------------------' '------------------'

For documentation on the included frameworks see L<Mojolicious::Book> and
L<Mojolicious::Lite>.

=head1 ATTRIBUTES

L<Mojo> implements the following attributes.

=head2 C<build_tx_cb>

    my $cb = $mojo->build_tx_cb;
    $mojo  = $mojo->build_tx_cb(sub { ... });

The transaction builder callback, by default it builds a
L<Mojo::Transaction::Single> object.

=head2 C<client>

    my $client = $mojo->client;
    $mojo      = $mojo->client(Mojo::Client->new);

A full featured HTTP 1.1 client for use in your applications, by default a
L<Mojo::Client> object.

=head2 C<home>

    my $home = $mojo->home;
    $mojo    = $mojo->home(Mojo::Home->new);

The home directory of your application, by default a L<Mojo::Home> object
which stringifies to the actual path.

=head2 C<log>

    my $log = $mojo->log;
    $mojo   = $mojo->log(Mojo::Log->new);
    
The logging layer of your application, by default a L<Mojo::Log> object.

=head1 METHODS

L<Mojo> inherits all methods from L<Mojo::Base> and implements the following
new ones.

=head2 C<new>

    my $mojo = Mojo->new;

Construct a new L<Mojo> application.
Will automatically detect your home directory and set up logging to
C<log/mojo.log> if there's a log directory.

=head2 C<handler>

    $tx = $mojo->handler($tx);

The handler is the main entry point to your application or framework and
will be called for each new transaction.

    sub handler {
        my ($self, $tx) = @_;
    }

=head2 C<start>

    Mojo->start;
    Mojo->start('daemon');

Start the L<Mojo::Commands> command line interface for your application.

=head1 SUPPORT

=head2 Web

    http://mojolicious.org

=head2 IRC

    #mojo on irc.perl.org

=head2 Mailing-List

    http://lists.kraih.com/listinfo/mojo

=head1 DEVELOPMENT

=head2 Repository

    http://github.com/kraih/mojo/commits/master

=head1 SEE ALSO

L<Mojolicious>

=head1 AUTHOR

Sebastian Riedel, C<sri@cpan.org>.

=head1 CREDITS

In alphabetical order:

Adam Kennedy

Adriano Ferreira

Alexey Likhatskiy

Anatoly Sharifulin

Andre Vieth

Andreas Koenig

Andy Grundman

Aristotle Pagaltzis

Ask Bjoern Hansen

Audrey Tang

Breno G. de Oliveira

Burak Gursoy

Ch Lamprecht

Christian Hansen

David Davis

Gisle Aas

Graham Barr

James Duncan

Jaroslav Muhin

Jesse Vincent

Kazuhiro Shibuya

Kevin Old

Lars Balker Rasmussen

Leon Brocard

Maik Fischer

Marcus Ramberg

Mark Stosberg

Maksym Komar

Maxim Vuets

Mirko Westermeier

Pascal Gaudette

Pedro Melo

Pierre-Yves Ritschard

Rafal Pocztarski

Randal Schwartz

Robert Hicks

Shu Cho

Stanis Trendelenburg

Tatsuhiko Miyagawa

Uwe Voelker

Viacheslav Tikhanovskii

Yuki Kimoto

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008-2010, Sebastian Riedel.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
