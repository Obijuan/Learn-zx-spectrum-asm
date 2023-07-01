;-----------------------------------------------------------------------------
;-- Hola mundo final: Se cambia el color de la pantalla y se imprime
;-- un mensaje en la parte central
;-----------------------------------------------------------------------------

    ;--- Puerto a escribir para cambiar el color
    ;--- del borde
BORDER: EQU $FE


;------------------------------------
;--- VARIABLES DEL SISTEMA
;------------------------------------

;-- Atributos permanentes del sistema. Es lo que se usa cuando se llama 
;-- a CLS
;-- Formato:  Flash, Bright, paper (3-bits), ink (3-bits)
ATTR_S: EQU $5C8D

;-- Atributos de las impresiones actuales
ATTR_T: EQU $5C8F


;-------------------------------------------------------------
;-- RUTINAS DE LA MEMORIA ROM
;-------------------------------------------------------------

;-------------------------------------------------
;-- Rutina de CLS
;-- Altera el valor de los registros AF, BC, DE Y HL
;----------------------------------------------------
CLS: EQU $0DAF

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



    org $8000

    ;--- Cambiar el borde a color azul
    ld a, 1
    out (BORDER), a

    ;-- Establecer atributos del sistema y actuales
    ld a, $0e
    ld hl, ATTR_T
    ld (hl), a

    ld hl, ATTR_S
    ld (hl), a

    ;-- Limpiar la pantalla
    CALL CLS

    ;-- Situarse en (10, 2)
    ld b, 24 - 10
    ld c, 33 - 2
    call LOCATE

    ;-- Imprimir el mensaje en la pantalla
    ld hl, msg

bucle:
    ld a, (hl)    ;-- Leer caracter
    or a          ;-- Comprobar si a = 0
    jr z, fin     ;-- Si es 0, terminar

    ;--Imprimir caracter
    rst $10

    ;-- Apuntar al siguiente
    inc hl

    ;-- Repetir
    jr bucle

fin:

    ;-- Terminar
inf: jr inf

msg: defm "Hola ensamblador zx Spectrum", $00


    end $8000
