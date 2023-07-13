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

;-----------------------------------------------------------------------------
;-- draw_sprite: Dibujar un sprite (de 8 lineas) en la pantalla (de 8 lineas)
;-- 
;-- ENTRADAS:
;--   * HL: Direccion de la memoria de video
;--   * DE: Direccion del sprite a pintar
;-----------------------------------------------------------------------------
draw_sprite8:
  
  ld b, 8  ;-- El sprite tiene 8 lineas

sprite_loop:
  ld a, (de)  ;-- Leer byte del sprite
  ld (hl), a  ;-- Mostrar byte en pantalla
  inc h       ;-- Siguiente linea
  inc de      ;-- Siguiente byte
  djnz sprite_loop

  ret


