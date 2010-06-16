#!perl

# Checking the function Algorithm::Shape::RandomTree::calc_new_endpoints

use strict;
use warnings;

use Test::More tests => 8;
use Test::Exception;

use Algorithm::Shape::RandomTree;
use Algorithm::Shape::RandomTree::Branch::Point;

## calc_new_endpoints accepts: ( $start_point, $dx, $dy ) 

my $tester = Algorithm::Shape::RandomTree->new();

## Test 1: Calculating new endpoint with correct params

my $startp = Algorithm::Shape::RandomTree::Branch::Point->new(
    x => 1,
    y => 1,
);

my ( $dx, $dy ) = ( 2, 2 );

my $x_end = $dx + $startp->x;
my $y_end = $dy + $startp->y;

my ( $retur_x_end, $retur_y_end ) = $tester->calc_new_endpoints( $startp, $dx, $dy );

# t1:
is( $retur_x_end, $x_end, 'Calculated correct endpoint.x value' );

# t2:
is( $retur_y_end, $y_end, 'Calculated correct endpoint.y value' );

## Test 2: Wrong type of start point or undef value

$startp = 1;

# t3:
throws_ok { $tester->calc_new_endpoints( $startp, $dx, $dy ) }
    qr{^Error in use of 'calc_new_endpoints'. The wrong parameter is: start point},
    'calc_new_enpoints dies with a relevant msg when given a wrong type of start point';

$startp = undef;

# t4:
throws_ok { $tester->calc_new_endpoints( $startp, $dx, $dy ) }
    qr{^Error in use of 'calc_new_endpoints'. The wrong parameter is: start point},
    'calc_new_enpoints dies with a relevant msg when given undef as a start point';
    
## Test 3: Wrong or undef dx and dy values

$startp = Algorithm::Shape::RandomTree::Branch::Point->new(
    x => 1,
    y => 1,
);

$dx = 'string';

# t5:
throws_ok { $tester->calc_new_endpoints( $startp, $dx, $dy ) }
    qr{^Error in use of 'calc_new_endpoints'. The wrong parameter is: dx},
    'calc_new_enpoints dies with a relevant msg when given a wrong type of dx';

$dx = undef;

# t6:
throws_ok { $tester->calc_new_endpoints( $startp, $dx, $dy ) }
    qr{^Error in use of 'calc_new_endpoints'. The wrong parameter is: dx},
    'calc_new_enpoints dies with a relevant msg when given undef as dx';

$dx = 2;
$dy = 'string';

# t7:
throws_ok { $tester->calc_new_endpoints( $startp, $dx, $dy ) }
    qr{^Error in use of 'calc_new_endpoints'. The wrong parameter is: dy},
    'calc_new_enpoints dies with a relevant msg when given a wrong type of dy';

$dy = undef;

# t8:    
throws_ok { $tester->calc_new_endpoints( $startp, $dx, $dy ) }
    qr{^Error in use of 'calc_new_endpoints'. The wrong parameter is: dy},
    'calc_new_enpoints dies with a relevant msg when given undef as dy';