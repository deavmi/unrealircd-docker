unrealircd-docker
=================

[![Docker image build](https://github.com/deavmi/unrealircd-docker/actions/workflows/docker-image.yml/badge.svg)](https://github.com/deavmi/unrealircd-docker/actions/workflows/docker-image.yml)

Custom Docker Image and Compose service for UnrealIRCD that actually works (even for custom UID/GIDs!)

### Note on UIDs/GIDs

If you want them to be different you will need to build from the `Dockerfile` your own image
instead of one we would have pre-built here with those build arguments fixed to certain values.
