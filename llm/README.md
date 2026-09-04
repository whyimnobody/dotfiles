This package is intended to be stowed to `~` as a single GNU Stow package.

Layout:

- `shared-skills/` is the canonical skill source in the repo.
- `.agents/skills` points at `../shared-skills/`.
- `.claude/skills` points at `../shared-skills/`.
- `.stow-local-ignore` prevents Stow from linking `shared-skills/` or `README.md` into `$HOME`.

Usage:

```sh
stow --dir="$HOME/.dotfiles" --target="$HOME" llm
```

Notes:

- `frontend-design` exists in both `~/.agents/skills` and `~/.codex/skills`.
- This package keeps the `~/.agents/skills/frontend-design` variant because it is the more complete version and includes the reference files it depends on.
- A dry-run against the current machine still reports conflicts because `~/.agents/skills` and `~/.claude/skills` already contain unmanaged files. Stow will need `--adopt` or a manual cleanup before the package can take ownership.
