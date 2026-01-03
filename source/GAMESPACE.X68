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
    MOVE.W	TAILLE_TOTAL,D3
BOUCLE:
        MOVE.W  (A1),D0        ; lire la valeur actuelle
        CMP.W   D1,D0          ; comparer avec l'ancienne valeur
        BNE     SKIP_PROPAGE
        MOVE.W  D2,(A1)        ; remplacer par la nouvelle valeur
SKIP_PROPAGE:
        ADD.L   #2,A1          ; passer ï¿½ la case suivante
        SUB.L   #1,D3          ; dï¿½crï¿½menter compteur
        BNE     BOUCLE
        RTS

ALGO_FUSION:
LOOP_FUSION:
    ; Vï¿½rifier si le labyrinthe est terminï¿½
    MOVE.L TAILLE_TOTAL,D0
    JSR LABYFAIT
    CMP.W #1,D4
    BEQ FIN

    ; --- Gï¿½nï¿½rer coordonnï¿½es alï¿½atoires X et Y ---
    MOVE.W TAILLE,D4
    JSR RANDOMVAL
    MOVE.L A2,D6        ; D6 = X
    MOVE.L D6,X_MUR

    JSR RANDOMVAL
    MOVE.L A2,D7        ; D7 = Y
    MOVE.L D7,Y_MUR

    ; --- Ajuster Y selon paritï¿½ de X ---
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
    ; --- Tester paritï¿½ Y pour savoir quel mur traiter ---
    MOVE.L Y_MUR,D7
    BTST #0,D7
    BEQ CAS_Y_PAIR      ; Y pair
    ; Y impair
    BTST #0,D6
    BEQ X_PAIR_Y_IMPAIR
    BRA LOOP_FUSION     ; sinon relancer gï¿½nï¿½ration

CAS_Y_PAIR:
    BTST #0,D6
    BNE X_IMPAIR_Y_PAIR
    BRA LOOP_FUSION     ; sinon relancer gï¿½nï¿½ration

; --- Cas X pair, Y impair ---
X_PAIR_Y_IMPAIR:
    MOVE.W TAILLE,D3
    MOVE.L X_MUR,D4
    MOVE.L Y_MUR,D5
    ADD.L #1,D4
    JSR GETCELL
    MOVE.L D5,VALEURBAS
    MOVE.L	X_MUR,D4
    MOVE.L 	Y_MUR,D5
    SUB.L #2,D5
    JSR GETCELL
    MOVE.L D5,VALEURHAUT
    CMP.W VALEURBAS,D5
    BEQ LOOP_FUSION
    MOVE.W TAILLE,D3
    MOVE.L X_MUR,D4
    MOVE.L Y_MUR,D5
    MOVE.L #0,A0
    JSR SETCELL
    MOVE.L VALEURBAS,D1
    MOVE.L VALEURHAUT,D2
    MOVE.L TAILLE_TOTAL,D3
    MOVE.L A0,D4
    MOVE.L A1,D5
    JSR PROPAGERVALEUR
    BRA LOOP_FUSION

; --- Cas X impair, Y pair ---
X_IMPAIR_Y_PAIR:
    MOVE.W TAILLE,D3
    MOVE.L X_MUR,D4
    MOVE.L Y_MUR,D5
    ADD.L #1,D5
    JSR GETCELL
    MOVE.L D5,VALEURDROITE
    MOVE.L	X_MUR,D4
    MOVE.L 	Y_MUR,D5
    SUB.L #2,D5
    JSR GETCELL
    MOVE.L D5,VALEURGAUCHE
    CMP.L VALEURDROITE,D5
    BEQ LOOP_FUSION
    MOVE.W TAILLE,D3
    MOVE.L X_MUR,D4
    MOVE.L Y_MUR,D5
    MOVE.L #0,A0
    JSR SETCELL
    MOVE.W VALEURGAUCHE,D1
    MOVE.W VALEURDROITE,D2
    MOVE.W TAILLE_TOTAL,D3
    MOVE.L A0,D4
    MOVE.L A1,D5
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
