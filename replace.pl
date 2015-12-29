use strict;
use warnings;
use feature qw(switch);
no warnings 'experimental::smartmatch';

# Configuration parameters
my $expr = $ARGV[0];
my $subst;
my $dir;
my @include;
my @exclude;
my $dry = 1;

# Retrieve config from commandline arguments
for my $i (1 .. $#ARGV) {
    my $command = $ARGV[$i];

    if($command eq 'now') {
        $dry = 0;
        next;
    }

    my $argument = $ARGV[$i+1];

    given($command) {
        when('with') { $subst = $argument; }
        when('in') { $dir = $argument; }
        when('including') { push @include, $argument; }
        when('excluding') { push @exclude, $argument; }
    }
}

my $escaped_include = join ' ', map { sprintf "--include=%s", quotemeta $_ } @include;
my $escaped_exclude = join ' ', map { sprintf "--exclude=%s", quotemeta $_ } @exclude;
my $escaped_expr = quotemeta $expr;
my $escaped_subst = quotemeta $subst;
my $escaped_dir = quotemeta $dir;

print "Input interpretation: replace $escaped_expr with $escaped_subst in $escaped_dir $escaped_include $escaped_exclude\n";

# Do shit
if ($dry) {
    my $grep_command = "grep --color=always -rHP $escaped_expr $escaped_dir $escaped_include $escaped_exclude";
    my $grep_out = `$grep_command`;
    #print "$grep_out\n";
    my @lines = split('\n', $grep_out);
    #print "@lines\n";

    for my $line (@lines) {
        # Retrieve grep info
        my ($file, @text) = split /\:/, $line;
        print "$file\n";
        my $text = join '', @text;
        print "   $text\n";

        # Substitute and print
        $text =~ s/$expr/$subst/g;
        print "-->$text\n";
    }
}
else {
    my $grep_command = "grep -rlP $escaped_expr $escaped_dir $escaped_include $escaped_exclude";
    my $files = `$grep_command`;
    my $result = `perl -pi -e "s/$expr/$subst/g" $files`;
    print $result;
}
