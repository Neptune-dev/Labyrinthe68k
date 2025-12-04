# Labyrinthe68k - Documentation

## Variables
Ici sont listées les variables. Sont spécifiés:
* La taille de la variable
* Son utilisation

___

* **MAZE** :
    * tableau de 6 561o
    * représente l'architecture du labyrinthe
        * les 1 sont les murs
        * les 0 sont les chemins ouverts
        * les autres valeurs sont les indices de cases
        * chaque case fait 16 bits

* **TILESHEET** :
    * tableau de 2048o
    * stocke la tilesheet pour *RENDERER.X68*
    * les tiles font par défaut 32px de large et 32px de long
    * chaque pixel est codé sur 8 bits
    * le format de couleur est `00RRGGBB`
    * les tiles sont empilées en colonne

* **SEED** :
    * entier de 4o
    * représente la seed utilisée pour les valeurs pseudo-aléatoire
    * définie à l'execution grâce à la procédure **SETSEED**

## Procédures

Ici sont listées les procédures. Sont spécifiés:
* Le nom de la procédure
* Le programme dans laquelle est elle définie
* Les registres utilisés, et si leurs valeurs sont écrasées :
    * ✅ = valeur conservée
    * ❌ = valeur écrasée
* optionnel : les registres où se situent les valeurs de retour

___

* **GETCELL** : *DATASPACE.X68*
    * retourne la valeur de **MAZE** à l'adresse (x,y)
    * ✅ D3.w : largeur du labyrinthe
    * ❌ D4.w : x
    * ❌ D5.w : y
    * ❌ A0 : travail
    * **retour** : D5

* **SETCELL** : *DATASPACE.X68*
    * écrit la valeur n à l'adresse (x,y) de **MAZE**
    * ✅ D3.w : largeur du labyrinthe
    * ❌ D4.w : x
    * ❌ D5.w : y
    * ❌ A0.l : n

* **SETSEED** : *DATASPACE.X68*
    * génère la seed en fonction de l'heure et la stocke dans **SEED**
    * ❌ D1.l : travail

* **RANDOMVAL** : *DATASPACE.X68*
    * retourne une valeur aléatoire comprise entre 1 et n
    * ✅ D4 : n
    * **retour** : A2

* **COUCOU** : *RENDERER.X68*
    * écrit coucou sur la sortie standard


## Registres

| Registre | Libre | Utilisation |
|---|---|---|
| D0 | ❌ | Appels systèmes très fréquents |
| D1 | ❌ | Appels systèmes très fréquents |
| D2 | ❌ | Appels systèmes pour l'affichage |
| D3 | ⚠️ | GETCELL, SETCELL |
| D4 | ⚠️ | GETCELL, SETCELL, RANDOMVAL |
| D5 | ⚠️ | GETCELL, SETCELL |
| D6 | ✅ |  |
| D7 | ✅ |  |
| A0 | ⚠️ | GETCELL, SETCELL |
| A1 | ⚠️ | Ouverture de fichiers |
| A2 | ⚠️ | RANDOMVAL |
| A3 | ✅ |  |
| A4 | ✅ |  |
| A5 | ✅ |  |
| A6 | ✅ |  |
| A7 | ✅ |  |
