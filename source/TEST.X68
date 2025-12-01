*-----------------------------------------------------------
* Title      : TEST
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description: fichier de test
*-----------------------------------------------------------
    ORG $1000
START

    JSR     SETSEED

    JSR     COUCOU

    MOVE.l  #81,D3
    MOVE.l  #10,D4
    MOVE.l  #10,D5
    MOVEA   #7,A0

    JSR     SETCELL

    MOVE.l  #81,D3
    MOVE.l  #10,D4
    MOVE.l  #10,D5
    
    JSR     GETCELL

    JMP FINPRG

    INCLUDE 'DATASPACE.X68'
    INCLUDE 'RENDERER.X68'
    
    INCLUDE 'BIBLIO.X68'
    INCLUDE 'BIBGRAPH.X68'

    MAZE: DS.w 6561
    SEED: DS.l 1

    END START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~