;-------------------------------------------------------------
;-- Prueba de movimiento de una bala pixel a pixel
;-- Se mueve de izquierda a derecha
;-------------------------------------------------------------

;-- Puerto de salida para cambiar el borde
BORDER: EQU $FE

;-- Sprite de la bala: 01111110 (8x1)
SBALA: EQU $7E

    org $8000

    ;-- Cambiar el borde a amarillo
    ld a, $06
    out (BORDER), a

    ;-- RETO: Mover el sprite 8x1 pixel a pixel hacia la derecha
    ;-- Cordenada x: CCCCCPPP
    ;--     C: Bit de columna
    ;--     P: Pixel: Indica el numero de pixel dentro de la columna

    ;-- Posicion inicial: x = 0
    ld b, 0

    push bc

bucle:

    ;-- Recuperar posicion x
    pop bc
    push bc

    ;-- Obtener memoria de video
    call get_videoRam
    jr z, pos_exacta

    ;-- Posicion NO exacta. El sprite se divide en dos partes
    ;-- segmento izquierdo (escribir en HL) y segmento derecho
    ;-- (escribir en HL+1)

    ;-- A = PPP (A partir de ahora R). Posicion de pixel
    ;--   Lo denominamos ROTACION

    ;-- Seg izdo   Seg. Der  
    ;-- XXXXXXXX   00000000    (R=0)  (Posicion exacta)
    ;-- 0XXXXXXX   X0000000    (R=1)
    ;-- 00XXXXXX   XX000000    (R=2)
    ;-- 000XXXXX   XXX00000    (R=3)
    ;-- 0000XXXX   XXXX0000    (R=4)
    ;-- 00000XXX   XXXXX000    (R=5)
    ;-- 000000XX   XXXXXX00    (R=6)
    ;-- 0000000X   XXXXXXX0    (R=7)

    ;-------- Calcular segmento izquierdo
    ;-- Hay que desplazar el sprite A bits hacia la derecha 

    ;-- B = Numero de bits a desplazar hacia la derecha
    ld b,a
    ld d,b  ;-- Guardar B tambien en D para recuperarlo luego

    ;-- Leer el sprite
    ld a, SBALA

    ;-- Desplazar B bits a la derecha
rot:
    sra a

    ;-- Eliminar bit de signo
    and $7F

    djnz rot

    ;-- Escribir el segmento izquierdo en memoria video
    ld (hl), a

    ;------- Calcular segmento derecho
    ;-- Partimos de la mascara $80 y la vamos desplazando
    ;-- a la derecha, obteniendo: 10000000, 11000000... 11111111
    ;-- A la vez rotamos el sprite y aplicamos la máscara al final

    ;-- En total hay que hacer A desplazamientos a la derecha
    ;-- Usamos B para el bucle
    ld b,d   ;-- Numero de repeticiones 

    ;-- Leer el sprite
    ld a, SBALA

    ;-- En c metemos la mascara inicial
    ld c,$80

rot2:
    rrca   ;-- Rotar el sprite 1-bit a la derecha
    sra c  ;-- Desplazar la mascara
    djnz rot2

    ;-- Aplicar la mascara
    and c

    ;-- Escribir el segmento derecho en HL+1
    inc l
    ld (hl), a
    dec l  ;-- Dejar l como estaba

    ;-- Esperar
    halt
    ;call wait
    ;call wait
    ;call wait

    ;-- Incrementar posicion x
    pop bc
    inc b

    ;-- Guardar posicion
    push bc

    ;-- Repetir
    jr bucle


pos_exacta:
    pop bc

    ;-- Escribir el sprite tal cual
    ld a,$7E
    ld (hl),a

    inc b
    push bc

    jr bucle

wait:
    halt
    halt
    halt
    halt
    halt
    ret

;--------------------------------------------------------------
;-- Get_videoRAM: Obtener la direccion de memoria correspondiente
;--   a la direccion de pixel (x,0), con x entre 0 y 255
;--
;-- ENTRADA:
;--  * B: Posicion x (pixel, entre 0-255) Formato: CCCCCPPP
;--
;-- SALIDA:
;--  * HL: Direccion memoria de video
;--  * A: Campo PPP
;--  * Z: Posicion exacta (multiplo de 8 pixeles)
;--  * NZ: Posicion intermedia (no multiplo 8)
;-----------------------------------------------------------------
get_videoRam:
    ;-- Parte alta de la memoria de video
    ld h, $47

    ;-- Obtener campo CCCCC en l
    ld a,b     ;-- A = CCCCCPPP

    ;-- Desplazar 3 posiciones a la derecha para eliminar PPP
    rrca       ;-- A = PCCCCCPP
    rrca       ;-- A = PPCCCCCP
    rrca       ;-- A = PPPCCCCC
    and $1F    ;-- A = 000CCCCC

    ;-- HL tiene la direccion final
    ld l,a     ;-- L = 000CCCCC

    ;-- Obtener campo PPP en A
    ld a,b     ;-- A = CCCCCPPP
    and $07    ;-- 7 = 00000111
               ;-- A = 00000PPP

               ;-- Flag Z activado si es posicion exacta
    ret

    end $8000
