# Mouse Optimization — PowerShell GUI
> Script PowerShell avec interface graphique pour optimiser l'input souris sous Windows.  
> Conçu pour le gaming compétitif / supprime toute latence et interférence logicielle.

Ensemble de tweaks registre ciblés pour obtenir un mouvement souris **brut, linéaire et instantané**. L'interface permet de sélectionner, appliquer ou annuler chaque catégorie de tweaks en un clic, avec sauvegarde automatique avant toute modification.

> [!NOTE]
> Not sure what it does? Check the **[video preview](https://youtu.be/p5Yo4Uq4rYk)** to see it in action. the whole process takes under 10 seconds.

---

## Preview

> Interface principale — menu latéral avec les 6 catégories de tweaks, avec console de sortie intégrée.

![Main interface](https://imgur.com/XTgQb9A.png)

<details>
  <summary>More screenshots</summary>

---

**Tweak selection popup — sélection individuelle des tweaks**
> Fenêtre de sélection d'une catégorie : chaque tweak est listé avec son nom, sa description et une case à cocher. Il est possible de tout sélectionner, tout désélectionner, ou choisir manuellement les tweaks à appliquer avant de confirmer (il est possbile de se rendre a l'emplacement dans le registre de chauque cle en cliquant sur le nom de la cle reg en question sur la quelle vous etes placer avec la souris.

![Tweak popup](https://imgur.com/2N5SAvL.png)

---

**Live status — état actuel de chaque clé registre trackée**
> Vue en temps réel de l'état de tous les tweaks : `applied` (vert) si la valeur correspond, `default` (jaune) si elle diffère, `not found` (gris) si la clé est absente. Permet de vérifier l'état exact du système avant ou après application.

![Status view](https://imgur.com/gDXhdeG.png)

---

**Console output — résultat après application d'une catégorie**
> Log détaillé affiché après chaque Apply : nom du tweak, statut (`applied` / `failed`), description, chemin du backup créé et résumé final. Tout est visible directement dans l'interface sans ouvrir de fenêtre externe.

![Apply output](https://imgur.com/p6iMaFw.png)

---

**Revert — restauration d'un backup registre**
> Liste tous les backups `.reg` disponibles avec leur date et heure de création. Un clic sur Restore applique silencieusement le fichier sélectionné via `regedit /s` pour annuler toutes les modifications effectuées.

![Revert view](https://imgur.com/wfyMDDy.png)

</details>

---

## Fonctionnalités

- Suppression complète de l'accélération souris (logicielle via `MouseSpeed` + matérielle via `MouseThreshold1/2`).
- Mouvement 1:1 parfaitement linéaire — courbes X/Y (`SmoothMouseXCurve` / `SmoothMouseYCurve`) forcées à zéro.
- Réduction des délais driver — `mouclass.sys` en priorité kernel realtime (31) et transmit timeout forcé à 0.
- Optimisation du buffer d'entrée — `MouseDataQueueSize` réglé à 16 pour un transfert d'événements plus rapide.
- Optimisation USB — suspension sélective désactivée pour éviter les micro-coupures et la latence périphérique.
- Hover instantané — `MouseHoverTime` à 0ms, double-clic resserré à 200ms.
- Désactivation du magnétisme curseur Windows (`CursorMagnetism`) — supprime les attractions automatiques vers les boutons UI.
- Backup `.reg` automatique avant chaque modification — restauration complète possible à tout moment.
- Revert en un clic — sélection du backup et restauration silencieuse via `regedit /s`.
- Interface console intégrée — log en temps réel de chaque tweak appliqué avec statut coloré.

---

## Support
**If you need any help or have questions**, feel free to join the **[Discord support server](https://discord.gg/insovs)** — I'll be happy to assist you.

---

## Installation & Launch
Head to the **[Releases](https://github.com/insovs/insopti-MouseOptimization/releases)** section and download `MouseOptimization.ps1`, then **right-click** it → **"Run with PowerShell"**.  
The script will automatically request administrator privileges and open a GUI — no installation required, fully standalone.

---

## Tweaks inclus

| Catégorie | Clés modifiées | Effet principal |
|---|---|---|
| Main Registry Tweaks | `MouseSpeed`, `MouseThreshold1/2`, `SmoothMouseXCurve/YCurve`, `MouseHoverTime`, etc | Suppression accel, mouvement linéaire, hover 0ms, effets visuels off |
| CursorUpdateInterval | `CursorUpdateInterval` (mouhid) | Taux de mise à jour curseur maximal — valeur configurable (0 = fastest) |
| HID Pointer Mode | `TreatAbsolutePointerAsAbsolute`, `TreatAbsoluteAsRelative` | Correction du mode pointeur HID — évite les sauts et conversions parasites |
| Class Transmit Timeout | `MouseTransmitTimeout` (mouclass) | Suppression du délai d'envoi interne — événements transmis immédiatement |
| Class Thread Priority | `ThreadPriority` (mouclass) | Priorité kernel 31 (realtime) — traitement des interruptions souris en priorité absolue |
| Data Queue Size | `MouseDataQueueSize` (mouclass) | Buffer d'entrée à 16 — latence minimale, transfert plus rapide des événements |

---

## Utilisation

> [!NOTE]
> If you are not allowed to run **PowerShell scripts**, *enable* it first:
> ```
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```
> or refer to [EnablePowerShellScript](https://github.com/insovs/EnablePowerShellScript).

1. Sélectionner une catégorie dans le menu latéral gauche.
2. Cocher / décocher les tweaks individuels à appliquer dans la popup.
3. Ajuster les valeurs numériques si disponibles (`CursorUpdateInterval`, `MouseDataQueueSize`).
4. Cliquer **Apply** — un backup est créé automatiquement avant toute écriture.
5. Redémarrer le système pour valider l'ensemble des modifications.

Pour annuler : **Revert Optimization** → sélectionner un backup dans la liste → **Restore** → redémarrer.

---

## Notes
- Un backup `.reg` est créé automatiquement dans `MouseOptimizer_Backups/` avant chaque application.
- Redémarrage recommandé après application — certaines clés kernel ne sont chargées qu'au boot.

> [!CAUTION]
> Tester ces deux ci dessous **indépendamment** en cas d'instabilité pour isoler la source du problème et corrige cela.
- `CursorUpdateInterval = 0` correspond au taux maximal. Augmenter progressivement (1, 2, 3...) si des instabilités apparaissent.
- `MouseDataQueueSize` : **ne pas descendre en dessous de 16**. Sur systèmes anciens ou instables, tester 18–24.

---

<p align="center">
  <sub>©insopti — <a href="https://guns.lol/inso.vs">guns.lol/inso.vs</a> | For personal use only.</sub>
</p>
