# Labyrinthe68k - Documentation


Par convention, on décide que l'écran de jeu fait 640 x 480 px.

___

Répertoires :
* **source/** :
    * le code X68 de l'app
    * les fichiers de texture
    * **/includes/** :
        * les biliotèques données par le professeur
* **tools** :
    * les textures non formatées pour l'app
    * un script python qui formate les images png

* **doc/** :
    * fichiers de conception

<br>

___

# Code X68

## Variables
Ici sont listées les variables. Sont spécifiés:
* La taille de la variable
* Son utilisation

___

* **PLAYER** :
    * entier de 4o
    * représente la postition et l'orientation du joueur dans **MAZE**
        * le 1er octet est vide
        * le 2eme represente l'orientation selon le format `0000NSEW`
        * le 3eme represente x
        * le 4eme represente y

* **MAZE** :
    * tableau de 1681 mots (=3362o)
    * représente l'architecture du labyrinthe
        * les 1 sont les murs
        * les 0 sont les chemins ouverts
        * les autres valeurs sont les indices de cases, uniquement lors de la génération
        * chaque case fait 16 bits (= 2o)
        * la taille maximale du labyrinthe est de 20x20, donc 41x41 cases

* **TILESHEET** :
    * tableau de 3072 mots longs (=12 288o)
    * > pour le moment il n'y a que 3 tiles : mur, sans mur, le joueur = 12 288 octets
    * stocke la tilesheet pour *RENDERER.X68*
    * les tiles font par défaut 32px de large et 32px de long
    * la couleur de chaque pixel est codé sur 32 bits au format `$00BBGGRR`
    * un pixel transparent à son premier octet à `$FF`
    * les tiles sont empilées en colonne

* **TILEREF** :
    * chaine de caractère contenant le nom du fichier de tilesheet utilisé

* **BAKED** :
    * tableau de 1 721 344 mots longs = (430 336 o)
    * chaque case (mot long) représente une couleur au format `$00BBGGRR`
    * les tiles sont mises à la suite les unes des autres

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

* **CLEAR_TILESHEET** : *RENDERER.X68*
    * met à 0 toute la **TILESHEET**
    * ❌ A1 : travail
    * ❌ D2 : travail
    * ✅ D3.l : taille attendue de la tilesheet (en octets)

* **LOAD_TILESHEET** : *RENDERER.X68*
    * met à 0 toute la **TILESHEET**
    * charge dans **TILESHEET** le fichier **TILEREF**
    * ✅ D3.l : taille attendue de la tilesheet (en octets)
    * ❌ D2 : travail
    * ❌ A1 : travail

* **CLEAR_BAKED** : *RENDERER.X68*
    * met à 0 tout **BAKED**
    * ❌ A1 : travail
    * ❌ D2 : travail
    * ❌ D3 : travail

* **BAKE_MAZE** : *RENDERER.X68*
    * charge pour chaque case du labyrinthe la tile correspondante
    * charge dans **BAKED**
    * ❌ D2 : travail
    * ❌ D3 : travail
    * ❌ D4 : travail
    * ❌ D5 : travail
    * ❌ D6 : travail
    * ❌ A1 : travail
    * ❌ A2 : travail
    * ❌ A3 : travail
    * ❌ A4 : travail

* **RENDER_PIXEL** : *RENDERER.X68*
    * dessine un pixel en RGB
    * ❌ D2.l : couleur du pixel au format `$00BBGGRR`
    * ✅ D3.w : coordonnée x du pixel sur l'écran
    * ✅ D4.w : coordonnée y du pixel sur l'écran

* **RENDER_PIXEL_ALPHA** : *RENDERER.X68*
    * dessine un pixel en RGBa
    * ❌ D2.l : couleur du pixel au format `$AABBGGRR` où le canal alpha ne peut être que `$00` ou `$FF`
    * ✅ D3.w : coordonnée x du pixel sur l'écran
    * ✅ D4.w : coordonnée y du pixel sur l'écran
    * ❌ D5 : travail

* **RENDER_MAZE** : *RENDERER.X68*
    * dessine le labyrinthe contenue dans **MAZE**
    * écrase les dessins déjà exitants
    * ❌ D2 : travail
    * ❌ D3 : travail
    * ❌ D4 : travail
    * ❌ D5 : travail
    * ❌ D6 : travail
    * ❌ D7 : travail
    * ❌ A1 : travail
    * ❌ A2 : travail
    * ❌ A3 : travail
    * ❌ A4 : travail
    * ❌ A5 : travail
    * ❌ A6 : travail



## Registres

| Procédure | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | A0 | A1 | A2 | A3 | A4 | A5 | A6 | A7 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| GETCELL               |  |  |  | ✅ | ❌ | ❌ |  |  | ❌ |  |  |  |  |  |  |  |
| SETCELL               |  |  |  | ✅ | ❌ | ❌ |  |  | ❌ |  |  |  |  |  |  |  |
| SETSEED               |  | ❌ |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| RANDOMVAL             |  |  |  |  | ❌ |  |  |  |  |  |  |  |  |  |  |  |
| CLEAR_TILESHEET       |  |  | ❌ | ✅ |  |  |  |  |  | ❌ |  |  |  |  |  |  |
| LOAD_TILESHEET        |  |  | ❌ | ✅ |  |  |  |  |  | ❌ |  |  |  |  |  |  |
| CLEAR_BAKED           |  |  | ❌ | ❌ |  |  |  |  |  | ❌ |  |  |  |  |  |  |
| BAKE_MAZE             |  |  | ❌ | ❌ | ❌ | ❌ | ❌ |  |  | ❌ | ❌ | ❌ | ❌ |  |  |  |
| RENDER_PIXEL          |  |  | ❌ | ✅ | ✅ |  |  |  |  |  |  |  |  |  |  |  |
| RENDER_PIXEL_ALPHA    |  |  | ❌ | ✅ | ✅ | ❌ |  |  |  |  |  |  |  |  |  |  |
| RENDER_MAZE           |  |  | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |  | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |  |
|                       |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |

