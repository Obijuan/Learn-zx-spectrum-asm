;----------------------------------------------------------------------------
;-- Prueba de la subrutina CLS-DF
;----------------------------------------------------------------------------

;--- Puerto para establecer el color del Borde
BORDER: EQU $FE


    org $8000

    ;-- Poner el borde amarillo
    ld a, 6
    out (BORDER), a

    ;-- Borrar todos los tercios
    call CLS_DF

    ;-- No retornamos para que se vea la pantalla limpia
inf:
    jr inf


;---------------------------------------------------------------------------
;- CLS_DF: Borrar la pantalla
;---------------------------------------------------------------------------
CLS_DF:

    ld hl, $4000   ;-- Puntero al comienzo memoria video

    ;-- Indicar cuantos bytes por encima hay que rellenar
    ;-- Queremos llegar hasta la dir $57FF ($4000 + 17FF)
    ld bc, $17FF
    ;-- Byte a usar de relleno: 0
    ;-- Se podria usar: LD (HL), 0 PERO como L es 0, es más rápido
    ;-- (y ocupa menos) esta instruccion LD (HL),L
    ld (hl), l

    ;-- En DE ponemos la direccion destino para copiar de ($4000)
    ;-- a ($4001)
    ld d,h
    ld e,1

    ;-- La instrucción ldir repite esta operación BC veces
    ;-- (Incrementa DE y HL, y decrementa BC hasta que llega a 0)
    ldir 

    ;-- Terminar
    ret

    end $8000