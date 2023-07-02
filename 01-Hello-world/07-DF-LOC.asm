;----------------------------------------------------------------------------
;-- Prueba de la subrutina DF-LOC
;----------------------------------------------------------------------------

;--- Puerto para establecer el color del Borde
BORDER: EQU $FE


    org $8000

    ;-- Poner el borde amarillo
    ld a, 6
    out (BORDER), a

    ;-- Print AT 0,0
    ld b, 0  ;-- B = Linea
    ld c, 0  ;-- C = columna
    call DF_LOC

    ;-- Pintar
    ld a,$FF
    ld (hl), a

    ;-- Print AT 1,1
    ld b, 1
    ld c, 1
    call DF_LOC

    ;-- Pintar
    ld a,$FF
    ld (hl), a

    ;-- Print at 21,31
    ld b,21
    ld c,31
    call DF_LOC

    ;-- Pintar
    ld a,$FF
    ld (hl), a


    ret


;---------------------------------------------------------------------------
;- DF_LOC: Devolver la memoria de video asociada a la posicon (LNEA,COL)
;-
;-- ENTRADAS:
;--    * B = Linea (0-23)
;--    * C = Col (0 - 31)
;--
;-- SALIDA:
;--    * HL: Direccion de video
;--
;-- Formato de la direccion de video:
;-- 010T TSSS LLLC CCCC
;--
;-- El tercio se toma como parte de la linea para trabajar en el rango 0-21 
;-- Así la linea es TTLLL (5-bits). Está formada por dos campos
;---------------------------------------------------------------------------
DF_LOC:

    ld a,b    ;-- A = Linea (000T TLLL)
    and $f8   ;-- Poner a 0 los bits L (dejando solo los T)
              ;-- A = 000T T000
    add a,$40 ;-- A = 0100 0000 --> 010T T000
    ;-- H completado: Contiene valor corrector y el Tercio establecido (TT)
    ld h, a   ;-- H = 010T T000

    ;-- Establecer la parte baja en reg L (LLLC CCCC)
    ld a,b    ;-- A = linea (000T TLLL)
    and $7    ;-- A = 000T TLLL
              ;--     0000 0111
              ;-- A = 0000 0LLL  (Nos quedamos con la linea)
    rrca      ;-- A = L000 00LL
    rrca      ;-- A = LL00 000L
    rrca      ;-- A = LLL0 0000 (Tenemos LLL bien posicionado)

    ;-- Añadir el campo de la columna (que esta en C)
    add a,c

    ;-- Actualizar L
    ld l,a

    ;-- HL contiene la direccion
    ret


    end $8000