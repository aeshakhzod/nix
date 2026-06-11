# aeshakhzod/nix

helpful templates, because i tired typing everything manually

## start with default

```sh
nix flake init -t github:aeshakhzod/nix
```

## list all templates

```sh
nix flake show github:aeshakhzod/nix
```

## start with other template

```sh
nix flake init -t github:aeshakhzod/nix#simple-rust
```

## refresh in case if you have the old version

```sh
nix flake show github:aeshakhzod/nix --refresh
```
