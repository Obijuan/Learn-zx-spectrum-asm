;-- Programa hola mundo

;--- Comienzo de la RAM
    org $8000

    ld hl, $4000   ;--- Direccion de comienzo de la memoria de video
    ld (hl), $FF   ;--- Activar 8 pixeles
    ret


end $8000
