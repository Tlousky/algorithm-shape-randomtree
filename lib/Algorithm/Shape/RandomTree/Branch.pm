package Algorithm::Shape::RandomTree::Branch;

use Moose;

use Algorithm::Shape::RandomTree::Branch::Point;

has 'name' => ( is => 'ro', isa => 'Str' );

has [ 'start_point', 'end_point'  ] => ( 
    is => 'ro',
    isa => 'Algorithm::Shape::RandomTree::Branch::Point' 
);

# Deltas: the difference between start and end x and y coordinates
# reflecting the slope of the branch
has [ 'dx', 'dy' ] => ( is => 'ro', isa => 'Int' );

# Level in which this branch stands in a linearly created tree
has 'level' => ( is => 'ro', isa => 'Int' );

# Line thickness
has 'width' => ( is => 'ro', isa => 'Int' );

# Contains a reference to the parent branch
has 'parent' => ( is => 'ro', isa => 'Ref' );

# Nodulation: is the attribute that determins whether this branch will
#             continue to create sub-branches
# Complexity: is the number of sub-branches this branch has if nodulation
#             is > 0 (otherwise, no new branches will be created on this 
#             branch, even if it's complexity is > 0
has [ 'nodulation', 'complexity' ] => ( is => 'ro', isa => 'Int' );

# The SVG string representaiton of the params required to create a curved path,
# which will represent the branch's geometry
has 'path_string' => ( is => 'ro', isa => 'Str' );

1;

__END__

=head1 Algorithm::Shape::RandomTree::Branch

Create an object representing a procedural, editable, randomized plant shape that
can be rendered graphically by other modules.

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Algorithm::Shape::RandomTree;

    my $foo = Algorithm::Shape::RandomTree->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=head2 function2

=head1 AUTHOR

Tamir Lousky, C<< <tlousky at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-algorithm-shape-randomtree at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Algorithm-Shape-RandomTree>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Algorithm::Shape::RandomTree


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Algorithm-Shape-RandomTree>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Algorithm-Shape-RandomTree>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Algorithm-Shape-RandomTree>

=item * Search CPAN

L<http://search.cpan.org/dist/Algorithm-Shape-RandomTree/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Tamir Lousky.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.
