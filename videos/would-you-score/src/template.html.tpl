<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=1080, height=1920" />
<title>Would You Score — sample</title>
<script src="node_modules/gsap/dist/gsap.min.js"></script>
<style>
/*FONTS*/
:root { --y: #FFC83D; --g: #6BFF8E; --w: #F4F1EA; --dim: rgba(244,241,234,.7); }
html, body { margin: 0; background: #05070a; }
#root { position: relative; width: 1080px; height: 1920px; overflow: hidden; font-family: Inter, sans-serif; color: var(--w); }
#bg { position: absolute; inset: 0; background: #05070a; }
#three-layer { position: absolute; inset: 0; width: 1080px; height: 1920px; display: block; }
#vignette { position: absolute; inset: 0; background: radial-gradient(ellipse 75% 60% at 50% 45%, rgba(0,0,0,0) 40%, rgba(0,0,0,.72) 100%); }

/* ---------- title card ---------- */
#title { position: absolute; inset: 0; }
#title-dim { position: absolute; inset: 0; background: rgba(3,5,8,.42); }
#title-inner { position: absolute; left: 0; right: 0; top: 640px; text-align: center; }
.kicker { font-family: 'JetBrains Mono', monospace; font-weight: 700; font-size: 26px; letter-spacing: .18em; color: var(--g); }
.big { font-family: 'Bebas Neue', sans-serif; font-size: 190px; line-height: .9; letter-spacing: .01em; }
.row2 { display: flex; justify-content: center; align-items: center; gap: 26px; }
.bracket { position: relative; padding: 0 22px; color: var(--y); }
.bracket i { position: absolute; width: 34px; height: 34px; border: 6px solid var(--y); }
.bracket i.tl { left: -6px; top: -14px; border-right: 0; border-bottom: 0; }
.bracket i.tr { right: -6px; top: -14px; border-left: 0; border-bottom: 0; }
.bracket i.bl { left: -6px; bottom: -4px; border-right: 0; border-top: 0; }
.bracket i.br { right: -6px; bottom: -4px; border-left: 0; border-top: 0; }

/* ---------- HUD ---------- */
#hud { position: absolute; left: 0; right: 0; top: 0; height: 200px; opacity: 0; }
#hud-shade { position: absolute; inset: 0; background: linear-gradient(rgba(0,0,0,.75), rgba(0,0,0,0)); }
#logo { position: absolute; left: 44px; top: 54px; display: flex; gap: 14px; align-items: center; }
#logo .ball { width: 46px; height: 46px; border-radius: 50%; border: 4px solid var(--g); box-sizing: border-box; position: relative; }
#logo .ball::after { content: ''; position: absolute; inset: 9px; border-radius: 50%; background: var(--g); }
#logo b { display: block; font-family: 'Bebas Neue'; font-size: 40px; line-height: 1; letter-spacing: .04em; }
#logo small { display: block; font-family: 'JetBrains Mono'; font-size: 16px; color: var(--g); letter-spacing: .12em; }
#clock { position: absolute; left: 0; right: 0; top: 44px; text-align: center; }
#clock small { display: block; font-family: 'JetBrains Mono'; font-size: 16px; letter-spacing: .2em; color: var(--dim); }
#clock b { font-family: 'JetBrains Mono'; font-weight: 700; font-size: 58px; color: var(--y); letter-spacing: .04em; }
#chance { position: absolute; right: 44px; top: 56px; text-align: right; width: 230px; }
#chance small { font-family: 'JetBrains Mono'; font-size: 16px; letter-spacing: .14em; color: var(--dim); }
#chance .pct { position: relative; display: inline-block; width: 66px; height: 22px; vertical-align: -3px; }
#chance .pct span { position: absolute; right: 0; top: 0; font-family: 'JetBrains Mono'; font-weight: 700; font-size: 20px; color: var(--w); }
#bar { margin-top: 10px; height: 16px; display: flex; gap: 4px; }
#bar i { flex: 1; background: rgba(255,255,255,.16); }
#bar i.on { background: var(--w); }
#bar i.up { background: var(--y); opacity: 0; }

/* ---------- callout tags ---------- */
.tag { position: absolute; left: 0; top: 0; opacity: 0; font-family: 'JetBrains Mono'; font-weight: 700; font-size: 22px; letter-spacing: .1em;
       padding: 10px 16px; border: 3px solid var(--g); color: var(--w); background: rgba(5,10,8,.78); white-space: nowrap; }
.tag em { font-style: normal; color: var(--g); }
.tag.y { border-color: var(--y); }
.tag.y em { color: var(--y); }

/* ---------- captions ---------- */
#caps { position: absolute; left: 60px; right: 60px; top: 1330px; height: 140px; }
.chunk { position: absolute; left: 0; right: 0; top: 0; text-align: center; opacity: 0; font-family: Inter; font-weight: 700; font-size: 64px; line-height: 140px;
         text-shadow: 0 4px 18px rgba(0,0,0,.85); white-space: nowrap; }
.wd { display: inline-block; opacity: .32; margin: 0 9px; position: relative; }
.wd.key { color: var(--y); padding: 0 12px; }
.wd.key i { position: absolute; width: 18px; height: 18px; border: 4px solid var(--y); opacity: 0; }
.wd.key i.tl { left: -2px; top: 18px; border-right: 0; border-bottom: 0; }
.wd.key i.br { right: -2px; bottom: 18px; border-left: 0; border-top: 0; }
</style>
</head>
<body>
<div id="root" data-composition-id="main" data-width="1080" data-height="1920" data-duration="__DUR__" data-fps="30">
  <div id="bg" class="clip" data-start="0" data-duration="__DUR__" data-track-index="0"></div>
  <canvas id="three-layer" class="clip" data-start="0" data-duration="__DUR__" data-track-index="1"></canvas>
  <div id="vignette" class="clip" data-start="0" data-duration="__DUR__" data-track-index="2"></div>

  <div id="hud" class="clip" data-start="0" data-duration="__DUR__" data-track-index="3">
    <div id="hud-shade"></div>
    <div id="logo"><div class="ball"></div><div><b>KICK LAB</b><small>● FILE #001</small></div></div>
    <div id="clock"><small>MATCH CLOCK</small><b>120:00</b></div>
    <div id="chance"><small>SCORE CHANCE</small> <span class="pct"><span id="p76">76%</span><span id="p81" style="opacity:0">81%</span></span>
      <div id="bar"><i class="on"></i><i class="on"></i><i class="on"></i><i class="on"></i><i class="on"></i><i class="on"></i><i class="on"></i><i id="b8" class="up"></i><i></i><i></i></div>
    </div>
  </div>

  <div id="tag-you" class="tag clip" data-start="0" data-duration="__DUR__" data-track-index="4">YOU · <em>AT THE SPOT</em></div>
  <div id="tag-keeper" class="tag clip" data-start="0" data-duration="__DUR__" data-track-index="5">KEEPER · <em>READING YOU</em></div>
  <div id="tag-corner" class="tag y clip" data-start="0" data-duration="__DUR__" data-track-index="6">TARGET · <em>LOCKED</em></div>

  <div id="title" class="clip" data-start="0" data-duration="__DUR__" data-track-index="7">
    <div id="title-dim"></div>
    <div id="title-inner">
      <div class="kicker" id="t-kicker">● WORLD CUP FINAL · PENALTIES</div>
      <div class="big" id="t-l1">YOU HAVE</div>
      <div class="big row2" id="t-l2"><span class="bracket" id="t-num"><i class="tl"></i><i class="tr"></i><i class="bl"></i><i class="br"></i>12</span><span>YARDS</span></div>
    </div>
  </div>

  <div id="caps" class="clip" data-start="0" data-duration="__DUR__" data-track-index="8"></div>

  <audio id="mix" src="assets/mix.wav" data-start="0" data-duration="__DUR__" data-track-index="10" data-volume="1"></audio>
</div>

<script>
// ---------- captions DOM ----------
const CHUNKS = __CHUNKS__;
const caps = document.getElementById('caps');
CHUNKS.forEach((c, ci) => {
  const d = document.createElement('div'); d.className = 'chunk'; d.id = 'ck' + ci;
  c.words.forEach((w, wi) => {
    const s = document.createElement('span'); s.className = 'wd' + (w.key ? ' key' : ''); s.id = `ck${ci}w${wi}`;
    s.textContent = w.w;
    if (w.key) { s.insertAdjacentHTML('beforeend', `<i class="tl" id="ck${ci}w${wi}a"></i><i class="br" id="ck${ci}w${wi}b"></i>`); }
    d.appendChild(s);
  });
  caps.appendChild(d);
});

// ---------- timeline ----------
window.__timelines = window.__timelines || {};
const tl = gsap.timeline({ paused: true, onUpdate: () => window.__renderThree && window.__renderThree(tl.time()) });

// title card
tl.from('#t-kicker', { opacity: 0, y: 20, duration: .4, ease: 'power2.out' }, .15)
  .from('#t-l1', { opacity: 0, y: 40, duration: .45, ease: 'power3.out' }, .3)
  .from('#t-l2', { opacity: 0, scale: .85, duration: .5, ease: 'back.out(2)' }, 2.2)
  .to('#title', { opacity: 0, duration: .45, ease: 'power2.in' }, 3.55);

// HUD
tl.to('#hud', { opacity: 1, duration: .4 }, 3.95)
  .from('#hud', { y: -30, duration: .5, ease: 'power3.out' }, 3.95)
  .to('#p76', { opacity: 0, duration: .15 }, 11.55)
  .to('#p81', { opacity: 1, duration: .15 }, 11.55)
  .to('#b8', { opacity: 1, duration: .2, ease: 'steps(2)' }, 11.55);

// callout tags (positions are driven per-frame by the 3D projection)
tl.to('#tag-you', { opacity: 1, duration: .25 }, 6.2).to('#tag-you', { opacity: 0, duration: .25 }, 8.0)
  .to('#tag-keeper', { opacity: 1, duration: .25 }, 5.6).to('#tag-keeper', { opacity: 0, duration: .25 }, 8.1)
  .to('#tag-corner', { opacity: 1, duration: .25 }, 11.4);

// captions
CHUNKS.forEach((c, ci) => {
  tl.fromTo('#ck' + ci, { opacity: 0 }, { opacity: 1, duration: .01, immediateRender: false }, c.start - .01);
  tl.fromTo('#ck' + ci, { opacity: 1 }, { opacity: 0, duration: .01, immediateRender: false }, c.end - .02);
  c.words.forEach((w, wi) => {
    tl.fromTo(`#ck${ci}w${wi}`, { opacity: .32 }, { opacity: 1, duration: .1, immediateRender: false }, w.t);
    if (w.key) {
      tl.fromTo(`#ck${ci}w${wi}`, { scale: 1 }, { scale: 1.12, duration: .12, yoyo: true, repeat: 1 }, w.t);
      tl.to([`#ck${ci}w${wi}a`, `#ck${ci}w${wi}b`], { opacity: 1, duration: .1 }, w.t);
    }
  });
});
tl.set({}, {}, __DUR__);
window.__timelines['main'] = tl;
</script>

<script type="module">
import * as THREE from './node_modules/three/build/three.module.js';

const W = 1080, H = 1920;
const canvas = document.getElementById('three-layer');
const renderer = new THREE.WebGLRenderer({ canvas, antialias: true, preserveDrawingBuffer: true });
renderer.setPixelRatio(1); renderer.setSize(W, H, false);
renderer.outputColorSpace = THREE.SRGBColorSpace;
renderer.toneMapping = THREE.ACESFilmicToneMapping; renderer.toneMappingExposure = 1.05;

const scene = new THREE.Scene();
scene.background = new THREE.Color(0x05070c);
scene.fog = new THREE.Fog(0x05070c, 90, 260);
const camera = new THREE.PerspectiveCamera(50, W / H, 0.1, 600);

// seeded PRNG (determinism)
let seed = 1337; const rnd = () => { seed |= 0; seed = seed + 0x6D2B79F5 | 0; let t = Math.imul(seed ^ seed >>> 15, 1 | seed); t = t + Math.imul(t ^ t >>> 7, 61 | t) ^ t; return ((t ^ t >>> 14) >>> 0) / 4294967296; };

// ---------- pitch texture ----------
const PW = 68, PL = 105, S = 14; // px per meter
const tc = document.createElement('canvas'); tc.width = (PW + 12) * S; tc.height = (PL + 12) * S;
const g = tc.getContext('2d');
for (let i = 0; i < 18; i++) { g.fillStyle = i % 2 ? '#1d5a2a' : '#226633'; g.fillRect(0, i * tc.height / 18, tc.width, tc.height / 18 + 1); }
const X = m => (m + PW / 2 + 6) * S, Z = m => (m + PL / 2 + 6) * S;
g.strokeStyle = 'rgba(240,245,235,.92)'; g.lineWidth = 0.13 * S; g.fillStyle = 'rgba(240,245,235,.92)';
const rect = (x0, z0, x1, z1) => g.strokeRect(X(x0), Z(z0), X(x1) - X(x0), Z(z1) - Z(z0));
rect(-PW / 2, -PL / 2, PW / 2, PL / 2);
g.beginPath(); g.moveTo(X(-PW / 2), Z(0)); g.lineTo(X(PW / 2), Z(0)); g.stroke();
g.beginPath(); g.arc(X(0), Z(0), 9.15 * S, 0, Math.PI * 2); g.stroke();
for (const s of [-1, 1]) {
  const gl = s * PL / 2;
  rect(-20.16, gl, 20.16, gl - s * 16.5); rect(-9.16, gl, 9.16, gl - s * 5.5);
  const spot = gl - s * 11; g.beginPath(); g.arc(X(0), Z(spot), 0.25 * S, 0, Math.PI * 2); g.fill();
  g.beginPath(); const a = Math.acos(5.5 / 9.15); s < 0 ? g.arc(X(0), Z(spot), 9.15 * S, Math.PI / 2 - a, Math.PI / 2 + a) : g.arc(X(0), Z(spot), 9.15 * S, -Math.PI / 2 - a, -Math.PI / 2 + a); g.stroke();
}
const tex = new THREE.CanvasTexture(tc); tex.colorSpace = THREE.SRGBColorSpace; tex.anisotropy = 8;
const pitch = new THREE.Mesh(new THREE.PlaneGeometry(PW + 12, PL + 12), new THREE.MeshStandardMaterial({ map: tex, roughness: .95 }));
pitch.rotation.x = -Math.PI / 2; scene.add(pitch);

// ---------- stands + crowd ----------
const standMat = new THREE.MeshStandardMaterial({ color: 0x15171d, roughness: 1 });
const crowdGeo = new THREE.BoxGeometry(.5, .9, .5);
const crowdMat = new THREE.MeshStandardMaterial({ roughness: .9, emissive: 0x000000 });
const seats = [];
function stand(len, cx, cz, rotY) {
  const depth = 34, rise = 22, slope = Math.atan2(rise, depth), hyp = Math.hypot(depth, rise);
  const grp = new THREE.Group(); grp.position.set(cx, 0, cz); grp.rotation.y = rotY; scene.add(grp);
  const slab = new THREE.Mesh(new THREE.BoxGeometry(len, 1, hyp), standMat);
  slab.position.set(0, rise / 2, -depth / 2 - 4); slab.rotation.x = slope; grp.add(slab);
  const wall = new THREE.Mesh(new THREE.BoxGeometry(len, 2.2, .6), new THREE.MeshStandardMaterial({ color: 0x0b2a4a, emissive: 0x08263f, emissiveIntensity: .6 }));
  wall.position.set(0, 1.1, -3.6); grp.add(wall);
  const roof = new THREE.Mesh(new THREE.BoxGeometry(len, .8, 16), standMat); roof.position.set(0, rise + 9, -depth + 2); grp.add(roof);
  // floodlight strip under roof edge
  for (let x = -len / 2 + 4; x < len / 2; x += 8) {
    const lamp = new THREE.Mesh(new THREE.BoxGeometry(3.2, .5, .5), new THREE.MeshBasicMaterial({ color: 0xfff6e0 }));
    lamp.position.set(x, rise + 8.4, -depth + 10); grp.add(lamp);
  }
  for (let r = 0; r < 26; r++) {
    const d = 5.5 + r * (depth - 6) / 26, y = (d - 4) * Math.tan(slope) + .9;
    for (let x = -len / 2 + 1; x < len / 2 - 1; x += .85) {
      if (rnd() < .08) continue;
      const v = new THREE.Vector3(x + (rnd() - .5) * .2, y, -d).applyEuler(grp.rotation).add(grp.position);
      seats.push(v);
    }
  }
}
stand(PL + 14, -(PW / 2 + 6), 0, Math.PI / 2);
stand(PL + 14, (PW / 2 + 6), 0, -Math.PI / 2);
stand(PW + 14, 0, -(PL / 2 + 6), 0);
stand(PW + 14, 0, (PL / 2 + 6), Math.PI);
const crowd = new THREE.InstancedMesh(crowdGeo, crowdMat, seats.length);
const m4 = new THREE.Matrix4(), col = new THREE.Color();
const palette = [0x2b2f3a, 0x3a3f4c, 0x1f2430, 0xd9d4c7, 0xc7323b, 0x2a5bd7, 0xf2c14e, 0x444a57];
seats.forEach((p, i) => { m4.makeTranslation(p.x, p.y, p.z); crowd.setMatrixAt(i, m4); col.setHex(palette[Math.floor(rnd() * palette.length)]); crowd.setColorAt(i, col); });
scene.add(crowd);

// ---------- goal ----------
const GZ = -PL / 2, GW = 7.32, GH = 2.44;
const postMat = new THREE.MeshStandardMaterial({ color: 0xffffff, emissive: 0xffffff, emissiveIntensity: .35 });
const goal = new THREE.Group(); scene.add(goal);
for (const x of [-GW / 2, GW / 2]) { const p = new THREE.Mesh(new THREE.BoxGeometry(.12, GH, .12), postMat); p.position.set(x, GH / 2, GZ); goal.add(p); }
const bar = new THREE.Mesh(new THREE.BoxGeometry(GW + .12, .12, .12), postMat); bar.position.set(0, GH, GZ); goal.add(bar);
const net = new THREE.Mesh(new THREE.BoxGeometry(GW, GH, 2, 24, 8, 6), new THREE.MeshBasicMaterial({ color: 0xdfe6ee, wireframe: true, transparent: true, opacity: .28 }));
net.position.set(0, GH / 2, GZ - 1); goal.add(net);

// ---------- figures ----------
function figure(color, emissive) {
  const m = new THREE.MeshStandardMaterial({ color, emissive, emissiveIntensity: .35, roughness: .6, flatShading: true });
  const f = new THREE.Group();
  const part = (geo, x, y, z) => { const o = new THREE.Mesh(geo, m); o.position.set(x, y, z); f.add(o); return o; };
  part(new THREE.BoxGeometry(.24, .85, .26), -.15, .43, 0); part(new THREE.BoxGeometry(.24, .85, .26), .15, .43, 0);
  part(new THREE.BoxGeometry(.62, .72, .34), 0, 1.22, 0);
  f.userData.armL = part(new THREE.BoxGeometry(.18, .7, .2), -.42, 1.2, 0);
  f.userData.armR = part(new THREE.BoxGeometry(.18, .7, .2), .42, 1.2, 0);
  part(new THREE.IcosahedronGeometry(.22, 1), 0, 1.8, 0);
  return f;
}
const SPOT = GZ + 11;
const player = figure(0xf2f2f2, 0x9aa3b5); player.position.set(0, 0, SPOT + 1.9); player.rotation.y = Math.PI; scene.add(player);
const keeper = figure(0x9bff6b, 0x2fbf3a); keeper.position.set(0, 0, GZ + .4); scene.add(keeper);
const ball = new THREE.Mesh(new THREE.IcosahedronGeometry(.13, 1), new THREE.MeshStandardMaterial({ color: 0xffffff, flatShading: true, emissive: 0x444444 }));
ball.position.set(0, .13, SPOT); scene.add(ball);

// glow ring under player + light pool
const ring = new THREE.Mesh(new THREE.RingGeometry(1.5, 1.62, 64), new THREE.MeshBasicMaterial({ color: 0xffffff, transparent: true, opacity: .75 }));
ring.rotation.x = -Math.PI / 2; ring.position.set(0, .03, SPOT + 1.9); scene.add(ring);
const pool = new THREE.Mesh(new THREE.CircleGeometry(4.5, 48), new THREE.MeshBasicMaterial({ color: 0xfff4d6, transparent: true, opacity: .12, depthWrite: false }));
pool.rotation.x = -Math.PI / 2; pool.position.set(0, .02, SPOT + 1); scene.add(pool);

// aim line + target
const TGT = new THREE.Vector3(-3.15, .35, GZ + .05);
const aimMat = new THREE.MeshBasicMaterial({ color: 0xffc83d, transparent: true, opacity: .95 });
const aimLen = Math.hypot(TGT.x, TGT.z - SPOT);
const aim = new THREE.Mesh(new THREE.PlaneGeometry(.22, 1), aimMat); aim.rotation.x = -Math.PI / 2;
const aimGrp = new THREE.Group(); aimGrp.position.set(0, .05, SPOT); aimGrp.rotation.y = Math.atan2(-TGT.x, -(TGT.z - SPOT)) ; aimGrp.add(aim); scene.add(aimGrp);
const target = new THREE.Mesh(new THREE.RingGeometry(.42, .56, 40), new THREE.MeshBasicMaterial({ color: 0xffc83d, transparent: true, side: THREE.DoubleSide }));
target.position.copy(TGT); target.position.z += .02; scene.add(target);

// ---------- lights ----------
scene.add(new THREE.HemisphereLight(0x9fb4d8, 0x0a0d12, .55));
for (const [x, z] of [[-60, -70], [60, -70], [-60, 70], [60, 70]]) { const d = new THREE.DirectionalLight(0xfff1dc, .55); d.position.set(x, 55, z); scene.add(d); }
const spotL = new THREE.SpotLight(0xfff2d8, 260, 60, Math.PI / 9, .6, 1.4); spotL.position.set(0, 22, SPOT + 6); spotL.target.position.set(0, 0, SPOT - 2); scene.add(spotL, spotL.target);

// ---------- camera path ----------
const ease = t => t <= 0 ? 0 : t >= 1 ? 1 : t * t * (3 - 2 * t);
const lerpV = (a, b, t) => new THREE.Vector3().lerpVectors(a, b, t);
const V = (x, y, z) => new THREE.Vector3(x, y, z);
const KEYS = [ // time, position, lookAt
  [0.0, V(26, 150, 70), V(0, 0, -6)],
  [3.7, V(18, 128, 44), V(0, 0, -16)],
  [5.1, V(10, 42, SPOT + 32), V(0, 0, SPOT - 6)],
  [6.6, V(7, 13, SPOT + 15), V(0, .8, SPOT - 1.5)],
  [8.4, V(4.5, 12, SPOT + 11.5), V(0, .8, SPOT + .5)],
  [10.0, V(1.5, 30, SPOT + 12), V(-.8, 0, GZ + 6.5)],
  [13.6, V(0.4, 28, SPOT + 10), V(-1.2, 0, GZ + 6)],
];
function camAt(t) {
  let i = 0; while (i < KEYS.length - 2 && t > KEYS[i + 1][0]) i++;
  const [t0, p0, l0] = KEYS[i], [t1, p1, l1] = KEYS[i + 1];
  const k = ease((t - t0) / (t1 - t0));
  camera.position.copy(lerpV(p0, p1, k)); camera.lookAt(lerpV(l0, l1, k));
}

// ---------- DOM tags pinned to 3D points ----------
const tags = [['tag-you', () => V(0, 2.6, SPOT + 1.9), 30, -40], ['tag-keeper', () => V(keeper.position.x, 2.8, GZ + .4), -300, -70], ['tag-corner', () => TGT.clone().add(V(0, .6, 0)), -60, -78]];
function placeTags() {
  for (const [id, fn, dx, dy] of tags) {
    const p = fn().project(camera); const el = document.getElementById(id);
    const x = (p.x * .5 + .5) * W + dx, y = (-p.y * .5 + .5) * H + dy;
    el.style.transform = `translate(${Math.round(x)}px, ${Math.round(y)}px)`;
  }
}

function renderAt(t) {
  camAt(t);
  // keeper sways on the line, arms out
  keeper.position.x = Math.sin(t * 2.4) * .55;
  keeper.userData.armL.rotation.z = .9 + Math.sin(t * 4.8) * .12; keeper.userData.armR.rotation.z = -.9 - Math.sin(t * 4.8) * .12;
  // player breathing
  player.position.y = Math.sin(t * 3.1) * .015;
  ring.scale.setScalar(1 + .06 * Math.sin(t * 3.6));
  // aim line draws from 9.0s; target pops at 11.4
  const k = ease((t - 9.0) / 1.3);
  aim.visible = k > 0.001; aim.scale.y = Math.max(k * aimLen, .001); aim.position.z = -k * aimLen / 2;
  const tk = ease((t - 10.2) / .35); target.visible = tk > 0.001; target.scale.setScalar(.2 + .8 * tk + (t > 11.4 ? .08 * Math.sin((t - 11.4) * 9) : 0));
  renderer.render(scene, camera);
  placeTags();
}
window.__renderThree = renderAt;
window.addEventListener('hf-seek', e => renderAt(e.detail.time));
renderAt(window.__hfThreeTime || (window.__timelines.main ? window.__timelines.main.time() : 0));
</script>
</body>
</html>
