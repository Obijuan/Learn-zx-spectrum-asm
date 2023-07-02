;----------------------------------------------------------------------------
;-- Animación de una bala...
;----------------------------------------------------------------------------

;--- Puerto para establecer el color del Borde
BORDER: EQU $FE


    org $8000

    ;-- Poner el borde amarillo
    ld a, 6
    out (BORDER), a

init:
    ;-- Posicion inicial
    ld b, 10  ;-- B = Linea
    ld c, 0  ;-- C = columna
    call DF_LOC

    ;-- Print AT
    ld a, $FF
    ld (hl), a

    halt

loop:

    ;-- Guardar posicion actual
    ld de, pos_old
    ld a,l
    ld (de), a

    ;-- Obtener la nueva posicion
    inc c

     ;-- Si la bala ha llegado al final se termina
    ld a,c
    cp 32
    jr z, fin

    ;-- Imprimir la bala en la nueva posicion
    call DF_LOC
    ld a, $FF
    ld (hl), a
    push hl

    ;-- Borrar la bala de la posicion anterior
    ld de, pos_old
    ld a, (de)
    ld l,a
    xor a       ;-- Escribir un 0
    ld (hl), a

    ;-- Recuperar posicion actual
    pop hl
   
    ;-- Mini-pausa
    halt
    halt

   jr loop
    

fin:
   
    ;-- Borrar la bala de la posicion anterior
    ld de, pos_old
    ld a, (de)
    ld l,a
    xor a       ;-- Escribir un 0
    ld (hl), a

    ;-- Hacer una pausa mayor
    ld b,$40
loop2:
    halt
    dec b
    jr nz, loop2

    ;-- Repetir
    jr init

;-- Guardar la posicion antigua 
pos_old: defb 0


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