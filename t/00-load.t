#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Catalyst::Action::MatchHost' );
}

diag( "Testing Catalyst::Action::MatchHost $Catalyst::Action::MatchHost::VERSION, Perl $], $^X" );
