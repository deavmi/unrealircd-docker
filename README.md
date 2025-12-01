unrealircd-docker
=================

[![Docker image build](https://github.com/deavmi/unrealircd-docker/actions/workflows/docker-image.yml/badge.svg)](https://github.com/deavmi/unrealircd-docker/actions/workflows/docker-image.yml)

Custom Docker Image and Compose service for UnrealIRCD that actually works (even for custom UID/GIDs!)

## Interpolation variables

* `USER_UID=1000`
  * Change these to the value of `id -u` on your HOST
* `USER_GID=1003`
  * Change these to the value of `id -g` on your HOST

## Build arguments

* `BRANCH=unreal60_dev`
  * Branch to use
* `COMMIT=30b9f66f716e69e0734620c9b356d66443de0d4d`
  * Commit hash to checkout

### Note on UIDs/GIDs

If you want them to be different you will need to build from the `Dockerfile` your own image
instead of one we would have pre-built here with those build arguments fixed to certain values.
