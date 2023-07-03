;---------------------------------------------------------------------------
;-- Reto 1-10: Bandera cyan-amarilla, de 8x4
;---------------------------------------------------------------------------

    org $8000

    ;-- El sprite a dibujar ocupa 4bits de la primera celda, con atributos
    ;-- de tinta cyan y fondo blanco y 4 bits de la segunda celda, con
    ;-- atributos de tinta amarilla y fondo blanco
    ;-- Este es el sprite en blanco y negro:
    ;--
    ;-- Celda 0   Celda 1
    ;--
    ;-- 00001111  11110000  = 0F F0
    ;-- 00001111  11110000  = 0F F0
    ;-- 00001111  11110000  = 0F F0
    ;-- 00001111  11110000  = 0F F0

    ;-- El byte bajo de las direcciones (LLLCCCCC) es 00 ya que es la primera
    ;-- linea (0) y columnas 0 y 1
    ;-- El byte alto es: 01000SSS, con scanlines de 000,001,010,011
    ;-- Direcciones:
    ;--   $4000 $4001
    ;--   $4100 $4101
    ;--   $4200 $4200
    ;--   $4300 $4300
    ld hl, $F00F
    ld ($4000), hl
    ld ($4100), hl
    ld ($4200), hl
    ld ($4300), hl
    
    ;-- Atributos. Parte cyan
    ;-- 00 111 101 = 0011 1101 = 3D

    ;-- Atributos. Parte amarilla
    ;-- 00 111 110 = 0011 1110 = 3E
    ld hl,$3e3d
    ld ($5800), hl

    ;-- Bucle infinito
inf:
    jr inf

    end $8000
