*-----------------------------------------------------------
* Title      : TEST
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description: fichier de test
*-----------------------------------------------------------
    ORG $1000
START

    ; --- init renderer  ---
    MOVE.l  #12288,D3       ; nombre d'octets dans une texture pour 3 cases de 32x32
    JSR     LOAD_TILESHEET
    MOVE.b  #17,D1          ; preparation du dessin
    JSR     DRAW_MODE

    ; --- init labyrinthe  ---
    MOVE.W  TAILLE,D3
    JSR     INIT_MAZE
    JSR     BAKE_MAZE

    MOVE.l  #$00FF0403,PLAYER    ; position (4;3)

    JSR     RENDER_MAZE


MAIN:
    JSR     SAISCAR     ; input

    CMP.b   #$7A,D1     ; z
    BEQ     Z_INPUT
    CMP.b   #$71,D1     ; q
    BEQ     Q_INPUT
    CMP.b   #$73,D1     ; s
    BEQ     S_INPUT
    CMP.b   #$64,D1     ; d
    BEQ     D_INPUT

Z_INPUT:
    MOVEA.l  #$00000000,A5
    BRA     CONTINUE
Q_INPUT:
    MOVEA.l  #$00FF0000,A5
    BRA     CONTINUE
S_INPUT:
    MOVEA.l  #$0000FF00,A5
    BRA     CONTINUE
D_INPUT:
    MOVEA.l  #$000000FF,A5

CONTINUE:
    JSR     RENDER_MAZE
    JMP     MAIN        ; boucle

    JMP FINPRG

    INCLUDE 'DATASPACE.X68'
    INCLUDE 'GAMESPACE.X68'
    INCLUDE 'RENDERER.X68'
    
    INCLUDE 'includes/BIBLIO.X68'
    INCLUDE 'includes/BIBGRAPH.X68'
    INCLUDE 'includes/BIBFICH.X68'
    INCLUDE 'includes/BIBPERIPH.X68'

    PLAYER:     DS.b 4
    MAZE:       DS.w 6561
    BAKED:      DS.l 6718464
    TAILLE:  DC.W    9 ; taille d'une ligne du tableau
    TAILLE_TOTAL:	DC.L	TAILLE*TAILLE ; nombre de cases total du labyrinthe
    TILESHEET:  DS.l 3072
    TILEREF:    DC.l 'debug.tilesheet'
    SEED:       DS.l 1

    END START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~