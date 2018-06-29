# 3DSPACE
Docker for generation of 3DSPACE Stimulus.

```Shell
docker run --rm -it -v /Users/macklabadmin/Desktop/render_test:/output \
  3dspace \
  --step 1 --side --threads 4 --height 300 --width 400
```
