ZERO:  EQU  $00
LINE:  EQU  $80

;--- Raquetas
PADDLE: EQU $3C
PADDLE_TOP:    EQU $00  ;-- Posicion superior de la raqueta en el campo
PADDLE_BOTTOM: EQU 168  ;-- Posicion inferior de la raqueta en el campo

                       ;-- 010TTSSS LLLCCCCC
paddle1pos: DW $4861   ;-- 01001000 01100001  (1, 11)
paddle2pos: DW $487e   ;-- 01001000 01111110  (30, 11)


