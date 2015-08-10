Examples
========

Run gdg giving the name of a new directory to create. gdg will create
the directory, and add a subdirectory that is named by a generation
number. The subdirectory may be populated in any way designed. For
convience, the full path to this generation directory is printed.

    $ gdg backup
    /home/gulan/gdg/backup/001
    cp important_file /home/gulan/gdg/backup/001/

Repeating the command will create a new generation subdirectory.

    $ gdg backup
    /home/gulan/gdg/backup/002
    cp important_file /home/gulan/gdg/backup/002/

The most recently created generation subdirectory may also be
referenced with an unchanging path called 'latest'.

    cp another_file /home/gulan/gdg/backup/latest/

    $ tree backup/
    backup/
    ├── 001
    │   └── important_file
    ├── 002
    │   ├── another_file
    │   └── important_file
    ├── latest -> 002
    └── previous -> 001
