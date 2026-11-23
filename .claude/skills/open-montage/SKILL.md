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

## 4. Extra entry points

OpenMontage ships slash-command recipes in `$OM_DIR/.claude/commands/`: `ink-art` (self-drawing ink doodle animation), `animated-drawing` (animate a supplied drawing), `reel`, `backlot` (live storyboard board: `python -m backlot open`). Read the matching file when the user asks for that kind of output.

## 5. Deliver

Final renders land under `$OM_DIR/projects/<project-id>/`. Copy the final video into the user's working directory (or send it with SendUserFile) and report path, duration, and the providers used. Respond in the user's language.
