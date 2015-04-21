use strict;
use warnings;

use Test::More 0.88;
use Sub::Name::XS;

eval { Sub::Name::XS::get_subname(undef) };
like $@, qr/^Not a subroutine reference/, 'error for undef';
eval { Sub::Name::XS::get_subname('') };
like $@, qr/^Not a subroutine reference/, 'error for empty string';
eval { Sub::Name::XS::get_subname('welp') };
like $@, qr/^Not a subroutine reference/, 'error for string';

sub foo {}
is Sub::Name::XS::get_subname(\&foo), 'main::foo',
  'correct name for normal sub';

sub bar;
is Sub::Name::XS::get_subname(*main::bar{CODE}), 'main::bar',
  'correct name for sub stub';

#use constant BAZ => 1;
#is Sub::Name::XS::get_subname(\&BAZ), undef,
#  'correct name for constant';

my $fuzz = sub {};
is Sub::Name::XS::get_subname($fuzz), 'main::__ANON__',
  'correct name for anonymous sub';

my $lex = eval q{
  use feature 'lexical_subs';
  no warnings 'experimental::lexical_subs';
  my sub buzz {};
  \&buzz;
};
if ($lex) {
  is Sub::Name::XS::get_subname($lex), undef,
    'no name for lexical sub';
}

done_testing;
