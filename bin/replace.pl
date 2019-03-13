use v5.18;
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
    say 'USAGE: replace <FIND_PATTERN> <SUBSTITUTE_PATTERN> [<ARBITRARY GIT GREP PARAMETERS>] [--now]';
    say '';
    say 'The patterns are treated as Perl regex patterns and the other arguments';
    say 'are treated like the corresponding grep arguments.';
    say 'If the "now" flag is not given, replace will run in dry mode';
    say '';
    say 'EXAMPLE:';
    say 'replace "number:(\d)" "digit:$1" ../libs -- \*.{cpp,h} --now';
    exit 0;
}

if ($ARGV[0] ~~ ['help', '--help', '-h']) { help; }


# Configuration parameters
my $find = shift;
my $subst = shift;
my @remaining = ();
my $dry = 1;

# Don't replace in .bak, .orig and .swp files files
#push @remaining, '--exclude="*.bak" --exclude="*.orig" --exclude="*.swp" --exclude="tags"';

# Retrieve config from commandline arguments
for my $arg (@ARGV) {
    if ($arg eq '--now') { $dry = 0; next; }
    else { push @remaining, $arg; }
}

if (not $find) {
    say 'Invalid arguments. Find pattern not given.';
    say '';
    help;
}

my $escaped_find = quotemeta $find;
my $escaped_subst = quotemeta $subst;
#my $escaped_remaining = join ' ', map { quotemeta $_ } @remaining;
my $escaped_remaining = join ' ', @remaining;

say "Input interpretation: $magenta replace $reset $find $magenta with $reset $subst $magenta in $reset $escaped_remaining";


# Do the actual shit
if ($dry) {
    my $grep_command = "git grep -IHP $escaped_find $escaped_remaining";
    say "Git grep search command: $grep_command";
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
    my $grep_command = "git grep -lIP $escaped_find $escaped_remaining";
    my $files = `$grep_command`;
    $files = join ' ', (map quotemeta, (split "\n", $files));
    my $perl_command = "perl -p -i.bak -e 's/$find/$subst/g' $files";
    say 'Perl replacement command: ', $perl_command;
    print `$perl_command`;
    say 'Replacements successful';
}

