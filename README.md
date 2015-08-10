##Examples

Run gdg giving the name of a new directory to create. gdg will create
the directory, and add a subdirectory that is named by a generation
number. The subdirectory may be populated in any way designed. For
convenience, the full path to this generation directory is printed.

    $ gdg backup
    /home/gulan/backup/001
    cp important_file /home/gulan/backup/001/

Repeating the command will create a new generation subdirectory.

    $ gdg backup
    /home/gulan/backup/002
    cp important_file /home/gulan/backup/002/

The most recently created generation subdirectory may also be
referenced with an unchanging path called 'latest'.

    cp another_file /home/gulan/backup/latest/

    $ tree backup/
    backup/
    ├── 001
    │   └── important_file
    ├── 002
    │   ├── another_file
    │   └── important_file
    ├── latest -> 002
    └── previous -> 001

Another example:

    $ find . -ctime 0 > `gdg changed`/find.out
    $ find . -ctime 1 > `gdg changed`/find.out
    $ find . -ctime 2 > `gdg changed`/find.out
    $ tree changed/
    changed/
    ├── 001
    │   └── find.out
    ├── 002
    │   └── find.out
    ├── 003
    │   └── find.out
    ├── latest -> 003
    └── previous -> 002
    
    $ ls -l changed/latest
    lrwxrwxrwx 1 gulan gulan 3 Aug 10 14:07 changed/latest -> 003
