#! /usr/bin/env tcsh

# Check usage.
if (${#argv} != 1) then
    printf "USAGE: results-to-db.sh <results directory>\n"
    exit
endif

# Assign names to the arguments.
set resultsDirectory = ${argv[1]}
set sqlPath          = `pwd`/results-to-db.mysql

# Prepare...
set pushdsilent = true
pushd ${resultsDirectory}
printf "" > ${sqlPath}

# Process the results files one by one.
set resultsFileList = ( `ls *.out` )
foreach resultsFile ( ${resultsFileList} )

    # Each results files becomes its own insertion query.
    printf "INSERT INTO sorttest\n"                                      >> ${sqlPath}
    printf "\t( algorithm, array_size, value_range, iteration, time )\n" >> ${sqlPath}
    printf "VALUES\n"                                                    >> ${sqlPath}
    cat ${resultsFile} | awk -F ',' '{ if (NR > 1) { print "," } { printf "\t(\"" $1 "\", " $2 ", " $3 ", " $4 ", " $5 " )" } }' >> ${sqlPath}
    printf ";\n"                                                        >> ${sqlPath}

end # while i

