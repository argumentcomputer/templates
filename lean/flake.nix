{
  description = "Lean Nix flake";

  nixConfig = {
    extra-substituters = [
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  inputs = {
    # System packages
    nixpkgs.follows = "lean4-nix/nixpkgs";

    # Lean 4 & Lake
    lean4-nix.url = "github:argumentcomputer/lean4-nix?ref=7653ecd6d80710f42fcc2c117144698b18acdfc1";

    # Helper: flake-parts for easier outputs
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    lean4-nix,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      # Systems we want to build for
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem = {
        system,
        pkgs,
        ...
      }: let
        lake2nix = pkgs.callPackage lean4-nix.lake {};
        lakeArgs = {
          src = ./.;
        };
        lakeDeps = lake2nix.buildDeps lakeArgs;
        lakeBuildArgs =
          lakeArgs
          // {
            inherit lakeDeps;
          };
        leanLib = lake2nix.mkPackage (lakeBuildArgs
          // {
            name = "Template";
            buildLibrary = true;
          });
        leanBin = lake2nix.mkPackage (lakeBuildArgs
          // {
            lakeArtifacts = leanLib;
            installArtifacts = false;
            name = "template";
          });
      in {
        # Lean overlay
        _module.args.pkgs = import nixpkgs {
          inherit system;
          overlays = [(lean4-nix.readToolchainFile ./lean-toolchain)];
        };

        packages = {
          default = leanLib;
          lean-bin = leanBin;
        };

        # Provide a unified dev shell with Lean + Rust
        devShells.default = pkgs.mkShell {
<<<<<<< Updated upstream
          LEAN_SYSROOT = "${pkgs.lean.lean-all}";
          packages = with pkgs; [
            lean.lean # Lean compiler
            lean.lean-all # Includes Lake, stdlib, etc.
=======
          packages = with pkgs; [
            lean.lean-all # Includes Lean compiler, lake, stdlib, etc.
>>>>>>> Stashed changes
          ];
        };
      };
    };
}
