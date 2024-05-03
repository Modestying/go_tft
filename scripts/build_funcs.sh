#!/usr/bin/env bash

set -e

version="$(git tag -l --points-at HEAD)"
commit=$(git log --format="%H" -n 1)
function compile {
  local os=$1
  local arch=$2
  local ext=$3

  echo "Compiling for $os/$arch..."
  local dir="bin/lft_${os}_${arch}"
  rm -rf "$dir"
  mkdir -p "$dir"

  GOOS=$os GOARCH=$arch CGO_ENABLED=0 go build \
    -ldflags "-X 'goltf/cmd/ltf/srv.VersionName=${version}' -X 'goltf/cmd/ltf/srv.GitCommit=${commit}' -X 'goltf/cmd/ltf/srv.BuildDate=$(date +"%Y-%m-%d %H:%M:%S")'" \
    -o "$dir/ltf$ext" ./cmd/ltf/main.go
}

export -f compile
