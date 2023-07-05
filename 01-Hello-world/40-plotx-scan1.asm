;---------------------------------------------------------------------------
;-- Experimento. Dibujo de un pixel en el primer scanline. Posiciones 0-255
;-- Para probar la rutina plotx() se hace una animación del pixel, moviéndose
;-- entre las posiciones 0 y 255
;---------------------------------------------------------------------------

;-- Puerto para cambiar el color del borde
BORDER: EQU $FE

    org $8000

    ;-- Poner borde amarillo para ver mejor la posicion
    ;-- de los píxeles
    ld a, 6
    out (BORDER), a
 
start:

    ;-- Entrada: HL: Memoria de video
    ld hl, $4000

    ;-- Entrada B = Posicion del pixel (0-255)
    ld b, 0

bucle
    push bc

    ;-- Dibujar el pixel!
    call plotx

    ;-- Esperar un tiempo
    call wait

    ;-- Incrementar la posicion
    pop bc
    inc b

    ;-- Repetir
    jr nz, bucle

    ;-- La linea ha llegado al final
    ;-- La borramos, para volver a comenzar
    ;-- Longitud: 32 celdas
    ld b,32
    ld hl, $4000

    ;-- Valor a guardar en la memoria
    ld a,0

    ;-- Bucle de borrado
clear:
    ld (hl),a
    inc l
    djnz clear

    ;-- Comenzar!
    jp start


;--------------------------------------------------------------
;-- PLOTX(HL, POS)  (Pos: 0-255)
;-- Dibujar un pixel en la posicion 0-255 de una scanline
;--
;-- ENTRADA:
;--    * HL: Direccion base de la memoria de video
;--    * B: Posicion x: 0 - 255
;--------------------------------------------------------------
plotx:
    push hl

    ld a,b

    ;-- Desplazamiento a la derecha 3 posiciones
    ;-- Para tener el campo CCCCC
    sra a
    sra a
    sra a
    and $1F  ;-- Quedarse con los 5 bits de menor peso (000CCCCC)

    ;-- Sumar CCCCC a la dirección base
    add a,l
    ld l,a   ;-- HL apunta a la celda CCCCC (0-31)

    ld a,b   ;-- Obtener el campo PPP
    and 7
    ld b,a 

    ;-- Dibujar el pixel
    call plotxp

    pop hl
    ret


;-----------------------------------------------------------
;-- PLOTXP(HL,pos) Meter pixel en una celda (pos: 0-7)
;--
;-- ENTRADAS:
;--   * HL: Direccion de la memoria de video
;--   * B: Posicion del pixel (0-7) en el scanline 0 de la celda
;-----------------------------------------------------------------
plotxp:
    ;-- Si es la posicion 0, se escribe el valor $80 y se termina
    ld a,b
    or a    ;-- Actualizar flag z para comproar si A es 0
    jr z,pos0  ;-- A=0, es la posicion 0

    ;-- NO es la posicion 0
    ;-- Partimos del valor $80 y lo desplazamos B posiciones
    ;-- a la derecha
    ld a, $80

to_pos
    rrca 
    djnz to_pos

    ;-- En A tenemos el valor a escribir en memoria de video
    ;-- Escribir!
    jr plot


pos0:
    ;-- Valor a escribir en memoria video
    ld a, $80

plot:
    ;-- Primer leemos lo que hay
    ld b,(hl)

    ;-- Aplicamos un or para añdir a
    or b

    ;-- Guardamos el nuevo valor
    ld (hl), a


fin:
    ret

;----------------------------------
;-- Esperar N frames...
;-- Cada frame son 20ms aprox...
;----------------------------------
wait:
    halt  ;-- 20 ms
    ret

    end $8000
