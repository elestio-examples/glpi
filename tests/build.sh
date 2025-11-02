#!/usr/bin/env bash
mv ./Dockerfile ./Dockerfile.old
cp ./.docker/app/Dockerfile ./Dockerfile
docker buildx build . --output type=docker,name=elestio4test/glpi:latest | docker load
