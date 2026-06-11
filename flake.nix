{
  description = "helpful templates, because i tired typing everything manually";
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
      templates = {
        default = self.templates.blank;
        blank = {
          path = ./templates/blank;
          description = "Reasonable default to quickstart any project";
        };
        simple-rust = {
          path = ./templates/simple-rust;
          description = "Minimal with crane initialized";
        };
      };

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
