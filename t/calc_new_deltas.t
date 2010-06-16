#!perl

# Checking the function Algorithm::Shape::RandomTree::calc_new_deltas

use strict;
use warnings;

use Test::More tests => 15;
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


## Test 2: succeed in 