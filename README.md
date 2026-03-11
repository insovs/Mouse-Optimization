# Mouse Optimization — PowerShell GUI

> Script PowerShell avec interface graphique pour optimiser l'input souris sous Windows.  
> Conçu pour le gaming compétitif / supprime toute latence et interférence logicielle.

**Mouse Optimization** applique un ensemble de tweaks registre ciblés pour obtenir un mouvement souris **brut, linéaire et instantané**.  
L'interface permet de sélectionner, appliquer ou annuler chaque catégorie de tweaks en un clic, avec sauvegarde automatique avant toute modification.

---

## Preview
![Proceed Optimization](https://imgur.com/w2ZweoV.png)

<details>
  <summary>Click to show more screenshots</summary>

**Revert Optimization** — backup selection and restore

![Revert Optimization](https://imgur.com/GpLiM9G.png)

**Show Service List** — live status of all tracked services

![Show Service List](https://imgur.com/KYVltbi.png)

**Result** — a lightweight Windows without too much effort

![Task Manager result](https://imgur.com/lEdrvYW.png)

</details>

## Support
**If you need any help or have questions**, feel free to join the **[Discord support server](https://discord.gg/insovs)** — I'll be happy to assist you.

## Installation & Launch
Head to the **[Releases](https://github.com/insovs/insopti-ServiceOptimization/releases)** section and download `ServiceOptimization.ps1`, then **right-click** it → **"Run with PowerShell"**.  
The script will automatically request administrator privileges and open a dark GUI.

## Fonctionnalités

- Suppression complète de l'accélération (logicielle + matérielle)
- Mouvement 1:1 parfaitement linéaire (courbes X/Y plates)
- Réduction des délais driver : `mouclass.sys` priorité kernel 31, transmit timeout 0
- Optimization du buffer data queue Size.
- Optimisation USB (suspension sélective désactivée)
- Désactivation du magnétisme curseur et des auto-focus
- Suppression des effets visuels parasites du curseurs (ombres, trainées)
- Backup `.reg` automatique avant chaque modification
- Revert en un clic via le backup sélectionné

---

## Tweaks inclus

| Catégorie | Effet principal |
|---|---|
| Main Registry Tweaks | Accel off, hover 0ms, double-clic 200ms, etc |
| CursorUpdateInterval | Taux de mise à jour curseur maximal |
| HID Pointer Mode | Pointeur absolu/relatif sans conversion parasite |
| Class Transmit Timeout | Envoi immédiat des événements input |
| Class Thread Priority | Priorité kernel realtime pour `mouclass.sys` |
| Data Queue Size | envoie des informations plus rapide|

---

## Utilisation

> **Requiert les droits Administrateur** (auto-élévation intégrée).
```powershell
.\MouseOptimization.ps1
```

1. Sélectionner une catégorie dans le menu latéral
2. Cocher / décocher les tweaks à appliquer
3. Cliquer **Apply**
4. Redémarrer pour valider tous les changements

Pour annuler : **Revert Optimization** → sélectionner un backup → **Restore**

---

## Notes

- Un backup `.reg` est créé automatiquement dans `MouseOptimizer_Backups/` avant chaque application.
- Tester ces catégories indépendamment en cas d'instabilité.
- `CursorUpdateInterval = 0` = latence max. Augmenter si instabilité.
- `MouseDataQueueSize` : ne pas descendre en dessous de 16.
- Redémarrage recommandé après application d'un tweaks.

> [!CAUTION]
> If you are not allowed to run **PowerShell scripts**, *enable* it first:
> ```
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```
> or refer to [EnablePowerShellScript](https://github.com/insovs/EnablePowerShellScript).


*Pour toute question : [Discord](https://discord.com/invite/fayeECjdtb)*

---

<p align="center">
  <sub>©insopti — <a href="https://guns.lol/inso.vs">guns.lol/inso.vs</a> | For personal use only.</sub>
</p>

