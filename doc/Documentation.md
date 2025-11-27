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

* **COUCOU** : *RENDERER.X68*
    * écrit coucou sur la sortie standart

## Registres

| Registre | Libre | Utilisation |
|---|---|---|
| D0 | ❌ | Appels systèmes très fréquents |
| D1 | ❌ | Appels systèmes très fréquents |
| D2 | ❌ | Appels systèmes pour l'affichage |
| D3 | ⚠️ | GETMAZE, SETCELL |
| D4 | ⚠️ | GETMAZE, SETCELL |
| D5 | ⚠️ | GETMAZE, SETCELL |
| D6 | ✅ |  |
| D7 | ✅ |  |
| A0 | ⚠️ | GETMAZE, SETCELL |
| A1 | ⚠️ | Ouverture de fichiers |
| A2 | ✅ |  |
| A3 | ✅ |  |
| A4 | ✅ |  |
| A5 | ✅ |  |
| A6 | ✅ |  |
| A7 | ✅ |  |
