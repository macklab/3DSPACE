# This file should be placed in the mounted output folder

# The bpy module is required
import bpy

# Set the size of the images rendered (integer)
bpy.data.scenes["Scene"].render.resolution_x = 400
bpy.data.scenes["Scene"].render.resolution_y = 300

# Set the camera to render from (string: side, back, angled)
bpy.context.scene.camera = bpy.data.objects['angled']

# Set whether or not background is rendered (boolean)
bpy.data.objects['Environment Box'].hide_render = False

# Modify spaceship parameters (float: 0 - 1)
bpy.data.shape_keys["Key"].key_blocks["Back - X"].value = 0.5
bpy.data.shape_keys["Key"].key_blocks["Tip - Y"].value = 1.0
bpy.data.shape_keys["Key"].key_blocks["Fins - Z"].value = 0.0

# Set file path for output, must point to /output/ and a filename (string)
bpy.context.scene.render.filepath = '/output/spaceship'

# Render the image
bpy.ops.render.render(write_still = True)
