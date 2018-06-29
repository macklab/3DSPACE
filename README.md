# 3DSPACE
Docker for generation of 3DSPACE Stimulus. 

```Shell
docker run --rm -it -v /Users/macklabadmin/Desktop/render_test:/output \
  3dspace --back_step 0.5 --nose_step 0.2 --nose_step 1.0 \
  --side --back --height 300 --width 400 --no_background
```
