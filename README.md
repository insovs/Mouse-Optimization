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

## Registry Key Documentation

Complete reference for every key modified by this script — path, type, applied value, default Windows value, and exact effect.

---

### 🟢 Category 1 — Main Mouse Registry Tweaks

> `HKEY_CURRENT_USER\Control Panel\Mouse` · `HKEY_LOCAL_MACHINE\SYSTEM\...` · `HKEY_CURRENT_USER\Control Panel\Desktop`

| Key | Path | Type | Applied Value | Default Value | Effect |
|---|---|---|---|---|---|
| `DisableSelectiveSuspend` | `HKLM\SYSTEM\CurrentControlSet\Services\USB` | DWORD | `1` | `0` | Disables USB selective suspend — prevents the controller from cutting power to the mouse port during low activity, which causes micro-stutters and reconnect latency |
| `MouseSensitivity` | `HKCU\Control Panel\Mouse` | STRING | `10` | `10` | Sets the pointer sensitivity in the Windows control panel (scale 1–20). Value `10` is the neutral midpoint — does not amplify or reduce raw input |
| `MouseSpeed` | `HKCU\Control Panel\Mouse` | STRING | `0` | `1` | Disables Windows pointer acceleration (Enhanced Pointer Precision). `0` = raw linear movement, `1` = acceleration enabled. This is the primary software acceleration switch |
| `MouseThreshold1` | `HKCU\Control Panel\Mouse` | STRING | `0` | `6` | First acceleration threshold in pixels/tick. Above this speed, Windows doubles pointer movement if `MouseSpeed` is active. Forcing to `0` neutralizes it entirely even if `MouseSpeed` is misconfigured |
| `MouseThreshold2` | `HKCU\Control Panel\Mouse` | STRING | `0` | `10` | Second acceleration threshold — triggers a 4x multiplier at high speed. Forcing to `0` removes this second stage of software acceleration |
| `MouseHoverTime` | `HKCU\Control Panel\Mouse` | STRING | `0` | `400` | Time in milliseconds before a tooltip or hover event fires. Set to `0` for instant hover — reduces perceived UI lag in applications that react to cursor position |
| `MouseTrails` | `HKCU\Control Panel\Mouse` | STRING | `0` | `0` | Number of trailing cursor ghost images. `0` = disabled. Trails add rendering overhead and increase perceived input lag on the cursor |
| `MouseDelay` | `HKCU\Control Panel\Mouse` | STRING | `0` | `0` | Delay in milliseconds before the first key repeat event fires on click-hold. `0` = immediate — removes the initial pause before repeated events |
| `MouseAccel` | `HKCU\Control Panel\Mouse` | STRING | `0` | `0` | Legacy hardware acceleration flag. `0` = disabled. Redundant on modern systems but explicitly set to prevent any driver-level acceleration fallback |
| `DoubleClickSpeed` | `HKCU\Control Panel\Mouse` | STRING | `200` | `500` | Maximum interval in milliseconds between two clicks to register as a double-click. Reduced to `200ms` for tighter, more responsive double-click detection |
| `SwapMouseButtons` | `HKCU\Control Panel\Mouse` | STRING | `0` | `0` | Button swap flag. `0` = standard layout (left = primary). Explicitly set to prevent any swap from being applied by other tools |
| `SnapToDefaultButton` | `HKCU\Control Panel\Mouse` | STRING | `0` | `0` | Disables the Windows feature that automatically moves the cursor to the default button in a dialog box. `0` = disabled — prevents unwanted cursor jumps |
| `ActiveWindowTracking` | `HKCU\Control Panel\Mouse` | DWORD | `0` | `0` | When enabled, moves focus to whichever window the cursor is over without clicking. `0` = disabled — prevents accidental focus changes while gaming |
| `Beep` | `HKCU\Control Panel\Mouse` | STRING | `No` | `Yes` | Controls whether Windows plays a beep on certain mouse events. Set to `No` — removes audio overhead tied to input events |
| `ExtendedSounds` | `HKCU\Control Panel\Mouse` | STRING | `No` | `Yes` | Extended audio feedback for mouse actions. Set to `No` — removes additional sound processing associated with mouse events |
| `SmoothMouseXCurve` | `HKCU\Control Panel\Mouse` | BINARY | `00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00` | Windows curve data | Defines the horizontal acceleration curve applied by Windows to pointer movement. Zeroing this binary value forces a completely flat (linear) X-axis response — no speed-dependent amplification |
| `SmoothMouseYCurve` | `HKCU\Control Panel\Mouse` | BINARY | `00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00` | Windows curve data | Defines the vertical acceleration curve. Zeroing it forces a flat Y-axis response — movement speed maps 1:1 to physical distance regardless of velocity |
| `AttractionRectInsetInDIPS` | `HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism` | DWORD | `0` | `varies` | Defines the inset area around UI buttons where cursor magnetism activates. Set to `0` — disables the attraction zone entirely |
| `DistanceThresholdInDIPS` | `HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism` | DWORD | `0` | `varies` | Distance in DIPs at which the cursor starts being attracted to a button. Set to `0` — cursor is never pulled toward any element |
| `MagnetismDelayInMilliseconds` | `HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism` | DWORD | `1` | `varies` | Delay before magnetism effect engages after the cursor enters the attraction zone. Reduced to `1ms` minimum — minimizes the window during which the effect could briefly alter movement |
| `MagnetismUpdateIntervalInMilliseconds` | `HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism` | DWORD | `1` | `varies` | How often the magnetism effect recalculates cursor pull in milliseconds. Set to `1ms` — reduces processing interval to near-zero |
| `VelocityInDIPSPerSecond` | `HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism` | DWORD | `0` | `varies` | Speed at which the cursor is pulled toward the attraction target. Set to `0` — zero velocity, no attraction force applied |
| `PollStatusIterations` | `HKLM\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters` | DWORD | `1` | `12` | Number of status polling iterations the PS/2 driver performs before processing an input event. Reduced to `1` — minimizes the PS/2 polling overhead and reduces input latency for legacy mouse ports |
| `UserPreferencesMask` | `HKCU\Control Panel\Desktop` | BINARY | `90 12 07 80 10 00 00 00` | `9E 3E 07 80 12 00 00 00` | Bitmask controlling miscellaneous UI effects including cursor shadow, animation and visual feedback. The applied value disables cursor shadow and several GPU-rendered desktop effects that add rendering overhead to the pointer |

