*-----------------------------------------------------------
* Title      : RENDERER
* Written by : Felix LADISLAS & Lucas DELCROIX
* Date       : 2025
* Description:
*-----------------------------------------------------------

CLEAR_TILESHEET:
    MOVEA.l #TILESHEET,A1  ; on met l'adresse de la tilesheet dans A1
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
    MOVEA.l #TILEREF,A1     ; on met l'adresse de notre fichier dans A1
    JSR     OPEN_FILE       ; on ouvre le fichier
    MOVEA.L #TILESHEET,A1   ; on met l'adresse de la tilesheet dans A1
    MOVE    D3,D2           ; spécifiction du nombre d'octet à lire
    JSR     READ_FILE       ; lecture
    JSR     CLOSE_FILE      ; fermeture du fichier
    RTS

CLEAR_BAKED:
    MOVEA   #BAKED,A1       ; on met l'adresse du bake dans A1
    MOVE.l  #1721344,D3     ; D3 = 6718464 = taille du bake
FORCLEAR_BAKED:
    CLR.l   (A1)
    ADDA.l  #4,A1
    SUBI.l  #1,D3
    BGT     FORCLEAR_BAKED
    RTS

BAKE_MAZE:
    JSR     CLEAR_BAKED     ; clear
    MOVEA   #MAZE,A1        ; A1 = adresse courante du labyrinthe
    MOVEA   #BAKED,A2       ; A2 = adresse courante du bake
    MOVEA   #TILESHEET,A3   ; A3 = adresse de la tilesheet
    CLR.l   D2
    CLR.l   D6
BAKING:
    MOVE.w  (A1),D2         ; D2 = valeur de la case
    MOVE.w  #$0,D3          ; D3 = 0, compteur dans la tilesheet, on est sur le premier pixel
    MOVE.l  #$1000,D4       ; D4 = 4096o, y-offset, car une tile = 1024 pixels = 4096 octets
    MULU    D2,D4           ; on applique l'offset en fonction de si c'est un mur ou un chemin
    ADD.l   D4,D3           ; D3 = bon premier pixel : on a selectionne la tile
    ADD.l   A3,D3           ; projection dans la tilesheet
    MOVE.l  D3,D4           ; copie
    ADD.l   #$FFC,D4        ; D4 += 4096 - 4 = dernier pixel de la tile
TILING:
    MOVEA   D3,A4           ; A3 = adresse du pixel dans la tile
    MOVE.l  (A4),D5         ; D5 = couleur du pixel
    MOVE.l  D5,(A2)         ; enregistrement du pixel
    ADDA.l  #4,A2           ; decalage dans le bake
    ADD.w   #4,D3           ; D3 += 4o
    CMP     D3,D4
    BLT     TILING          ; boucle si D3 < D4

    ADDA.l  #2,A1           ; decalage dans le labyrinthe
    ADD.l   #1,D6
    CMP     #$691,D6        ; $691 = 1681
    BLT     BAKING          ; on boucle si on a pas fait les 1681 cases du labyrinthe
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
    JSR     SET_PEN_COLOR
    JSR     SET_FILL_COLOR
    MOVEA.l D3,A4           ; sauvegarde x
    MOVEA.l D4,A5           ; sauvegarde y
    MOVE.w  D3,D1           ; préparation des coordonées (x)
    MOVE.w  D4,D2           ; préparation des coordonées (y)
    ADD.w   #2,D3           ; D3 = D1 + 2
    ADD.w   #2,D4           ; D4 = D2 + 2
    JSR     DRAW_FILL_RECT  ; dessin du rectangle
    MOVE.w  A4,D3           ; restore x
    MOVE.w  A5,D4           ; restore y
ALPHA_JUMP:
    RTS

RENDER_PLAYER:
    MOVEA.l     #TILESHEET,A1       ; A1 = &tilesheet
    ADDA.l      #$3000,A1           ; A1 += 12288 = 32*32 * 4o * 3 car on décale de 3 tiles dans la tilesheet
    SUBA.l      #4,A1               ; A1 -= 4 pour etre sur la dernière couleur de la tilesheet
    MOVE.l      #$80,D7             ; D7 = 128 = 32*4 : 128o sur une ligne de pixel 
    MOVE.l      #$FE,D4             ; D4 = 254 = y
FOR_RP_Y:
    MOVE.l      #$13E,D3            ; D3 = 318 = x
    MOVE.l      #$80,D6             ; D6 = 128 = 32*4 : 128o sur une ligne de pixel 
FOR_RP_X:
    MOVE.l      (A1),D2             ; on récupère la couleur
    JSR         RENDER_PIXEL_ALPHA  ; affichage du pixel
    SUBA.l      #4,A1               ; shift de l'adresse dans la tilesheet
    SUBQ.l      #2,D3               ; shift de x
    SUBQ.l      #4,D6               ; D6 -= 4       
    BGT         FOR_RP_X            ; boucle si D6 > 0

    SUBQ.l      #2,D4               ; shift de y
    SUBQ.l      #4,D7               ; D7 -= 4       
    BGT         FOR_RP_Y            ; boucle si D7 > 0
    RTS

