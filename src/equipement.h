#ifndef EQUIPEMENT_H
#define EQUIPEMENT_H

/* Nombre maximum d'équipements dans l'inventaire */
#define MAX_EQUIPEMENTS 100

/* Chemin du fichier de données */
#define FICHIER_DATA "data/equipements.txt"

/*
 * Structure Equipement :
 * Représente un équipement informatique
 * avec toutes ses caractéristiques
 */
typedef struct {
    int  id;               /* Identifiant unique */
    char nom[50];          /* Nom de l'équipement */
    char ip[20];           /* Adresse IP */
    char mac[20];          /* Adresse MAC */
    char localisation[50]; /* Lieu physique */
    char date_ajout[20];   /* Date d'ajout */
} Equipement;

/* Déclaration de toutes les fonctions */
void charger_equipements();
void sauvegarder_equipements();
void ajouter_equipement();
void modifier_equipement();
void supprimer_equipement();
void rechercher_equipement();
void afficher_equipements();

#endif