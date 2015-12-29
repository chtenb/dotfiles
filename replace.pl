use strict;
use warnings;
use feature qw(switch);
no warnings 'experimental::smartmatch';

sub writeline {
    print ((join ', ', @_) ."\n");
}

sub help {
    writeline 'USAGE: replace <FIND_PATTERN> <SUBSTITUTE_PATTERN> <FILES|DIRECTORIES> [including <PATTERNS>] [exluding <PATTERNS>] [now]';
    writeline '';
    writeline 'The patterns are treated as Perl regex patterns and the files and directory patterns are treated like the corresponding grep arguments.';
    writeline 'If the "now" flag is not given, replace will run in dry mode';
    writeline '';
    writeline 'EXAMPLE: replace "number:(\d)" "digit:$1" . ../libs including "*.c" "*.h" excluding "../libs/*.h" now';
    exit 0;
}

if ($ARGV[0] ~~ ['help', '--help', '-h']) { help; }

# Configuration parameters
my $find = $ARGV[0];
my $subst = $ARGV[1];
my @where = ();
my @include = ();
my @exclude = ();
my $dry = 1;

# Retrieve config from commandline arguments
my $current_command = \@where;
for my $i (2 .. $#ARGV) {
    my $arg = $ARGV[$i];

    given($arg) {
        when('now') { $dry = 0; next; }
        when('including') { $current_command = \@include; next; }
        when('excluding') { $current_command = \@exclude; next; }
    }

    push @$current_command, $arg;
}

if (not $find or not $subst or not @where) {
    writeline 'Invalid arguments.';
    writeline '';
    help;
}

my $escaped_include = join ' ', map { sprintf "--include=%s", quotemeta $_ } @include;
my $escaped_exclude = join ' ', map { sprintf "--exclude=%s", quotemeta $_ } @exclude;
my $escaped_where = join ' ', map { quotemeta $_ } @where;
my $escaped_expr = quotemeta $find;
my $escaped_subst = quotemeta $subst;

writeline "Input interpretation: replace $escaped_expr with $escaped_subst in $escaped_where $escaped_include $escaped_exclude";

# Do shit
if ($dry) {
    my $grep_command = "grep --color=always -rHP $escaped_expr $escaped_where $escaped_include $escaped_exclude";
    writeline "Grep command: $grep_command";
    my $grep_out = `$grep_command`;
    my @lines = split('\n', $grep_out);

    for my $line (@lines) {
        # Retrieve grep info
        my ($file, @text) = split /\:/, $line;
        writeline $file;
        my $text = join '', @text;
        writeline "OLD: $text";

        # Substitute and print
        $text =~ s/$find/$subst/g;
        writeline "NEW: $text";
    }
}
else {
    my $grep_command = "grep -rlP $escaped_expr $escaped_where $escaped_include $escaped_exclude";
    my @files = `$grep_command`;
    exec 'perl', '-pi', '-e', "s/$find/$subst/g", @files;
}
