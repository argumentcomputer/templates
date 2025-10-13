# templates

This repository contains template libraries for Lean and Rust with standard defaults for use in Argument projects.

TODO:
- Add top-level CI to test templates

## Usage

To copy a template, run the following:

Nix:

```
# Lean
nix flake new --template github:argumentcomputer/templates#lean ./my-lean-project

# Rust
nix flake new --template github:argumentcomputer/templates#rust ./my-rust-project
```

Non-Nix:

```
git clone https://github.com/argumentcomputer/templates && cd templates
cp -r <lean|rust> ../my-project && cd ../my-project
rm -rf .git
git init
git add . && git commit -m "Initial commit"
```

- Optional: Enable the Warpbuild and Garnix GitHub apps for CI and Nix caching
- Create a branch protection rule for `main` and enable the following as needed:
  - Require a pull request before merging
    - Require 1 approval
    - Dismiss stale pull request approvals when new commits are pushed
    - Require approval of the most recent reviewable push
  - Require status checks to pass before merging (optional, after CI has been triggered)
    - E.g. `linux-test` and `lints`
  - Require a merge queue using `squash and merge` (optional, only allowed if repo is public)
  - Allow force pushes if needed to bypass above restrictions when necessary
