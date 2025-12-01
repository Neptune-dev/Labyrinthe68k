*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
INIT_MAZE:                  ; first instruction of program

* Put program code here
        MOVE.W  #MAZE,A0
        MOVE.W  #6561,D1        
        MOVE.W  #$0001,D0
        RTS
INIT_MAZE_LOOP:
        MOVE.B  D0,(A0)+
        SUB.W  #1,D1
        BNE     INIT_LOOP
        RTS

    SIMHALT             ; halt simulator
    
* Put variables and constants here
    MAZE:   DS.w    6561
    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
