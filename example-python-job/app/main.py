import sys

# Check if the script is called with at least one argument
if len(sys.argv) < 2:
    print("Please provide an argument.")
    sys.exit(1)

# Get the argument passed via the command line
argument = sys.argv[1]

# Print the argument
print("Argument:", argument)
