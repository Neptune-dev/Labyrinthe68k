        ORG $1000
START:

        ; --- init labyrinthe  ---
        MOVE.W  TAILLE,D3
        JSR     INIT_MAZE

        MOVE.W  #3,D4       ; X = 3
        MOVE.W  #7,D5       ; Y = 7
        JSR     GETCELL      ; D5 = valeur actuelle

        MOVE.W  #5,D0        ; ancienne valeur
        MOVE.W  #9,D1        ; nouvelle valeur
        LEA     MAZE,A1         ; revenir au début du tableau
        MOVE.W  #TAILLE_TOTAL,D3
        JSR    PROPAGERVALEUR
        
        JSR     FINPRG

        INCLUDE 'DATASPACE.X68'
        INCLUDE 'includes/BIBLIO.X68'
        INCLUDE 'GAMESPACE.X68'


MAZE:    DS.W    6561 ; cases du labyrinthe 
SEED:    DS.L    1 ; seed pour valeur aléatoire
TAILLE:  DC.W    9 ; taille d'une ligne du tableau
TAILLE_TOTAL:	DC.L	TAILLE*TAILLE ; nombre de cases total du labyrinthe

        END START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
