;---------------------------------------------------------------------------
;-- Experimento. Dibujo de lineas vertical en la primera celda (0,0)
;---------------------------------------------------------------------------

;-- Puerto para cambiar el color del borde
BORDER: EQU $FE

    org $8000

    ;-- Poner borde amarillo para ver mejor la posicion
    ;-- de los píxeles
    ld a, 6
    out (BORDER), a

start:
    ;-- Memoria de video
    ld hl, $4000

    ld b,0  ;-- x
    ld c,0  ;-- y

loop:
    ;-- Pintar pixel en posicion actual
    push hl
    push bc
    call pixely
    pop bc
    pop hl

    call wait

    ;-- Incrementar posicion
    inc c

    ;-- Restringir la posicion a 0-7 (modulo 8)
    ld a,c
    and 7
    ;-- Si la linea llega al final... pasar a la siguiente linea vertical
    jr z, next_col
    ld c,a

    jr loop

next_col:
    ;-- Pasar a la siguiente columna
    inc b

    ;-- Incremento modulo 8
    ld a,b
    and 7
    jr z,fin  ;-- Si es la linea 7 hemos terminado
    ld b,a

    ;-- Volver a y=0
    ld c,0

    jr loop

fin:
    ;-- Borrar la celda 0,0
    ld b,8
    ld a,0
    ld hl,$4000
clear:
    ld (hl),a
    inc h
    djnz clear

    ;-- Volver a empezar
    call wait
    call wait
    jp start


;----------------------------------------------------------
;-- PIXEL_Y(y)
;--
;-- ENTRADAS:
;--   * HL: Direccion de la memoria de video
;--   * B: Posicion x del pixel (0-7)
;--   * C: Posicion y del pixel (0-7)
;-----------------------------------------------------------
pixely:
    ;-- Valor correspondiente al pixel de la posicion b
    
    call pixel_mask

    ;--- h = h + c
    push aF  ;-- guardar a para no perderlo
    ld a, h
    add a,c
    ld h,a   ;-- h = h + c
    pop af

    ;-- Dibujar pixel (over)
    ld b,a
    ld a,(hl)  ;-- Leer valor actual
    or b       ;-- Añadir nuevo pixel
    ld (hl), a

    ret
 


;-----------------------------------------------------------
;-- PIXEL_MASK(x): Devolver la máscara de pixel a escribir en la
;--   memoria de video de la posición x (0-7)
;--
;-- ENTRADAS:
;--   * HL: Direccion de la memoria de video
;--   * B: Posicion x del pixel (0-7) en el scanline 0 de la celda
;--
;-- DEVUELVE:
;--   * A: Valor a escribir en la memoria de video
;-----------------------------------------------------------------
pixel_mask:
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
    ;-- Devolverlo
    ret


pos0:
    ;-- Valor a escribir en memoria video
    ld a, $80
    ret

;----------------------------------
;-- Esperar N frames...
;-- Cada frame son 20ms aprox...
;----------------------------------
wait:
    halt  ;-- 20 ms
    halt  ;-- 20 ms
    halt  ;-- 20 ms
    halt  ;-- 20 ms
    halt  ;-- 20 ms
    ret

    end $8000
