#!/bin/bash
local=/usr/local

# Generation parameters
step=
back_step=
nose_step=
wings_step=

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
    -h|--help )
      echo "This is help"
      exit
      ;;
    * )
      # Positional arguments
      echo "Positional parameters?"
      # exit 1
  esac
  shift
done

echo $custom_python
ls /output/
if [ ! -z $custom_python ]; then
  if [ -f /output/$custom_python ]; then
    $local/blender/blender $local/3DSPACE.blend --background -noaudio -Y \
      -t $threads -P /output/$custom_python
  else
      echo "Error: Missing custom python script for rendering!"
      echo "Check git respository for more information."
      exit 1
  fi
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
    echo "Error: Missing height argument!"
    exit 1
  elif [ -z $width ]; then
    echo "Error: Missing width argument!"
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
    $back_step $nose_step $wings_step $angled $back $side $no_background \
    $width $height
fi
