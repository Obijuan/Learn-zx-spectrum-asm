;----------------------------------------------------------------------------
;-- RUTINAS DE VIDEO
;----------------------------------------------------------------------------

;----------------------------------------------------------------------------
;-- cls: Borrar la pantalla con los atributos indicados
;--
;-- ENTRADA:
;--   * A: Atributos a utilizar
;----------------------------------------------------------------------------
cls:
    ;-- Rellenar toda la memoria de video con ceros para limpiar... 
    ld hl, $4000  ;-- HL: Puntero a la memoria de Video
    ld (hl), $00  ;-- Borrar posicion actual
    ld de, $4001  ;-- Siguiente posicion
    ld bc, $17ff  ;-- Tamaño de la memoria de video
    ldir

    ;-- Establecer los atributos de la memoria de video
    ld hl, $5800
    ld (hl), a    ;-- Escribir atributos
    ld de, $5801
    ld bc, $2ff    ;-- Tamaño de la memoria de atributo (menos uno)
    ldir

    ret
