#!/usr/bin/env bash

set -e

version="$(git tag -l --points-at HEAD)"
commit=$(git log --format="%H" -n 1)
function compile {
  local os=$1
  local arch=$2
  local ext=$3

  echo "Compiling for $os/$arch..."
  local dir="bin/tft_${os}_${arch}"
  rm -rf "$dir"
  mkdir -p "$dir"

  GOOS=$os GOARCH=$arch CGO_ENABLED=0 go build \
    -ldflags "-X 'gotft/cmd/tft/srv.VersionName=${version}' -X 'gotft/cmd/tft/srv.GitCommit=${commit}' -X 'gotft/cmd/tft/srv.BuildDate=$(date +"%Y-%m-%d %H:%M:%S")'" \
    -o "$dir/tft$ext" ./cmd/tft/main.go
}

export -f compile
