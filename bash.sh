#!/bin/bash

CONTAINER_NAME="javafx-scene-builder-8.3.0"

CONTAINER_COUNT=$(docker container ls -a --filter "name=$CONTAINER_NAME$" --filter "status=running" --format '{{.Names}}\t{{.Image}}' | wc -l) 

if [ $CONTAINER_COUNT == 0 ]; then
	echo -e "The '$CONTAINER_NAME' container is not running. Execute ./run.sh and with Scene Builder opened execute ./bash.sh"
	exit 1
else	
	if [ "$#" -gt 0 ]; then
		docker container exec -it $CONTAINER_NAME "$@"
	else
		docker container exec -it $CONTAINER_NAME bash
	fi
fi
