*-----------------------------------------------------------
* Title      : TEST
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description: fichier de test
*-----------------------------------------------------------
    ORG $1000
START

    MOVE.l  #8192,D2    ;nombre d'octets dans une texture pour 2 cases
    JSR     LOAD_TILESHEET

    JMP FINPRG

    INCLUDE 'DATASPACE.X68'
    INCLUDE 'RENDERER.X68'
    
    INCLUDE 'includes/BIBLIO.X68'
    INCLUDE 'includes/BIBGRAPH.X68'
    INCLUDE 'includes/BIBFICH.X68'

    PLAYER:     DS.b 4
    MAZE:       DS.w 6561
    TILESHEET:  DS.l 2048
    TILEREF:    DC.l 'debug.tilesheet'
    SEED:       DS.l 1

    END START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~