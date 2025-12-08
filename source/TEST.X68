*-----------------------------------------------------------
* Title      : TEST
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description: fichier de test
*-----------------------------------------------------------
    ORG $1000
START

    MOVE.l  #12288,D3    ; nombre d'octets dans une texture pour 3 cases de 32x32
    JSR     LOAD_TILESHEET

    JSR     RENDER_MAZE

    JMP FINPRG

    INCLUDE 'DATASPACE.X68'
    INCLUDE 'RENDERER.X68'
    
    INCLUDE 'includes/BIBLIO.X68'
    INCLUDE 'includes/BIBGRAPH.X68'
    INCLUDE 'includes/BIBFICH.X68'

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