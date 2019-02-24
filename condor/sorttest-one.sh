#! /usr/bin/env tcsh

# Check usage.
if (${#argv} != 6) then
    printf "USAGE: sorttest-one.sh <algorithm>\n"
    printf "                       <array length>\n"
    printf "                       <value range (> 0)>\n"
    printf "                       <iterations>\n"
    printf "                       <verify sort (TRUE|FALSE)>\n"
    printf "                       <environment expansion (bytes)\n"
    exit
endif

# Assign names to the arguments.
set algorithm     = ${argv[1]}
set length        = ${argv[2]}
set range         = ${argv[3]}
set iterations    = ${argv[4]}
set verify        = ${argv[5]}
set expansionSize = ${argv[6]}

# Set an environment variable to consume the requested expansion space.
set expansion = ""
set i = 0
while (${i} < ${expansionSize})
    set expansion = "${expansion}X"
    @ i = ${i} + 1
end # while i < expansionSize
setenv ENVIRONMENT_EXPANSION_DUMMY "${expansion}"

# Run the test with the setarch option of disabling ASLR (which the `-R` flag controls).
setarch `uname -m` -R ./sorttest ${algorithm} ${length} ${range} ${iterations} ${verify}
