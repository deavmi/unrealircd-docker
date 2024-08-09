# Base image
FROM ubuntu:noble AS build
MAINTAINER "Tristan Brice Velloza Kildaire" "deavmi@redxen.eu"

# Don't allow interactive prompts when using apt
ARG DEBIAN_FRONTEND=noninteractive

# Activate arguments provided as build parameters
ARG USER_UID
ARG USER_GID

# Upgrade the system's dependencies
RUN apt update
RUN apt upgrade -y

# Install required build dependencies
RUN apt install git gcc make -y
RUN apt install libssl-dev -y

# Create the unreal user
# and delete the `ubuntu`
# user (it comes with this
# in newer Ubuntu images)
# and MAY conflict with
# the `unreal` user we want
# to add depending on your
# uid of choice
RUN userdel ubuntu
RUN groupadd unreal -g $USER_GID
RUN useradd -m unreal -u $USER_UID -g $USER_GID

# Copy over the start script
# and make it executable
COPY start.sh /start.sh
RUN chmod +x start.sh

# Switch to unreal user
USER unreal

# Clone sources
WORKDIR /home/unreal
RUN ["git", "clone", "https://github.com/unrealircd/unrealircd.git", "--depth", "1", "--branch", "unreal60_dev", "unrealircd"]
WORKDIR unrealircd/

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
CMD ["/start.sh"]
