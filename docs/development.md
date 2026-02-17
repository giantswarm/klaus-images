# Developing on klaus-images

## Prerequisites

- Docker
- Make

## Building images locally

Build all images:

```bash
make build-all
```

Build a specific image:

```bash
make build-klaus-go
```

Override the Klaus base version or Go version:

```bash
make build-klaus-go KLAUS_VERSION=0.0.20 GO_VERSION=1.25
```

## Version management

The `KLAUS_VERSION` ARG default lives in each Dockerfile. This is required because
the architect-orb `push-to-registries` job runs `docker build` without `--build-arg`
support. Renovate groups all Klaus image updates into a single PR via the
`klaus-images` group in `renovate.json5`.

The `Makefile` allows overriding versions for local builds via `make build-klaus-go KLAUS_VERSION=x.y.z`.

## Adding a new toolchain image

1. Create a new directory under the repo root (e.g. `klaus-rust/`).
2. Add `Dockerfile` (Alpine) and `Dockerfile.debian` variants.
3. Add `push-to-registries` jobs to `.circleci/config.yml`.
4. Add build targets to the `Makefile`.
5. Update `README.md` with the new image.
