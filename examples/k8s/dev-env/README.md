# dev-env

bla bla

## Updating

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
nix-build dev-env/nix -A tools
```

from the root of the project (if running from somewhere else, adapt the
`dev-env/nix` path accordingly).
