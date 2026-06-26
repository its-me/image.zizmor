FROM rust:alpine AS builder

ARG ZIZMOR_VERSION

RUN apk add --no-cache musl-dev make g++

RUN cargo install zizmor --version "${ZIZMOR_VERSION}" --locked


FROM alpine:latest

COPY --from=builder /usr/local/cargo/bin/zizmor /usr/local/bin/zizmor

WORKDIR /work
CMD ["zizmor"]
