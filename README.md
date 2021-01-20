# Template

**This repo contains a template to use dev-env in your own projects. Please bear in mind that it is provided for illustrative purposes only, and as such may not be production quality and/or may not fit your use-cases. You may use the contents of this repo in parts or in whole according to the BSD0 license:**

> Copyright (c) 2021 Digital Asset (Switzerland) GmbH and/or its affiliates
>
> Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.
>
> THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

> **This repository does not accept Pull Requests at the moment.**

# dev-env — Nix with training wheels

## Quickstart

If this is your first time, please read the rest fo this README first.

```
curl -sL https://github.com/digital-asset/dev-env/archive/master.tar.gz | tar xzf - --strip-components=1 dev-env-master/dev-env dev-env-master/.envrc
direnv allow
```

## Who is this for?

- You get a queasy feeling every time you need to install a tool globally on
  your machine just to compile that one project.
- You worry about weird bugs happening because you're not using the same
  version of `sed` as your CI environment.
- You get annoyed everytime you have to uninstall a tool just to reinstall a
  different version.
- You already have `rbenv`, `rvm`, `nvm`, `asdf-vm`, and you're trying to
  complete your collection.
- You know Nix, but your coworkers don't. You want to trick them into using it
  anyway.

## Who is this not for?

You know how to use Nix. Training wheels would get in your way, you can't
relate to any of the problems above as they don't exist in your world, and you
never work with people who don't know Nix.

You would probably be better served by [lorri] or [nix_direnv], if you're not
fully happy with `nix-shell` alone.

[lorri]: https://github.com/target/lorri
[nix_direnv]: https://github.com/nix-community/nix-direnv

## What?

`dev-env` is a set of tools that let you:

- pin the exact version of the executables used in building your project, and
- transparently manage those executables so they do not interfere with anything
  else on your machine.

To achieve that, `dev-env` relies on [`direnv`] and [Nix]. Both of those have
to be installed at the user (or machine) level; after that, all your tools can
be project-level only.

[`direnv`]: https://direnv.net
[Nix]: https://nixos.org/download.html

## How?

`dev-env` is (conceptually) made up of three pieces:

1. `direnv` adds `dev-env/bin` to your `$PATH` (when in the project
   directory).
2. `dev-env/nix` defines a Nix environment.
2. `dev-env/lib` contains shell scripts that look at their own name and search
   for a corresponding executable in the `dev-env/nix` environment, build (i.e.
   mostly download) them if they're not available yet, and then execute them.

Adding a new tool to the `dev-env` of your project is done in two steps:

1. Add a Nix definition for it in `dev-env/nix`.
2. Add a corresponding symlink in `dev-env/bin`.

See [`dev-env/README.md`](dev-env/README.md) for more information on how to
manage a `dev-env` for your project.

## Examples

There are a few examples in this repository that have been extracted from
internal projects. The biggest example you can look up is the `dev-env` in the
[Daml Connect] repository, though bear in mind this project is a monorepo-style
project tying together a large number of technologies through the Bazel build
system, and that has been developed over many years.

[Daml Connect]: https://github.com/digital-asset/daml
