#!/bin/bash

set -o errexit

images=(
    # OS images
    "resin/resinos:1.26.1-raspberry-pi"
    "resin/resinos:1.26.1-raspberry-pi2"
    "resin/resinos:1.26.1-raspberrypi3"

    # Supervisor images
    "resin/rpi-supervisor:v4.1.2_logstream"
    "resin/armv7hf-supervisor:v4.1.2_logstream"

    # Host OS updater images
    "resin/resinhup-test:v2.5.0-raspberry-pi|resin/resinhup:v2.5.0-raspberry-pi"
    "resin/resinhup-test:v2.5.0-raspberry-pi2|resin/resinhup:v2.5.0-raspberry-pi2"
    "resin/resinhup-test:v2.5.0-raspberrypi3|resin/resinhup:v2.5.0-raspberrypi3"

    # Legacy rce/docker migrator
    "imrehg/rpi-v1.10-migrator|resinhup/rpi-v1.10-migrator"
    "imrehg/armv7hf-v1.10-migrator|resinhup/armv7hf-v1.10-migrator"
)

REGISTRYV1="${BALENA_DEVICE_UUID}.balena-devices.com"
docker login -u resin -p "${REGISTRY_TOKEN}" "$REGISTRYV1"

function process_image() {
    local image=$1
    # Split image name by `|` to use the first/second part as from/to names.
    # If no such separator is found, then both names will be the same.
    local from_image="${image%|*}"
    local to_image="$REGISTRYV1/${image#*|}"

    echo "Processing ${from_image} -> ${to_image}"

    docker pull "${from_image}"
    docker tag "${from_image}" "${to_image}"
    docker push "${to_image}"
    docker rmi "${from_image}" "${to_image}"
}

for image in "${images[@]}"; do
    process_image "${image}"
done
echo "🏁 Registry population done."
