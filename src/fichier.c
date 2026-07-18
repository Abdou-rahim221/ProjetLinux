#include <stdio.h>
#include "fichier.h"

/*
 * copier_fichier() :
 * Copie le contenu d'un fichier source
 * vers un fichier destination, caractère par caractère
 */
void copier_fichier(const char *source, const char *destination) {
    FILE *src = fopen(source, "r");
    if (!src) {
        printf("Erreur : fichier source '%s' introuvable.\n", source);
        return;
    }

    FILE *dst = fopen(destination, "w");
    if (!dst) {
        printf("Erreur : impossible de créer '%s'.\n", destination);
        fclose(src);
        return;
    }

    /* Copier caractère par caractère */
    int c;
    while ((c = fgetc(src)) != EOF) {
        fputc(c, dst);
    }

    fclose(src);
    fclose(dst);
    printf("Fichier copie vers '%s'.\n", destination);
}

/*
 * afficher_fichier() :
 * Lit et affiche le contenu d'un fichier ligne par ligne
 */
void afficher_fichier(const char *chemin) {
    FILE *f = fopen(chemin, "r");
    if (!f) {
        printf("Erreur : fichier '%s' introuvable.\n", chemin);
        return;
    }

    char ligne[256];
    printf("--- Contenu de '%s' ---\n", chemin);
    while (fgets(ligne, sizeof(ligne), f)) {
        printf("%s", ligne);
    }
    fclose(f);
}