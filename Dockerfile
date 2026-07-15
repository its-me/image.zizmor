FROM rust:alpine AS builder

ARG ZIZMOR_VERSION

RUN apk add --no-cache musl-dev make g++

RUN cargo install --git https://github.com/woodruffw/zizmor --tag "v${ZIZMOR_VERSION}" --locked zizmor


FROM alpine:latest

ARG ZIZMOR_VERSION
LABEL org.opencontainers.image.version=$ZIZMOR_VERSION
LABEL org.opencontainers.image.source=https://github.com/its-me/image.zizmor
LABEL org.opencontainers.image.title="zizmor"
LABEL org.opencontainers.image.description="Static analysis tool for GitHub Actions workflows"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.authors="Sergey Kanafyev <sergeykanafyev@gmail.com>"

COPY --from=builder /usr/local/cargo/bin/zizmor /usr/local/bin/zizmor

RUN zizmor --version

ENTRYPOINT ["/usr/local/bin/zizmor"]
