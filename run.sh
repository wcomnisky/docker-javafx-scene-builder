#!/bin/bash

set -e

IMAGE_NAME="javafx-scene-builder:8.3.0"
CONTAINER_NAME="javafx-scene-builder-8.3.0"

HOST_BASE_PATH="/home/$USER/docker-volume/$CONTAINER_NAME"
mkdir -p $HOST_BASE_PATH

JAVA_VOL_PATH="$HOST_BASE_PATH/.java"
mkdir -p $JAVA_VOL_PATH

SCENEBUILDER_VOL_PATH="$HOST_BASE_PATH/.scenebuilder"
mkdir -p $SCENEBUILDER_VOL_PATH

WORKSPACE_VOL_PATH="$HOST_BASE_PATH/workspace"
mkdir -p $WORKSPACE_VOL_PATH

chown $USER:$USER -R $HOST_BASE_PATH

# 'docker' must be literal in the line below and not the $DOCKER_USER var
# It is related to the Docker user in the host environment and not from inside the container
xhost +local:docker &>/dev/null

CONTAINER_COUNT=$(docker container ls -a --filter "name=$CONTAINER_NAME$" --format '{{.Names}}\t{{.Image}}' | wc -l) 

# Cannot use variable in the -v param for the container path - looks like it's not parsing correctly
if [ $CONTAINER_COUNT == 0 ]; then
	docker container run -it --name $CONTAINER_NAME \
		-h $CONTAINER_NAME \
		-e DISPLAY=$DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v $JAVA_VOL_PATH:/home/developer/.java \
		-v $SCENEBUILDER_VOL_PATH:/home/developer/.scenebuilder \
		-v $WORKSPACE_VOL_PATH:/home/developer/workspace \
		$IMAGE_NAME
else
	docker container start -ia $CONTAINER_NAME
fi
