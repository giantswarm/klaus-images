# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).



## [Unreleased]

### Added

- Initial toolchain images: klaus-git, klaus-go, klaus-python.
- Alpine and Debian variants for each image.
- CircleCI config with push-to-registries jobs for all images.
- Auto-release workflow that creates a patch version tag and GitHub release
  when a PR is merged to main.
- OCI manifest annotations (`io.giantswarm.klaus.type`, `.name`, `.version`)
  on all toolchain image builds and Docker labels for local filtering.

### Fixed

- All images now build directly FROM `giantswarm/klaus` base instead of chaining
  through `giantswarm/klaus-git`. This avoids cross-image registry dependencies
  that would prevent parallel CI builds and require a multi-stage bootstrap.

[Unreleased]: https://github.com/giantswarm/klaus-images/tree/main
