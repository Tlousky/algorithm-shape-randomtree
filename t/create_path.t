#!perl

# Checking that the function Algorithm::Shape::RandomTree::create_path
# works properly and handles various types of input without a fuss

use strict;
use warnings;
use Test::More tests => 2;
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


## Test 1: The correct parameters:
my $startp = Algorithm::Shape::RandomTree::Branch::Point->new(
    x => 1,
    y => 1,
);

my $endp   = Algorithm::Shape::RandomTree::Branch::Point->new(
    x => 2,
    y => 2,
);

my ( $dx, $dy ) = ( 2, 2 );

my $path_str = $tester->create_path( $startp, $endp, $dy, $dx );

my $result   = check_path_string( $path_str, $startp->x, $startp->y, $endp->x, $endp->y );

is( $result, "success", 'created path string with fully correct params' );
# TODO: 
# Split this test to 10 tests,
# instead of checking the whole string, check each of the params
# Including that we get the "M" and "C" flags,
# And that the control point coordinates are in the proper range:
# which is defined in the actual function

## Test 2: scalars instead of objects:
$startp = 1;
$endp   = 1;

$path_str = $tester->create_path( $startp, $endp, $dy, $dx );
$result   = check_path_string( $path_str, $startp->x, $startp->y, $endp->x, $endp->y );

isnt( $result, "success", 'failes to create path without start/end point objects' );

sub check_path_string {
    
    my ( $str, $x1, $y1, $x2, $y2 ) = @_;
    # The SVG path string format:
    # M x1 y1 C cx1 cy1 cx2 cy2 x2 y2

    if ( $str =~ /^
                  M
                  \s(\d+)  # $1
                  \s(\d+)  # $2
                  \sC
                  \s(.+)   # $3
                  \s(.+)   # $4
                  \s(.+)   # $5
                  \s(.+)   # $6
                  \s(\d+)  # $7
                  \s(\d+)  # $8
                  $/x 
       ) {
        ( $1 == $x1 ) || return "failed x1 comparison";
        ( $2 == $y1 ) || return "failed y1 comparison";
        ( $7 == $x2 ) || return "failed x2 comparison";
        ( $8 == $y2 ) || return "failed y2 comparison";
        
        return "success";
    }
    
    return "failed path format regex";
}