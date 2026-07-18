#include <stdio.h>
#include <string.h>
#include <time.h>
#include "equipement.h"

/*
 * Tableau global qui stocke tous les équipements
 * et le compteur du nombre d'équipements
 */
Equipement equipements[MAX_EQUIPEMENTS];
int nb_equipements = 0;

/*
 * charger_equipements() :
 * Lit le fichier data/equipements.txt
 * et charge les données en mémoire
 */
void charger_equipements() {
    FILE *f = fopen(FICHIER_DATA, "r");
    if (!f) return; /* Fichier vide ou inexistant, pas d'erreur */

    nb_equipements = 0;
    while (fscanf(f, "%d|%49[^|]|%19[^|]|%19[^|]|%49[^|]|%19[^\n]\n",
        &equipements[nb_equipements].id,
        equipements[nb_equipements].nom,
        equipements[nb_equipements].ip,
        equipements[nb_equipements].mac,
        equipements[nb_equipements].localisation,
        equipements[nb_equipements].date_ajout) == 6) {
        nb_equipements++;
    }
    fclose(f);
    printf("%d equipement(s) charge(s).\n", nb_equipements);
}

/*
 * sauvegarder_equipements() :
 * Écrit tous les équipements dans le fichier
 * Format : id|nom|ip|mac|localisation|date
 */
void sauvegarder_equipements() {
    FILE *f = fopen(FICHIER_DATA, "w");
    if (!f) {
        printf("Erreur : impossible d'ouvrir le fichier.\n");
        return;
    }
    int i;
    for (i = 0; i < nb_equipements; i++) {
        fprintf(f, "%d|%s|%s|%s|%s|%s\n",
            equipements[i].id,
            equipements[i].nom,
            equipements[i].ip,
            equipements[i].mac,
            equipements[i].localisation,
            equipements[i].date_ajout);
    }
    fclose(f);
    printf("Donnees sauvegardees dans '%s'.\n", FICHIER_DATA);
}

/*
 * ajouter_equipement() :
 * Demande les infos à l'utilisateur
 * et ajoute un équipement dans le tableau
 */
void ajouter_equipement() {
    if (nb_equipements >= MAX_EQUIPEMENTS) {
        printf("Inventaire plein.\n");
        return;
    }

    Equipement e;
    time_t t = time(NULL);
    struct tm *tm_info = localtime(&t);

    /* ID automatique */
    e.id = nb_equipements + 1;

    /* Saisie des informations */
    printf("Nom de l'equipement : ");
    scanf(" %49[^\n]", e.nom);

    printf("Adresse IP : ");
    scanf(" %19s", e.ip);

    printf("Adresse MAC : ");
    scanf(" %19s", e.mac);

    printf("Localisation : ");
    scanf(" %49[^\n]", e.localisation);

    /* Date automatique */
    strftime(e.date_ajout, 20, "%Y-%m-%d", tm_info);

    /* Ajouter dans le tableau */
    equipements[nb_equipements++] = e;

    /* Sauvegarder immédiatement */
    sauvegarder_equipements();
    printf("Equipement ajoute avec ID %d.\n", e.id);
}

/*
 * afficher_equipements() :
 * Affiche tous les équipements sous forme de tableau
 */
void afficher_equipements() {
    if (nb_equipements == 0) {
        printf("Aucun equipement dans l'inventaire.\n");
        return;
    }
    int i;
    printf("\n%-4s %-20s %-15s %-18s %-15s %-12s\n",
        "ID", "Nom", "IP", "MAC", "Localisation", "Date");
    printf("%-4s %-20s %-15s %-18s %-15s %-12s\n",
        "----","--------------------",
        "---------------","------------------",
        "---------------","------------");
    for (i = 0; i < nb_equipements; i++) {
        printf("%-4d %-20s %-15s %-18s %-15s %-12s\n",
            equipements[i].id,
            equipements[i].nom,
            equipements[i].ip,
            equipements[i].mac,
            equipements[i].localisation,
            equipements[i].date_ajout);
    }
    printf("\nTotal : %d equipement(s).\n", nb_equipements);
}

/*
 * rechercher_equipement() :
 * Cherche par nom, IP ou MAC
 */
void rechercher_equipement() {
    char recherche[50];
    printf("Rechercher (nom, IP ou MAC) : ");
    scanf(" %49s", recherche);

    int i, trouve = 0;
    for (i = 0; i < nb_equipements; i++) {
        if (strstr(equipements[i].nom, recherche) ||
            strstr(equipements[i].ip, recherche) ||
            strstr(equipements[i].mac, recherche)) {
            printf("Trouve : ID=%-3d | Nom=%-20s | IP=%-15s | MAC=%s\n",
                equipements[i].id,
                equipements[i].nom,
                equipements[i].ip,
                equipements[i].mac);
            trouve = 1;
        }
    }
    if (!trouve) printf("Aucun resultat pour '%s'.\n", recherche);
}

/*
 * modifier_equipement() :
 * Modifie un équipement existant par son ID
 */
void modifier_equipement() {
    int id;
    printf("ID de l'equipement a modifier : ");
    scanf("%d", &id);

    int i;
    for (i = 0; i < nb_equipements; i++) {
        if (equipements[i].id == id) {
            printf("Nouveau nom [%s] : ", equipements[i].nom);
            scanf(" %49[^\n]", equipements[i].nom);
            printf("Nouvelle IP [%s] : ", equipements[i].ip);
            scanf(" %19s", equipements[i].ip);
            printf("Nouvelle MAC [%s] : ", equipements[i].mac);
            scanf(" %19s", equipements[i].mac);
            printf("Nouvelle localisation [%s] : ", equipements[i].localisation);
            scanf(" %49[^\n]", equipements[i].localisation);
            sauvegarder_equipements();
            printf("Equipement ID %d modifie.\n", id);
            return;
        }
    }
    printf("ID %d introuvable.\n", id);
}

/*
 * supprimer_equipement() :
 * Supprime un équipement par son ID
 * Décale les équipements suivants pour combler le trou
 */
void supprimer_equipement() {
    int id;
    printf("ID de l'equipement a supprimer : ");
    scanf("%d", &id);

    int i, j, trouve = 0;
    for (i = 0; i < nb_equipements; i++) {
        if (equipements[i].id == id) {
            printf("Supprimer '%s' ? (o/n) : ", equipements[i].nom);
            char conf;
            scanf(" %c", &conf);
            if (conf == 'o') {
                /* Décaler tous les éléments suivants */
                for (j = i; j < nb_equipements - 1; j++) {
                    equipements[j] = equipements[j + 1];
                }
                nb_equipements--;
                sauvegarder_equipements();
                printf("Equipement supprime.\n");
            }
            trouve = 1;
            break;
        }
    }
    if (!trouve) printf("ID %d introuvable.\n", id);
}