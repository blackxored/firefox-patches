{
  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      perSystem = {pkgs, ...}: {
        packages.firefox-esr-128-unwrapped = pkgs.firefox-esr-128-unwrapped.overrideAttrs (old: {
          patches = old.patches ++ [./dont_reserve_keys.patch];
        });
      };
    };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/x86_64-linux";
  };
}
