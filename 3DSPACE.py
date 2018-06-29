# Modules
import sys
import bpy
import math
import os

# Render function
def render(name, camera):
    # Print status
    print('Rendering {}. From camera: {}'.format(name, camera))

    # Set camera
    bpy.context.scene.camera = bpy.data.objects[camera]

    # Set path for output
    file = os.path.join("/output", camera, name)
    bpy.context.scene.render.filepath = file

    # Render it
    bpy.ops.render.render(write_still = True)

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
resolution_x = int(args[8])
resolution_y = int(args[9])

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
nameString = '{:0.' + str(backPrecision) + 'f},{:0.' + str(nosePrecision) + \
    'f},{:0.' + str(wingsPrecision) + 'f}'

# Change render resolution
bpy.data.scenes["Scene"].render.resolution_x = resolution_x
bpy.data.scenes["Scene"].render.resolution_y = resolution_y

# Iterates through dimensions
for backValue in backList:
    for noseValue in noseList:
        for wingsValue in wingsList:
            # Generate name
            name = nameString.format(backValue, noseValue, wingsValue)

            # Modify model
            bpy.data.shape_keys["Key"].key_blocks["Back - X"].value = backValue
            bpy.data.shape_keys["Key"].key_blocks["Tip - Y"].value = noseValue
            bpy.data.shape_keys["Key"].key_blocks["Fins - Z"].value = wingsValue

            # Render angled if needed
            if angled:
                render(name, 'angled')

            # Render back if needed
            if back:
                render(name, 'back')

            # Render side if needed
            if side:
                render(name, 'side')
