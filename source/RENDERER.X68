*-----------------------------------------------------------
* Title      : RENDERER
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description:
*-----------------------------------------------------------

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
    MOVE.l  D2,D1
    JSR     SET_PEN_COLOR   ; on donne la bonne couleur au crayon
    MOVE.w  D3,D1           ; préparation des coordonées (x)
    MOVE.w  D4,D2           ; préparation des coordonées (y)
    JSR     DRAW_PIX        ; dessin du pixel
    RTS

RENDER_PIXEL_ALPHA:
    MOVE.l  D2,D5           ; copie de la couleur dans D5
    AND.l   #$00FFFFFF,D2   ; D2.l <- canaux RGB
    AND.l   #$FF000000,D5   ; D5.l <- canal alpha
    CMP.l   #$FF000000,D5   ; verification du canal alpha
    BEQ     ALPHA_JUMP      ; on saute l'étape de dessin si le canal alpha est egale à $FF
    MOVE.l  D2,D1
    JSR     SET_PEN_COLOR   ; on donne la bonne couleur au crayon
    MOVE.w  D3,D1           ; préparation des coordonées (x)
    MOVE.w  D4,D2           ; préparation des coordonées (y)
    JSR     DRAW_PIX        ; dessin du pixel
ALPHA_JUMP:
    RTS

RENDER_MAZE:
    MOVE.w  #0,D3           ; x = 0
R_MAZE_FOR_X:
    MOVE.w  #0,D4           ; y = 0
R_MAZE_FOR_Y:
    MOVE.l  #$00FFFFFF,D2   ; couleur du pixel
    JSR     RENDER_PIXEL    ; rendu du pixel
    ADD.l   #1,D4           ; y++
    CMP.w   #480,D4       ; condition de boucle for
    BLT     R_MAZE_FOR_Y

    ADD.l   #1,D3           ; x++
    CMP.w   #640,D3      ; condition de boucle for
    BLT     R_MAZE_FOR_X
    RTS

RENDER_PLAYER:

    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

