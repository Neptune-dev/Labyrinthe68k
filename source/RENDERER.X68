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
    MOVE.w  #638,D5           ; x1 = 638 | dans D5 car la couleur aussi a besoin de D1
    MOVE.w  #640,D3           ; x2 = 640 | ce registre ne va pas changer d'usage
R_MAZE_FOR_X:
    MOVE.w  #478,D2           ; y1 = 478 | ce registre ne va pas changer d'usage
    MOVE.w  #480,D4           ; y2 = 480 | ce registre ne va pas changer d'usage
R_MAZE_FOR_Y:
    MOVE.l  #$00FFFFFF,D1   ; couleur du pixel upscalé

    MOVE    #80,D0
    TRAP    #15             ; on donne la bonne couleur au crayon

    MOVE    #81,D0
    TRAP    #15             ; couleur de remplissage

    MOVE.w  D5,D1           ; préparation des coordonées (x)

    MOVE    #87,D0
    TRAP    #15             ; dessin du rectangle

    SUBQ.w  #2,D2           ; y1 = y1-2
    SUBQ.w  #2,D4           ; y2 = y2-2
    BGT     R_MAZE_FOR_Y    ; condition de boucle for (y > 0)

    SUBQ.w  #2,D5           ; x1 = x1-2
    SUBQ.w  #2,D3           ; x2 = x2-2
    BGT     R_MAZE_FOR_X    ; condition de boucle for (x > 0)
    RTS

RENDER_PLAYER:

    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

