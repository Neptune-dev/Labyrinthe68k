*-----------------------------------------------------------
* Title      : DATASPACE
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description:
*-----------------------------------------------------------

GETCELL:
    MULU    D3,D5   ; y*t -> D5
    ADD.w   D5,D4   ; (yt + x) -> D4
    ADD.l   #MAZE,D4 ; adresse réelle -> D4
    MOVEA.l D4,A0   ; D4 -> A0
    MOVE    (A0),D5 ; D5 -> return
    RTS

SETCELL:
    MULU    D3,D5   ; y*t -> D5
    ADD.w   D5,D4   ; (yt + x) -> D4
    ADD.l   #MAZE,D4 ; adresse réelle -> D4
    MOVE.l  A0,D5   ; n -> D5
    MOVEA.l  D4,A0  ; adresse réelle -> A0
    MOVE    D5,(A0)
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

