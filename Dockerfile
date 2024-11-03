# Base image
FROM debian:bookworm AS build
MAINTAINER "Tristan Brice Velloza Kildaire" "deavmi@redxen.eu"

# Don't allow interactive prompts when using apt
ARG DEBIAN_FRONTEND=noninteractive

# Upgrade the system's dependencies
RUN apt update
RUN apt upgrade -y

# Activate arguments provided as build parameters
ARG USER_UID
ARG USER_GID
ARG BRANCH
ARG COMMIT

# Install required build dependencies
RUN apt install git gcc make -y
RUN apt install libssl-dev -y

# Create the unreal user
# and group
RUN groupadd unreal -g $USER_GID
RUN useradd -m unreal -u $USER_UID -g $USER_GID

# Switch to unreal user
USER unreal

# Clone sources
WORKDIR /home/unreal
RUN echo Building with commit $COMMIT
RUN git clone https://github.com/unrealircd/unrealircd.git --branch $BRANCH unrealircd
WORKDIR unrealircd/
RUN git checkout $COMMIT

# Copy the `config.settings` across
# so we can run ./Config in non-interactive mode
COPY config.settings ./config.settings

# We will output to this folder
RUN mkdir /home/unreal/ircd

# Configure using `config.settings`
# build and then install
RUN ./Config -quick

# Build and install
RUN make -j4
RUN make install

# Clear up all build-related things
FROM build AS unrealircd
USER root
RUN apt remove git gcc make -y
RUN apt remove libssl-dev -y
RUN apt autoremove -y
USER unreal
RUN rm -rfv /home/unreal/unrealircd

# Change to directory we shall run from
# and start
WORKDIR /home/unreal/ircd
CMD ["bin/unrealircd", "-F"]
