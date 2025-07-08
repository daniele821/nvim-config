#!/bin/bash

podman run --rm -it --security-opt label=disable --network none -v .:/app -w /app localhost/neovim:latest
