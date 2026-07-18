#include <stdio.h>
#include <stdlib.h>
#include "equipement.h"

/*
 * afficher_menu() :
 * Affiche le menu principal du programme C
 */
void afficher_menu() {
    printf("\n================================================\n");
    printf("       GESTION INVENTAIRE INFORMATIQUE\n");
    printf("         Institut Confucius — UCAD\n");
    printf("           Auteur : Abdou Rahim\n");
    printf("================================================\n");
    printf("  1. Ajouter un equipement\n");
    printf("  2. Modifier un equipement\n");
    printf("  3. Supprimer un equipement\n");
    printf("  4. Rechercher un equipement\n");
    printf("  5. Afficher tous les equipements\n");
    printf("  6. Sauvegarder les donnees\n");
    printf("  0. Quitter\n");
    printf("================================================\n");
    printf("  Votre choix : ");
}

/*
 * main() :
 * Point d'entrée du programme
 * Charge les données puis affiche le menu en boucle
 */
int main() {
    int choix;

    printf("\nChargement de l'inventaire...\n");
    charger_equipements();

    while (1) {
        afficher_menu();

        /* Lire le choix et gérer les entrées invalides */
        if (scanf("%d", &choix) != 1) {
            printf("Entree invalide.\n");
            while (getchar() != '\n'); /* Vider le buffer */
            continue;
        }

        switch (choix) {
            case 1: ajouter_equipement();    break;
            case 2: modifier_equipement();   break;
            case 3: supprimer_equipement();  break;
            case 4: rechercher_equipement(); break;
            case 5: afficher_equipements();  break;
            case 6: sauvegarder_equipements(); break;
            case 0:
                printf("Au revoir !\n");
                exit(0);
            default:
                printf("Choix invalide.\n");
        }
    }
    return 0;
}