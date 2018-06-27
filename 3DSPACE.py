# Modules
import sys
import bpy
import math

# Render function

# Get arguments
args = sys.argv[sys.argv.index('--'):]

# Assign arguments, indices based on input from shell script
back_step = float(args[1])
nose_step = float(args[2])
wings_step = float(args[3])
angled = bool(int(args[4]))
back = bool(int(args[5]))
side = bool(int(args[6]))
no_background = bool(int(args[7]))

# Maybe hide environment box for backgrounds
bpy.data.objects['Environment Box'].hide_render = no_background

# Calculate lists to loop over
backPrecision = len(str(back_step).split('.')[1])
backList = [round(x * back_step, backPrecision)
    for x in range(0, math.floor(1 / back_step + 1))]
nosePrecision = len(str(nose_step).split('.')[1])
noseList = [round(y * nose_step, nosePrecision)
    for y in range(0, math.floor(1 / nose_step + 1))]
wingsPrecision = len(str(wings_step).split('.')[1])
wingsList = [round(z * wings_step, wingsPrecision)
    for z in range(0, math.floor(1 / wings_step + 1))]

# Generate name strings with correct value precisions
nameString = '{:f' + backPrecision + '}'
# Iterates through dimensions
for backValue in backList:
    for noseValue in noseList:
        for wingsValue in wingsList:
            print(str(backValue) + ',' + str(noseValue) + ',' + str(wingsValue))
