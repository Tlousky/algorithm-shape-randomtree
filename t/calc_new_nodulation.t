#!perl

# Checking the function Algorithm::Shape::RandomTree::calc_new_nodulation

use strict;
use warnings;

use Test::More tests => 6;
use Test::Exception;

use Algorithm::Shape::RandomTree;
use Algorithm::Shape::RandomTree::Branch::Point;

## calc_new_nodulation accepts: ( $parent ) 
## and requires the RandomTree attributes: nodulation, ebbing_factor

my $tester = Algorithm::Shape::RandomTree->new(
    ebbing_factor => 2,
);

my $test_branch = Algorithm::Shape::RandomTree::Branch->new(
    nodulation    => 10,
);

## Test 1: succeed getting parameters from objects

# t1:
ok( defined $tester->ebbing_factor, "got a value in the Tree's ebbing_factor attribute" );

# t2:
ok( defined $test_branch->nodulation, "got a value in the Branch's nodulation attribute" );


## Test 2: succeed calculating a new nodulation value with correct params

my $result                 = $tester->calc_new_nodulation( $test_branch );
my $correct_new_nodulation = $test_branch->nodulation - $tester->ebbing_factor;

# t3:
ok( defined $result, 'got back a new nodulation value' );

# t4:
is( $result, $correct_new_nodulation, 'correct calculation of new nodulation value' );

## Test 3: wrong type of parent

$test_branch = 1;

#t5
throws_ok { $tester->calc_new_nodulation( $test_branch ) }
    qr{^Error in use of 'calc_new_nodulation'. The wrong parameter is: parent},
    'calc_new_nodulation dies with a relevant msg when given a wrong type of parent';
    
$test_branch = undef;

#6
throws_ok { $tester->calc_new_nodulation( $test_branch ) }
    qr{^Error in use of 'calc_new_nodulation'. The wrong parameter is: parent},
    'calc_new_nodulation dies with a relevant msg when given undef as parent';