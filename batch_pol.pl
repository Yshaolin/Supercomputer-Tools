#!usr/bin/perl 
#
#
use strict;
use warnings;

my @seq = @ARGV;
my $begin = shift @seq;
my $end = shift @seq;
my $program_line;
my $yhrun = shift @seq;

store_program($yhrun);
batch_pol($begin, $end, $program_line);

sub store_program {
    my $program_file_name = shift;
    open my $pro_pol, "<", $program_file_name
        or die "Can't open the \"$program_file_name\" for reading: $!";

    while(my $line = <$pro_pol>) {
        $program_line .= $line;
    }
}

sub batch_pol {
    my ($begin_1, $end_1, $pro) = @_;
    if ($end_1 > $begin_1) {
        for (my $i = $begin_1; $i <= $end_1; $i += 2) {
            my $ii = $i + 1;
            if ($pro =~ s/SD\-\{\d+,\d+\}/SD\-\{$i,$ii\}/g) {
                open my $new_program, ">", "SD_$i-$ii.sh"
                    or die "Can't open \"SD_$i-$ii \": $!";
                print $new_program "$pro";
                `yhbatch -N 5 ./SD_$i-$ii.sh`;
                `rm SD_$i-$ii.sh`
            } else {
                print "Not Match!";
            }
        }
    } else {
        print "please make sure the second number: \"$end\" biger than the first one :\"$begin\"";
    }
}
