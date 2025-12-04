# Labyrinthe68k - Documentation

## Variables
Ici sont listées les variables. Sont spécifiés:
* La taille de la variable
* Son utilisation

___

* **MAZE** :
    * tableau de 6 561 mots (=13 322o)
    * représente l'architecture du labyrinthe
        * les 1 sont les murs
        * les 0 sont les chemins ouverts
        * les autres valeurs sont les indices de cases
        * chaque case fait 16 bits

* **TILESHEET** :
    * tableau de 2048 mots longs (=8192o)
    * stocke la tilesheet pour *RENDERER.X68*
    * les tiles font par défaut 32px de large et 32px de long
    * chaque pixel est codé sur 32 bits
    * le format de couleur est `$00BBGGRR`
    * les tiles sont empilées en colonne
    * > pour le moment il n'y a que 2 tiles : mur et sans mur = 

* **TILEREF** :
    * chaine de caractère contenant le nom du fichier de tilesheet utilisé

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

* **CLEAR_TILESHEET** : *RENDERER.X68*
    * met à 0 toute la **TILESHEET**
    * ❌ A1 : travail
    * ❌ D2 : travail

* **LOAD_TILESHEET** : *RENDERER.X68*
    * met à 0 toute la **TILESHEET**
    * charge dans **TILESHEET** le fichier **TILEREF**
    * ❌ D2.l : taille attendue de la tilesheet (en octets)


## Registres

| Registre | Libre | Utilisation | Procédures |
|---|---|---|---|
| D0 | ❌ | Appels systèmes |  |
| D1 | ❌ | Appels systèmes |  |
| D2 | ⚠️ | Appels systèmes pour l'affichage | CLEAR_TILESHEET |
| D3 | ⚠️ |  | GETCELL, SETCELL |
| D4 | ⚠️ |  | GETCELL, SETCELL, RANDOMVAL |
| D5 | ⚠️ |  | GETCELL, SETCELL |
| D6 | ✅ |  |
| D7 | ✅ |  |
| A0 | ⚠️ |  | GETCELL, SETCELL |
| A1 | ⚠️ |  | LOAD_TILESHEET, CLEAR_TILESHEET |
| A2 | ⚠️ |  | RANDOMVAL |
| A3 | ✅ |  |  |
| A4 | ✅ |  |  |
| A5 | ✅ |  |  |
| A6 | ✅ |  |  |
| A7 | ✅ |  |  |
