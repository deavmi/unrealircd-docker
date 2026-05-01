# Base image
FROM debian:trixie AS build
MAINTAINER "Tristan Brice Velloza Kildaire" "deavmi@redxen.eu"

# Don't allow interactive prompts when using apt
ARG DEBIAN_FRONTEND=noninteractive

# Upgrade the system's dependencies
RUN apt update
RUN apt upgrade -y

# Activate arguments provided as build parameters
ARG BRANCH
ARG COMMIT

# Install required build dependencies
RUN apt install git gcc make -y
RUN apt install libssl-dev -y

# Setup build environment and clone
# source code
RUN mkdir /build
WORKDIR /build
RUN echo Building with commit $COMMIT
RUN git clone https://github.com/unrealircd/unrealircd.git --branch $BRANCH unrealircd
WORKDIR unrealircd/
RUN git checkout $COMMIT

# Copy the `config.settings` across
# so we can run ./Config in non-interactive mode
COPY config.settings ./config.settings

# We will output to this folder
RUN mkdir /ircd
WORKDIR /ircd

# Configure using `config.settings`
# build and then install
RUN ./Config -quick

# Build and install
RUN make -j4
RUN make install

# Start a new layer and just copy across the
# binaries, libraries etc.
FROM debian:trixie AS base
COPY --from build /ircd /ircd

# Change to directory we shall run from
# and start
WORKDIR /ircd
CMD ["bin/unrealircd", "-F"]
