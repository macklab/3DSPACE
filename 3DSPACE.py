# Modules
import sys

# Get arguments
args = sys.argv[sys.argv.index('--'):]

# Assign arguments, indices based on input from shell script
back_step = args[1]
nose_step = args[2]
wings_step = args[3]
angled = bool(int(args[4]))
back = bool(int(args[5]))
side = bool(int(args[6]))
no_background = bool(int(args[7]))

for arg in args:
    print(arg)
