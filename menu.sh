#!/bin/bash

# ================================================
# SYSTÈME D'ADMINISTRATION LINUX AUTOMATISÉ
# Auteur : Abdou Rahim
# Institut Confucius — UCAD 2025-2026
# ================================================

# ---- MENU PRINCIPAL ----
menu_principal() {
    while true; do
        clear
        echo "================================================"
        echo "      SYSTÈME D'ADMINISTRATION LINUX"
        echo "         Institut Confucius — UCAD"
        echo "================================================"
        echo "  1. Gestion des répertoires"
        echo "  2. Gestion des fichiers"
        echo "  3. Gestion des permissions"
        echo "  4. Recherche"
        echo "  5. Surveillance du système"
        echo "  6. Gestion des processus"
        echo "  7. Sauvegarde automatique"
        echo "  8. Planification"
        echo "  0. Quitter"
        echo "================================================"
        read -p "  Votre choix : " choix

        case $choix in
            1) menu_repertoires ;;
            2) menu_fichiers ;;
            3) menu_permissions ;;
            4) menu_recherche ;;
            5) menu_surveillance ;;
            6) menu_processus ;;
            7) menu_sauvegarde ;;
            8) menu_planification ;;
            0) echo "Au revoir !"; exit 0 ;;
            *) echo "Choix invalide !"; sleep 1 ;;
        esac
    done
}

# ---- 1. GESTION DES RÉPERTOIRES ----
menu_repertoires() {
    while true; do
        clear
        echo "=== GESTION DES RÉPERTOIRES ==="
        echo "1. Créer un dossier"
        echo "2. Supprimer un dossier"
        echo "3. Renommer un dossier"
        echo "4. Afficher le contenu"
        echo "0. Retour"
        read -p "Votre choix : " choix
        case $choix in
            1)
                read -p "Chemin du dossier à créer : " nom
                mkdir -p "$nom" && echo "Dossier '$nom' créé." || echo "Erreur."
                ;;
            2)
                read -p "Dossier à supprimer : " nom
                read -p "Confirmer ? (o/n) : " conf
                [ "$conf" = "o" ] && rm -rf "$nom" && echo "Supprimé." || echo "Annulé."
                ;;
            3)
                read -p "Nom actuel : " ancien
                read -p "Nouveau nom : " nouveau
                mv "$ancien" "$nouveau" && echo "Renommé." || echo "Erreur."
                ;;
            4)
                read -p "Chemin du dossier : " chemin
                ls -la "$chemin"
                ;;
            0) return ;;
            *) echo "Choix invalide." ;;
        esac
        read -p "Entrée pour continuer..."
    done
}

# ---- 2. GESTION DES FICHIERS ----
menu_fichiers() {
    while true; do
        clear
        echo "=== GESTION DES FICHIERS ==="
        echo "1. Créer un fichier"
        echo "2. Copier un fichier"
        echo "3. Déplacer un fichier"
        echo "4. Supprimer un fichier"
        echo "5. Rechercher un fichier"
        echo "0. Retour"
        read -p "Votre choix : " choix
        case $choix in
            1)
                read -p "Nom du fichier : " nom
                touch "$nom" && echo "Fichier '$nom' créé." || echo "Erreur."
                ;;
            2)
                read -p "Source : " src
                read -p "Destination : " dst
                cp "$src" "$dst" && echo "Copié." || echo "Erreur."
                ;;
            3)
                read -p "Source : " src
                read -p "Destination : " dst
                mv "$src" "$dst" && echo "Déplacé." || echo "Erreur."
                ;;
            4)
                read -p "Fichier à supprimer : " nom
                read -p "Confirmer ? (o/n) : " conf
                [ "$conf" = "o" ] && rm "$nom" && echo "Supprimé." || echo "Annulé."
                ;;
            5)
                read -p "Nom à rechercher : " nom
                find / -name "*$nom*" 2>/dev/null
                ;;
            0) return ;;
            *) echo "Choix invalide." ;;
        esac
        read -p "Entrée pour continuer..."
    done
}

# ---- 3. GESTION DES PERMISSIONS ----
menu_permissions() {
    while true; do
        clear
        echo "=== GESTION DES PERMISSIONS ==="
        echo "1. Afficher les permissions"
        echo "2. Modifier les permissions (chmod)"
        echo "3. Changer le propriétaire (chown)"
        echo "0. Retour"
        read -p "Votre choix : " choix
        case $choix in
            1)
                read -p "Fichier ou dossier : " cible
                ls -la "$cible"
                ;;
            2)
                read -p "Fichier ou dossier : " cible
                echo "Exemples : 755=rwxr-xr-x  644=rw-r--r--  777=rwxrwxrwx"
                read -p "Permissions (ex: 755) : " perm
                chmod "$perm" "$cible" && echo "Permissions modifiées." || echo "Erreur."
                ;;
            3)
                read -p "Fichier ou dossier : " cible
                read -p "Nouveau propriétaire : " proprio
                sudo chown "$proprio" "$cible" && echo "Propriétaire modifié." || echo "Erreur."
                ;;
            0) return ;;
            *) echo "Choix invalide." ;;
        esac
        read -p "Entrée pour continuer..."
    done
}

