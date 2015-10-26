#!usr/bin/perl 
#
#
#
use strict;
use warnings;

my $path = "/HOME/whu_bio_wtma_1/WORKSPACE/15_10_12/work";
my $bindata;
my %para_ava;

opendir my $DIR, $path
    or die "Can't open the dir: $!";
while (my $file_dir = readdir($DIR)) {
    if ($file_dir =~ /^pol-/) {
        my @file_name = split "-", $file_dir;
        my $key_name = $file_name[1]."-".$file_name[2];
        my $same_sd = each_result($path."/".$file_dir);
        push @{$para_ava{$key_name}}, $same_sd;
    } 
}

for my $key (keys %para_ava) {
    my @numbers = @{$para_ava{$key}};
    #my $total = 0;
    #foreach (0 .. $#numbers) {
	#$total += $numbers[$_];
    #}
    my @para = split "-", $key;
    # my $ava = $total / @numbers;
    mkdir "./results";
    open my $file, ">>", "./results/$para[0].txt"
	or die "Can't open";
    print $file "$para[0] $para[1] @numbers \n";
}


sub each_result {
    my $dir = shift;
    my $total = 0;
    opendir my $DIR, $dir
        or die "Can't open $dir: $!";
    while (my $file = readdir($DIR)) {
        if ($file =~ /pol-a-[34].dat/) {
            my $num = read_end($dir."/".$file);
            $total += $num;
        }
    }
    return ($total/2);
}

sub read_end {
    my $file = shift;
    open my $data, "<", $file
        or die "Can't open the file: $!";
    seek($data, -4, 2);
    read($data, $bindata, 4);
    return unpack("f", $bindata);
#    while (read($file, $bindata, 4)) {
#        my $num = unpack("f", $bindata);
#        print "$num\n";
#    }
}

