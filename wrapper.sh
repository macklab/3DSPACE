#!/bin/bash
local=/usr/local

# Generation parameters
step=
back_step=
nose_step=
wings_step=
generate_models=0

# Rendering parameters
threads=0
angled=0
back=0
side=0
no_background=0
height=
width=

# Custom python file
custom_python=

# Assign arguments
while [ "$1" != "" ]; do
  case $1 in
    --step )
      shift
      step=$1
      ;;
    --back_step )
      shift
      back_step=$1
      ;;
    --nose_step )
      shift
      nose_step=$1
      ;;
    --wings_step )
      shift
      wings_step=$1
      ;;
    -t|--threads )
      shift
      threads=$1
      ;;
    --perspectives )
      shift
      perspectives=$1
      ;;
    --angled )
      angled=1
      ;;
    --back )
      back=1
      ;;
    --side )
      side=1
      ;;
    --no_background )
      no_background=1
      ;;
    --width )
      shift
      width=$1
      ;;
    --height )
      shift
      height=$1
      ;;
    --custom_python )
      shift
      custom_python=$1
      ;;
    --generate_models )
      generate_models=1
      ;;
    -h|--help )
      echo "This is help"
      exit
      ;;
    * )
      # Incorrect parameters
      echo "Error: Incorrect parameter - $1"
      exit 1
  esac
  shift
done

if [ ! -z $custom_python ]; then # Use custom rendering script flag
  if [ -f /output/$custom_python ]; then # Check if the rendering script exists
    # Run blender using custom rendering script
    $local/blender/blender $local/3DSPACE.blend --background -noaudio -Y \
      -t $threads -P /output/$custom_python
  else # Rendering script doesn't exist
      echo "Error: Missing custom python script for rendering!"
      echo "Check git respository for more information."
      exit 1
  fi
elif [ $generate_models = 1 ]; then # Only generate models
  # Override unnecessary parameters
  angled=0
  back=0
  side=0
  no_background=0
  width=1
  height=1

  # Check if there are any specific dimension step overrides
  if [ -z $back_step ]; then
    back_step=$step
  fi
  if [ -z $nose_step ]; then
    nose_step=$step
  fi
  if [ -z $wings_step ]; then
    wings_step=$step
  fi

  echo "Generate models only!"

  # Generate models
  $local/blender/blender $local/3DSPACE.blend --background -noaudio -Y \
    -t $threads -P $local/3DSPACE.py -- \
    $back_step $nose_step $wings_step $generate_models $angled $back $side \
    $no_background $width $height
else
  # Check if there are any specific dimension step overrides
  if [ -z $back_step ]; then
    back_step=$step
  fi
  if [ -z $nose_step ]; then
    nose_step=$step
  fi
  if [ -z $wings_step ]; then
    wings_step=$step
  fi

  # Check if specific arguments are missing
  if [ -z $back_step ] && [ -z $nose_step ] && [ -z $wings_step ]; then
    echo "Error: Missing step argument for rendering!"
    exit 1
  elif [ -z $height ]; then
    echo "Error: Missing height argument for rendering!"
    exit 1
  elif [ -z $width ]; then
    echo "Error: Missing width argument for rendering!"
    exit 1
  fi

  # Check if no perspective was chosen
  if [ $angled = 0 ] && [ $back = 0 ] && [ $side = 0 ]; then
    angled=1
    back=1
    side=1
  fi

  # Render!
  $local/blender/blender $local/3DSPACE.blend --background -noaudio -Y \
    -t $threads -P $local/3DSPACE.py -- \
    $back_step $nose_step $wings_step $generate_models $angled $back $side \
    $no_background $width $height
fi
