package Data::Model::Mixin;
use strict;
use warnings;

use Carp ();
$Carp::Internal{(__PACKAGE__)}++;

sub import {
    my($class, %args) = @_;
    Carp::croak "Usage: use Data::Model::Mixin modules => ['MixinModuleName', 'MixinModuleName2', .... ]"
        unless $args{modules} && ref($args{modules}) eq 'ARRAY';

    my $caller = caller;
    for my $module (@{ $args{modules} }) {
        my $pkg = $module;
        $pkg = __PACKAGE__ . "::$pkg" unless $pkg =~ s/^\+//;

        eval "use $pkg"; ## no critic
        if ($@) {
            Carp::croak $@;
        }

        my $register_methods = $pkg->register_method;
        while (my($method, $code) = each %{ $register_methods }) {
            no strict 'refs';
            *{"$caller\::$method"} = $code;
        }
    }
}


1;

=head1 NAME

Data::Model::Mixin - mixin manager for Data::Model

=head1 SYNOPSIS

  use Data::Model::Mixin modules => ['mixin_module_names'];

=head1 AUTHOR

Kazuhiro Osawa E<lt>yappo <at> shibuya <döt> plE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
