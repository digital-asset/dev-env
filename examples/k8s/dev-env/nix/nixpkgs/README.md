# channels

This folder contains the upstream Nix channels that are used for the dev-env.
We currently follow nixpkgs-unstable.

## Updating

To update the nixpkgs revision, find a commit in nixkgs-unstable from
https://github.com/NixOS/nixpkgs-channels/commits/nixpkgs-unstable and
use it in the `rev` field in `nix/nixpkgs/default.src.json`.  Set the
`sha256` to a dummy hash, e.g., 64 zeros and run `nix-build -A tools
-A cached nix` and nix will tell you the correct hash.

After upgrading the revision, the easiest solution is usually to open
a PR and see what fails on CI (running the builds locally can take
quite some time). The most common reason for failures is usually that
we have overriden a specific package with certain patches that no
longer work. In that case, a good first step is to check if these
patches are still necessary and if not try to switch to the unpatched
package from nixpkgs.
