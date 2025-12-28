*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
INIT_MAZE:
        MOVE.L  #MAZE,A0
        MOVE.W  #6561,D1        
        MOVE.W  #1,D0
INIT_MAZE_LOOP:
        MOVE.W  D0,(A0)+
        SUB.W  #1,D1
        CMP.W   #0,D1
        BNE     INIT_MAZE_LOOP
INIT_LOOP: ; remplit uniquement les cases impaires avec des valeurs croissantes
        MOVE.W  #2,D6       ; valeur initiale = 2
        MOVE.W  #1,D4

X_LOOP:
        CMP.W   D3,D4
        BGE     FIN_LOOP
        MOVE.W  #1,D5

Y_LOOP:
        CMP.W   D3,D5
        BGE     NEXT_X

        JSR     SETCELL     ; MAZE[x][y] = D6

        ADD.W   #1,D6       ; valeur suivante
        ADD.W   #2,D5
        BRA     Y_LOOP

NEXT_X:
        ADD.W   #2,D4
        BRA     X_LOOP

FIN_LOOP:
        RTS

LABYFAIT:
    CMP.W	#0,D0           ; taille == 0 ?
    BEQ   TOUSEGAUX	;si vide alors vrai

    MOVE.W  (A0),D1      ; D1 = première valeur de référence
    ADD.L  #2,A0        ; avance au 2e élément
    SUB.L  #1,D0

LOOP:
    CMP.W   (A0),D1      ; case courante != valeur de ref ?
    BNE   PASEGAUX

    ADD.L  #2,A0        ; incrémente adresse
    SUB.L  #1,D0        ; décrémente compteur
    BNE   LOOP		; pas fini ? continue

TOUSEGAUX:
    MOVE   #1,D0        ; TRUE
    RTS

PASEGAUX:
    MOVE   #0,D0        ; FALSE
    RTS

PROPAGERVALEUR:
        MOVE.W  (A1),D2            ; lire la valeur actuelle
        CMP.W   D0,D2              ; comparer avec l'ancienne valeur
        BNE     SKIP_PROPAGE       ; si différent, passe à la suivante
        MOVE.W  D1,(A1)            ; sinon, remplacer par D1
SKIP_PROPAGE:
        ADD.L  #2,A1              ; passer à la case suivante
        SUB.L  #1,D3
        BNE     PROPAGERVALEUR
		RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
