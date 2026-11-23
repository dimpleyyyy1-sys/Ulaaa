---
name: open-montage
description: Produce videos with OpenMontage, the open-source agentic video production system (explainers, animations, documentary montages, talking heads, clips, podcast repurposing, screen demos, avatar spokesperson, localization/dubbing, cinematic trailers). Use when the user asks to make, create, edit or render a video, "смонтируй видео", "сделай ролик", mentions OpenMontage / "open монтаж", or gives a reference video to imitate. Installs OpenMontage automatically if missing.
---

# OpenMontage

OpenMontage (https://github.com/OpenMontageInc/OpenMontage, AGPLv3) turns the coding agent into a video studio: pipeline manifests (YAML) + stage director skills (Markdown) + Python tools (FFmpeg, Remotion, HyperFrames, Piper TTS, cloud providers).

## 1. Make sure it is installed

```bash
OM_DIR=$(bash .claude/skills/open-montage/scripts/ensure_installed.sh | tail -1)
```

Requirements: Python 3.10+, Node.js 22+, FFmpeg, make. Default location is `~/OpenMontage` (override with `OPENMONTAGE_DIR`). The first run takes a few minutes (`make setup`).

## 2. Follow OpenMontage's own contract — mandatory

Before replying to the video request, read `$OM_DIR/AGENT_GUIDE.md` in full and obey it. Key rules from it:

- **Vague request** ("what can you do?", "make me a video") → read `$OM_DIR/skills/meta/onboarding.md` first.
- **Reference video given** ("make something like this") → read `$OM_DIR/skills/meta/video-reference-analyst.md`.
- **Rule Zero: all production goes through a pipeline.** Pick one from `$OM_DIR/pipeline_defs/`:
  `animated-explainer`, `animation`, `avatar-spokesperson`, `character-animation`, `cinematic`, `clip-factory`, `documentary-montage`, `hybrid`, `localization-dub`, `podcast-repurpose`, `screen-demo`, `talking-head`.
- Read `pipeline_defs/<pipeline>.yaml`, then for EACH stage read `skills/pipelines/<pipeline>/<stage>-director.md` before doing that stage's work.
- Before using a tool with an `agent_skills` field, read the referenced provider skill (in `$OM_DIR/.agents/skills/` or `$OM_DIR/.claude/skills/`).
- Announce tool/provider/model/cost before any paid generation; ask before switching providers or major creative choices; checkpoint and self-review per the meta skills.
- Do NOT write ad-hoc scripts that call providers directly or skip preflight.

## 3. Preflight — see what is actually available

Run all Python from inside `$OM_DIR` with its venv:

```bash
cd "$OM_DIR" && .venv/bin/python -c "from tools.tool_registry import registry; import json; registry.discover(); print(json.dumps(registry.provider_menu(), indent=2))"
```

Without API keys only local tools work (FFmpeg, Piper TTS, Remotion, HyperFrames). Keys go in `$OM_DIR/.env` (all optional): `FAL_KEY`, `PEXELS_API_KEY`, `PIXABAY_API_KEY`, `UNSPLASH_ACCESS_KEY`, `ELEVENLABS_API_KEY`, `OPENAI_API_KEY`, `SUNO_API_KEY`, `KLING_API_KEY`, etc. — see `$OM_DIR/docs/PROVIDERS.md`. Never ask the user to paste keys into chat.

## 3b. Local voiceover — Kokoro-82M (https://github.com/hexgrad/kokoro, Apache-2.0)

Free offline TTS, installed by `ensure_installed.sh`. Always export the venv python so the HyperFrames CLI finds `kokoro-onnx`:

```bash
export HYPERFRAMES_PYTHON="$OM_DIR/.venv/bin/python"
npx --yes hyperframes tts "Text here" --voice am_michael -o "$OM_DIR/projects/<id>/assets/audio/vo.wav"
npx --yes hyperframes tts --list   # voices
```

- Languages: English (US/GB), Spanish, French, Italian, Hindi, Portuguese (BR), Japanese, Chinese. **No Russian** — for Russian narration use a cloud TTS or Piper.
- Good narrator voices: `am_michael`, `am_fenrir`, `am_adam` (US male), `bm_george` (UK male), `af_heart` (US female).
- Kokoro gives no word timestamps; for word-by-word captions run the `transcriber` (Whisper) on the result, or derive timing from the script.
- The registry's `tts_selector` does not list Kokoro (shows TTS 0/N); tell the user Kokoro is available via the HyperFrames CLI path and log it as the TTS decision.

### Voice cast (binding — user's standing choice, see `voices.json`)

| ID | Kokoro voice | Speed | Use |
|----|--------------|-------|-----|
| **M1** | `am_michael` | `0.93` | Main narrator. Default for ALL videos. |
| **F1** | `af_heart` | `0.95` | Only when a female voice is needed (second speaker, female role). |

```bash
npx --yes hyperframes tts "..." --voice am_michael --speed 0.93 -o vo_m1.wav   # M1
npx --yes hyperframes tts "..." --voice af_heart   --speed 0.95 -o vo_f1.wav   # F1
```

Do not re-ask the user about voice casting at proposal time: state "M1 (am_michael, 0.93)" (and F1 if used) and log it as the `voice_selection` decision with `rejected_because: "user standing voice cast"` for alternatives. Ask only if they request a different voice or a language Kokoro lacks (e.g. Russian).

## 4. Extra entry points

OpenMontage ships slash-command recipes in `$OM_DIR/.claude/commands/`: `ink-art` (self-drawing ink doodle animation), `animated-drawing` (animate a supplied drawing), `reel`, `backlot` (live storyboard board: `python -m backlot open`). Read the matching file when the user asks for that kind of output.

## 5. Deliver

Final renders land under `$OM_DIR/projects/<project-id>/`. Copy the final video into the user's working directory (or send it with SendUserFile) and report path, duration, and the providers used. Respond in the user's language.
