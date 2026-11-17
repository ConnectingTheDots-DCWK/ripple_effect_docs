#!/usr/bin/env bash
# Runs a pre-commit hook's command with `node`, `pnpm` and `trufflehog` on
# PATH, however git was started.
#
# A terminal has them because a login shell put them on PATH. A git run by an
# editor launched from the desktop has whatever the desktop session had, which
# may be none of them. The app repository hit this first: every hook died with
# "command not found", and VS Code reported the failed push in its stock
# words, "try Pull first". Nothing was wrong with the remote.
#
# Looks in the places each installs itself and prepends the first that has
# it. Prepends rather than replaces, so a PATH that already has one wins.
ensure() {
  local tool=$1; shift
  command -v "$tool" >/dev/null 2>&1 && return
  local candidate
  for candidate in "$@"; do
    if [ -x "$candidate/$tool" ]; then
      PATH="$candidate:$PATH"
      export PATH
      return
    fi
  done
}
# mise's shims first, when this machine has them (the app repository's
# mise.toml pins pre-commit and trufflehog): a shim runs the pinned version
# and works with nothing else of mise on PATH.
shims="${MISE_DATA_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/mise}/shims"
if [ -d "$shims" ]; then
  PATH="$shims:$PATH"
  export PATH
fi
# Node and pnpm from n, pnpm's own installer, Homebrew or Volta.
ensure node "$HOME/n/bin" /usr/local/bin /opt/homebrew/bin "$HOME/.volta/bin"
ensure pnpm "$HOME/n/bin" "${PNPM_HOME:-$HOME/.local/share/pnpm}" /usr/local/bin /opt/homebrew/bin "$HOME/.volta/bin"
ensure trufflehog "$HOME/.local/bin" /usr/local/bin /opt/homebrew/bin "$HOME/go/bin"

# Git exports GIT_DIR to a hook it runs from a worktree, or from the app
# repository's submodule checkout, and every git a tool below runs then targets
# that repository instead. The working directory is the checkout; nothing
# below needs telling where the repository is.
unset GIT_DIR
exec "$@"
