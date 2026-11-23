#!/usr/bin/env bash
# Ensures OpenMontage is cloned and set up. Prints the install path on the last line.
set -euo pipefail
OM_DIR="${OPENMONTAGE_DIR:-$HOME/OpenMontage}"
if [ ! -d "$OM_DIR/.git" ]; then
  git clone --depth 1 https://github.com/OpenMontageInc/OpenMontage.git "$OM_DIR" >&2
fi
if [ ! -x "$OM_DIR/.venv/bin/python" ] || [ ! -d "$OM_DIR/remotion-composer/node_modules" ] || [ ! -f "$OM_DIR/.env" ]; then
  (cd "$OM_DIR" && make setup) >&2
fi
echo "$OM_DIR"
