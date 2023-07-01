;-----------------------------------------------------------------------------
;-- Impresion del caracter 'A' en cada esquina de la pantalla, usando
;-- la rutina ROM de locate
;-----------------------------------------------------------------------------

    ;--- Puerto a escribir para cambiar el color
    ;--- del borde
BORDER: EQU $FE

;-------------------------------------------------------------
;-- RUTINAS DE LA MEMORIA ROM
;-------------------------------------------------------------

;-------------------------------------------------------
;-- LOCATE: Posicionar el cursor (x,y)
;--
;-- ENTRADA: 
;--    B : Coordenada y
;-     C : Coordenada X
;--
;--  Esquina superior izquierda: (y=24, x=33)
;--  Esquina superior derecha: (y=24, x=2)
;--  Esquina inferior izquierda (y=3, x=33)
;--  Esquina inferior derecha: (y=3, x=2)
;-------------------------------------------------------
LOCATE: EQU $0DD9


;-----------------------------------
;-- MAIN
;-----------------------------------
    org $8000

    ;-- Poner borde Azul
    ld a, 1
    out (BORDER), a

    ;-- Caracter en la esquina superior izquierda (0, 0)
    ld b, 24 - 0
    ld c, 33 - 0
    call LOCATE

    ld a, 'A'
    rst $10

    ;-- Esquina superior derecha (0, 31)
    ld b, 24 - 0
    ld c, 33 - 31
    call LOCATE

    ld a, 'A'
    rst $10

    ;-- Esquina inferior izquierda (21, 0)
    ld b, 24 - 21
    ld c, 33 - 0
    call LOCATE

    ld a, 'A'
    rst $10

    ;-- Esquina inferior derecha (21, 31)
    ld b, 24 - 21
    ld c, 33 - 31
    call LOCATE

    ld a, 'A'
    rst $10


    ;-- Terminar
    ;-- (bucle infinito)
inf: jr inf

    end $8000