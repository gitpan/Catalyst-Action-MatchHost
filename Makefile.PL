use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME          => 'Catalyst::Action::MatchHost',
	AUTHOR        => 'Anatoliy Lapitskiy <nuclon@cpan.org>',
	VERSION_FROM  => 'lib/Catalyst/Action/MatchHost.pm',
	LICENSE       => 'perl',
	ABSTRACT_FROM => 'lib/Catalyst/Action/MatchHost.pm',
	PL_FILES      => {},
	PREREQ_PM     => {
		'Catalyst::Runtime'  => '5.80',
		'Moose'    => '0',
		'namespace::autoclean' => '0',
		'MRO::Compat' => '0',
		},

	dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
	clean => { FILES    => 'Test-Output-*' },
);
