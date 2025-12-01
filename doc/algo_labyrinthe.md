## Conditions initiales

- Chaque case contient une valeur ajoutée via un incrément.

On modélise le labyrinthe de la façon suivante :

- Une case "valeur" est une case du labyrinthe avec les conditions suivantes :
    - pour tout `(x, y)` d'une case valeur, `x % 2 == 0` ET `y % 2 == 0`.
    - une case "valeur" ne sera jamais égale à 0 ou à 1.
- Une case "valeur" est entourée de murs. Les murs dans les diagonales entre chaque case "valeur" ne seront jamais modifiés — on dira qu'ils sont "intouchables".
- Une case "intouchable" se définit donc ainsi :
    - pour tout `(x, y)` d'une case intouchable, `x % 2 == 1` ET `y % 2 == 1`.
    - de plus, une case du bord du tableau est également une case intouchable.
- Le reste des cases seront donc des cases de murs qui peuvent être vouées à se casser au fil de l'algorithme.

Posons en préambule les fonctions suivantes:

**labyFait**: bool -> renverra true ou false en fonction de si toutes les cases "valeur" du tableau sont à la meme valeur.

**propagerValeur(ancienne,nouvelle)**: void -> propage la valeur *nouvelle* partout où les valeurs *ancienne* sont présentes.

**get_cell(x,y)**: int -> renvoie la valeur de la cellule à la position (x,y)

**set_cell(x,y,val)**: void -> met à la position x,y la valeur val.

ainsi que la constante **taille** qui contient le nombre de cases valeurs du labyrinthe (carré).
## Algorithme pseudo-68000
```
    LABEL MUR_RANDOM:
        xmur <- valeur aléatoire comprise entre 1 et taille*2
        SI get_cell(xmur,ymur) == 1 faire //si c'est bien un mur plein
            SI xmur%2 != 1 ET ymur%2 != 1 //si les deux sont vrais: mur intouchable
                si (xmur != taille*2 +1) ET (ymur != taille*2+1)faire // les bords sont intouchables aussi
                BRA BOUCLE_CONSTRUCTION
            FINSI
        FINSI
        BRA MUR_RANDOM
    FIN LABEL MUR_RANDOM

-------------- Implémentation théorique en 68000 du script ci-dessus -------------
    MUR_RANDOM:
        
        JSR RANDOMVAL
        MOVE.W (A2),XMUR
        JSR RANDOMVAL
        MOVE.W (A2),YMUR :A2 utilisable à partir d'ici
        MOVE.W XMUR,D4 : preparation du getcell
        MOVE.W YMUR,D5
        JSR GETCELL
        CMP.W (A0),#1 : A0 utilisable à partir d'ici
        BEQ SI_MUR_RANDOM1
        BRA MUR_RANDOM

    SI_MUR_RANDOM1:
        MOVE.W xmur,(D6) : copie dans A3/A4 pour division
        MOVE.W ymur,(D7)
        DIVU (D6),#2 : division pour modulo 2
        DIVU (D7),#2
        SWAP D6 : reste dans les 16 bits de poids fort: swap nécéssaire
        SWAP D7
        CMP.W   #1,D6
        BNE ET_MUR_RANDOM1
        BRA MUR_RANDOM

    ET_MUR_RANDOM1:
        CMP.W   #1,D7
        BNE MUR_RANDOM_SUITE
        BRA MUR_RANDOM

    MUR_RANDOM_SUITE:
        CMP.W D7,TAILLE : ATTENTION: VARIABLE TAILLE NON STOCKEE DANS UN REGISTRE, A VOIR OU ON LA STOCKE
        BNE ET_MUR_RANDOM_SUITE1
        BRA MUR_RANDOM

    ET_MUR_RANDOM_SUITE1:
        CMP.W D6,TAILLE
        BNE BOUCLE_CONSTRUCTION
        BRA MUR_RANDOM
        RTS

    


---------------- fin ---------------------






















    LABEL BOUCLE_CONSTRUCTION:

    si get_cell(xmur,ymur+1)=1 ET get_cell(xmur,ymur-1)=1 faire //si il y a des murs en haut et en bas du mur choisi (rappel: aucun mur choisi aléatoirement ne peut etre compris entre 4 murs)
        si get_cell(xmur-1,ymur) != get_cell(xmur+1,ymur) faire //si les cases sont pas déjà identiques
            propagerValeur(get_cell(xmur-1,ymur),get_cell(xmur+1,ymur)) //propagation de la valeur de gauche
            set_cell(xmur,ymur,0) //ouverture du mure
        finsi
    sinon si get_cell(xmur+1,ymur)=1 ET get_cell(xmur-1,ymur)=1 faire
        si get_cell(xmur,ymur-1) != get_cell(xmur,ymur+1) faire
            propagerValeur(get_cell(xmur,ymur-1),get_cell(xmur,ymur+1)) //propagation de la valeur du haut
            set_cell(xmur,ymur,0) //ouverture du mur
        finsi
    finsi
    FIN LABEL BOUCLE_CONSTRUCTION
```

