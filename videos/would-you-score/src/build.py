"""Builds index.html for the 'Would You Score?' sample (HyperFrames + Three.js).
Caption word timings are derived from the measured Kokoro line durations."""
import json, re, pathlib

HERE = pathlib.Path(__file__).parent
DUR = 13.6

# (start_s, line_duration_s, chunks) — chunk = (text, keyword)
LINES = [
    (0.30, 3.477, [("World Cup final.", "final."), ("Penalties.", "Penalties."), ("You have twelve yards.", "twelve")]),
    (4.15, 3.797, [("Seventy thousand people", "thousand"), ("are screaming.", "screaming."), ("Here's how you score.", "score.")]),
    (8.30, 4.096, [("First: pick your corner", "corner"), ("before you walk up.", "walk"), ("And never change it.", "never")]),
]

def weight(w):
    return len(re.sub(r"[^\w']", "", w)) + 2 + (3 if re.search(r"[.,:]$", w) else 0)

chunks = []
for start, dur, cks in LINES:
    words = [(ci, w) for ci, (txt, _) in enumerate(cks) for w in txt.split()]
    total = sum(weight(w) for _, w in words)
    speak = dur * 0.94
    t = start
    times = []
    for ci, w in words:
        times.append((ci, w, round(t, 3)))
        t += speak * weight(w) / total
    for ci, (txt, key) in enumerate(cks):
        ws = [(w, tt) for c, w, tt in times if c == ci]
        chunks.append({"words": [{"w": w, "t": tt, "key": w == key} for w, tt in ws]})
for i, c in enumerate(chunks):
    c["start"] = c["words"][0]["t"]
    c["end"] = chunks[i + 1]["words"][0]["t"] if i + 1 < len(chunks) else DUR - 0.25
    # don't linger across long pauses between lines
    last = c["words"][-1]["t"]
    c["end"] = min(c["end"], last + 1.1) if i + 1 < len(chunks) else c["end"]

fonts_css = (HERE / "assets/fonts/g.css").read_text()
fonts_css = re.sub(r"url\(https://fonts\.gstatic\.com/[^)]*/([^/)]+)\)", r"url(assets/fonts/\1)", fonts_css)

html = (HERE / "template.html.tpl").read_text()
html = html.replace("/*FONTS*/", fonts_css).replace("__CHUNKS__", json.dumps(chunks)).replace("__DUR__", str(DUR))
(HERE / "index.html").write_text(html)
print("chunks:", len(chunks))
