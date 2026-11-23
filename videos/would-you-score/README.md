# Would You Score? — penalty (sample v1)

- Format: 1080x1920, 30 fps, 13.6 s sample (target final: 20–30 s)
- Pipeline: OpenMontage `animation`, runtime HyperFrames + Three.js (atelier, hand-authored)
- Voice: M1 — Kokoro `am_michael`, speed 0.93
- Music: local FFmpeg-synthesised bed (stadium crowd noise + drone + pulse) — Pixabay is blocked by the network policy
- Rebuild: copy `src/*` into `~/OpenMontage/projects/would-you-score/hyperframes/`, `npm i three@0.181.2 gsap@3.14.2`, fetch fonts, `python3 build.py`, `npx -p hyperframes@0.9.86 hyperframes render .`
