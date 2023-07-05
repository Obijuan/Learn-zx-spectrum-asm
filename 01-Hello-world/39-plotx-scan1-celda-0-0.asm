;---------------------------------------------------------------------------
;-- Experimento. Dibujo de un pixel en el primer scanline de la celda (0,0)
;-- Para probar la rutina plotx() se hace una animación del pixel, moviéndose
;-- entre las posiciones 0 y 7 de la celda (0,0) (Esquina superior izquierda)
;---------------------------------------------------------------------------

;-- Puerto para cambiar el color del borde
BORDER: EQU $FE

    org $8000

    ;-- Poner borde amarillo para ver mejor la posicion
    ;-- de los píxeles
    ld a, 6
    out (BORDER), a
 
    ;-- Entrada: HL: Memoria de video
    ld hl, $4000  ;-- Celda (0,0)

    ;-- Entrada B = Posicion del pixel (0-7)
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

    ;-- La posicion queremos que sea siempre modulo 8 
    ;-- (entre 0 y 7)
    ld a,b
    and 7
    ld b,a

    ;-- Repetir
    jr bucle



;-----------------------------------------------------------
;-- PLOTX(HL,pos)
;--
;-- ENTRADAS:
;--   * HL: Direccion de la memoria de video
;--   * B: Posicion del pixel (0-7) en el scanline 0 de la celda
;-----------------------------------------------------------------
plotx:
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
    ld (hl), a
    jr fin


pos0:
    ;-- Valor a escribir en memoria video
    ld a, $80
    ld (hl), a


fin:
    ret

;----------------------------------
;-- Esperar N frames...
;-- Cada frame son 20ms aprox...
;----------------------------------
wait:
    halt  ;-- 20 ms
    halt
    halt
    halt
    halt
    ret

    end $8000
