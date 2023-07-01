;--------------------------------------
;-- Ejemplo para imprimir el mensaje HI
;-- en la pantalla, caracter a caracter
;-- Cada caracter se lee de memoria y se imprime

    org $8000

    ;-- Direccion de la cadena en HL
    ld hl, msg

    ;-- Imprimir el primer caracter
    ld a, (hl)  ;-- Leer caracter
    rst $10     ;-- Imprimirlo!

    ;-- Apuntar al siguiente caracter
    inc hl

    ;-- Imprimir el siguiente carcter
    ld a, (hl)
    rst $10

    ;-- Terminar
    ret


msg:  defm 'HI'

    end $8000