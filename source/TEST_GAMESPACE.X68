*-----------------------------------------------------------
* Title      : TEST
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description: fichier de test
*-----------------------------------------------------------
    ORG $1000
START:

    JSR INIT_MAZE
    JSR INIT_MAZE_LOOP
	MOVE.W	TAILLE,D3
    JSR INIT_LOOP
	
    JSR FINPRG
    INCLUDE 'GAMESPACE.X68'
    INCLUDE 'DATASPACE.X68'
    INCLUDE 'BIBLIO.X68'
    MAZE: DS.w 6561
    SEED: DS.l 1
    TAILLE: DC.W 8
    END START


    



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
