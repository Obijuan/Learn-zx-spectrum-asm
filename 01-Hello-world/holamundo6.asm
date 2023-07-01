;-----------------------------------------------------------------------------
;-- Impresion del caracter 'A' en cada esquina de la pantalla, usando
;-- la rutina ROM de locate
;-----------------------------------------------------------------------------

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

    ;-- Caracter en la esquina superior izquierda (24, 33)
    ld b, 24
    ld c, 33
    call LOCATE

    ld a, 'A'
    rst $10

    ;-- Esquina superior derecha (24, 2)
    ld b, 24
    ld c, 2
    call LOCATE

    ld a, 'A'
    rst $10

    ;-- Esquina inferior izquierda (3, 33)
    ld b, 3
    ld c, 33
    call LOCATE

    ld a, 'A'
    rst $10

    ;-- Esquina inferior derecha (3, 2)
    ld b, 3
    ld c, 2
    call LOCATE

    ld a, 'A'
    rst $10


    ;-- Terminar
    ;-- (bucle infinito)
inf: jr inf



    end $8000