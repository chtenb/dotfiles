use strict;
use warnings;
use feature qw(switch);
no warnings 'experimental::smartmatch';


# Colors
use Term::ANSIColor;
my $magenta = color('magenta');
my $red = color('red');
my $reset = color('reset');


# Utilities
sub writeline { print ((join ' ', @_) ."\n"); }

sub help {
    writeline 'USAGE: replace <FIND_PATTERN> <SUBSTITUTE_PATTERN> <FILES|DIRECTORIES> [including <PATTERNS>] [excluding <PATTERNS>] [now]';
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

my $escaped_find = quotemeta $find;
my $escaped_subst = quotemeta $subst;
my $escaped_include = join ' ', map { sprintf "--include=%s", quotemeta $_ } @include;
my $escaped_exclude = join ' ', map { sprintf "--exclude=%s", quotemeta $_ } @exclude;
my $escaped_where = join ' ', map { quotemeta $_ } @where;

writeline "Input interpretation: replace $escaped_find with $escaped_subst in $escaped_where $escaped_include $escaped_exclude";


# Do the actual shit
if ($dry) {
    my $grep_command = "grep -rHP $escaped_find $escaped_where $escaped_include $escaped_exclude";
    writeline "Grep search command: $grep_command";
    my $grep_out = `$grep_command`;

    # Process grep output per line
    my @lines = split("\n", $grep_out);
    for my $line (@lines) {
        # Chop down grep output
        my ($file, @text) = split ':', $line;
        my $text = join ':', @text;

        # Print everything in nice highlighting
        writeline "$magenta$file$reset";

        my $printvar;
        ($printvar = $text) =~ s/$find/$red$&$reset/g;
        writeline "OLD: $printvar";

        ($printvar = $text) =~ s/$find/qq("$red$subst$reset")/gee;
        writeline "NEW: $printvar";
    }
}
else {
    my $grep_command = "grep -rlP $escaped_find $escaped_where $escaped_include $escaped_exclude";
    my $files = `$grep_command`;
    $files = join ' ', (map quotemeta, (split "\n", $files));
    my $perl_command = "perl -p -e 's/$find/$subst/g' $files";
    writeline 'Perl replacement command: ', $perl_command;
    print `$perl_command`;
    writeline 'Replacements successful';
}

