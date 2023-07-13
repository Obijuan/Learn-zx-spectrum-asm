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
    ld hl, VIDEORAM      ;-- HL: Puntero a la memoria de Video
    ld (hl), $00         ;-- Borrar posicion actual
    ld de, VIDEORAM + 1  ;-- Siguiente posicion
    ld bc, VIDEOSIZE - 1 ;-- Tamaño de la memoria de video
    ldir

    ;-- Establecer los atributos de la memoria de video
    ld hl, VIDEOATTR
    ld (hl), a                ;-- Escribir atributos
    ld de, VIDEOATTR + 1
    ld bc, VIDEATTR_SIZE - 1  ;-- Tamaño de la memoria de atributo (menos uno)
    ldir

    ret
