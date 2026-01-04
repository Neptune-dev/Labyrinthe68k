*-----------------------------------------------------------
* Title      : MAIN
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2026
* Description: programme principal
*-----------------------------------------------------------
    ORG $1000
START

    ; --- init renderer  ---
    MOVE.l  #12288,D3       ; nombre d'octets dans une texture pour 3 cases de 32x32
    JSR     LOAD_TILESHEET
    ; MOVE.b  #17,D1          ; preparation du dessin
    ; JSR     DRAW_MODE

    ; --- init labyrinthe  ---
    MOVE.l  #LOAD_MSG,A1        ; message de chargement
    MOVE.l  #14,D0
    TRAP    #15
    ; JSR     SWAP_SCREEN
    MOVE.W  TAILLE,D3
    JSR     INIT_MAZE
    ; JSR     ALGO_FUSION
    MOVEA   #MAZE,A0
    MOVE.l  #$691,D0            ; 1681
    JSR     TABLEAU_RENDERING

    MOVE.l  #$00020403,PLAYER    ; position (4;3)

    JSR     RENDER_MAZE          ; 1er rendu

    ; --- boucle principale  ---
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
    JMP     MAIN        ; else

Z_INPUT:
    SUB.l   #$1,PLAYER          ; player.y -= 1  /!\ inversion de l'axe y
    CLR.w   PLAYER              ; player.orientation = 0
    OR.w    #$8,PLAYER          ; player.orientation = 00001000
    JMP     CONTINUE_MAIN
Q_INPUT:
    SUBI.l  #$100,PLAYER        ; player.x -= 1
    CLR.w   PLAYER              ; player.orientation = 0
    OR.w    #$1,PLAYER          ; player.orientation = 00000001
    JMP     CONTINUE_MAIN
S_INPUT:
    ADD.l   #$1,PLAYER          ; player.y += 1  /!\ inversion de l'axe y
    CLR.w   PLAYER              ; player.orientation = 0
    OR.w    #$4,PLAYER          ; player.orientation = 00000100
    JMP     CONTINUE_MAIN
D_INPUT:
    ADD.l   #$100,PLAYER        ; player.x += 1
    CLR.w   PLAYER              ; player.orientation = 0
    OR.w    #$2,PLAYER          ; player.orientation = 00000010

CONTINUE_MAIN:
    JSR     RENDER_MAZE         ; rendu
    JMP     MAIN                ; boucle



    JMP FINPRG

    INCLUDE 'DATASPACE.X68'
    INCLUDE 'GAMESPACE.X68'
    INCLUDE 'RENDERER.X68'
    
    INCLUDE 'includes/BIBLIO.X68'
    INCLUDE 'includes/BIBGRAPH.X68'
    INCLUDE 'includes/BIBFICH.X68'
    INCLUDE 'includes/BIBPERIPH.X68'

    PLAYER:         DS.l 1
    
    X_MUR:	        DC.L 1
    Y_MUR:	        DC.L 1
    VALEURBAS:	    DC.L 1
    VALEURHAUT:	    DC.L 1
    VALEURGAUCHE:	DC.L 1
    VALEURDROITE:	DC.L 1
    TAILLE:         DC.W 19              ; taille d'une ligne du tableau
    TAILLE_TOTAL:	DC.l 361             ; nombre de cases total du labyrinthe
    TAILLE_MAX:	    DC.L 41             ; nombre de cases total du labyrinthe
    TILESHEET:      DS.l 3072
    TILEREF:        DC.l 'lab.tilesheet'
    SEED:           DS.l 1
    LOAD_MSG:       DC.l 'Chargement...',0
    MAZE:           DS.w 1681           ;   3 362 o
    BAKED:          DS.l 1721344        ; 430 336 o

    END START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~