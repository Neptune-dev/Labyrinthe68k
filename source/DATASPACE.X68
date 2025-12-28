*-----------------------------------------------------------
* Title      : DATASPACE
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description: 
*-----------------------------------------------------------

GETCELL:
    MULU    D3,D5       ; D5 = Y * largeur
    ADD.W   D5,D4       ; D4 = X + Y*largeur
    LSL.W   #1,D4       ; *2 pour que ce soit valide pour un mot
    LEA     MAZE,A0
    ADD.W   D4,A0       ; A0 = &MAZE[Y][X]
    MOVE.W  (A0),D5     ; D5 = valeur
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
