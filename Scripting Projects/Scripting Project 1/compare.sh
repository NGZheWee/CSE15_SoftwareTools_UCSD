
# TODO: Complete the first line of the script with the correct location for
# bash
#
# Name: NG Zhe Wee (Derrick)
# PID: A16389707
# Account ID: cs15lsp21lr
# File: compare.sh
# Assignment: Scripting Project 1
# Date: 5/10/2021
#
#
#===============================================================================
# DO NOT TOUCH BELOW THIS LINE
#===============================================================================

ERR_USAGE="Usage: ./compare.sh myprog solprog
       ./compare.sh -i test_input myprog solprog"

MY_OUTPUT="tmp_prog.txt"
SOL_OUTPUT="tmp_sol.txt"
DIFF_RESULTS="results.txt"

#===============================================================================
# DO NOT TOUCH ABOVE THIS LINE
#
#
# ========================== YOUR CODE STARTS BELOW ===========================

# check_results
# Function that compares two input files using diff. If the files are different,
# then two messages are printed (one to stdout and one to stderr) and a file
# containing their differences is saved in the current working directory. If the
# files are the same, then one message is printed to stdout and the file
# containing their differences is deleted after creation.
#
# USAGE
#   check_results filename1 filename2
#
# INPUT
#   filename1: name of the first file for comparison
#   filename2: name of the second file for comparison
function check_results {
    output1="$1"
    output2="$2"

    # Compare the results using diff and save it to the filename stored in
    # the variable DIFF_RESULTS
    diff $output1 $output2 > $DIFF_RESULTS

    # Check if the file stored in DIFF_RESULTS contains any characters
    if [[ `cat $DIFF_RESULTS |wc -c` -ne 0 ]]; then
        echo "Outputs are not identical. :("
        echo "Check out ${DIFF_RESULTS} for more details" >&2
    else
        echo "Outputs are identical. Great job!"
        rm "${DIFF_RESULTS}"
    fi
}

# clean
# Function that removes any temporary output files in the current working
# directory if they are present
#
# USAGE
#   clean
function clean {
    # Remove the temporary output files stored in the variables
    # MY_OUTPUT and SOL_OUTPUT
    rm -rf $MY_OUTPUT
    rm -rf $SOL_OUTPUT
}

# prog_compare
# Function that compares the output of two different programs
#
# USAGE
#   prog_compare myprog solprog
#
# INPUT
#   myprog: name of script or program that will be tested against the solution
#   solprog: name of the solution implementation of the program
function prog_compare {
    # Set incoming arguments to correct variables
    program="$1"
    solution="$2"

    # Run both the program and the solution and save the output to the
    # correct temporary output file (hint: myprog should save to the filename
    # stored in MY_OUTPUT and solprog should save to the filename stored in
    # SOL_OUTPUT)
    $program > $MY_OUTPUT
    $solution > $SOL_OUTPUT

    check_results "${MY_OUTPUT}" "${SOL_OUTPUT}"

    clean
}

# prog_compare_with_input
# Function that compares the output of two different programs given an input
# test file (redirect the input file into the stdin of the program you specify)
#
# USAGE
#   prog_compare_with_input testfile myprog solprog
#
# INPUT
#   testfile: name of file that will be fed to stdin of the programs under test
#   myprog: name of script or program that will be tested against the solution
#   solprog: name of the solution implementation of the program
function prog_compare_with_input {
    # Set incoming arguments to correct variables
    program="$2"
    solution="$3"
    input_file="$1"

    # Check if the input_file exists
    if [ -f $input_file ]; then
        # If it does exist, run both the program and the solution using
        # input_file as the input to the two programs and outputting to the
        # correct temporary output file
        $program < $input_file > $MY_OUTPUT
        $solution < $input_file > $SOL_OUTPUT
    else
        print_error_and_exit
    fi

    check_results "${MY_OUTPUT}" "${SOL_OUTPUT}"

    clean
}

# check_permissions
# Function that checks if the given file is executable and terminates the script
# with exit status code 1 if the permissions are incorrect
#
# USAGE
#   check_permissions prog
#
# INPUT
#   prog: name of a script or program
function check_permissions {
    # Set incoming arguments to correct variables
    program="$1"

    # Check if the file exists and if it can be read and executed
    if [ -x $input_file ]; then
        echo "${program} is valid"
    else
        echo "Error: Bad permissions or file does not exist (${program})" >&2

        # Terminate the script with exit status code 1
        exit -1
    fi
}

# print_error_and_exit
# Function that prints an error message concerning incorrect usage to stderr and
# then terminates the script with exit status code 1
#
# USAGE
#   print_error_and_exit
function print_error_and_exit {
    echo "${ERR_USAGE}" >&2

    # Terminate the script with exit status code 1
    exit -1
}

#===============================================================================
# DO NOT TOUCH BELOW THIS LINE
#===============================================================================

function ??? {
    echo "WARNING! TODO on line ${BASH_LINENO[0]} not implemented (or ??? was" \
         "not removed)" 1>&2
}

function main {
    if [ "$#" -le 1 ] || [ "$#" -eq 3 ] || [ "$#" -ge 5 ]; then
        print_error_and_exit

    elif [ "$#" -eq 2 ]; then
        check_permissions "$1"
        check_permissions "$2"
        prog_compare "$1" "$2"

    elif [ "$#" -eq 4 ]; then
        if [ "$1" != "-i" ]; then
            print_error_and_exit
        else
            check_permissions "$3"
            check_permissions "$4"
            prog_compare_with_input "$2" "$3" "$4"
        fi

    else
        print_error_and_exit
    fi
}

main "$@"

#===============================================================================
# DO NOT TOUCH ABOVE THIS LINE
#===============================================================================
