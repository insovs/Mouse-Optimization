# Mouse Optimization — PowerShell GUI
> PowerShell script with a graphical interface to optimize mouse input on Windows.  
> Designed for competitive gaming — removes all latency and software interference.

A set of targeted registry tweaks to achieve **raw, linear and immediate** mouse movement. The interface lets you select, apply or revert each category of tweaks in one click, with automatic backup before any modification.

---

## Preview

> Main interface — side menu with the 6 tweak categories and an integrated output console.

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

> [!NOTE]
> Not sure what it does? Check the **[video preview](https://youtu.be/p5Yo4Uq4rYk)** to see it in action. The whole process takes under 10 seconds.

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

## Included Tweaks

| Category | Modified Keys | Main Effect |
|---|---|---|
| Main Registry Tweaks | `MouseSpeed`, `MouseThreshold1/2`, `SmoothMouseXCurve/YCurve`, `MouseHoverTime`, etc. | Remove acceleration, linear movement, 0ms hover, visual effects off |
| CursorUpdateInterval | `CursorUpdateInterval` (mouhid) | Maximum cursor update rate — configurable value (0 = fastest) |
| Class Transmit Timeout | `MouseTransmitTimeout` (mouclass) | Remove internal send delay — events transmitted immediately |
| Class Thread Priority | `ThreadPriority` (mouclass) | Kernel priority 31 (realtime) — mouse interrupts processed with absolute priority |
| Data Queue Size | `MouseDataQueueSize` (mouclass) | Input buffer set to 16 — minimal latency, faster event transfer |
| HID Pointer Mode | `TreatAbsolutePointerAsAbsolute`, `TreatAbsoluteAsRelative` | Fix HID pointer mode — prevents cursor jumps and parasitic conversions |

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

## Notes
- A `.reg` backup is automatically created in `MouseOptimizer_Backups/` before each application.
- Reboot recommended after applying — some kernel keys are only loaded at boot.

> [!CAUTION]
> Test these two independently if instability occurs, to isolate the source of the problem.
- `CursorUpdateInterval = 0` corresponds to the maximum rate. Increase progressively (1, 2, 3...) if instability appears.
- `MouseDataQueueSize`: **do not go below 16**. On older or unstable systems, test with 18–24.

---

<p align="center">
  <sub>©insopti — <a href="https://guns.lol/inso.vs">guns.lol/inso.vs</a> | For personal use only.</sub>
</p>
