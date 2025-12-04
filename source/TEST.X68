*-----------------------------------------------------------
* Title      : TEST
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description: fichier de test
*-----------------------------------------------------------
    ORG $1000
START

    JSR     LOAD_TILESHEET

    JMP FINPRG

    INCLUDE 'DATASPACE.X68'
    INCLUDE 'RENDERER.X68'
    
    INCLUDE 'BIBLIO.X68'
    INCLUDE 'BIBGRAPH.X68'
    INCLUDE 'BIBFICH.X68'

    MAZE:       DS.w 6561
    TILESHEET:  DS.l 2048
    TILEREF:    DC.l 'lab.tilesheet'
    SEED:       DS.l 1

    END START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~