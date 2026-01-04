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
    MOVE.W (A0),D5     ; D5 = MAZE[Y][X]
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
    MULU    #75,D0			; D0=D0*3
    ADD.L   #74,D0			; D0=D0*3 +71 (LCG)
    MOVE.L  D0,SEED        ; mettre à jour la seed

    MOVE.L  SEED,D1

    MOVE.W  D4,D2           ; D4 borne supérieure
    SUB.W  #1,D2           ; D2 = D4 - 1
	DIVU D2,D1        ; D1 = SEED mod (borne)
	MOVE.W D1,A2      ; résultat directement

    MOVE.W  D1,A2           ; renvoie la valeur dans A2
    RTS

















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
