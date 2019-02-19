#! /bin/tcsh -f

if (${#argv} != 1) then

    echo "Usage: ${argv[0]} <arbitrary int>"
    exit

endif

./test ${argv[1]}

