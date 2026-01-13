{
  description = "Advent of code";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      hPkgs =
        pkgs.haskell.packages."ghc9103";

      myDevTools = [
        hPkgs.ghc # GHC compiler in the desired version (will be available on PATH)
        hPkgs.ghcid # Continuous terminal Haskell compile checker
        hPkgs.ormolu # Haskell formatter
        hPkgs.hlint # Haskell codestyle checker
        hPkgs.hoogle # Lookup Haskell documentation
        hPkgs.haskell-language-server # LSP server for editor
        hPkgs.implicit-hie # auto generate LSP hie.yaml file from cabal
        stack-wrapped
      ];

      stack-wrapped = pkgs.symlinkJoin {
        name = "stack"; # will be available as the usual `stack` in terminal
        paths = [ pkgs.stack ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/stack \
            --add-flags "\
              --no-nix \
              --system-ghc \
              --no-install-ghc \
            "
        '';
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = myDevTools;
      };
    };
}
