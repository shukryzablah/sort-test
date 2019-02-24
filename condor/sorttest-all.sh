#! /usr/bin/env tcsh

set taskName             = sorttest
set script               = ${taskName}-one.sh
set baseDirectory        = `pwd`
set baseResultsDirectory = ${baseDirectory}/results
set commandPathname      = ${baseDirectory}/${taskName}.cmd

#set algorithmList      = ( bubble counting insertion merge quick radix selection )
set algorithmList      = ( counting quick )
set lengthMin          = 100
set lengthMax          = 500
set lengthIncrement    = 100
set valueRangeMax      = 1000
set iterations         = 5
set verifySort         = FALSE
set expansionMin       = 0
set expansionMax       = 4096
set expansionIncrement = 16    # Double-word alignment.

# Create the results directory and make it world-writeable so that
# Condor doesn't complain.
mkdir --parents --mode=700 ${baseResultsDirectory}

# Emit the arguments needed for the condor script.  These are for all
# tasks in the job.
printf "## Global job properties\n\n"         > ${commandPathname}
printf "universe =     vanilla\n"            >> ${commandPathname}
printf "notification = never\n"              >> ${commandPathname}
printf "getenv =       true\n"               >> ${commandPathname}
printf "initialdir =   ${baseDirectory}\n"   >> ${commandPathname}
printf "priority =     5\n"                  >> ${commandPathname}
printf "executable =   ${taskName}-one.sh\n" >> ${commandPathname}
printf 'requirements = (TotalCpus == 32)\n'  >> ${commandPathname}

foreach algorithm ( ${algorithmList} )

    set length = ${lengthMin}
    while (${length} <= ${lengthMax})

	set expansion = ${expansionMin}
	while (${expansion} <= ${expansionMax})

	    # Make the results directory for this specific task.
	    set task          = ${algorithm}-${length}-${valueRangeMax}-${expansion}
	    set resultsPrefix = ${baseResultsDirectory}/${task}

	    # Emit the arguments for this task.
	    printf "\n## Task properties\n"             >> ${commandPathname}
	    printf "log       = ${resultsPrefix}.log\n" >> ${commandPathname}
	    printf "output    = ${resultsPrefix}.out\n" >> ${commandPathname}
	    printf "error     = ${resultsPrefix}.err\n" >> ${commandPathname}
	    printf "arguments = ${algorithm} ${length} ${valueRangeMax} ${iterations} ${verifySort} ${expansion}\n" >> ${commandPathname}
	    printf "queue\n" >> ${commandPathname}

    	    @ expansion = ${expansion} + ${expansionIncrement}

	end # while expansion
    
	@ length = ${length} + ${lengthIncrement}

    end # while length

end # foreach algorithm

# Submit the job.
#condor_submit ${commandPathname}

# Clean up.
# rm ${commandPathname}
