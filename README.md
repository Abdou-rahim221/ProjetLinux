# ProjetLinux — Système d'Administration Linux Automatisé

## Auteur
**Abdou Rahim**
Licence 3 — Administration et Sécurité des Réseaux
Institut Confucius — UCAD 2025-2026

## Description
Système complet d'administration Linux automatisé comportant :
- Un menu interactif Bash pour administrer Linux
- Un programme C de gestion d'inventaire informatique

## Structure
ProjetLinux/
├── README.md
├── Makefile
├── menu.sh
├── sauvegarde.sh
├── install.sh
├── src/
│   ├── main.c
│   ├── fichier.c
│   ├── fichier.h
│   ├── equipement.c
│   └── equipement.h
├── data/
│   └── equipements.txt
├── backup/
└── docs/
    └── rapport.pdf

## Installation
bash install.sh

## Utilisation

### Menu Bash
bash menu.sh

### Programme C
make
./inventaire

### Débogage
gdb ./inventaire
(gdb) break main
(gdb) run
(gdb) next
(gdb) quit