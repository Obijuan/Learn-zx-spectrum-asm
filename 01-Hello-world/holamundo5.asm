;------------------------------------------------------------------------------
;-- Impresión de una cadena en la pantalla
;------------------------------------------------------------------------------
    org $8000

    ;-- Cargar la direccion de la cadena
    ld hl, msg

bucle:
    ;-- Leer caracter
    ld a, (hl)

    ;-- Si es 0, terminar
    or a    ;-- Evaluar z
    jr z, fin  

    ;-- Imprimir caracter
    rst $10

    ;-- Apuntar al siguiente caracter
    inc hl

    ;-- Repetir
    jr bucle

fin:
    ret

      ;--- Cadena terminada en 0
msg:  defm 'Holi...',$00

    end $8000   