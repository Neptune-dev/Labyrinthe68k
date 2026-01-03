        ORG $1000
START:
		
        MOVE.W  TAILLE,D3
        JSR     INIT_MAZE
		JSR		ALGO_FUSION
		JSR FINPRG
		INCLUDE 'DATASPACE.X68'
		INCLUDE 'GAMESPACE.X68'
		INCLUDE 'includes/BIBLIO.X68'


SEED:    DS.L    1 ; seed pour valeur aléatoire
X_MUR:	DC.L	1
Y_MUR:	DC.L	1
VALEURBAS:	DC.L	1
VALEURHAUT:	DC.L	1
VALEURGAUCHE:	DC.L	1
VALEURDROITE:	DC.L	1
TAILLE:  DC.W    32 ; taille d'une ligne du tableau (toutes les cases)
TAILLE_TOTAL:	DC.L	1024  ; nombre de cases total du labyrinthe
MAZE:    DS.W    6561 ; cases du labyrinthe 


	
	END START





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
