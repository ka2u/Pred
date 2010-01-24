package Mojolicious::Plugin::Session;

use strict;
use warnings;

use base 'Mojolicious::Plugin';

use MojoX::Session;

sub register {
    my ($self, $app, $args) = @_;

    $args ||= {};

    my $stash_key = delete $args->{stash_key} || 'session';

    my $session = MojoX::Session->new(%$args);

    $app->plugins->add_hook(
        before_dispatch => sub {
            my ($self, $c) = @_;

            $session->tx($c->tx);

            $c->stash($stash_key => $session);
        }
    );

    $app->plugins->add_hook(
        after_dispatch => sub {
            my ($self, $c) = @_;

            $session->flush;
        }
    );
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::Session - Session plugin for Mojolicious

=head1 SYNOPSIS

    # Mojolicious::Lite
    plugin session =>
      {stash_key => 'session', store => 'dbi', expires_delta => 5};

    # Mojolicious
    $self->plugin(
        session => {
            stash_key     => 'session',
            store         => 'dbi',
            expires_delta => 5
        }
    );

=head1 DESCRIPTION

L<Mojolicious::Plugin::Session> is a session plugin for L<Mojolicious>. It
creates L<MojoX::Session> instance with provided parameters, passes $tx object
before dispatch method is called and calls flush just after dispatching.
L<MojoX::Session> instance is placed in the stash.

=head1 ATTRIBUTES

L<Mojolicious::Plugin::Session> accepts all the attributes accepted by
L<MojoX::Session> and implements the following.

=head2 C<stash_key>

    MojoX::Session instance will be saved in stash using this key.

=head1 SEE ALSO

L<MojoX::Session>

L<Mojolicious>

=head1 AUTHOR

vti, C<vti@cpan.org>.

=head1 COPYRIGHT

Copyright (C) 2009, Viacheslav Tykhanovskyi.

This program is free software, you can redistribute it and/or modify it under
the same terms as Perl 5.10.

=cut
