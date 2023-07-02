;----------------------------------------------------------------------------
;-- Ejemplo de uso de la rutina PRINT1
;----------------------------------------------------------------------------

;--- Puerto para establecer el color del Borde
BORDER: EQU $FE

    org $8000

    ;-- Poner el borde amarillo
    ld a, 6
    out (BORDER), a

    ;-- Imprimir todos los caracteres disponibles
    ;-- Desde el $20 hasta el $7F
    ld c, $20
loop:

    ;-- Imprimir caracter actual
    ld a,c
    call PRINT1  ;-- print1 conserva registro c

    ;-- Siguiente caracter a imprimir
    inc c

    ;-- Si es $80, hemos terminado
    ld a,c
    cp $80
    jr nz,loop

    ret

;----------------------------------------------------------------------------
;-- VARIABLES
;----------------------------------------------------------------------------

;-- Direccion base de la memoria de caracteres
BASE: DEFW  $3C00
DFCC: DEFW  $4000  ;-- Direccion actual del cursor
ATT:  DEFB  $39    ;-- Attributos por defecto: papel blanco, tinta negra
MASK: DEFB  $0     ;-- Mascara de atributos

;---------------------------------------------------------------------------
;-- PRINT1: Imprimir un caracter en la posicion actual
;-         
;-- ENTRADAS:
;--    * A: Caracter a imprimir
;---------------------------------------------------------------------------
PRINT1:

    ld l, a   ;-- L = Caracter a imprimir
    ld h, 0   ;-- H = 0

    ;-- Multiplicar por 8 el caracter
    ;-- Cada caracter esta formado por 8 bytes
              ;-- HL = HL = 0000 0000 CCCC CCCC
    add hl,hl ;-- HL = 2*HL. Desplazar un bit a la izquierda
              ;-- HL = 0000 000C CCCC CCC0
    add hl,hl ;-- HL = 0000 00CC CCCC CC00
    add hl,hl ;-- HL = 0000 0CCC CCCC C000

    ;-- Obtener direccion del caracter: Base + car * 8
    ;-- DE = Direccion base de los caracteres
    ld DE, (BASE)
    add hl, de    ;-- HL: Direccion del caracter

    ;-- DE= Direccion de la memoria de video donde colocar el caracter
    ld DE, (DFCC)

    ;-- Imprimir el caracter fila por fila
    ld B, 8    ;-- Numero de bytes (8 bytes por caracter)
next_row:
    ld a, (HL) ;-- Leer byte del caracter
    ld (de), a ;-- Escribir byte en memoria de video
    inc hl
    inc d      ;-- Apuntar a la siguiente scanline en la meoria de video
    djnz next_row

    ;-- DE= Direccion del atributo
    ld a, d    ;--  A = 010TTSSS
    rrca       ;--  A = S010TTSS
    rrca       ;--  A = SS010TTS
    rrca       ;--  A = SSS010TT
    dec a      ;--  ?
    and 3      ;--  3 = 00000011
               ;--  A = 000000TT
    or $58     ;-- 58 = 01011000
               ;--  A = 010110TT
    ld d,a
    ld hl,(ATT) ;-- H=Mascara, L=Atributo

    ;-- Leer anterior atributo
    ld a, (de)

    ;-- Construir el nuevo atributo
    xor l
    and h
    xor l

    ;-- Reemplazar atributo
    ld (de), a

    ;- Poner en DFCC la siguiente posicion de impresion
    ld HL, DFCC
    inc (HL)
    ret nz
    inc HL
    ld a, (hl)
    add a,8
    ld (hl),a
    ret

    end $8000