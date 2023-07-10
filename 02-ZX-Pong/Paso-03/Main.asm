
 ;--- Puerto del borde
 BORDE EQU $FE

    org $8000

    ;-- Borde Rojo
    ld a, $02
    out (BORDE), a 

    ;-- Borrar pantalla: Tinta blanca, Fondo negro
    call Cls

    ;-- Dibujar linea
    call PrintLine

    ;-- Dibujar raqueta jugador 1
    ld hl, (paddle1pos)
    call PrintPaddle

    ;-- Dibujar raqueta jugador 2
    ld hl, (paddle2pos)
    call PrintPaddle

    ;-- Terminar
    ret

    include "Sprite.asm"
    include "Video.asm"
    
    end $8000
