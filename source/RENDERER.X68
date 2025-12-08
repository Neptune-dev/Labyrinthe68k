*-----------------------------------------------------------
* Title      : RENDERER
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description:
*-----------------------------------------------------------

COUCOU:
    MOVE.b  #$43,D1 ; C
    JSR     AFFCAR
    MOVE.b  #$4F,D1 ; O
    JSR     AFFCAR
    MOVE.b  #$55,D1 ; U
    JSR     AFFCAR
    MOVE.b  #$43,D1 ; C
    JSR     AFFCAR
    MOVE.b  #$4F,D1 ; O
    JSR     AFFCAR
    MOVE.b  #$55,D1 ; U
    JSR     AFFCAR
    RTS

CLEAR_TILESHEET:
    MOVEA   #TILESHEET,A1  ; on met l'adresse de la tilesheet dans A1
    CLR.l   D2
FORCLEAR:
    CLR.l   (A1)
    ADDA.l   D2,A1
    ADD.l   #4,D2
    CMP     D3,D2
    BLT     FORCLEAR
    RTS

LOAD_TILESHEET:
    JSR     CLEAR_TILESHEET ; clear
    MOVEA   #TILEREF,A1     ; on met l'adresse de notre fichier dans A1
    JSR     OPEN_FILE       ; on ouvre le fichier
    MOVEA   #TILESHEET,A1   ; on met l'adresse de la tilesheet dans A1
    MOVE    D3,D2           ; spécifiction du nombre d'octet à lire
    JSR     READ_FILE       ; lecture
    JSR     CLOSE_FILE      ; fermeture du fichier
    RTS

RENDER_PIXEL:
    

RENDER_MAZE:
R_MAZE_FORX:
R_MAZE_FORY:
    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

