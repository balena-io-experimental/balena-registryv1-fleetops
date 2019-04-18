#!/bin/bash

REGISTRYV1="${BALENA_DEVICE_UUID}.balena-devices.com"
docker login -u resin -p "${REGISTRY_TOKEN}" "$REGISTRYV1"

images=(
    "resin/resinos:1.26.1-raspberry-pi"
    "resin/resinos:1.26.1-raspberry-pi2"
    "resin/resinos:1.26.1-raspberry-pi3"
    "resin/rpi-supervisor:v4.1.2_logstream"
    "resin/armv7hf-supervisor:v4.1.2_logstream"
)

for image in "${images[@]}"; do
    docker pull "${image}"
    docker tag "${image}" "$REGISTRYV1/${image}"
    docker push "$REGISTRYV1/${image}"
    docker rmi "$REGISTRYV1/${image}" "${image}"
done

