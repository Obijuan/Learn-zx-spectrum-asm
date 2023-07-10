
    org $8000

    ;-- Dibujar Linea vertical izquierda
    ;-- Apuntar a la celda (0,0)
    ld hl, $4000
    ld b, 192  ;-- Recorrer las 192 scanlines...
loop:
    ld (hl), $3c  ;-- Escribir en memoria de video
    call NextScan ;-- Siguiente scanline

    ;-- DEBUG: Hacer una pausa para ver como se
    ;-- dibuja la linea de arriba hacia abajo
    ;halt  
    djnz loop

    ;--------------- Dibujar linea vertical derecha
    ;-- La dibujamos de abajo hacia arriba, para probar la
    ;-- rutina PreviousScan
    ld hl, $57FF  ;-- Posicion: (255,192)
    ld b,192      ;-- Recorrer las 192 scanlines

loop2:
    ld (hl), $3c
    call PreviousScan

    ;-- DEBUG: Hacer una pausa para ver el dibujo
    ;-- de la linea
    ;-- halt
    djnz loop2
    ret

    include "Video.asm"
    end $8000
