# Usage

## Setup

Replace UID (`1000`) and GID (`1000`) in `Dockerfile` with yours.

## With Docker

To build image:

    docker build -t bookmark-gen-dev .

To start shell:

    docker run -it --rm -v $PWD/../..:/bookmark-gen -w /bookmark-gen bookmark-gen-dev bash

## With Docker Compose

To start shell:

    docker compose run --rm ws bash
