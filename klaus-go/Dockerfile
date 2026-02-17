ARG KLAUS_VERSION=0.0.20
ARG GO_VERSION=1.25
FROM golang:${GO_VERSION}-alpine AS go-source
FROM gsoci.azurecr.io/giantswarm/klaus-git:${KLAUS_VERSION}
USER root
COPY --from=go-source /usr/local/go /usr/local/go
RUN mkdir -p /go && chown klaus:klaus /go
USER klaus
ENV GOPATH=/go PATH="/usr/local/go/bin:/go/bin:${PATH}"
