*-----------------------------------------------------------
* Title      : DATASPACE
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description:
*-----------------------------------------------------------

GETCELL:
    MULU    D3,D5   ; y*t -> D5
    ADD.w   D5,D4   ; (yt + x) -> D4
    ADD.l   #MAZE,D4 ; adresse rÃ©elle -> D4
    MOVEA.l D4,A0   ; D4 -> A0
    MOVE.W    (A0),D5 ; D5 -> return
    RTS

SETCELL:
        MOVE.W D5,D1        ; D1 = y
        MULU   D3,D1        ; D1 = y * largeur
        ADD.W  D4,D1        ; D1 = y*largeur + x
        LSL.W  #1,D1        ; *2 pour mot (décalage de 2 bits)
        LEA    MAZE,A1      ; charge l'adresse de MAZE dans A1
        ADD.W D1,A1        ; A1 = &MAZE[y][x]
        MOVE.W D6,(A1)      ; MAZE[y][x] = D6

        RTS

SETSEED:
    JSR     GET_TIME
    MOVE.L  D1,SEED
    RTS

RANDOMVAL:
    MOVE.L  SEED,D0
    MULU    #25173,D0
    ADD.L   #13849,D0
    MOVE.L  D0,SEED

    MOVE.W  SEED,D1
    DIVU    D4,D1
    SWAP    D1
    MOVE.W  D1,A2
    RTS









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
