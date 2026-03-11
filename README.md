# Mouse Optimization — PowerShell GUI

> Script PowerShell avec interface graphique pour optimiser l'input souris sous Windows.  
> Conçu pour le gaming compétitif — supprime toute latence et interférence logicielle.

---

## Présentation

**Mouse Optimization** applique un ensemble de tweaks registre ciblés pour obtenir un mouvement souris **brut, linéaire et instantané**.  
L'interface permet de sélectionner, appliquer ou annuler chaque catégorie de tweaks en un clic, avec sauvegarde automatique avant toute modification.

---

## Fonctionnalités

- Suppression complète de l'accélération (logicielle + matérielle)
- Mouvement 1:1 parfaitement linéaire (courbes X/Y plates)
- Désactivation du magnétisme curseur et des auto-focus
- Optimisation USB (suspension sélective désactivée)
- Réduction des délais driver : `mouclass.sys` priorité kernel 31, transmit timeout 0
- Buffer d'entrée bas (MouseDataQueueSize = 16)
- Suppression des effets visuels parasites (ombres, trainées)
- Backup `.reg` automatique avant chaque modification
- Revert en un clic via le backup sélectionné

---

## Tweaks inclus

| Catégorie | Effet principal |
|---|---|
| Main Registry Tweaks | Accel off, hover 0ms, double-clic 200ms, beep off |
| CursorUpdateInterval | Taux de mise à jour curseur maximal |
| HID Pointer Mode | Pointeur absolu/relatif sans conversion parasite |
| Class Transmit Timeout | Envoi immédiat des événements input |
| Class Thread Priority | Priorité kernel 31 pour `mouclass.sys` |
| Data Queue Size | Buffer d'entrée minimal (recommandé : 16) |

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
- Tester chaque catégorie indépendamment en cas d'instabilité.
- `CursorUpdateInterval = 0` = latence max. Augmenter si instabilité.
- `MouseDataQueueSize` : ne pas descendre en dessous de 16.
- Redémarrage recommandé après application.

---

## Source officielle

Télécharger uniquement depuis : **https://github.com/insovs**  
Modification, copie ou redistribution **interdites**.

---

*Pour toute question : [Discord](https://discord.com/invite/fayeECjdtb)*
