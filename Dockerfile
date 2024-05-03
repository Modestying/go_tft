FROM --platform=$BUILDPLATFORM golang:1.22.0 AS builder
WORKDIR .

# Add gcc and libc-dev early so it is cached
RUN set -xe \
	&& apk add --no-cache gcc libc-dev

# Install dependencies earlier so they are cached between builds
COPY go.mod go.sum ./
RUN set -xe \
	&& go mod download

# Get the version name and git commit as a build argument
ARG GIT_VERSION
ARG GIT_COMMIT

# Get the operating system and architecture to build for
ARG TARGETOS
ARG TARGETARCH

RUN set -xe \
	&& GOOS=$TARGETOS GOARCH=$TARGETARCH go build \
        -ldflags="-X github.com/tus/tusd/v2/cmd/tusd/cli.VersionName=${GIT_VERSION} -X github.com/tus/tusd/v2/cmd/tusd/cli.GitCommit=${GIT_COMMIT} -X 'github.com/tus/tusd/v2/cmd/tusd/cli.BuildDate=$(date --utc)'" \
        -o /go/bin/tusd ./cmd/tusd/main.go

# start a new stage that copies in the binary built in the previous stage
FROM alpine:3.19.1
WORKDIR /opt

COPY --from=builder /go/bin/tusd /usr/local/bin/tusd

EXPOSE 8080

ENTRYPOINT ["/usr/local/share/docker-entrypoint.sh"]
CMD ["sh", "-c", "/opt"]
