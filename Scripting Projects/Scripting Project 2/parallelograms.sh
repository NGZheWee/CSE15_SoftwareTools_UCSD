
#
# Name: NG Zhe Wee (Derrick)
# PID: A16389707
# Account ID: cs15lsp21lr
# File: parallelograms.sh
# Assignment: Scripting Project 2
# Date: 5/14/2021
#
#===============================================================================
# DO NOT TOUCH BELOW THIS LINE
#===============================================================================

ERR_USAGE="Usage: ./parallelograms.sh"
ERR_INPUT="Parallelogram size must be [2,20]."
MSG_PROMPT="Enter the size of the parallelograms to display: "
MSG_REPLAY="Run again? (y/N): "
U_LIMIT=20
L_LIMIT=2

#===============================================================================
# DO NOT TOUCH ABOVE THIS LINE
#===============================================================================

# print_pattern
# Function that prints out a parallelogram pattern row by row. The pattern
# should consist of:
#
# [spaces-stars] space [stars-spaces] space [spaces-stars] space [stars]\n
#
# where
#   [spaces-stars] is a pattern consisting of spaces and stars up to a given
#                  width that will result in a triangle if printed alone
#   [stars-spaces] is a pattern consiting of stars and spaces up to a given
#                  width that will result in a triangle if printed alone
#   space          is a single space separating the blocks
#   [stars]        is a pattern consisting of only stars for the 4th triangle
#   \n             is the newline character. Printed with `echo`
#
# A parallelogram of size three looks like:
#
# *** *     * ***
#  ** **   ** **
#   * *** *** *
#
# USAGE
#   print_pattern numrows
#
# INPUT
#   numrows: number of rows of the parallelogram that should be printed
function print_pattern {
    # Finish this function. You will need nested loops here, as well as
    # basic arithmetic. This function should print the parallelograms out row by
    # row. Remember that you can do arithmetic expressions with `bc`, `expr`, or
    # $(( ... )). We've provided you with the skeleton code for the first
    # triangle. Your job is to finish the rest. Be sure to match the reference
    # implementation _exactly_!

    # Index to keep track of the current row
    ind=0

    while [ $ind -lt "$1" ]; do
        # Spaces before first triangle
        for ((inner=0; inner < $ind; inner++)); do
            echo -n " "
        done

        # HINT: Set the variable num_stars1 using the correct math for the
        # required number of stars. The value should be:
        #   num_stars1 = the first argument - the current index
        num_stars1=`expr $1 - $ind`
        for ((inner=0; inner < ${num_stars1}; inner++)); do
            echo -n "*"
        done

        echo -n " " # This line is necessary for padding

        num_stars2=`expr 1 + $ind`
        for ((inner=0; inner < ${num_stars2}; inner++)); do
            echo -n "*"
        done

        # # HINT: Remember that there is an extra space between the triangles!
        # ???
        num_spaces=`expr $1 + $1 - $ind - $ind - 1`
        for ((inner=0; inner < ${num_spaces}; inner++)); do
            echo -n " "
        done
        
        for ((inner=0; inner < ${num_stars2}; inner++)); do
            echo -n "*"
        done

        echo -n " " # This line is necessary for padding

        for ((inner=0; inner < ${num_stars1}; inner++)); do
            echo -n "*"
        done

        ind=`expr $ind + 1`
        echo # Print newline
    done
}

# print_usage_and_exit
# Function that prints an error message concerning incorrect usage to stderr and
# then terminates the script with exit status code 1
#
# USAGE
#   print_usage_and_exit
function print_usage_and_exit {
    echo $ERR_USAGE >&2
    exit 1
}

# print_input_error
# Function that prints an error to stdout notifying the user of the correct
# range of valid input values. This function SHOULD NOT terminate the script.
#
# USAGE
#   print_input_error
function print_input_error {
    echo $ERR_INPUT
}

# main
# Function that interfaces with the user. The function should prompt the user
# for the size of the parallelograms, check that the user input is within range,
# and then print the parallelograms. After printing, the function should ask the
# user if they want to "Run again? (y/N): ". If "y" or "Y" are pressed, the
# loop will run again. Otherwise, the loop will exit and the function will
# return.
#
# USAGE
#   main
function main {

    # Check that the number of input arguments is correct
    if [ $# -gt 0 ]; then
        print_usage_and_exit
    fi

    # Infinite Loop
    while [ 0 -ne 1 ]; do
        # Prompt the user to input a value
        echo -n "$MSG_PROMPT"
        read value

        # Check the user input to ensure it is safe and within range
        if ! [ "$value" -eq "$value" ] &> /dev/null; then
            # The above test-command checks that the input argument is a valid
            # integer by trying to convert it to a number. If the conversion
            # fails, then [ "$value" -eq "$value" ] has an exit status code of 2,
            # which can be inverted using !. An improper value results in an error.
            # Instead of displaying the error, send it to the null device
            # (/dev/null)
            print_input_error

            continue

        # by the upper limit U_LIMIT and lower limit L_LIMIT. If outside of
        # range, then print an input error and repeat the loop.
        elif [ $value -lt $L_LIMIT ] || [ $value -gt $U_LIMIT ]; then
            print_input_error

            continue
        fi

        # Print newline for clarity
        echo

        # Call function with number parsed
        print_pattern $value

        # HINT: This should look like the prompt above. Use the provided
        # variables at the top of the file to get the formatting for the message
        # correct!
        echo -n "$MSG_REPLAY"
        read again

        # the program.
        # HINT: Make sure your logic is correct!
        if [ $again != "y" ] && [ $again != "Y" ]; then
            break
        fi
    done
}

#===============================================================================
# DO NOT TOUCH BELOW THIS LINE
#===============================================================================

function ??? {
    echo "WARNING! TODO on line ${BASH_LINENO[0]} not implemented (or ??? was" \
         "not removed)" 1>&2
}

main "$@"

echo "Script finished."

#===============================================================================
# DO NOT TOUCH ABOVE THIS LINE
#===============================================================================
