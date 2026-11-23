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
# Kokoro-82M local TTS (used by `npx hyperframes tts`): python deps + espeak-ng phonemizer
if ! "$OM_DIR/.venv/bin/python" -c "import kokoro_onnx, soundfile" 2>/dev/null; then
  "$OM_DIR/.venv/bin/pip" install -q kokoro-onnx soundfile >&2
fi
if ! command -v espeak-ng >/dev/null 2>&1; then
  (apt-get install -y -q espeak-ng || (apt-get update -q && apt-get install -y -q espeak-ng)) >/dev/null 2>&1 || echo "warn: espeak-ng not installed (needed for non-English Kokoro)" >&2
fi
echo "$OM_DIR"
