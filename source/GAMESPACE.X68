*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
INIT_MAZE:                  ; first instruction of program

        MOVE.L  #MAZE,A0
        MOVE.W  #6561,D1        
        MOVE.W  #$0001,D0
        RTS
INIT_MAZE_LOOP:
        MOVE.W  D0,(A0)+
        SUB.W  #1,D1
        CMP.W   #0,D1
        BNE     INIT_MAZE_LOOP
        RTS
        
INIT_LOOP: ;Parcourt toutes les coordonnées paires
        MOVE.W #2,D6       ; val initial = 2
        MOVE.W #0,D4       ; x = 0

X_LOOP:
        CMP.W D3,D4
        BGE FIN_LOOP       ; fin si x >= largeur

        MOVE.W #0,D5       ; y = 0

Y_LOOP:
        CMP.W D3,D5
        BGE NEXT_X         ; passer à la colonne suivante si y >= largeur

        JSR SETCELL        ; MAZE[x][y] = val

        ADD.W #1,D6        ; val++
        ADD.W #2,D5        ; prochaine coordonnée paire
        BRA Y_LOOP

NEXT_X:
        ADD.W #2,D4        ; prochaine coordonnée paire
        BRA X_LOOP

FIN_LOOP:
        RTS

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
