package Algorithm::Shape::RandomTree::Branch::Point;

use Moose;
use namespace::autoclean;

has [ 'x', 'y' ] => ( is => 'ro', isa => 'Int' );

no Moose;

1;
