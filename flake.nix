{
  description = "Advent of code";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          haskellPackages.ormolu
          bashInteractive
          ghc
          cabal-install
          haskell-language-server
          haskellPackages.hlint
        ];
      };
    };
}
