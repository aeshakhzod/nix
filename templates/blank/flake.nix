{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      eachSystem =
        fn:
        nixpkgs.lib.genAttrs systems (
          system:
          fn {
            inherit system;
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      devShells = eachSystem (
        { pkgs, system }: {
          default = pkgs.mkShell {
            packages = with pkgs; [
              self.formatter.${system}
              nixd
              statix
              deadnix
            ];
          };
        }
      );

      formatter = eachSystem ({ pkgs, ... }: pkgs.nixfmt);
    };
}
