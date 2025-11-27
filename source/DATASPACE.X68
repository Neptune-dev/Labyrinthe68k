*-----------------------------------------------------------
* Title      : DATASPACE
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

    TO1D:
        MULU.l  D3,D5   ; y*t -> D5
        ADD.l   D5,D4   ; (yt + x) -> D4
        MOVE.l  D4,D3   ; D4 -> D3
        DIVU    #8,D3   ; (yt + x)/8 -> D3


        RTS

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

xxxx yyyy tttttttt
0000 0000 11111111