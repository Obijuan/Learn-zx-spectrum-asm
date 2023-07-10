
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

loop:
    call ScanKeys

MovePaddle1Up:
    bit 0, d  ;-- Comprobar si tecla A pulsada
    jr z, MovePaddle1Down  ;-- Si no pulsada, salta

    ;-- Tecla A pulsada: Movimiento hacia arriba
    ;-- Comprobar si hemos alcanzado el límite superior
    ld hl, (paddle1pos)
    ld a, PADDLE_TOP     ;-- Margen superior
    call CheckTop        ;-- Evaluar si limite alcanzado
    jr z, MovePaddle2Up  ;-- Limite alcanzado. No mover. Pasar
                         ;-- a la raqueta 2
    ;-- Limite no alcanzado
    ;-- Obtener la direccion
    call PreviousScan ;-- Obtener scanline anterior a la pala
    ld (paddle1pos), hl ;-- Es la nueva posicion
    jr MovePaddle2Up    ;-- Saltar


MovePaddle1Down:
    bit 1, d  ;-- Comprobar si tecla Z pulsada
    jr z, MovePaddle2Up

    ;-- Tecla Z pulsada: Movimiento hacia abajo
    ;-- Comprobar si limite inferior alcanzado
    ld hl, (paddle1pos)
    ld a, PADDLE_BOTTOM
    CALL CheckBottom
    jr z, MovePaddle2Up     ;-- Limite alcanzado. No mover. Pasar a
                            ;-- la raqueta 2

    ;-- Limite no alcanzado
    ;-- Obtener la direccion de la siguiente posicion
    call NextScan
    ld (paddle1pos), hl


MovePaddle2Up:
    bit 2, d   ;-- Comprobar si tecla 0 pulsada
    jr z, MovePaddle2Down
    ld hl, (paddle2pos)
    ld a, PADDLE_TOP
    call CheckTop
    jr Z, MovePaddleEnd
    call PreviousScan
    ld (paddle2pos), hl
    jr MovePaddleEnd

MovePaddle2Down:
    bit 3, d    ;-- Comprobar si tecla O pulsada
    jr z, MovePaddleEnd
    ld hl, (paddle2pos)
    ld a, PADDLE_BOTTOM
    call CheckBottom
    jr z, MovePaddleEnd
    call NextScan
    ld (paddle2pos),hl

MovePaddleEnd:
    ;-- Imprimir raqueta 1
    ld hl, (paddle1pos)  
    call PrintPaddle   

    ;-- Imprimir raqueta 2
    ld hl, (paddle2pos)
    call PrintPaddle

    halt

    jr loop

    ;-- Terminar
    ret

    include "Controls.asm"
    include "Sprite.asm"
    include "Video.asm"
    
    
    end $8000
