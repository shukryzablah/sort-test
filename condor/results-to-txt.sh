#! /usr/bin/env tcsh

# Check usage.
if (${#argv} != 1) then
    printf "USAGE: results-to-txt.sh <results directory>\n"
    exit
endif

# Assign names to the arguments.
set resultsDirectory = ${argv[1]}
set txtPath          = `pwd`/results-all.txt

# Prepare...
set pushdsilent = true
pushd ${resultsDirectory}
printf "" > ${txtPath}

# Process the results files one by one.
set resultsFileList = ( `ls *.out` )
foreach resultsFile ( ${resultsFileList} )

    # Each results files becomes its own insertion query.
    set displacement = `printf "${resultsFile}" | awk -F '-' '{ print $4 }' | awk -F '.' '{ print $1 }'`
    set resultsList = ( `cat ${resultsFile}` )
    foreach result ( ${resultsList} )
	printf "${result}, ${displacement}\n" >> ${txtPath}
    end # foreach result

end # while i

