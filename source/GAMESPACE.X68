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
        MOVE.W  #1,D5       ; D5 = y commence � 1

Y_LOOP:
        CMP.W   D3,D5
        BGE     FIN_LOOP
        MOVE.W  #1,D4       ; D4 = x commence � 1

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

    MOVE.W  (A0),D1        ; valeur de r�f�rence
    ADDQ.L  #2,A0          ; �l�ment suivant
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
        CMP.B D1,D0              ; comparer avec l'ancienne valeur
        BNE SKIP_PROPAGE
        MOVE.W D2,(A1)           ; remplacer par la nouvelle valeur
SKIP_PROPAGE:
        ADD.L #2,A1              ; passer ? la cellule suivante
        DBRA D3,BOUCLE       ; d�cr�menter D3 et boucler si pas fini
        RTS


ALGO_FUSION:
LOOP_FUSION:
	; boucle tant qu'on a pas fait 100 appels
	MOVE.L	NB_TOURS,D0
	CMP.L   #0,D0
    BEQ FIN               ; arr�ter si compteur = 0
    SUBQ.L  #1,D0
	MOVE.L	D0,NB_TOURS
	; initialisation de x et y al�atoires (fonctionne pas)
    MOVE.W TAILLE,D2     
	JSR RANDOMVAL
	MOVE.B	A2,D6
	JSR RANDOMVAL
	MOVE.B	A2,D7
    MOVE.L D6,X_MUR
    MOVE.L D7,Y_MUR

    ; --- gestion de la parit? de X ---
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
    ; --- v?rification de la parit? de Y ---
    MOVE.L Y_MUR,D7
    BTST #0,D7
    BEQ CAS_Y_PAIR      ; Y pair
    ; Y impair
    BTST #0,D6
    BEQ X_PAIR_Y_IMPAIR
    BRA LOOP_FUSION     ; sinon relancer g?n?ration

CAS_Y_PAIR:
    BTST #0,D6
    BNE X_IMPAIR_Y_PAIR
    BRA LOOP_FUSION     ; sinon relancer g?n?ration

; --- Cas X pair, Y impair ---
X_PAIR_Y_IMPAIR:
	; --- pr?paration du GETCELL(x_mur+1,y_mur) ---
    MOVE.W TAILLE,D3
    MOVE.L X_MUR,D4
    MOVE.L Y_MUR,D5
    ADD.L	#1,D4
    JSR GETCELL
    ; d?placement du r?sultat vers son espace atitr?
    MOVE.L D5,VALEURDROITE
    ; --- pr?paration du GETCELL(x_mur-1,y_mur)
    MOVE.L	X_MUR,D4
    MOVE.L 	Y_MUR,D5
    SUB.L #1,D4
    JSR GETCELL
    ; d?placement vers son espace atitr?
    MOVE.L D5,VALEURGAUCHE
    CMP.W VALEURDROITE,D5 ; si les deux r?sultats sont ?gaux, les deux valeurs ont d?j? subi la m?me propagation donc on refait une boucle
    BEQ LOOP_FUSION
    ; --- pr?paration du SETCELL(x_mur,y_mur,0) pour casser le mur
    MOVE.W TAILLE,D3
    MOVE.L X_MUR,D4
    MOVE.L Y_MUR,D5
    MOVE.L #0,D6
    JSR SETCELL ; casse le mur o? on est
    ; --- pr?paration du PROPAGERVALEUR(VALEURGAUCHE,VALEURDROITE)
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
    
    
    
TABLEAU_RENDERING: ; remplace FFFF par 0001 et ensuite met tout ce qui n'est pas = 1 ? la valeur 1.
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
        ADDQ.L  #2, A0          ; ?l?ment suivant
        SUBQ.W  #1, D0          ; d?cr?mente compteur
        BNE     BOUCLE_CHGT		; tant que D0 ? 0, on boucle

COLLIDER:
        MOVE.l  D2,D4           ; récupération des données
        MOVE.l  D4,D5           ; copie
        AND.l   #$FF00,D4       ; D4 = player.x décalé d'un octet
        LSR.l   #8,D4           ; D4 = player.x
        AND.l   #$FF,D5         ; D5 = player.y
        MOVE.w  TAILLE,D3       ; D3 = taille du labyrinthe     
        JSR     GETCELL         ; D5 = lab(x,y)
        RTS

END_TAB:
        RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
