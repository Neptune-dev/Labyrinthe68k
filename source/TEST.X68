*-----------------------------------------------------------
* Title      : TEST
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description: fichier de test
*-----------------------------------------------------------
    ORG $1000
START

    MOVE.l  #12288,D3       ; nombre d'octets dans une texture pour 3 cases de 32x32
    JSR     LOAD_TILESHEET

    MOVE.b  #17,D1          ; preparation du dessin
    JSR     DRAW_MODE

    MOVE.l  #$00FFFFFF,D6
    JSR     RENDER_MAZE

    MOVE.l  #$00FF0000,D6
    JSR     RENDER_MAZE

    MOVE.l  #$0000FF00,D6
    JSR     RENDER_MAZE

    MOVE.l  #$000000FF,D6
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
    BRA     ELSE_INPUT  ; else

Z_INPUT:
    MOVE.l  #$00000000,D6
    BRA     CONTINUE
Q_INPUT:
    MOVE.l  #$00FF0000,D6
    BRA     CONTINUE
S_INPUT:
    MOVE.l  #$0000FF00,D6
    BRA     CONTINUE
D_INPUT:
    MOVE.l  #$000000FF,D6
    BRA     CONTINUE
ELSE_INPUT:
    MOVE.l  #$00000000,D6

CONTINUE:
    JSR     RENDER_MAZE
    JMP     MAIN        ; boucle

    JMP FINPRG

    INCLUDE 'DATASPACE.X68'
    INCLUDE 'RENDERER.X68'
    
    INCLUDE 'includes/BIBLIO.X68'
    INCLUDE 'includes/BIBGRAPH.X68'
    INCLUDE 'includes/BIBFICH.X68'
    INCLUDE 'includes/BIBPERIPH.X68'

    PLAYER:     DS.b 4
    MAZE:       DS.w 6561
    TILESHEET:  DS.l 3072
    TILEREF:    DC.l 'debug.tilesheet'
    SEED:       DS.l 1

    END START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~