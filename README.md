unrealircd-docker
=================

[![Docker image build](https://github.com/deavmi/unrealircd-docker/actions/workflows/docker-image.yml/badge.svg)](https://github.com/deavmi/unrealircd-docker/actions/workflows/docker-image.yml)

Custom Docker Image and Compose service for UnrealIRCD that actually works (even for custom UID/GIDs!)

## Build arguments

* `BRANCH=unreal60_dev`
  * Branch to use
* `COMMIT=30b9f66f716e69e0734620c9b356d66443de0d4d`
  * Commit hash to checkout

### Note on UIDs/GIDs

Set the `USER_UID` and `USER_GID` values in your `.env` so that
Docker Compose can pick them up and use them to set the effective user
ID and group ID. See `compose.yml` for whwre it is used.
