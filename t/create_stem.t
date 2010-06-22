#!perl

# Checking the function Algorithm::Shape::RandomTree::create_stem

use strict;
use warnings;

use Test::More tests => 15;
use Test::Exception;

use Algorithm::Shape::RandomTree;
use Algorithm::Shape::RandomTree::Branch;
use Algorithm::Shape::RandomTree::Branch::Point;

## create_stem(); doesn't accept any input
## and requires the RandomTree attributes: stem_length, image_width, nodulation,
## complexity, tree_width


my $tester = Algorithm::Shape::RandomTree->new(
    stem_length => 10,
    image_width => 512,
    nodulation  => 5,
    complexity  => 5,
    tree_width  => 10,
);

## Test 1: getting parameters from objects

# t1:
ok( defined $tester->stem_length, "got a value in the Tree's stem_length attribute" );
# t2:
ok( defined $tester->image_width, "got a value in the Tree's image_width attribute" );
# t3:
ok( defined $tester->nodulation,  "got a value in the Tree's nodulation attribute"  );
# t4:
ok( defined $tester->complexity,  "got a value in the Tree's complexity attribute"  );
# t5:
ok( defined $tester->tree_width,  "got a value in the Tree's tree_width attribute"  );

## Test 2: calculating the right output

my $stem = $tester->create_stem();

# t6:
is( 
    ref $stem,
    "Algorithm::Shape::RandomTree::Branch",
    "create_stem returns the right type of object"
);

# t7:
is( $stem->name, 1, "correct name from stem branch" );

# t8:
is( 
    ref $stem->start_point,
    "Algorithm::Shape::RandomTree::Branch::Point",
    "stem's start point is of the correct object type",
);

# t9:
is( 
    ref $stem->end_point,
    "Algorithm::Shape::RandomTree::Branch::Point",
    "stem's end point is of the correct object type",
);

# t10:
is( $stem->start_point->x , int( $tester->image_width / 2 ), 'correct startpoint x val' );

# t11:
is( $stem->start_point->y , 0, 'correct startpoint y val' );

# t12:
is( $stem->level , 0, 'correct stem branch level' );

# t13:
is( $stem->complexity, $tester->complexity, 'correct stem branch complexity' );

# t14:
is( $stem->nodulation, $tester->nodulation, 'correct stem branch nodulation' );

# t15:
is( $stem->width, $tester->tree_width, 'correct stem branch width' );