---

### 🔵 Category 2 — CursorUpdateInterval

> `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouhid\Parameters`

| Key | Path | Type | Applied Value | Default Value | Effect |
|---|---|---|---|---|---|
| `CursorUpdateInterval` | `HKLM\SYSTEM\CurrentControlSet\Services\mouhid\Parameters` | DWORD | `0` *(configurable 0–5)* | `not set` | Controls how frequently the HID mouse driver updates the cursor position. `0` = maximum update rate (every kernel tick). Higher values reduce update frequency. Start at `0` and increase progressively (1, 2, 3…) only if cursor instability or erratic movement appears |

> [!CAUTION]
> Value `0` is the most aggressive setting. If you experience erratic cursor behavior, increase to `1` or `2` before increasing further.

---

### 🟡 Category 3 — HID Pointer Mode Tweaks

> `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouhid\Parameters`

| Key | Path | Type | Applied Value | Default Value | Effect |
|---|---|---|---|---|---|
| `TreatAbsolutePointerAsAbsolute` | `HKLM\SYSTEM\CurrentControlSet\Services\mouhid\Parameters` | DWORD | `1` | `0` | Forces Windows to process absolute HID pointer devices (tablets, touchscreens, some gaming mice) as true absolute devices — cursor maps directly to physical coordinates without conversion. Prevents the driver from misinterpreting absolute input as relative movement |
| `TreatAbsoluteAsRelative` | `HKLM\SYSTEM\CurrentControlSet\Services\mouhid\Parameters` | DWORD | `0` | `0` | When set to `1`, forces the driver to treat absolute pointer data as relative deltas. Explicitly set to `0` to prevent this conversion — avoids cursor jumps and erratic behavior on mice that send absolute position packets |

---

### 🟠 Category 4 — Mouse Class Transmit Timeout

> `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters`

| Key | Path | Type | Applied Value | Default Value | Effect |
|---|---|---|---|---|---|
| `MouseTransmitTimeout` | `HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters` | DWORD | `0` | `not set` | Defines the timeout in milliseconds that `mouclass.sys` waits before forwarding buffered mouse input data to the system. Set to `0` — disables the internal delay entirely, ensuring every input event is transmitted to the OS immediately upon receipt without waiting for a timeout window |

---

### 🟣 Category 5 — Mouse Class Thread Priority

> `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters`

| Key | Path | Type | Applied Value | Default Value | Effect |
|---|---|---|---|---|---|
| `ThreadPriority` | `HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters` | DWORD | `31` (`0x1F`) | `not set` | Sets the kernel thread priority of the `mouclass.sys` driver thread. `31` is the highest real-time priority level in the Windows kernel scheduler — the mouse input thread preempts all other non-interrupt threads. Under heavy CPU load, mouse events are still processed first, reducing jitter and latency spikes |

---

### ⚪ Category 6 — Mouse Data Queue Size

> `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters`

| Key | Path | Type | Applied Value | Default Value | Effect |
|---|---|---|---|---|---|
| `MouseDataQueueSize` | `HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters` | DWORD | `16` | `100` | Defines the size of the internal input event buffer maintained by `mouclass.sys`. The default value of `100` means the driver can queue up to 100 mouse events before flushing — this adds latency. Reducing to `16` keeps the buffer small, forcing events to be flushed and processed more frequently. Do not go below `16` on older or unstable systems |

> [!CAUTION]
> Do not set `MouseDataQueueSize` below `16`. On older hardware or unstable systems, test with values between `18` and `24` if issues occur.

---

## Notes
- A `.reg` backup is automatically created in `MouseOptimizer_Backups/` before each application.
- Reboot recommended after applying — some kernel keys are only loaded at boot.
- All tweaks are reversible at any time via the Revert function.

---

<p align="center">
  <sub>©insopti — <a href="https://guns.lol/inso.vs">guns.lol/inso.vs</a> | For personal use only.</sub>
</p>
