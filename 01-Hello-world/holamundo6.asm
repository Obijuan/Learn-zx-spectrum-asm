;-----------------------------------------------------------------------------
;-- Ejemplo para cambiar el borde a otro color
;-----------------------------------------------------------------------------

    ;--- Puerto a escribir para cambiar el color
    ;--- del borde
BORDER: EQU $FE

    org $8000

    ld a, 1  ;-- Color azul

    ;-- Escribir en el puerto
    out (BORDER), a

    ;-- Terminar
    ret

    end $8000