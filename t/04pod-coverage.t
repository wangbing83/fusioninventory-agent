#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use UNIVERSAL::require;

plan(skip_all => 'Author test, set $ENV{TEST_AUTHOR} to a true value to run')
    if !$ENV{TEST_AUTHOR};

plan(skip_all => 'Test::Pod::Coverage required')
    unless Test::Pod::Coverage->require();

Test::Pod::Coverage->import();

all_pod_coverage_ok({
    coverage_class => 'Pod::Coverage::CountParents',
    also_private   => [ qw/getDescription getDescriptionHP getDescriptionOther/ ],
});
