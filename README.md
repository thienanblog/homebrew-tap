# homebrew-tap

Homebrew casks for [Ân Vũ](https://github.com/thienanblog)'s macOS apps.

```bash
brew install --cask thienanblog/tap/geda-clipboard
```

`brew` taps this repository on its own the first time you name a cask from it,
so there is no separate `brew tap` step.

## Casks

| Cask | What it is |
| --- | --- |
| [`geda-clipboard`](Casks/geda-clipboard.rb) | [Geda Clipboard](https://github.com/thienanblog/geda-clipboard) — a menu bar clipboard manager that notifies you on every copy and paste |

## A note on upgrades

Geda Clipboard updates itself through [Sparkle](https://sparkle-project.org),
which the cask declares with `auto_updates true`. A plain `brew upgrade`
therefore leaves it alone — the app has already handled it, and reinstalling
the pinned version over a newer one would walk you backwards.

To have Homebrew do the upgrade instead, ask for it explicitly:

```bash
brew upgrade --cask --greedy geda-clipboard
```

## Where the casks come from

They are generated, not hand-edited. `scripts/update-cask.sh` in the
[geda-clipboard](https://github.com/thienanblog/geda-clipboard) repository
renders the cask from that project's version and the checksum of the archive
attached to its GitHub release, and the release workflow pushes the result
here whenever a tag is published. Editing a cask here directly means the next
release overwrites the change.
