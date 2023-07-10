
    org $8000

    ;-- Apuntar a la celda (0,0)
    ld hl, $4000
    ld b, 192  ;-- Recorrer las 192 scanlines...
loop:
    ld (hl), $3c  ;-- Escribir en memoria de video
    call NextScan ;-- Siguiente scanline

    ;-- DEBUG: Hacer una pausa para ver como se
    ;-- dibuja la linea de arriba hacia abajo
    halt  
    djnz loop

    ret

    include "Video.asm"
    end $8000
