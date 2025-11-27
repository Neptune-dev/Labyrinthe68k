*-----------------------------------------------------------
* Title      : TEST
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description: fichier de test
*-----------------------------------------------------------
    ORG $1000
START

    JSR COUCOU

    JMP FINPRG

    INCLUDE 'DATASPACE.X68'
    INCLUDE 'RENDERER.X68'
    INCLUDE 'BIBLIO.X68'

    MAZE: DS.w 6561

    END START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~