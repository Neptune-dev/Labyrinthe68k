## Conditions initiales

- Chaque case contient une valeur ajoutée via un incrément.

On modélise le labyrinthe de la façon suivante :

- Le labyrinthe est un carré donc TAILLE_TOTAL=TAILLE*TAILLE (avec TAILLE le nombre de cases d'une ligne, impair obligatoirement)
- Une case "valeur" est une case du labyrinthe avec les conditions suivantes :
    - pour tout `(x, y)` d'une case valeur, `x % 2 == 1` ET `y % 2 == 1`.
    - une case "valeur" ne sera jamais égale à 0 ou à 1.
- Une case "valeur" est entourée de murs. Les murs à casser ont pour coordonnées:
    - `(x,y)` avec `x % 2 = 0` ET `y % 2 = 1` -> les cases valeurs sont à gauche et à droite du mur
    - `(x,y)` avec `x % 2 = 1` ET `y % 2 = 0` -> les cases valeurs sont en haut et en bas du mur
    - Condition: ∀ x,y∈{1,2,…,TAILLE−1} -> x,y ne peuvent pas être des cases au bord

```

L'initialisation du labyrinthe ressemblerait donc à ceci pour une taille = 9:
y x 0 1 2 3 4 5 6 7 8
0   # # # # # # # # #
1   # 2 # 6 #10 #14 #
2   # # # # # # # # #
3   # 3 # 7 #11 #15 #
4   # # # # # # # # #
5   # 4 # 8 #12 #16 #
6   # # # # # # # # #
7   # 5 # 9 #13 #17 #
8   # # # # # # # # #

```

Les subroutines prérequises pour le bon fonctionnement de l'algo de génération du labyrinthe:

**INITMAZE**:
-> initialise le contenu de MAZE.

**LABYFAIT**: paramètre: TAILLE dans D0 -> output: D4
-> renverra true ou false en fonction de si toutes les cases "valeur" du tableau sont à la meme valeur.

**PROPAGERVALEUR(ancienne,nouvelle)**:  ancienne: D1, nouvelle: D2
-> propage la valeur *nouvelle* partout où les valeurs *ancienne* sont présentes.

**GETCELL(x,y)**: TAILLE: D3, x: D4, y: D5 -> output: D5
-> renvoie la valeur de la cellule à la position (x,y)

**SETCELL(x,y,n)**: TAILLE: D3, x: D4, y: D5, n: A0
-> met à la position x,y la valeur n.

**TAILLE**: Constante qui contient le nombre de cases sur une ligne du labyrinthe
**TAILLE_TOTAL**: Constante qui contient le nombre de lignes totales du labyrinthe.


## Algorithme de fusion aléatoire de chemins (brouillon)
```

tant que !LABYFAIT FAIRE
    x_mur = valeur aléatoire (paire ou impaire)
    y_mur = valeur aléatoire (de parité opposée à x_mur)
    si x_mur pair et y_mur impair faire //les valeurs sont en haut et en bas
        VALEURDROITE=GETCELL(x_mur+1,y_mur)
        VALEURGAUCHE=GETCELL(x_mur-1,y_mur)
        si VALEURDROITE != VALEURGAUCHE faire
            SETCELL(x_mur,y_mur,0)
            PROPAGERVALEUR(VALEURGAUCHE,VALEURDROITE)
        finsi
    finsi
    si x_mur impair et y_mur pair faire //les valeurs sont à gauche et à droite
        VALEURHAUT=GETCELL(x_mur,y_mur-1)
        VALEURBAS=GETCELL(x_mur,y_mur+1)
        si VALEURHAUT != VALEURBAS faire
            SETCELL(x_mur,y_mur,0)
            PROPAGERVALEUR(VALEURHAUT,VALEURBAS)
        finsi
    finsi
fintq

```
