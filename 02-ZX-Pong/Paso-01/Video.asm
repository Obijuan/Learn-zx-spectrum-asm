;--------------------------------------------------------------------
;--  NextScan: Obtener la direccion del siguiente scanline
;--
;--  ENTRADA:
;--    * HL: Scanline actual
;--  SALIDA:
;--    * HL: Scanline siguiente
;--
;--  Formato direccion: 010TTSSS LLLCCCCC
;---------------------------------------------------------------------
NextScan:

    ;-- Incrementar scanline (Módulo 7)
    inc h
    ld a,h
    and $7
    ret nz  ;-- Si no es cero hemos terminado

    ;-- El scanline es 8 (mayor de 3 bits)
    ;-- Hay que pasar a la siguiente linea (incrementar LLL)
    ld a,l  ;-- A = LLLC CCCC
    add a,$20 ;-- +   0010 0000
    ld l,a
    ret c   ;-- Si hay acarreo hemos terminado

    ;-- Decrementar el tercio (se había incrementado en el paso 1)
    ld a, h  ;-- A = 010T TSSS
    sub $08  ;--     0000 1000
    ld h, a
    ret
    