RENDER_MAZE:
    MOVE.l      PLAYER,D6           ; récupération des données
    MOVE.l      D6,D7               ; copie
    AND.l       #$FF00,D6           ; D6 = player.x décalé d'un octet
    LSR.l       #8,D6               ; D6 = player.x
    AND.l       #$FF,D7             ; D7 = player.y
    MOVEA.l     D6,A1               ; A1 = player.x
    MOVEA.l     D7,A2               ; A2 = player.y

    MOVEA.l  #638,A3            ; x1 = 638
    MOVEA.l  #640,A4            ; x2 = 640
R_MAZE_FOR_X:
    MOVEA.l  #478,A5            ; y1 = 478
    MOVEA.l  #480,A6            ; y2 = 480
R_MAZE_FOR_Y:

    MOVE.l  A3,D6           ; recupération x pour changer le bake

    DIVU    #64,D6          ; D6 <- x // 64 (32*2 car upscaling)

    MOVE.l  #$FFFF,D4       ; masque
    AND.l   D6,D4           ; D4 = q = tile pour x

    ADD.l   A1,D4           ; on ajoute la position du joueur pour avoir le bon offset
    SUBI.l  #4,D4           ; offset parce que le joueur est au milieu de l'ecran

    LSR.l   #8,D6           ; shift de 2o = 1 mot
    LSR.l   #8,D6           ; D6 = r = pixel (upscale)

    LSL.l   #1,D6           ; division par deux car 32px par tile et pas 64 mais multiplication par 4 car 4o par pixel

    MOVE.l  A5,D7           ; recupération y pour changer le bake

    DIVU    #64,D7          ; D7 <- y // 64 (32*2 car upscaling)

    MOVE.l  #$FFFF,D5       ; masque
    AND.l   D7,D5           ; D5 = q = tile pour y

    ADD.l   A2,D5           ; on ajoute la position du joueur pour avoir le bon offset
    SUBI.l  #3,D5           ; offset parce que le joueur est au milieu de l'ecran

    LSR.l   #8,D7           ; shift de 2o = 1 mot
    LSR.l   #8,D7           ; D7 = r = pixel (upscale)
    LSR.l   #1,D7           ; division par deux car 32px par tile et pas 64
    
    CLR.l   D3
    MOVE.w  TAILLE,D3       ; D3 = taille du labyrinthe
    JSR     GETCELL         ; D5 = valeur de la case correspondante

    LSL.l   #8,D5           ; D5 = D5 * 4096 = D5 * 2^12 car 4096 octets dans une tile
    LSL.l   #4,D5           ; deuxieme partie de la multiplication, D5 = adresse dans la tilesheet

    ADD.l   D6,D5           ; on ajoute x

    LSL.l   #7,D7           ; D7 = D7 * 128 = D7 * 2^7 car 128 octets sur un ligne dans la tilesheet
    ADD.l   D7,D5           ; on ajoute y

    ADD.l   #TILESHEET,D5    ; on ajoute l'adresse de la tilesheet

    MOVEA.l D5,A7           ; on charge l'adresse
    MOVE.l  (A7),D1         ; couleur du pixel dans la tilesheet
    MOVE.l  #$10000000,A7   ; reset de A7 pour éviter de planter

    MOVE    #80,D0          ; SET_PEN_COLOR
    TRAP    #15             ; on donne la bonne couleur au crayon

    MOVE    #81,D0          ; SET_FILL_COLOR
    TRAP    #15             ; couleur de remplissage

    MOVE.l  A3,D1           ; préparation des coordonées (x1)
    MOVE.l  A4,D3           ; préparation des coordonées (x2)
    MOVE.l  A5,D2           ; préparation des coordonées (y1)
    MOVE.l  A6,D4           ; préparation des coordonées (y2)

    MOVE    #87,D0          ; DRAW_FILL_RECT
    TRAP    #15             ; dessin du rectangle

    SUBA.w  #2,A6           ; y2 = y2-2
    SUBA.w  #2,A5           ; y1 = y1-2
    CMPA.l  #0,A5
    BGT     R_MAZE_FOR_Y    ; condition de boucle for (y > 0)

    SUBA.w  #2,A4           ; x2 = x2-2
    SUBA.w  #2,A3           ; x1 = x1-2
    CMPA.l  #0,A3
    BGT     R_MAZE_FOR_X    ; condition de boucle for (x > 0)

    JSR     RENDER_PLAYER
    ; MOVE    #94,D0          ; SWAP_SCREEN
    ; TRAP    #15

    RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

