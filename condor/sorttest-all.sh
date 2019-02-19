#! /bin/tcsh -f

set taskName = test
set script = ${taskName}-one.sh
set baseDirectory = `pwd`
set baseResultsDirectory = ${baseDirectory}/results
set commandPathname = ${baseDirectory}/${taskName}.cmd
set totalJobs = 25

# Create the results directory and make it world-writeable so that
# Condor doesn't complain.
mkdir --parents --mode=700 ${baseResultsDirectory}

# Emit the arguments needed for the condor script.  These are for all
# tasks in the job.
printf "## Global job properties\n\n" > ${commandPathname}
printf "universe =     vanilla\n" >> ${commandPathname}
printf "notification = never\n" >> ${commandPathname}
printf "getenv =       true\n" >> ${commandPathname}
printf "initialdir =   ${baseDirectory}\n" >> ${commandPathname}
printf "priority =     5\n" >> ${commandPathname}
printf "executable =   ${taskName}-one.sh\n" >> ${commandPathname}
printf 'requirements = (TotalCpus == 8)\n' >> ${commandPathname}

# Loop through the arguments to be passed for each task.
set i = 0
while (${i} < ${totalJobs})

    # Make the results directory for this specific job.
    set resultsDirectory = ${baseResultsDirectory}/${i}
    mkdir --mode=700 ${resultsDirectory}

    # Emit the arguments for this task.
    printf "\n## Task properties\n" >> ${commandPathname}
    printf "log = ${resultsDirectory}/log\n" >> ${commandPathname}
    printf "output = ${resultsDirectory}/out\n" >> ${commandPathname}
    printf "error = ${resultsDirectory}/err\n" >> ${commandPathname}
    printf "arguments = ${i}\n" >> ${commandPathname}
    printf "queue\n" >> ${commandPathname}

    @ i = ${i} + 1

end

# Submit the job.
condor_submit ${commandPathname}

# Clean up.
# rm ${commandPathname}
