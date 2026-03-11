# Mouse Optimization — PowerShell GUI
> PowerShell script with a graphical interface to optimize mouse input on Windows.  
> Designed for competitive gaming — removes all latency and software interference.

A set of targeted registry tweaks to achieve **raw, linear and immediate** mouse movement. The interface lets you select, apply or revert each category of tweaks in one click, with automatic backup before any modification.

> [!NOTE]
> Not sure what it does? Check the **[video preview](https://youtu.be/p5Yo4Uq4rYk)** to see it in action. The whole process takes under 10 seconds.

---

## Preview

> Main interface — side menu with the tweak categories and an integrated output console.

![Main interface](https://imgur.com/XTgQb9A.png)

<details>
  <summary>More screenshots</summary>

---

**Tweak selection popup — individual tweak selection**
> Category selection window: each tweak is listed with its name, description and a checkbox. You can select all, deselect all, or manually pick the tweaks to apply before confirming. You can also navigate directly to the registry location of each key by clicking on its name.

![Tweak popup](https://imgur.com/2N5SAvL.png)

---

**Live status — current state of each tracked registry key**
> Real-time view of all tweak states: `applied` (green) if the value matches, `default` (yellow) if it differs, `not found` (grey) if the key is absent. Lets you verify the exact system state before or after applying.

![Status view](https://imgur.com/gDXhdeG.png)

---

**Console output — result after applying a category**
> Detailed log displayed after each Apply: tweak name, status (`applied` / `failed`), description, backup path and final summary. Everything is visible directly in the interface without opening any external window.

![Apply output](https://imgur.com/p6iMaFw.png)

---

**Revert — registry backup restoration**
> Lists all available `.reg` backups with their creation date and time. One click on Restore silently applies the selected file via `regedit /s` to undo all changes made.

![Revert view](https://imgur.com/wfyMDDy.png)

</details>

---

## Features

- Full mouse acceleration removal (software via `MouseSpeed` + hardware via `MouseThreshold1/2`).
- Perfect 1:1 linear movement — X/Y curves (`SmoothMouseXCurve` / `SmoothMouseYCurve`) forced to zero.
- Driver delay reduction — `mouclass.sys` set to kernel realtime priority (31) and transmit timeout forced to 0.
- Input buffer optimization — `MouseDataQueueSize` set to 16 for faster event transfer.
- USB optimization — selective suspend disabled to prevent micro-cutouts and peripheral latency.
- Instant hover — `MouseHoverTime` at 0ms, double-click tightened to 200ms.
- Windows cursor magnetism disabled (`CursorMagnetism`) — removes automatic attraction towards UI buttons.
- Automatic `.reg` backup before every modification — full restore possible at any time.
- One-click revert — select a backup and silently restore via `regedit /s`.
- Integrated console interface — real-time log of every applied tweak with color-coded status.

---

## Support
**If you need any help or have questions**, feel free to join the **[Discord support server](https://discord.gg/insovs)** — I'll be happy to assist you.

---

## Installation & Launch
Head to the **[Releases](https://github.com/insovs/insopti-MouseOptimization/releases)** section and download `MouseOptimization.ps1`, then **right-click** it → **"Run with PowerShell"**.  
The script will automatically request administrator privileges and open a GUI — no installation required, fully standalone.

---

## Usage

> [!NOTE]
> If you are not allowed to run **PowerShell scripts**, *enable* it first:
> ```
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```
> or refer to [EnablePowerShellScript](https://github.com/insovs/EnablePowerShellScript).

1. Select a category from the left sidebar.
2. Check / uncheck the individual tweaks to apply in the popup.
3. Adjust numeric values if available (`CursorUpdateInterval`, `MouseDataQueueSize`).
4. Click **Apply** — a backup is created automatically before any write operation.
5. Restart the system to validate all changes.

To undo: **Revert Optimization** → select a backup from the list → **Restore** → restart.

---

## Registry Key Reference

---

### 🟢 Category 1 — Main Mouse Registry Tweaks
> `HKCU\Control Panel\Mouse` · `HKLM\SYSTEM\...` · `HKCU\Control Panel\Desktop`

| Key | Type | Value | Default | Effect |
|---|---|---|---|---|
| `MouseSpeed` | STRING | `0` | `1` | Disables Windows pointer acceleration (Enhanced Pointer Precision) |
| `MouseThreshold1` | STRING | `0` | `6` | Removes first acceleration threshold (2x speed multiplier) |
| `MouseThreshold2` | STRING | `0` | `10` | Removes second acceleration threshold (4x speed multiplier) |
| `MouseSensitivity` | STRING | `10` | `10` | Neutral midpoint — no amplification of raw input |
| `SmoothMouseXCurve` | BINARY | `0x00…` | curve data | Flat horizontal response — zero speed-dependent amplification on X axis |
| `SmoothMouseYCurve` | BINARY | `0x00…` | curve data | Flat vertical response — perfect 1:1 physical distance mapping on Y axis |
| `MouseHoverTime` | STRING | `0` | `400` | Tooltip fires instantly at 0ms instead of 400ms |
| `DoubleClickSpeed` | STRING | `200` | `500` | Tighter double-click detection window (200ms) |
| `MouseTrails` | STRING | `0` | `0` | Cursor ghost trails disabled — removes rendering overhead |
| `MouseDelay` | STRING | `0` | `0` | No delay before first click-repeat event fires |
| `MouseAccel` | STRING | `0` | `0` | Legacy hardware acceleration flag explicitly disabled |
| `SwapMouseButtons` | STRING | `0` | `0` | Standard button layout enforced |
| `SnapToDefaultButton` | STRING | `0` | `0` | Disables auto-snap cursor to default dialog button |
| `ActiveWindowTracking` | DWORD | `0` | `0` | Focus does not follow cursor without a click |
| `Beep` | STRING | `No` | `Yes` | Mouse beep sounds disabled |
| `ExtendedSounds` | STRING | `No` | `Yes` | Extended mouse audio feedback disabled |
| `UserPreferencesMask` | BINARY | `90 12 07 80…` | `9E 3E 07 80…` | Disables cursor shadow and GPU-rendered desktop visual effects |
| `DisableSelectiveSuspend` | DWORD | `1` | `0` | Prevents USB port power cuts that cause micro-stutters |
| `PollStatusIterations` | DWORD | `1` | `12` | Reduces PS/2 polling overhead — lower input latency on legacy ports |
| `AttractionRectInsetInDIPS` | DWORD | `0` | varies | Disables cursor magnetism attraction zone around UI buttons |
| `DistanceThresholdInDIPS` | DWORD | `0` | varies | Cursor is never pulled toward any UI element |
| `MagnetismDelayInMilliseconds` | DWORD | `1` | varies | Minimizes the window during which magnetism can engage |
| `MagnetismUpdateIntervalInMilliseconds` | DWORD | `1` | varies | Near-zero magnetism recalculation interval |
| `VelocityInDIPSPerSecond` | DWORD | `0` | varies | Zero attraction velocity — no cursor pull force applied |

---

### 🔵 Category 2 — CursorUpdateInterval
> `HKLM\SYSTEM\CurrentControlSet\Services\mouhid\Parameters`

| Key | Type | Value | Default | Effect |
|---|---|---|---|---|
| `CursorUpdateInterval` | DWORD | `0` *(0–5)* | not set | HID cursor position update rate. `0` = every kernel tick (maximum frequency). Increase progressively if cursor behaves erratically |

> [!CAUTION]
> Start at `0`. If you experience erratic cursor movement, increase to `1`, `2`… until stable.

---

### 🟡 Category 3 — HID Pointer Mode Tweaks
> `HKLM\SYSTEM\CurrentControlSet\Services\mouhid\Parameters`

| Key | Type | Value | Default | Effect |
|---|---|---|---|---|
| `TreatAbsolutePointerAsAbsolute` | DWORD | `1` | `0` | Forces absolute HID devices to map directly to screen coordinates — prevents misinterpretation as relative movement |
| `TreatAbsoluteAsRelative` | DWORD | `0` | `0` | Explicitly blocks absolute-to-relative conversion — prevents cursor jumps and erratic behavior |

---

### 🟠 Category 4 — Mouse Class Transmit Timeout
> `HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters`

| Key | Type | Value | Default | Effect |
|---|---|---|---|---|
| `MouseTransmitTimeout` | DWORD | `0` | not set | Removes the internal buffer flush delay in `mouclass.sys` — every input event is forwarded to the OS immediately |

---

### 🟣 Category 5 — Mouse Class Thread Priority
> `HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters`

| Key | Type | Value | Default | Effect |
|---|---|---|---|---|
| `ThreadPriority` | DWORD | `31` (`0x1F`) | not set | Sets `mouclass.sys` to highest kernel realtime priority — mouse events processed before all other threads even under heavy CPU load |

---

### ⚪ Category 6 — Mouse Data Queue Size
> `HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters`

| Key | Type | Value | Default | Effect |
|---|---|---|---|---|
| `MouseDataQueueSize` | DWORD | `16` | `100` | Reduces the `mouclass.sys` event buffer from 100 to 16 — forces more frequent flushes, reducing queued input latency |

> [!CAUTION]
> Do not go below `16`. On older or unstable systems, test with `18–24`.

---


## Notes
- A `.reg` backup is automatically created in `MouseOptimizer_Backups/` before each application.
- Reboot recommended after applying — some kernel keys are only loaded at boot.
- All tweaks are reversible at any time via the Revert function.

---

<p align="center">
  <sub>©insopti — <a href="https://guns.lol/inso.vs">guns.lol/inso.vs</a> | For personal use only.</sub>
</p>
