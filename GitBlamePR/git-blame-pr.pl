#! /usr/bin/perl
#
# Written in 2017 by Kazuho Oku
#
# To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
#
use strict;
use warnings;

my $git_blame_pid = open(my $fh, "-|", "git", "blame", "--first-parent", @ARGV)
    or die "failed to invoke git-blame:$!";

my %cached; # commit-id -> substitution string

while (my $line = <$fh>) {
    my ($commit, $src) = split / .*?\) /, $line, 2;
    $cached{$commit} = lookup($commit)
        unless $cached{$commit};
    print $cached{$commit}, ',', $src;
}

while (waitpid($git_blame_pid, 0) != $git_blame_pid) {}
exit $?;

sub lookup {
    my $commit = shift;
    if ($commit =~ /0000000/) {
        return "Not Committed Yet";
    }
    my $message = `git show --oneline $commit`;
    if ($message =~ /Merge\s+(?:pull\s+request|pr)\s+\#?(\d+)\s/i) {
        return sprintf '%-9s', "PR #$1";
    }
    return $commit;
}
