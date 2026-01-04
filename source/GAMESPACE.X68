INIT_MAZE:
        MOVE.L  #MAZE,A0
        MOVE.L  TAILLE_TOTAL,D1
        MOVE.W  #1,D0
INIT_MAZE_LOOP:
        MOVE.W  D0,(A0)+
        SUB.L  #1,D1
        BNE     INIT_MAZE_LOOP
INIT_LOOP: ; remplit uniquement les cases impaires avec des valeurs croissantes
        MOVE.W  #2,D6       ; valeur initiale = 2
        MOVE.W  #1,D5       ; D5 = y commence Ã  1

Y_LOOP:
        CMP.W   D3,D5
        BGE     FIN_LOOP
        MOVE.W  #1,D4       ; D4 = x commence Ã  1

X_LOOP:
        CMP.W   D3,D4
        BGE     NEXT_Y

        JSR     SETCELL     ; MAZE[x][y] = D6

        ADD.W   #1,D6       ; valeur suivante
        ADD.W   #2,D4
        BRA     X_LOOP

NEXT_Y:
        ADD.W   #2,D5
        BRA     Y_LOOP

FIN_LOOP:
        RTS

LABYFAIT:
    MOVE.L  TAILLE_TOTAL,D0
    CMP.L   #0,D0
    BEQ     TOUS_EGAUX

    MOVE.W  (A0),D1        ; valeur de rÃ©fÃ©rence
    ADDQ.L  #2,A0          ; Ã©lÃ©ment suivant
    SUB.L  #1,D0

LOOP:
    CMP.L   (A0),D1
    BNE     PAS_EGAUX

    ADDQ.L  #2,A0
    SUB.L  #1,D0
    BNE     LOOP

TOUS_EGAUX:
    MOVEQ   #1,D4
    RTS

PAS_EGAUX:
    MOVEQ   #0,D4
    RTS

    
PROPAGERVALEUR:
        MOVE.L TAILLE_TOTAL,D3   ; compteur total
BOUCLE:
        MOVE.W (A1),D0          ; lire la valeur courante du tableau
        MOVE.L D0,D7             ; **copie dans D7 pour déboggage**
		MOVE.B	D1,D6
        CMP.B D1,D0              ; comparer avec l'ancienne valeur
        BNE SKIP_PROPAGE
        MOVE.W D2,(A1)           ; remplacer par la nouvelle valeur
SKIP_PROPAGE:
        ADD.L #2,A1              ; passer à la cellule suivante
        SUB.L #1,D3              ; décrémenter le compteur
        BNE BOUCLE
        RTS


ALGO_FUSION:
LOOP_FUSION:
    ; boucle tant que le labyrinthe est pas fait
    MOVE.L TAILLE_TOTAL,D0
    JSR LABYFAIT
    CMP.W #1,D4
    BEQ FIN

    ; --- génération des coordonnées randoms X et Y ---
    MOVE.W TAILLE,D4
    JSR RANDOMVAL
    MOVE.L A2,D6        ; D6 = X
    ;MOVE.L	#4,D6 ;----------------DEBUG
    MOVE.L D6,X_MUR

    JSR RANDOMVAL
    MOVE.L A2,D7        ; D7 = Y
    ;MOVE.L	#3,D7	;-------------------DEBUG
    MOVE.L D7,Y_MUR

    ; --- gestion de la parité de X ---
    BTST #0,D6          ; Test bit 0 de X
    BEQ X_PAIR
X_IMPAIR:
    BCLR #0,D7          ; X impair ? Y pair
    MOVE.L D7,Y_MUR
    BRA PARITE_OK
X_PAIR:
    BSET #0,D7          ; X pair ? Y impair
    MOVE.L D7,Y_MUR

PARITE_OK:
    ; --- vérification de la parité de Y ---
    MOVE.L Y_MUR,D7
    BTST #0,D7
    BEQ CAS_Y_PAIR      ; Y pair
    ; Y impair
    BTST #0,D6
    BEQ X_PAIR_Y_IMPAIR
    BRA LOOP_FUSION     ; sinon relancer génération

