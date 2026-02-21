# klaus-images

Pre-built toolchain container images that extend the minimal [Klaus](https://github.com/giantswarm/klaus) base with language runtimes and tools.

## Images

Each image adds exactly what it needs on top of Klaus. Variant is encoded in the image name, not the tag.

| Image | Contents | Base |
|-------|----------|------|
| `giantswarm/klaus-toolchains/git` | + git | `giantswarm/klaus` |
| `giantswarm/klaus-toolchains/git-debian` | + git (Debian) | `giantswarm/klaus-debian` |
| `giantswarm/klaus-toolchains/go` | + git, Go runtime | `giantswarm/klaus` |
| `giantswarm/klaus-toolchains/go-debian` | + git, Go runtime (Debian) | `giantswarm/klaus-debian` |
| `giantswarm/klaus-toolchains/python` | + git, Python | `giantswarm/klaus` |
| `giantswarm/klaus-toolchains/python-debian` | + git, Python (Debian) | `giantswarm/klaus-debian` |

### Image hierarchy

All toolchain images build directly from the Klaus base to avoid cross-image registry dependencies:

```
giantswarm/klaus
├── giantswarm/klaus-toolchains/git         (+ git)
├── giantswarm/klaus-toolchains/go          (+ git + Go)
└── giantswarm/klaus-toolchains/python      (+ git + Python)

giantswarm/klaus-debian
├── giantswarm/klaus-toolchains/git-debian
├── giantswarm/klaus-toolchains/go-debian
└── giantswarm/klaus-toolchains/python-debian
```

## Tagging

Tags follow the [Giant Swarm semver tagging schema](https://github.com/giantswarm/rfc/blob/main/semver-based-automatic-upgrades/README.md):

- **Stable**: `1.0.0` -- from `main` via `main#release#[patch,minor,major]`
- **RC**: `1.0.1-rc.1` -- from `main` via `main#release#[patch-rc,minor-rc,major-rc]`
- **Dev**: `1.0.1-dev.feature.20260217.120000` -- automatic from non-main branches

## Build args

| Arg | Default | Description |
|-----|---------|-------------|
| `KLAUS_VERSION` | pinned | Klaus base image version. Updated by Renovate. |
| `GO_VERSION` | `1.25` | Go version (klaus-go only). Managed by platform team. |

## Usage

Reference images in klausctl config, Helm values, or operator CRDs:

```yaml
image: gsoci.azurecr.io/giantswarm/klaus-toolchains/go:1.0.0
```

## Repository structure

```
klaus-git/
├── Dockerfile           # Alpine variant
└── Dockerfile.debian    # Debian variant
klaus-go/
├── Dockerfile
└── Dockerfile.debian
klaus-python/
├── Dockerfile
└── Dockerfile.debian
```

## CI

CircleCI builds one `push-to-registries` job per image using the [architect-orb](https://github.com/giantswarm/architect-orb). All images are pushed to `gsoci.azurecr.io/giantswarm/klaus-toolchains/` on every push (dev tags) and release (semver tags).
