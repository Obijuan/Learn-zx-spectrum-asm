;----------------------------------------------------------------------------
;-- Ejemplo de uso de la rutina DF-ATT
;----------------------------------------------------------------------------

;--- Puerto para establecer el color del Borde
BORDER: EQU $FE

    org $8000

    ;-- Poner el borde amarillo
    ld a, 6
    out (BORDER), a

    ;-- Escribir un caracter en una posicion cualquiera
    ld hl, $4034
    ld a, $aa
    ld (hl), a

    ;-- Cambiar los atributos de ese caracter
    call DF_ATT  ;-- Obtener direccion de los atributos
    ld a, $11
    ld (de), a   ;-- Establecer atributos para el caracter

    ret

;---------------------------------------------------------------------------
;- DF-ATT: Convertir la dirección de video a dirección de attributos
;-         
;-- ENTRADAS:
;--    * HL = Direccion de memoria de video
;--
;-- SALIDA:
;--    * DE: Direccion de memoria de atributos
;---------------------------------------------------------------------------
DF_ATT:
    ;-- Aislar el tercio
    ld a,h    ;--  A = 010TTSSS
    rrca      ;--  A = S010TTSS
    rrca      ;--  A = SS010TTS
    rrca      ;--  A = SSS010TT
    and 3     ;--  3 = 00000011
              ;--  A = 000000TT

    ;-- Añadir el prefijo de la direccion de los atributos
    or $58    ;-- 58 = 01011000
              ;--  A = 010110TT

    ;-- Devolver la direccion en DE
    ld d,a 
    ld e,l
    
    ;-- Terminar
    ret


    end $8000