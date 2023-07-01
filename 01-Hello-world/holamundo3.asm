
    org $8000

    ;----- Escribir el caracter 'A' en la posicion actual
    ;----- de la pantalla
    ld a, 'A'
    rst $10
    ret


    end $8000