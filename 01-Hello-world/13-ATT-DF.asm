;----------------------------------------------------------------------------
;-- Ejemplo de uso de la rutina ATT-DF
;----------------------------------------------------------------------------

;--- Puerto para establecer el color del Borde
BORDER: EQU $FE

    org $8000

    ;-- Poner el borde amarillo
    ld a, 6
    out (BORDER), a

    ;-- Establecer los atributos de una posicion aleatoria
    ld hl, $5904
    ld a, $11
    ld (hl),a

    ;-- Escribir un valor en esa posicion de video
    call ATT_DF  ;-- Obtener direccion corresponiente en el video
    ld a, $55    
    ld (de), a   ;-- Escribir un patron de pixeles

    ret

;---------------------------------------------------------------------------
;- ATT-DF: Convertir la dirección de atributos a video
;-         
;-- ENTRADAS:
;--    * HL = Direccion de memoria de atributos
;--
;-- SALIDA:
;--    * DE: Direccion de memoria de video
;---------------------------------------------------------------------------
ATT_DF:
    ld a, h    ;--  A = 010TTSSS
    and 3      ;--  3 = 00000011
               ;--  A = 000000SS
    rlca       ;--  A = 00000SS0
    rlca       ;--  A = 0000SS00
    rlca       ;--  A = 000SS000
    or $40     ;-- 40 = 01000000
               ;--  A = 010SS000
    ;-- Meter la direccion de video en DE
    ld d,a
    ld e,l
    
    ;-- Terminar
    ret


    end $8000
