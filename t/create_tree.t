#!perl

# Checking the function Algorithm::Shape::RandomTree::create_tree

use strict;
use warnings;

use Test::More tests => 3;
use Test::Exception;

use Algorithm::Shape::RandomTree;
use Algorithm::Shape::RandomTree::Branch;
use Algorithm::Shape::RandomTree::Branch::Point;

## create_stem(); doesn't accept any input

## It requires the RandomTree attributes: complexity, nodulation
## It also calls these functions: create_stem, create_branches_recursive, create_branches

## create_stem               returns a branch object, the stem branch
## create_branches_recursive adds all the children branches recursively
## create_branchces          adds all the children branches linearly

## I must take over all three functions:
#  I need to make sure create_branches_recursive ran $complexity number of times.
#  I need to ensure create_branches              ran $levels     number of times.
#  I need to return various types of return values from create_stem.

## Create tree does not return a value. It updates the branch collection of the tree object.
#  So to know whether it was successful or not, I need to test the tree object and 
#  to make sure it actually has branches, probably.

my $create_stem_counter               = 0;
my $create_branches_counter           = 0;
my $create_branches_recursive_counter = 0;

{
    # Override functions to isolate "create_tree"
    no warnings qw/redefine once/;
    
    *Algorithm::Shape::RandomTree::create_stem = sub {
        my $case = shift;

        $create_stem_counter++;

        # create points coordinates for returned stem branch
        my $start_point = Algorithm::Shape::RandomTree::Branch::Point->new(
            x => 1, y => 1,
        );
        my $end_point = Algorithm::Shape::RandomTree::Branch::Point->new(
            x => 2, y => 2,
        );

        $case eq 'empty'   and return undef;
        $case eq 'wrong'   and return 'WrongTypeOfReturnVal';
        $case eq 'success' and return Algorithm::Shape::RandomTree::Branch->new(
            name        => 1,
            start_point => $start_point,
            end_point   => $end_point,
            dx          => 1,
            dy          => 1,
            level       => 0,
            nodulation  => 5,
            complexity  => 5,
            width       => 2,
        ); 
    };

    *Algorithm::Shape::RandomTree::create_branches = sub {
        $create_branches_counter++;
    };

    *Algorithm::Shape::RandomTree::create_branches_recursive = sub {
        $create_branches_recursive_counter++;
    };
    
}


## Test 1: make sure all necessary initialization parameters were set
my $tester = Algorithm::Shape::RandomTree->new();

# t1: both complexity and nodulation missing
throws_ok { $tester->create_tree(); }
    qr{^Error in use of 'create_tree'. Missing parameter: complexity},
    'create_tree dies with a relevant msg when required attributes are missing';
    
# t2: complexity missing
$tester = Algorithm::Shape::RandomTree->new( nodulation => 10 );

throws_ok { $tester->create_tree(); }
    qr{^Error in use of 'create_tree'. Missing parameter: complexity},
    'create_tree dies with a relevant msg when complexity is missing';
    
# t3: nodulation missing
$tester = Algorithm::Shape::RandomTree->new( complexity => 10 );

throws_ok { $tester->create_tree(); }
    qr{^Error in use of 'create_tree'. Missing parameter: nodulation},
    'create_tree dies with a relevant msg when nodulation is missing';
    
## Test 2: make sure the default is the linear algorithm

## Test 3: make sure the linear algorithm is active and works ok when explicitly chosen

## Test 4: make sure the recursive algorithm is active and works ok when chosen

