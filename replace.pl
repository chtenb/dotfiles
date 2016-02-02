use v5.20;
use strict;
use warnings;
use feature qw(switch);
no warnings 'experimental::smartmatch';


# Colors
use Term::ANSIColor;
my $magenta = color('magenta');
my $red = color('red');
my $reset = color('reset');


sub help {
    say 'USAGE: replace <FIND_PATTERN> <SUBSTITUTE_PATTERN> [<FILES|DIRECTORIES>] [including <PATTERNS>] [excluding <PATTERNS>] [now]';
    say;
    say 'The patterns are treated as Perl regex patterns and the files and';
    say 'directory patterns are treated like the corresponding grep arguments.';
    say 'If no files or directories are given, these default to the current';
    say 'working directory. If the "now" flag is not given, replace will run';
    say 'in dry mode';
    say;
    say 'EXAMPLE:';
    say 'replace "number:(\d)" "digit:$1" . ../libs including "*.c" "*.h" excluding "../libs/*.h" now';
    exit 0;
}

if ($ARGV[0] ~~ ['help', '--help', '-h']) { help; }


# Configuration parameters
my $find = shift;
my $subst = shift;
my @where = ();
my @include = ();
my @exclude = ();
my $dry = 1;

# Don't replace in .bak files
push @exclude, '*.bak';

# Retrieve config from commandline arguments
my $current_command = \@where;
for my $arg (@ARGV) {
    given($arg) {
        when('now') { $dry = 0; next; }
        when('including') { $current_command = \@include; next; }
        when('excluding') { $current_command = \@exclude; next; }
    }

    push @$current_command, $arg;
}

if (not @where) {
    push @where, '.';
}

if (not $find or not $subst) {
    say 'Invalid arguments.';
    say;
    help;
}

my $escaped_find = quotemeta $find;
my $escaped_subst = quotemeta $subst;
my $escaped_include = join ' ', map { sprintf "--include=%s", quotemeta $_ } @include;
my $escaped_exclude = join ' ', map { sprintf "--exclude=%s", quotemeta $_ } @exclude;
my $escaped_where = join ' ', map { quotemeta $_ } @where;

say "Input interpretation: replace $escaped_find with $escaped_subst in $escaped_where $escaped_include $escaped_exclude";


# Do the actual shit
if ($dry) {
    my $grep_command = "grep -rIHP $escaped_find $escaped_where $escaped_include $escaped_exclude";
    say "Grep search command: $grep_command";
    my $grep_out = `$grep_command`;

    # Process grep output per line
    my @lines = split("\n", $grep_out);
    for my $line (@lines) {
        # Chop down grep output
        my ($file, $text) = $line =~ /^([^:]+):(.*)$/;

        # Print everything in nice highlighting
        say "$magenta$file$reset";

        my $printvar = $text =~ s/$find/$red$&$reset/gr;
        say "OLD: $printvar";

        $printvar = $text =~ s/$find/qq("$red$subst$reset")/geer;
        say "NEW: $printvar";
    }
}
else {
    my $grep_command = "grep -rlIP $escaped_find $escaped_where $escaped_include $escaped_exclude";
    my $files = `$grep_command`;
    $files = join ' ', (map quotemeta, (split "\n", $files));
    my $perl_command = "perl -p -i.bak -e 's/$find/$subst/g' $files";
    say 'Perl replacement command: ', $perl_command;
    print `$perl_command`;
    say 'Replacements successful';
}

