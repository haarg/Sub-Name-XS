use strict;
use warnings;

use Test::More tests => 2;
use Sub::Name::XS;
use B::Deparse;

my $source = eval {
    B::Deparse->new->coderef2text(Sub::Name::XS::set_subname foo => sub{ @_ });
};

ok !$@;

like $source, qr/\@\_/;
