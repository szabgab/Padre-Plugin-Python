package Padre::Plugin::Python;

use warnings;
use strict;
use 5.008;

our $VERSION = '0.01';

use base 'Padre::Plugin';
use Padre::Wx ();
use Padre::Wx::Dialog::Preferences();

sub padre_interfaces {
	'Padre::Plugin' => '0.91', 'Padre::Document' => '0.91';
}

sub registered_documents {
	'application/x-python' => 'Padre::Document::Python',;
}

sub plugin_enable {
	my $self = shift;

	$self->_config_settings;

#	$Padre::Wx::Dialog::Preferences::PANELS{'Padre::Wx::Dialog::Preferences::Python'} = 'Python';
}

sub menu_plugins_simple {
	my $self = shift;

	return (
		'Python' => [
			'About', sub { $self->about },
		]
	);
}

sub about {
	my ($main) = @_;

	my $about = Wx::AboutDialogInfo->new;
	$about->SetName(__PACKAGE__);
	$about->SetDescription("This plugin currently provides naive syntax highlighting for Python files\n");
	$about->SetVersion($VERSION);
	Wx::AboutBox($about);
	return;
}

###############################################################################
# Internal functions

sub _config_settings {
	my $self = shift;

	my $config = Padre->ide->config;

	$config->setting(
		name    => 'python_cmd',
		type    => Padre::Constant::ASCII,
		store   => Padre::Constant::HOST,
		default => '',
	);

	$config->setting(
		name    => 'python_interpreter_args_default',
		type    => Padre::Constant::ASCII,
		store   => Padre::Constant::HOST,
		default => '',
	);

}


1;
__END__

=head1 NAME

Padre::Plugin::Python - L<Padre> and Python

=head1 AUTHOR

Gabor Szabo, C<< <szabgab at gmail.com> >>

=head1 COPYRIGHT & LICENSE

Copyright 2013 Gabor Szabo, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
