#!perl

# Checking the function Algorithm::Shape::RandomTree::calc_new_deltas

use strict;
use warnings;

use Test::More tests => 10;
use Test::Exception;

use Algorithm::Shape::RandomTree;
use Algorithm::Shape::RandomTree::Branch;

## calc_new_nodulation accepts: ( $parent ) 
## and requires the RandomTree attributes: dx_range, dy_range
## and the RandomTree::Branch attributes: level, dx, dy

my $tester = Algorithm::Shape::RandomTree->new(
    dx_range => 2,
    dy_range => 2,
);

my $parent = Algorithm::Shape::RandomTree::Branch->new(
    dx    => 2,
    dy    => 2,
    level => 4,
);

## Test 1: getting parameters from objects

# t1:
ok( defined $tester->dx_range, "got a value in the Tree's dx_range attribute" );

# t2:
ok( defined $tester->dy_range, "got a value in the Tree's dy_range attribute" );

# t3:
ok( defined $parent->dx, "got a value in the Parent's dx attribute" );

# t4:
ok( defined $parent->dy, "got a value in the Parent's dy attribute" );

# t5:
ok( defined $parent->level, "got a value in the Parent's level attribute" );


## Test 2: getting the right output with correct params

my ( $new_dx, $new_dy ) = $tester->calc_new_deltas( $parent );

# t6:
ok( defined $new_dx, "a new dx value has been calculated" );

# t7:
ok( $new_dx < $parent->dx, "The new dx value is smaller than the parent's dx" );

# t8:
ok( defined $new_dy, "a new dy value has been calculated" );

# t9:
ok( $new_dy < $parent->dy, "The new dy value is smaller than the parent's dx" );

## Test 3: getting death with totally wrong params

# t10:

$parent = 1;

throws_ok { $tester->calc_new_deltas( $parent ) }
    qr{^Error in use of 'calc_new_deltas'. The wrong parameter is: parent},
    'calc_new_deltas dies with a relevant msg when given a wrong type of parent';