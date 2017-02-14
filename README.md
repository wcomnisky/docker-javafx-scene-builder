# Docker image for JavaFX Scene Builder

* Tested on a host running Linux Ubuntu 16.10 with Docker 1.13.1

## How to
Clone the project
```shell
git clone git@github.com:wcomnisky/docker-javafx-scene-builder.git
cd docker-javafx-scene-builder.git
```

Build the image (based on the Dockerfile - it will run the container after building it)
```shell
./build.sh
```

Consecutive usage of the container
```shell
cd docker-javafx-scene-builder.git
./run.sh
```

Opening a bash console on the container
```shell
cd docker-javafx-scene-builder.git
./bash.sh
```
