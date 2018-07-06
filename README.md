# 3DSPACE
Docker for generation of 3DSPACE Stimulus. This container allows custom
generation of 3DSPACE stimulus. By using Docker, users can generate images
easily without needing to download many prerequisites. The 3DSPACE set can
generate images from three different perspectives with three different
dimensions varying from 0-1. It is possible to only generate 3D models using
the --generate_models argument. As the 3DSPACE set was created using Blender,
the generation of images is controlled by a Python script. Advanced users can
define a custom Python script for the generation of images, see
example_script.py for the essential methods. In order to use the 3DSPACE
stimulus generator, you must have
[Docker](https://www.docker.com/community-edition) installed and running.

## Getting Started
1. Install [Docker](https://www.docker.com/community-edition) and ensure it is
running.
2. Create a folder where the images will be placed after being generated
3. Open a terminal window (Windows: Command Prompt, Mac: Terminal)
4. To generate your first set of images run this command. Replace the the entire
[REPLACE ME!] section with the path to the folder you made for the images.
```
docker run --rm -it -v [REPLACE ME!]:/output \
  macklabuoft/3dspace:latest --step 0.2 --width 400 --height 300
```
5. Let it run for your spaceships!

3DSPACE generator has the following command line arguments:
```
usage: wrapper.sh [-h] [--width WIDTH] [--height HEIGHT]
                  [--step STEP] [--back_step STEP] [--nose_step STEP]
                  [--wings_step STEP] [--angled] [--back] [--side]
                  [--no_background] [--threads THREADS] [--generate_models]
                  [--custom_python SCRIPT]
Wrapper for 3DSPACE stimulus generation using a Docker container.

name-value arguments:
  --width WIDTH             Width in pixels for the generated images.
  --height HEIGHT           Height in pixels for generated images.
  --step STEP               Units to step by from 0 in generating models/images.
  --back_step STEP          Units to step by from 0 for the back dimension,
                            overrides --step parameter.
  --nose_step STEP          Units to step by from 0 for the nose dimension,
                            overrides --step parameter.
  --wings_step STEP         Units to step by from 0 for the wings dimension,
                            overrides --step parameter.
  --threads THREADS         Number of threads to render images with, 0 will use
                            system configuration.
  --custom_python SCRIPT    Name of custom rendering python script, will
                            override all other parameters except --threads

arguments:
  -h, --help                Show this help message and exit.
  --angled                  Render images from the angled camera. If no camera
                            parameter is set, all cameras are used.
  --back                    Render images from the back camera. If no camera
                            parameter is set, all cameras are used.
  --side                    Render images from the side camera. If no camera
                            parameter is set, all cameras are used.
  --no_background           Render images with transparent background.
  --generate_models         Generate 3D models only, overrides all render
                            arguments.

```

Simplest generation command. Generates 400x300 images from all three perspective
stepping through the dimensions in 0.2 units. Here is a breakdown of each part:
- `docker run` will use Docker to run a container, if it is your first time
running the 3DSPACE container, it will auto-build it from the online repository.
- `-rm` will clean up the contents of the container after it is run (so there
won't be a build up of rendered images inside the container).
- `-it` are two parameters that will allow you to interact with the container
when it is running in the foreground.
- `-v /data...:/output` will mount a volume from the local machine into the
container. The left side of the colon should be a writable folder on your local
machine while the right side of the colon should always be `/output`.
- `macklabuoft/3dspace:latest` will use the latest version of the container from Dockerhub.
- `--step 0.2` will step through each dimension at steps of 0.2 units to render
stimuli.
- `--width 400--height 300` will render images at 400x300px.
```shell
docker run -rm -it -v /data/output:/output \
  macklabuoft/3dspace:latest --step 0.2 --width 400 --height 300
```

Maximum customization. Generate 100x100 images only from the side and the back,
with each dimension stepping differently, using only four cores, with no
background. It will specifically use the container tagged `v1.0`.
```shell
docker run --rm -it -v /data/output:/output \
  macklabuoft/3dspace:v1.0 --back_step 0.5 --nose_step 0.20 --wings_step 1.0 \
  --side --thread 4 --no_background --width 100 --height 100
```

To use a custom rendering script, place a python script in the output folder.
Use a command similar to the following:
```shell
docker run --rm -it -v /data/output:/output \
  macklabuoft/3dspace:latest --thread 4 --custom_python example_script.py
```
