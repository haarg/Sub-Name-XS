use strict;
use warnings;
use lib 'inc';
use ExtUtils::MakeMaker::Dist::Zilla::Develop;
WriteMakefile(
    NAME => 'Sub::Name::XS',
    VERSION_FROM => 'lib/Sub/Name/XS.pm',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
);
