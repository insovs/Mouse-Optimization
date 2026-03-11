Voilà une version condensée et lisible :

---

# Mouse Optimization — PowerShell GUI
> PowerShell GUI to optimize mouse input on Windows for competitive gaming.

> [!NOTE]
> Check the **[video preview](https://youtu.be/p5Yo4Uq4rYk)** — the whole process takes under 10 seconds.

---

## Preview

![Main interface](https://imgur.com/XTgQb9A.png)

<details>
<summary>More screenshots</summary>

![Tweak popup](https://imgur.com/2N5SAvL.png)
![Status view](https://imgur.com/gDXhdeG.png)
![Apply output](https://imgur.com/p6iMaFw.png)
![Revert view](https://imgur.com/wfyMDDy.png)

</details>

---

## Features
- Removes software & hardware mouse acceleration (`MouseSpeed`, `MouseThreshold1/2`)
- Forces perfect 1:1 linear movement (`SmoothMouseXCurve/YCurve` zeroed)
- `mouclass.sys` at kernel realtime priority (31) + transmit timeout forced to 0
- Input buffer reduced to 16 (`MouseDataQueueSize`) for faster event flushing
- USB selective suspend disabled — prevents micro-stutters
- Cursor magnetism fully disabled (`CursorMagnetism` keys zeroed)
- Automatic `.reg` backup before every change — one-click restore at any time

---

## Installation
Download `MouseOptimization.ps1` from **[Releases](https://github.com/insovs/insopti-MouseOptimization/releases)** → right-click → **Run with PowerShell**. Admin privileges requested automatically.

> [!NOTE]
> If scripts are blocked: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

---

## Registry Key Reference

### 🟢 Main Mouse Tweaks — `HKCU\Control Panel\Mouse` · `HKLM\SYSTEM\...`

| Key | Value | Default | Effect |
|---|---|---|---|
| `MouseSpeed` | `0` | `1` | Disables Windows pointer acceleration (Enhanced Pointer Precision) |
| `MouseThreshold1` | `0` | `6` | Removes first acceleration threshold (2x multiplier) |
| `MouseThreshold2` | `0` | `10` | Removes second acceleration threshold (4x multiplier) |
| `MouseSensitivity` | `10` | `10` | Neutral midpoint — no amplification of raw input |
| `SmoothMouseXCurve` | `0x00…` | curve data | Forces flat horizontal response — zero speed-dependent amplification |
| `SmoothMouseYCurve` | `0x00…` | curve data | Forces flat vertical response — 1:1 physical distance mapping |
| `MouseHoverTime` | `0` | `400` | Instant hover — tooltip fires at 0ms |
| `DoubleClickSpeed` | `200` | `500` | Tighter double-click window (200ms) |
| `MouseTrails` | `0` | `0` | Cursor trails disabled — removes rendering overhead |
| `MouseDelay` | `0` | `0` | No delay before first click-repeat event |
| `MouseAccel` | `0` | `0` | Legacy hardware acceleration flag — explicitly off |
| `SwapMouseButtons` | `0` | `0` | Standard button layout enforced |
| `SnapToDefaultButton` | `0` | `0` | No auto-snap to dialog default button |
| `ActiveWindowTracking` | `0` | `0` | Focus doesn't follow cursor without click |
| `Beep` | `No` | `Yes` | Mouse beep sounds disabled |
| `ExtendedSounds` | `No` | `Yes` | Extended mouse audio feedback disabled |
| `UserPreferencesMask` | `90 12 07 80…` | `9E 3E 07 80…` | Disables cursor shadow and GPU-rendered desktop effects |
| `DisableSelectiveSuspend` | `1` | `0` | Prevents USB port power cuts that cause micro-stutters |
| `PollStatusIterations` | `1` | `12` | Reduces PS/2 polling overhead — lower input latency |
| `AttractionRectInsetInDIPS` | `0` | varies | Disables cursor magnetism attraction zone |
| `DistanceThresholdInDIPS` | `0` | varies | Cursor is never pulled toward any UI element |
| `MagnetismDelayInMilliseconds` | `1` | varies | Minimizes magnetism engagement window |
| `MagnetismUpdateIntervalInMilliseconds` | `1` | varies | Near-zero magnetism recalculation interval |
| `VelocityInDIPSPerSecond` | `0` | varies | Zero attraction velocity — no pull force applied |

---

### 🔵 CursorUpdateInterval — `HKLM\SYSTEM\CurrentControlSet\Services\mouhid\Parameters`

| Key | Value | Default | Effect |
|---|---|---|---|
| `CursorUpdateInterval` | `0` *(0–5)* | not set | HID cursor position update rate. `0` = every kernel tick (maximum). Increase if cursor behaves erratically |

---

### 🟡 HID Pointer Mode — `HKLM\SYSTEM\CurrentControlSet\Services\mouhid\Parameters`

| Key | Value | Default | Effect |
|---|---|---|---|
| `TreatAbsolutePointerAsAbsolute` | `1` | `0` | Forces absolute HID devices to map directly to screen coordinates — prevents misinterpretation as relative input |
| `TreatAbsoluteAsRelative` | `0` | `0` | Explicitly blocks absolute-to-relative conversion — prevents cursor jumps |

---

### 🟠 Transmit Timeout — `HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters`

| Key | Value | Default | Effect |
|---|---|---|---|
| `MouseTransmitTimeout` | `0` | not set | Removes the internal buffer flush delay in `mouclass.sys` — every event is forwarded immediately |

---

### 🟣 Thread Priority — `HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters`

| Key | Value | Default | Effect |
|---|---|---|---|
| `ThreadPriority` | `31` (0x1F) | not set | Sets `mouclass.sys` to highest kernel realtime priority — mouse events processed before all other threads even under heavy CPU load |

---

### ⚪ Data Queue Size — `HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters`

| Key | Value | Default | Effect |
|---|---|---|---|
| `MouseDataQueueSize` | `16` | `100` | Reduces the `mouclass.sys` event buffer from 100 to 16 — forces more frequent flushes, reducing queued input latency |

> [!CAUTION]
> Do not go below `16`. On older systems test `18–24` if instability occurs.  
> For `CursorUpdateInterval`: start at `0`, increase progressively if cursor behaves erratically.

---

## Notes
- Backups saved to `MouseOptimizer_Backups/` — restore anytime via Revert
- Reboot recommended after applying — some kernel keys load only at boot
- All changes are fully reversible

---

**Support: [Discord](https://discord.gg/insovs) · [guns.lol/inso.vs](https://guns.lol/inso.vs)**

<p align="center"><sub>©insopti — For personal use only.</sub></p>

---

Tu peux copier-coller ça directement dans ton `README.md` sur GitHub. Toutes les clés sont là, condensées en tableaux compacts par catégorie, sans texte inutile.
