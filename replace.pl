use strict;
use warnings;
use feature qw(switch);
no warnings 'experimental::smartmatch';
use Term::ANSIColor;
use Term::ANSIColor 2.01 qw(colorstrip);

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


# Do shit
if ($dry) {
    my $grep_command = "grep -rHP $escaped_find $escaped_where $escaped_include $escaped_exclude";
    writeline "Grep command: $grep_command";
    my $grep_out = `$grep_command`;
    writeline $grep_out;
    my @lines = split('\n', $grep_out);


    for my $line (@lines) {
        # Retrieve grep info
        my ($file, @text) = split /\:/, $line;

        print color('magenta');
        writeline colorstrip($file);
        print color('reset');

        #print color('cyan');
        #writeline 'Patterns', $find, $subst;
        #print color('reset');

        my $text = join ':', @text;
        my $printvar;
        my $red = color('red');
        my $reset = color('reset');
        ($printvar = $text) =~ s/($find)/$red$1$reset/;
        writeline "OLD: $printvar";

        $text =~ s/$find/qq("$red$subst$reset")/gee;
        writeline "NEW: $text";
    }
}
else {
    my $grep_command = "grep -rlP $escaped_find $escaped_where $escaped_include $escaped_exclude";
    my @files = `$grep_command`;
    my $files = (join ' ', (map quotemeta, (split "\n", (join '', @files))));
    my $perl_command = "perl -pi -e 's/$find/$subst/g' $files";
    writeline 'Perl replacement command: ', $perl_command;
    `$perl_command`;
}