CAS_Y_PAIR:
    BTST #0,D6
    BNE X_IMPAIR_Y_PAIR
    BRA LOOP_FUSION     ; sinon relancer génération

; --- Cas X pair, Y impair ---
X_PAIR_Y_IMPAIR:
	; --- préparation du GETCELL(x_mur+1,y_mur) ---
    MOVE.W TAILLE,D3
    MOVE.L X_MUR,D4
    MOVE.L Y_MUR,D5
    ADD.L	#1,D4
    JSR GETCELL
    ; déplacement du résultat vers son espace atitré
    MOVE.L D5,VALEURDROITE
    ; --- préparation du GETCELL(x_mur-1,y_mur)
    MOVE.L	X_MUR,D4
    MOVE.L 	Y_MUR,D5
    SUB.L #1,D4
    JSR GETCELL
    ; déplacement vers son espace atitré
    MOVE.L D5,VALEURGAUCHE
    CMP.W VALEURDROITE,D5 ; si les deux résultats sont égaux, les deux valeurs ont déjà subi la même propagation donc on refait une boucle
    BEQ LOOP_FUSION
    ; --- préparation du SETCELL(x_mur,y_mur,0) pour casser le mur
    MOVE.W TAILLE,D3
    MOVE.L X_MUR,D4
    MOVE.L Y_MUR,D5
    MOVE.L #0,D6
    JSR SETCELL ; casse le mur où on est
    ; --- préparation du PROPAGERVALEUR(VALEURGAUCHE,VALEURDROITE)
    MOVE.L VALEURGAUCHE,D1
    MOVE.L VALEURDROITE,D2
    LEA	MAZE,A1
    CLR D0
    JSR PROPAGERVALEUR
    BRA LOOP_FUSION

; --- Cas X impair, Y pair ---
X_IMPAIR_Y_PAIR:
    MOVE.W TAILLE,D3
    MOVE.L X_MUR,D4
    MOVE.L Y_MUR,D5
    ADD.L #1,D5
    JSR GETCELL
    MOVE.L D5,VALEURHAUT
    MOVE.L	X_MUR,D4
    MOVE.L 	Y_MUR,D5
    SUB.L #1,D5
    ;ADD.L #4,D4
    JSR GETCELL
    MOVE.L D5,VALEURBAS
    CMP.L VALEURHAUT,D5
    BEQ LOOP_FUSION
    MOVE.L X_MUR,D4
    MOVE.L Y_MUR,D5
    MOVE.L #0,D6
    JSR SETCELL
    MOVE.L VALEURBAS,D1
    MOVE.L VALEURHAUT,D2
    LEA	MAZE,A1
    CLR D0
    JSR PROPAGERVALEUR
    BRA LOOP_FUSION

FIN:
    RTS
    
    
    
TABLEAU_RENDERING: ; remplace FFFF par 0001 et ensuite met tout ce qui n'est pas = 1 à la valeur 1.
        TST.W   D0
        BEQ     CHGT_VALEURS
; partie suppression des FF et remplacement par 01
LOOP_DELETE_FF:
        CMP.W   #$FFFF, (A0)    ; compare avec 0x00FF
        BNE     SKIP_DELETE_FF

        MOVE.W  #1, (A0)        ; remplace par 1

SKIP_DELETE_FF:
        ADDQ.L  #2, A0
        SUBQ.W  #1, D0
        BNE     LOOP_DELETE_FF
; changements des valeurs par 1
CHGT_VALEURS:
		LEA		MAZE,A0 		;reset des registres pour re parcours de MAZE
		MOVE.L	#6561,D0
        TST.W   D0              ; si D0 = 0, ne rien faire
        BEQ     END_TAB

BOUCLE_CHGT:
        CMP.W   #1, (A0)
        BEQ     CONTINUE_CHGT

        CLR.W   (A0)

CONTINUE_CHGT:
        ADDQ.L  #2, A0          ; élément suivant
        SUBQ.W  #1, D0          ; décrémente compteur
        BNE     BOUCLE_CHGT		; tant que D0 ? 0, on boucle

END_TAB:
        RTS





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
