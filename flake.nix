{
  description = "Haita development flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            typst
            pagefind
            just
            ripgrep
          ];
          shellHook = ''
            unset SOURCE_DATE_EPOCH
          '';
        };
        # for converting Typst to Markdown
        devShells.prepareRelease = pkgs.mkShell {
          packages = [ pkgs.pandoc ];
        };
      }
    );
}
