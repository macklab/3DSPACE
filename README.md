# 3DSPACE
Docker for generation of 3DSPACE Stimulus.

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
stepping through the dimensions in 0.2 units.
```shell
docker run -rm -it -v /data/output:/output \
  macklabuoft/3dspace:latest --step 0.2 --width 400 --height 300
```

Maximum customization. Generate 100x100 images only from the side and the back,
with each dimension stepping differently, using only four cores, with no
background.
```shell
docker run --rm -it -v /data/output:/output \
  macklabuoft/3dspace:latest --back_step 0.5 --nose_step 0.20 --back_step 1.0 \
  --side --thread 4 --no_background --width 100 --height 100
```

Self-test
```Shell
docker run --rm -it -v /Users/macklabadmin/Desktop/render_test:/output \
  macklabuoft/3dspace:latest --wings_step 0.5 --back_step 0.2 --nose_step 1.0 \
  --side --back --height 100 --width 100 --no_background
```
