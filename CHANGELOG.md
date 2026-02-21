# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).



## [Unreleased]

### Changed

- Move toolchain images to `giantswarm/klaus-toolchains/<name>` sub-namespace for consistent naming with plugins (`klaus-plugins/`) and personalities (`klaus-personalities/`). This also eliminates a ~30s cold-start latency in `klausctl toolchain list` caused by enumerating the entire `giantswarm/` catalog.

### Removed

- `io.giantswarm.klaus.*` OCI manifest annotations from CircleCI and Makefile builds. With dedicated sub-namespaces for each artifact type, annotation-based identification is no longer needed.
- `io.giantswarm.klaus.*` Docker labels from all Dockerfiles (same reason).

### Added

- Initial toolchain images: klaus-git, klaus-go, klaus-python.
- Alpine and Debian variants for each image.
- CircleCI config with push-to-registries jobs for all images.
- Auto-release workflow that creates a patch version tag and GitHub release
  when a PR is merged to main.
- OCI manifest annotations (`io.giantswarm.klaus.type`, `.name`, `.version`)
  on all toolchain images via `architect-orb@6.14.0` multiarch workflow.
- Docker labels (`io.giantswarm.klaus.type`, `.name`) in all Dockerfiles
  for local image filtering.

### Changed

- Switch CI builds from `push-to-registries` to `push-to-registries-multiarch`
  for multi-architecture support (linux/amd64, linux/arm64) and OCI annotations.
- Build amd64-only on branches for faster PR feedback; full multi-arch only on
  release tags.
- Local builds in Makefile now use `docker buildx build --load` with annotation
  flags matching CI output.

### Fixed

- All images now build directly FROM `giantswarm/klaus` base instead of chaining
  through `giantswarm/klaus-git`. This avoids cross-image registry dependencies
  that would prevent parallel CI builds and require a multi-stage bootstrap.

[Unreleased]: https://github.com/giantswarm/klaus-images/tree/main
