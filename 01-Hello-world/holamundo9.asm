;-----------------------------------------------------------------------------
;-- Ejemmplo de borrado de la pantalla llamando a la rutina ROM CLS
;-----------------------------------------------------------------------------

;------------------------------------
;--- VARIABLES DEL SISTEMA
;------------------------------------

;-- Atributos permanentes del sistema. Es lo que se usa cuando se llama 
;-- a CLS
;-- Formato:  Flash, Bright, paper (3-bits), ink (3-bits)
ATTR_S: EQU $5C8D

;-------------------------------------------------
;-- Rutina de CLS
;-- Altera el valor de los registros AF, BC, DE Y HL
;----------------------------------------------------
CLS: EQU $0DAF


    org $8000

    ;-- Establecer los atributos permanentes
    ld a, $0e      ;-- Paper=1 (azul) ink = 6 (amarillo?)
    ld hl, ATTR_S
    ld (hl), a 

    ;-- Borrar la pantalla
    CALL CLS

    ;-- Terminar
    ret

    end $8000