unit module IO::Notification::Recursive;

use File::Find;

sub watch-recursive(Str $path, Bool :$update) is export {

    my sub watch-dirs {
        my @paths = $path, slip find :dir($path), :type<dir>;
        return Supply.merge(map { IO::Notification.watch-path($_) }, @paths>>.Str);
    }

    my $watchers = watch-dirs;
    supply {
        whenever $watchers -> $e {
            $watchers = watch-dirs if $update && $e.path.IO ~~ :d;
            emit($e); 
        }
    }
}
