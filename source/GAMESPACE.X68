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
        MOVE.W  #1,D5       ; D5 = y commence à 1

Y_LOOP:
        CMP.W   D3,D5
        BGE     FIN_LOOP
        MOVE.W  #1,D4       ; D4 = x commence à 1

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

    MOVE.W  (A0),D1        ; valeur de référence
    ADDQ.L  #2,A0          ; élément suivant
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
        ADD.L   #2,A1          ; passer � la case suivante
        SUB.L   #1,D3          ; d�cr�menter compteur
        BNE     BOUCLE
        RTS

ALGO_FUSION:
LOOP_FUSION:
    ; V�rifier si le labyrinthe est termin�
    MOVE.L TAILLE_TOTAL,D0
    JSR LABYFAIT
    CMP.W #1,D4
    BEQ FIN

    ; --- G�n�rer coordonn�es al�atoires X et Y ---
    MOVE.L TAILLE_TOTAL,D4
    JSR RANDOMVAL
    MOVE.L A2,D6        ; D6 = X
    MOVE.L D6,X_MUR

    MOVE.L TAILLE_TOTAL,D4
    JSR RANDOMVAL
    MOVE.L A2,D7        ; D7 = Y
    MOVE.L D7,Y_MUR

    ; --- Ajuster Y selon parit� de X ---
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
    ; --- Tester parit� Y pour savoir quel mur traiter ---
    MOVE.L Y_MUR,D7
    BTST #0,D7
    BEQ CAS_Y_PAIR      ; Y pair
    ; Y impair
    BTST #0,D6
    BEQ X_PAIR_Y_IMPAIR
    BRA LOOP_FUSION     ; sinon relancer g�n�ration

CAS_Y_PAIR:
    BTST #0,D6
    BNE X_IMPAIR_Y_PAIR
    BRA LOOP_FUSION     ; sinon relancer g�n�ration

; --- Cas X pair, Y impair ---
X_PAIR_Y_IMPAIR:
    MOVE.L TAILLE_TOTAL,D3
    MOVE.W X_MUR,D4
    MOVE.W Y_MUR,D5
    ADD.W #1,D4
    JSR GETCELL
    MOVE.W D5,VALEURBAS
    MOVE.W Y_MUR,D5
    SUB.W #2,D4
    JSR GETCELL
    MOVE.W D5,VALEURHAUT
    CMP.W VALEURBAS,D5
    BEQ LOOP_FUSION
    MOVE.L TAILLE_TOTAL,D3
    MOVE.W X_MUR,D4
    MOVE.W Y_MUR,D5
    MOVE.L #0,A0
    JSR SETCELL
    MOVE.W VALEURBAS,D1
    MOVE.W VALEURHAUT,D2
    MOVE.L TAILLE_TOTAL,D3
    MOVE.L A0,D4
    MOVE.L A1,D5
    JSR PROPAGERVALEUR
    BRA LOOP_FUSION

; --- Cas X impair, Y pair ---
X_IMPAIR_Y_PAIR:
    MOVE.L TAILLE_TOTAL,D3
    MOVE.W X_MUR,D4
    MOVE.W Y_MUR,D5
    ADD.W #1,D5
    JSR GETCELL
    MOVE.W D5,VALEURDROITE
    MOVE.W Y_MUR,D5
    SUB.W #2,D4
    JSR GETCELL
    MOVE.W D5,VALEURGAUCHE
    CMP.W VALEURDROITE,D5
    BEQ LOOP_FUSION
    MOVE.L TAILLE_TOTAL,D3
    MOVE.W X_MUR,D4
    MOVE.W Y_MUR,D5
    MOVE.L #0,A0
    JSR SETCELL
    MOVE.W VALEURGAUCHE,D1
    MOVE.W VALEURDROITE,D2
    MOVE.L TAILLE_TOTAL,D3
    MOVE.L A0,D4
    MOVE.L A1,D5
    JSR PROPAGERVALEUR
    BRA LOOP_FUSION

FIN:
    RTS







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
