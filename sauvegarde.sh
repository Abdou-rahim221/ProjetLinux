#!/bin/bash

# ================================================
# SCRIPT DE SAUVEGARDE AUTOMATIQUE
# Auteur : Abdou Rahim
# ================================================

# Le répertoire à sauvegarder (passé en argument, sinon ProjetLinux par défaut)
REPERTOIRE=${1:-~/ProjetLinux}

# La date et heure actuelles pour nommer le fichier
DATE=$(date +%F_%H-%M-%S)

# Le dossier où stocker les sauvegardes
BACKUP_DIR=~/ProjetLinux/backup

# Le nom complet du fichier de sauvegarde
FICHIER="$BACKUP_DIR/sauvegarde_$DATE.tar.gz"

# Créer le dossier backup s'il n'existe pas
mkdir -p "$BACKUP_DIR"

echo "Sauvegarde de '$REPERTOIRE' en cours..."

# Créer l'archive compressée
tar -czf "$FICHIER" "$REPERTOIRE" 2>/dev/null

# Vérifier si la sauvegarde a réussi
if [ $? -eq 0 ]; then
    echo "Sauvegarde créée : $FICHIER"
    echo "Taille : $(du -sh $FICHIER | cut -f1)"
else
    echo "Erreur lors de la sauvegarde."
    exit 1
fi