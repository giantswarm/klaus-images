# Developing on klaus-images

## Prerequisites

- Docker (with buildx support)
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

Override the Go version:

```bash
make build-klaus-go GO_VERSION=1.25
```

## Version management

The `KLAUS_VERSION` ARG default lives in each Dockerfile. Renovate groups all
Klaus image updates into a single PR via the `klaus-images` group in
`renovate.json5`.

The `Makefile` allows overriding versions for local builds via `make build-klaus-go KLAUS_VERSION=x.y.z`.

## OCI annotations and Docker labels

All toolchain images carry structured metadata for discovery by `klausctl`:

- **Manifest annotations** (`io.giantswarm.klaus.type`, `.name`, `.version`) --
  set via `docker buildx --annotation` in both CI and local builds. These can
  be read remotely with a single manifest GET (no config blob fetch needed).
- **Docker labels** (`io.giantswarm.klaus.type`, `.name`) -- set via `LABEL` in
  Dockerfiles for local filtering with `docker images --filter label=...`.

## Adding a new toolchain image

1. Create a new directory under the repo root (e.g. `klaus-rust/`).
2. Add `Dockerfile` (Alpine) and `Dockerfile.debian` variants.
3. Add `push-to-registries-multiarch` jobs to `.circleci/config.yml` with
   `io.giantswarm.klaus.*` annotations.
4. Add build targets to the `Makefile`.
5. Update `README.md` with the new image.
