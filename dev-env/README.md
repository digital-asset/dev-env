# dev-env

Welcome to the `dev-env` for MY_PROJECT at MY_COMPANY. This folder defines the
set of tools we use to build MY_PROJECT, and to ensure we all use the exact
same versions. That includes all developers and CI machines.

## Adding a tool

[`Nix`]: https://nixos.org/download.html

The `nix` folder defines a full [`Nix`] environment. You can add arbitrary Nix
expressions to it, but because dev-env is meant to define executable tools, not
dependencies, chances are high that most of your definitions can be taken
directly from the existing repository of Nix recipes known as `nixpkgs`.

For example, to add GNU sed to your Nix environment, add

```
sed = pkgs.gnused;
```

to `nix/default.nix` in the `tools` section.

To make the tool available, you still need to add it to `$PATH`, which you can
do by creating a symlink:

```
ln -s ../lib/dade-exec-nix-tool dev-env/bin/sed
```

## Updating the Nix channel

Nix pins down everything to the exact version of the source code used to build
it and all of its dependencies. Yet we don't want to be dealing with that,
because it would be very tedious. So for most of our Nix definitions, we rely
on a known set of definitions (that hardcode all version numbers all the way
down) in the form of a checkout of the [nixpkgs] repository. The specific
version of that repository `dev-env` uses is defined in
`nix/nixpkgs/default.src.json`.

[nixpkgs]: https://github.com/NixOS/nixpkgs

To update the nixpkgs revision to the latest available, go to
https://status.nixos.org and pick the commit hash for `nixpkgs-unstable`. Any
commit from the [`nixpkgs-unstable`] branch _should_ work, but not all of them
may have been built yet.

[`nixpkgs-unstable`]: https://github.com/NixOS/nixpkgs/commits/nixpkgs-unstable

Once you have chosen a commit, put it in the `rev` field of the file
`dev-env/nix/nixpkgs/default.src.json`, and change a character in the `sha256`
field. (If you don't, you may keep using the previous snapshot.)

On the next dev-env activation (`cd` out and back in if `direnv` is enabled),
`dev-env` will download the archive and tell you what the `sha256` should be.
You can of course also just download the archive yourself and compute the
`sha256` if you want to be extra careful. Once you have the new `sha256` value,
enter it into `dev-env/nix/nixpkgs/default.src.json`.

To test the new revision, you can try building all of your tools by running:

```
nix-build dev-env/nix -A tools --no-out-link
```

from the root of the project (if running from somewhere else, adapt the
`dev-env/nix` path accordingly).
