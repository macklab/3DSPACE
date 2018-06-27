# Use Ubuntu 16.04
FROM ubuntu:16.04

# Get dependencies
RUN apt-get update && \
  apt-get install -y \
  curl \
  tar \
  bzip2

# Blender download URL
ENV BLENDER_URL https://mirror.clarkson.edu/blender/release/Blender2.79/blender-2.79b-linux-glibc219-x86_64.tar.bz2

# Download and unpack blender to its directory
RUN mkdir /usr/local/blender && \
  curl -ssL $BLENDER_URL | tar -jxv --strip-components=1 -C /usr/local/blender

# Add assets
ADD 3DSPACE.blend /usr/local/3DSPACE.blend
