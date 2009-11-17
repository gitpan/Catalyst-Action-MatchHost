package Catalyst::Action::MatchHost;

use warnings;
use strict;
use Moose;
use namespace::autoclean;
use MRO::Compat;
extends 'Catalyst::Action';

=head1 NAME

Catalyst::Action::MatchHost - Match action against domain host name

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.02';


=head1 SYNOPSIS

Match host name

    sub method :ActionClass('MatchHost') :Host(^hostname$)
	{
		my ( $self, $c ) = @_;
		...
	}

    sub method :ActionClass('MatchHost') :HostNot(^hostname$)
	{
		my ( $self, $c ) = @_;
		...
	}


=cut

sub match
{
	my $self = shift;
	my ( $c ) = @_;
	my $host = $c->req->uri->host;

	return $self->check_domain_constraints( $host ) && $self->next::method( @_ );
}

sub check_domain_constraints
{
	my ( $self, $host ) = @_;


	if ( exists $self->attributes->{'Host'} )
	{
		foreach my $dom ( @{ $self->attributes->{'Host'} } )
		{
			if ( !$self->_test($host, $dom) )
			{
				return undef;
			}
		}
	}
	if ( exists $self->attributes->{'HostNot'} )
	{
		foreach my $dom ( @{ $self->attributes->{'HostNot'} } )
		{
			if ( $self->_test($host, $dom) )
			{
				return undef;
			}
		}
	}

	return 1;
}

sub _test
{
	my $self = shift;
	my ( $string, $test ) = @_;

	return $string =~ /$test/i;
}


=head1 AUTHOR

Anatoliy Lapitskiy, C<< <anatoliy.lapitskiy at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-catalyst-action-domain at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-Action-Domain>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Catalyst::Action::Domain


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Catalyst-Action-Domain>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Catalyst-Action-Domain>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Catalyst-Action-Domain>

=item * Search CPAN

L<http://search.cpan.org/dist/Catalyst-Action-Domain/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Anatoliy Lapitskiy.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut


__PACKAGE__->meta->make_immutable;
1; # End of Catalyst::Action::Host
