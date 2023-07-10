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
    
;--------------------------------------------------------------------
;--  PreviousScan: Obtener la direccion scanline anterior
;--
;--  ENTRADA:
;--    * HL: Scanline actual
;--  SALIDA:
;--    * HL: Scanline anterior
;--
;--  Formato direccion: 010TTSSS LLLCCCCC
;---------------------------------------------------------------------
PreviousScan:

    ;-- Decrementar el scanline
    ld a,h
    dec h
    and $7
    ret nz  ;-- Nos quedamos en la fila actual

    ;-- El scanline está en la fila anterior. Hay que decrementar
    ;-- la fila
    ld a, l
    sub $20
    ld l,a
    ret c  ;-- Hemos cambiado de fila, y de tercio

    ;-- Hay que incrementar el tercio para que se quede como está
    ld a,h 
    add a, $08
    ld h,a

    ret

;----------------------------------------------------------------------------
;-- Cls: Borrar la pantalla con tinta blanca y fondo negro
;----------------------------------------------------------------------------
Cls:
    ;-- Rellenar toda la memoria de video con ceros para limpiar... 
    ld hl, $4000  ;-- HL: Puntero a la memoria de Video
    ld (hl), $00  ;-- Borrar posicion actual
    ld de, $4001  ;-- Siguiente posicion
    ld bc, $17ff  ;-- Tamaño de la memoria de video
    ldir

    ;-- Establecer los atributos de la memoria de video
    ld hl, $5800
    ld (hl), $07  ;-- Fondo negro, tinta blanca
    ld de, $5801
    ld bc, $2ff    ;-- Tamaño de la memoria de atributo
    ldir

    ret

;-----------------------------------------------------------------------------
;-- PrintLine:  Imprimir la linea central de la red
;-----------------------------------------------------------------------------
PrintLine:
    ld b, 24      ;-- Tamaño: 24 líneas
    ld hl, $4010  ;-- Columna central, Primera línea (16,0)

PrintLine_loop:
    ;-- No hay parte superior de la linea
    ld (hl), ZERO
    inc h
    push bc

    ld b, 6        ;-- Pintar 6 lineas verticales  
PrintLine_loop2:
    ld (hl), LINE  ;-- Pintar linea vertical
    inc h          ;-- Siguiente scanline
    djnz PrintLine_loop2

    pop bc

    ;-- Pintar ultimo tramo: sin linea
    ld (hl), ZERO
    call NextScan

    ;-- Repetir para las 24 líneas
    djnz PrintLine_loop

    ret


;----------------------------------------------------------------------------
;-- PrintPaddle:  Imprimir la raqueta
;--
;--  ENTRADA:
;--    * HL: Posicion de la raqueta (direccion)
;----------------------------------------------------------------------------
PrintPaddle:

    ;-- Parte superior de la raqueta: blanco
    ld (hl), ZERO
    call NextScan

    ;-- Pintar la parte visible de la pala
    ;-- Longitud: 22 scanlines
    ld b, 22
printPaddle_loop:
    ld (hl), PADDLE
    call NextScan
    djnz printPaddle_loop

    ;-- La última línea de la pala en blanco
    ld (hl), ZERO
    ret

