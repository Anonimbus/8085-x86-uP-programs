#!/bin/bash

# Grant X11 access to Docker containers
xhost +local:docker
echo -e "\nX11 access granted to Docker containers.\n"

# Run your Docker container (the --rm flag is automatically removes the container after execution)
docker run --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v ./programs:/home/dosbox/programs dos_masm_611:full

# Revoke X11 access from Docker containers after execution
echo -e "\nRevoking X11 access from docker containers..."
xhost -local:docker
echo -e "X11 access revoked from Docker containers."