# ---- 4. RECHERCHE ----
menu_recherche() {
    while true; do
        clear
        echo "=== RECHERCHE ==="
        echo "1. Rechercher un fichier"
        echo "2. Rechercher un texte dans un fichier"
        echo "3. Rechercher un utilisateur"
        echo "4. Rechercher un processus"
        echo "0. Retour"
        read -p "Votre choix : " choix
        case $choix in
            1)
                read -p "Nom du fichier : " nom
                find / -name "*$nom*" 2>/dev/null
                ;;
            2)
                read -p "Texte à chercher : " texte
                read -p "Dans quel fichier/dossier : " cible
                grep -rn "$texte" "$cible" 2>/dev/null || echo "Aucun résultat."
                ;;
            3)
                read -p "Nom de l'utilisateur : " user
                grep "^$user" /etc/passwd || echo "Utilisateur introuvable."
                ;;
            4)
                read -p "Nom du processus : " proc
                result=$(ps aux | grep "$proc" | grep -v grep)
                [ -n "$result" ] && echo "$result" || echo "Processus introuvable."
                ;;
            0) return ;;
            *) echo "Choix invalide." ;;
        esac
        read -p "Entrée pour continuer..."
    done
}

# ---- 5. SURVEILLANCE DU SYSTÈME ----
menu_surveillance() {
    while true; do
        clear
        echo "=== SURVEILLANCE DU SYSTÈME ==="
        echo "1. Mémoire utilisée"
        echo "2. Espace disque"
        echo "3. Utilisateurs connectés"
        echo "4. Charge processeur"
        echo "0. Retour"
        read -p "Votre choix : " choix
        case $choix in
            1) free -h ;;
            2) df -h ;;
            3) who ;;
            4) top -bn1 | head -15 ;;
            0) return ;;
            *) echo "Choix invalide." ;;
        esac
        read -p "Entrée pour continuer..."
    done
}

# ---- 6. GESTION DES PROCESSUS ----
menu_processus() {
    while true; do
        clear
        echo "=== GESTION DES PROCESSUS ==="
        echo "1. Afficher tous les processus"
        echo "2. Rechercher un processus"
        echo "3. Arrêter un processus (SIGTERM)"
        echo "4. Envoyer un signal"
        echo "0. Retour"
        read -p "Votre choix : " choix
        case $choix in
            1) ps aux | head -20 ;;
            2)
                read -p "Nom du processus : " proc
                ps aux | grep "$proc" | grep -v grep
                ;;
            3)
                read -p "PID du processus : " pid
                kill -SIGTERM "$pid" && echo "SIGTERM envoyé." || echo "Erreur."
                ;;
            4)
                read -p "PID du processus : " pid
                echo "Signaux : SIGTERM(15) SIGKILL(9) SIGSTOP(19) SIGCONT(18)"
                read -p "Signal : " sig
                kill -"$sig" "$pid" && echo "Signal envoyé." || echo "Erreur."
                ;;
            0) return ;;
            *) echo "Choix invalide." ;;
        esac
        read -p "Entrée pour continuer..."
    done
}

# ---- 7. SAUVEGARDE ----
menu_sauvegarde() {
    while true; do
        clear
        echo "=== SAUVEGARDE AUTOMATIQUE ==="
        echo "1. Sauvegarder un répertoire"
        echo "2. Restaurer une sauvegarde"
        echo "3. Lister les sauvegardes"
        echo "0. Retour"
        read -p "Votre choix : " choix
        case $choix in
            1)
                read -p "Répertoire à sauvegarder : " rep
                bash ~/ProjetLinux/sauvegarde.sh "$rep"
                ;;
            2)
                ls ~/ProjetLinux/backup/ 2>/dev/null || echo "Aucune sauvegarde."
                read -p "Fichier .tar.gz à restaurer : " fichier
                read -p "Destination : " dest
                mkdir -p "$dest"
                tar -xzf "$fichier" -C "$dest" && echo "Restauré." || echo "Erreur."
                ;;
            3)
                ls -lh ~/ProjetLinux/backup/ 2>/dev/null || echo "Aucune sauvegarde."
                ;;
            0) return ;;
            *) echo "Choix invalide." ;;
        esac
        read -p "Entrée pour continuer..."
    done
}

# ---- 8. PLANIFICATION ----
menu_planification() {
    while true; do
        clear
        echo "=== PLANIFICATION ==="
        echo "1. Sauvegarde quotidienne avec cron"
        echo "2. Restauration avec at"
        echo "3. Voir les tâches cron"
        echo "4. Voir les tâches at"
        echo "0. Retour"
        read -p "Votre choix : " choix
        case $choix in
            1)
                read -p "Répertoire à sauvegarder : " rep
                (crontab -l 2>/dev/null; echo "0 3 * * * bash ~/ProjetLinux/sauvegarde.sh $rep >> /var/log/cron-diop.log 2>&1") | crontab -
                echo "Sauvegarde quotidienne à 03h00 programmée."
                ;;
            2)
                read -p "Fichier .tar.gz : " fichier
                read -p "Destination : " dest
                echo "tar -xzf $fichier -C $dest" | at now + 1 minute
                echo "Restauration programmée dans 1 minute."
                ;;
            3) crontab -l ;;
            4) atq ;;
            0) return ;;
            *) echo "Choix invalide." ;;
        esac
        read -p "Entrée pour continuer..."
    done
}

# Lancer le menu
menu_principal