#!/usr/bin/perl 

use strict;
use warnings;

my $count = 0;
my @file_name = @ARGV;
my @config_arry;
my $program_line;
my $temp_program;
#把配置储存到二维数组
while (@file_name) {
    my $confi_file_name = shift @file_name;
    if (-e $confi_file_name && -f $confi_file_name) {
        if ($confi_file_name =~ /.*\.cpp/) {
            store_program($confi_file_name);
        } else {
            store_config($confi_file_name);
        }
    } else {
        print "\"$confi_file_name\" does't exists or not a file !";
    }
}
creat_file($program_line, \@config_arry,"pol");

#用于储存配置文件中的信息到一个数组中
sub store_config {
    my $confi_file_name = shift;
    open my $config_file, '<', $confi_file_name 
        or die "Can't open the '$confi_file_name' for reading: $!";
    my @config_list;
    while (my $line = <$config_file>) {
        next if $line =~ /^\s*$/;
        chomp($line);
        $line =~ s///g;
        if ($line =~ /#define.*/) {
            push @config_list, $line;
        }
    }
    push @config_arry, [@config_list];
}

#用于储存源程序，保存到一个字符串中
sub store_program {
    my $program_file_name = shift;
    open my $program, '<', $program_file_name
        or die "Can't open the \"$program_file_name\" for reading: $!";

    while(my $line = <$program>) {
        $program_line .= $line;
    }
}

sub creat_file {
    mkdir "./work";
    my ($program, $p_arry, $file_name) = @_;
    my @para_arry = @{$p_arry->[0]};

    while (@para_arry) {
        my $para = shift @para_arry;
        my @temp_arry = split(/\s+/, $para);
        my $temp_program = $program;
        if ($temp_program =~ s#$temp_arry[0]\s+$temp_arry[1]\s+.*\d#$temp_arry[0] $temp_arry[1] $temp_arry[2]#g) {
            my $file_name2 = "$file_name-$temp_arry[1]-$temp_arry[2]";
#            my @p_arry2 = @{$p_arry->[1..$#$p_arry]};
            my @p_arry2 = @{$p_arry}[1..$#$p_arry];
            if (@p_arry2) {
                creat_file($temp_program, \@p_arry2, $file_name2);
                next;
            }
            mkdir("./work/$file_name2");
            open FILE, '>', "./work/$file_name2/$file_name2.cpp"
                or die "Can't create!";
            print FILE "$temp_program" and `g++ -O3 ./work/$file_name2/$file_name2.cpp -o ./work/$file_name2/$file_name2.out`;
            $count++;
	    print "已编译程序：$count 个\n" if ($count%10 == 0);
        } else {
            print "Erro Not Match!!\n";
        }
    }
}
