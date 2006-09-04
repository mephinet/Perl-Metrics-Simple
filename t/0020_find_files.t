# $Header: /Users/matisse/Desktop/CVS2GIT/matisse.net.cvs/Perl-Metrics-Simple/t/0020_find_files.t,v 1.3 2006/09/03 17:13:29 matisse Exp $
# $Revision: 1.3 $
# $Author: matisse $
# $Source: /Users/matisse/Desktop/CVS2GIT/matisse.net.cvs/Perl-Metrics-Simple/t/0020_find_files.t,v $
# $Date: 2006/09/03 17:13:29 $
###############################################################################
use strict;
use warnings;
use English qw(-no_match_vars);
use FindBin qw($Bin);
use Readonly;
use Test::More tests => 3;

Readonly::Scalar my $TEST_DIRECTORY => "$Bin/test_files";
Readonly::Scalar my $EMPTY_STRING   => q{};
BEGIN { use_ok('Perl::Code::Analyze'); }

test_find_files();

exit;

sub set_up {
    my $analyzer = Perl::Code::Analyze->new();
}

sub test_find_files {
    my $analyzer = set_up();
    eval { $analyzer->find_files('non/existent/path'); };
    isnt( $EVAL_ERROR, $EMPTY_STRING,
        'find_files() throws exception on missing path.' );

    my $expected_list = [
        "$TEST_DIRECTORY/Perl/Code/Analyze/Test/Module.pm",
        "$TEST_DIRECTORY/no_packages_nor_subs",
        "$TEST_DIRECTORY/package_no_subs.pl",
        "$TEST_DIRECTORY/subs_no_package.pl",
    ];    
    my $found_files = $analyzer->find_files($TEST_DIRECTORY);
    is_deeply( $found_files, $expected_list,
        'find_files() find expected files' );
}