#!perl

# Checking that the function Algorithm::Shape::RandomTree::create_path
# works properly and handles various types of input without a fuss

use strict;
use warnings;

use Test::More tests => 16;
use Test::Exception;

use Algorithm::Shape::RandomTree;
use Algorithm::Shape::RandomTree::Branch::Point;

my $tester = Algorithm::Shape::RandomTree->new(
    branch_curve => 2,
);

# create_path accepts: ( $self, $start, $end, $dx, $dy )

# For each var, except $self, I need to test that the function handles propely:
# 1. The right value                                  ( that returns the right result )
# 2. The wrong value                                  (die?)
# 2. The wrong type (array / hash / object / scalar ) (die?)
# 3. No value                                         (die?)

# Function-wise, check that it can handle:
# 4. Too many values             (die? ignore and use first values?)
# 5. Too few values              (die?)
# 5. The right number of values  (that give the expected result)

## Test 0: check that we have a value in branch_curve

# t1:
ok( defined $tester->branch_curve, "got a value in the Tree's branch_curve attribute" );

## Test 1: The right result with correct parameters:
my $startp = Algorithm::Shape::RandomTree::Branch::Point->new(
    x => 1,
    y => 1,
);

my $endp   = Algorithm::Shape::RandomTree::Branch::Point->new(
    x => 2,
    y => 2,
);

my ( $dx, $dy ) = ( 2, 2 );

my $path_str = $tester->create_path( $startp, $endp, $dx, $dy );
my $phandle  = $tester->branch_curve * sqrt( $dx ** 2 + $dy ** 2 );

# Check path string thoroughly, all params included. Total of 11 test:
my $result   = check_path_string( $path_str, $startp->x, $startp->y, $endp->x, $endp->y, $phandle );

## Test 2: scalars instead of Point objects:
$startp = 1;

# t13:
throws_ok { $tester->create_path( $startp, $endp, $dx, $dy ) }
    qr{^Error in use of 'create_path'. The wrong parameter is: start point},
    'create_path dies with a relevant msg when given a wrong type of start point';

$startp = Algorithm::Shape::RandomTree::Branch::Point->new(
    x => 1,
    y => 1,
);

$endp = 1;

# t14:
throws_ok { $tester->create_path( $startp, $endp, $dx, $dy ) }
    qr{^Error in use of 'create_path'. The wrong parameter is: end point},
    'create_path dies with a relevant msg when given a wrong type of end point';

## Test 3: strings instead of numbers in dx and dy

$endp = Algorithm::Shape::RandomTree::Branch::Point->new(
    x => 2,
    y => 2,
);

$dx = 'string';

# t15:
throws_ok { $tester->create_path( $startp, $endp, $dx, $dy ) }
    qr{^Error in use of 'create_path'. The wrong parameter is: dx},
    'create_path dies with a relevant msg when given a wrong type of dx value';

$dx = 2;
$dy = 'string';

# t16:
throws_ok { $tester->create_path( $startp, $endp, $dx, $dy ) }
    qr{^Error in use of 'create_path'. The wrong parameter is: dy},
    'create_path dies with a relevant msg when given a wrong type of dy value';



sub check_path_string {
    
    my ( $str, $x1, $y1, $x2, $y2, $phandle ) = @_;
    # The SVG path string format:
    # M x1 y1 C cx1 cy1 cx2 cy2 x2 y2

    my $match = 1 if ( $str =~ /^
                  (M)      # $1  => M
                  \s(\d+)  # $2  => x1
                  \s(\d+)  # $3  => y1
                  \s(C)    # $4  => C
                  \s(.+)   # $5  => cx1
                  \s(.+)   # $6  => cy1
                  \s(.+)   # $7  => cx2
                  \s(.+)   # $8  => cy2
                  \s(\d+)  # $9  => x2
                  \s(\d+)  # $10 => y2
                  $/x 
    );

    # t2:
    ok( $match, 'Got a properly formatted path string' );

    # t3-t8:
    is( $1,  'M', 'Got M flag in path string' );
    is( $2,  $x1, 'Correct x1 in path string' );
    is( $3,  $y1, 'Correct y1 in path string' );
    is( $4,  'C', 'Got C flag in path string' );
    is( $9,  $x2, 'Correct x2 in path string' );
    is( $10, $y2, 'Correct y2 in path string' );

    my $cx1_in_range = 1 if ( ( $5 < $phandle ) and ( $5 > ( $phandle * -1 ) ) );
    my $cy1_in_range = 1 if ( ( $6 < $phandle ) and ( $6 > ( $phandle * -1 ) ) );
    my $cx2_in_range = 1 if ( ( $7 < $phandle ) and ( $7 > ( $phandle * -1 ) ) );
    my $cy2_in_range = 1 if ( ( $8 < $phandle ) and ( $8 > ( $phandle * -1 ) ) );

    # t9-t12:
    ok( $cx1_in_range, "cx1's value in proper range" );
    ok( $cy1_in_range, "cy1's value in proper range" );
    ok( $cx2_in_range, "cx2's value in proper range" );
    ok( $cy2_in_range, "cy2's value in proper range" );

}