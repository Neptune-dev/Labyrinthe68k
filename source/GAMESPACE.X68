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
        MOVE.B  D0,(A0)+
        SUB.W  #1,D1
        CMP.W   #0,D1
        BNE     INIT_MAZE_LOOP
        RTS




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
