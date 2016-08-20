
use Test;
use File::Temp;

use IO::Notification::Recursive;

my $dir = tempdir;
say "temp dir $dir";
chdir($dir);
my $f1 = open "file1", :w or die "Can't create file1";
mkdir("dir1") or die "Can't make directory dir1";
mkdir("dir2") or die "Can't make directory dir2";
chdir("dir1");
my $f2 = open "file2", :w or die "Can't create file2";

my $w = watch-recursive($dir, :update);
$w.tap(&say);

$f1.say("hi");
$f2.say("foo");
mkdir("dir3");
chdir("dir3");
my $f3 = open "file3", :w or die "Can't create file3";

.close for $f1, $f2, $f3;;

sleep 5;

done-testing;


