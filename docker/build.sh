#!/bin/bash

BASE_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )/../" &> /dev/null && pwd 2> /dev/null; )"

docker build \
    -t exaworks/flux-psij \
    -f "$BASE_DIR/docker/flux-psij.dockerfile" \
    "$BASE_DIR/"
