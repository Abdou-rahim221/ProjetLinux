#!/bin/bash

# ================================================
# SCRIPT D'INSTALLATION DU PROJET
# ================================================

echo "Installation en cours..."

# Mettre à jour les paquets
sudo apt update -y

# Installer les outils nécessaires
sudo apt install -y gcc make gdb at

# Créer les dossiers nécessaires
mkdir -p ~/ProjetLinux/{src,data,backup,docs}

# Créer le fichier de données vide
touch ~/ProjetLinux/data/equipements.txt

# Créer le fichier de log pour cron
sudo touch /var/log/cron-diop.log
sudo chmod 666 /var/log/cron-diop.log

# Rendre les scripts exécutables
chmod +x ~/ProjetLinux/menu.sh
chmod +x ~/ProjetLinux/sauvegarde.sh

echo "Installation terminée !"
echo "Lance le menu avec : bash ~/ProjetLinux/menu.sh"