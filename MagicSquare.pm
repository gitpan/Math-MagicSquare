#
# MagicSquare.pm, version 1.00 Feb 1998
#
# Copyright (c) 1998 Fabrizio Pivari Italy
#
# Free usage under the same Perl Licence condition.
#


package Math::MagicSquare;

use Carp;
use strict;
use vars qw(@ISA @EXPORT @EXPORT_OK $VERSION);

use Exporter();
@ISA= qw(Exporter);
@EXPORT=qw();
@EXPORT_OK=qw(new check print printhtml);
$VERSION='1.01';

sub new {
  my $type = shift;
  my $self = [];
  my $len = scalar(@{$_[0]});
  my $numelem = 0;
  for (@_) {
    push(@{$self}, [@{$_}]);
    $numelem += scalar(@{$_});
    }
  croak "Math::MagicSquare::new(): number of rows and columns must be equal"
    if ($numelem != $len*$len);
  bless $self, $type;
  }

sub check {
  my $self = shift;
  my $i=0; my $j=0;
  my $line1=0; my $line2=0; my $diag1=0; my $diag2=0; my $SUM=0;
  my $sms=1;
  my $len = scalar(@{$self});

# Magic Constant for a Magic Square 1,2,...,n
  my $sum=$len*($len*$len+1)/2;
# Generic Magic Constant
  for ($i=0;$i<$len;$i++) {
    $SUM+=$self->[$i][0];
    }
  if ($SUM != $sum) {$sum=$SUM;}
# Check lines and columns
  for ($i=0;$i<$len;$i++) {
    $j=0; $line1=0; $line2=0;
    for ($j=0;$j<$len;$j++) {
      $line1+=$self->[$i][$j];
      $line2+=$self->[$j][$i];
      }
    if ($line1 != $sum || $line2 != $sum) {
# This isn't a Magic
      return(0);
      }
    }
# Check diagonals
  for ($i=0;$i<$len;$i++) {
    $diag1+=$self->[$i][($i+0)%$len];
    $diag2+=$self->[$len-1-$i][($i+0)%$len];
    }
  if ($diag1 != $sum || $diag2 != $sum) {
# This is a Semimagic Square
    return(1);
    } else {
# This is a Magic Square
    return(2);
    }
  }

sub print {
  my $self = shift;
  my $row=""; my $col="";
    
  print @_ if scalar(@_);
  for $row (@{$self}) {
    for $col (@{$row}) {
      printf "%5d ", $col;
      }
    print "\n";
    }
  }

1;

__END__

=pod

=head1 NAME

Math::MagicSquare - Magic Square Checker

=head1 SYNOPSIS

  use Math::MagicSquare;

  $a= Math::MagicSquare -> new ([num,...,num],
                                 ...,
                                [num,...,num]);
  $a->print("string");
  $a->check;

=head1 DESCRIPTION

The following methods are available:

=head2 new

Constructor arguments are a list of references to arrays of the same
length.

    $a = Math::MagicSquare -> new ([num,...,num],
                                    ...,
                                   [num,...,num]);

=head2 check

This function can return 3 value

=over

=item *

B<0:> the Square is not Magic

=item *

B<1:> the Square is a B<Semimagic Square> (the sum of the rows and the columns
is equal)

=item *

B<2:> the Square is a B<Magic Square> (the sum of the rows, the columns and the
diagonals is equal)

=back

=head2 print

Prints the Square on STDOUT. If the method has additional parameters,
these are printed before the Magic Square is printed.

=head1 EXAMPLE

    use Math::MagicSquare;

    $A = Math::MagicSquare -> new ([8,1,6],
                                   [3,5,7],
                                   [4,9,2]);
    $A->print("Magic Square A:\n");
    $i=$A->check;
    if($i == 2) {print "This is a Magic Square.\n";}

 This is the output:
    Magic Square A:
        8     1     6 
        3     5     7 
        4     9     2 
    This is a Magic Square.

=head1 AUTHOR

 Fabrizio Pivari pivari@geocities.com
 member of ANFACE Software http://www.geocities.com/CapeCanaveral/Hangar/4794/

=head1 Copyright 

 Copyright 1998, Fabrizio Pivari pivari@geocities.com
 This library is free software; you can redistribute it and/or modify it under
 the same terms as Perl itself. 

=head1 Availability

 The latest version of this library is likely to be available from:
 http://www.geocities.com/CapeCanaveral/Lab/3469/
 and at any CPAN mirror

=head1 Information about Magic Square

 Do you like Magic Square?
 Do you want to know more information about Magic Square?
 Try to visit

=over

=item A very good introduction on Magic Square

http://www.astro.virginia.edu/~eww6n/math/MagicSquare.html

=item A whole collection of links and documents in Internet

http://www.pse.che.tohoku.ac.jp/~msuzuki/MagicSquare.html

=item A good collection of strange Magic Square

http://www.geocities.com/CapeCanaveral/Lab/3469/examples.html

=item The only Magic Square checker and gif maker in Internet (I think)

http://www.geocities.com/CapeCanaveral/Lab/3469/squaremaker.html

=back

=cut
