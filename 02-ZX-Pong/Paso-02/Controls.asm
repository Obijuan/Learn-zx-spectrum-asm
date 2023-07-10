;--- Puerto del teclado
TECLADO EQU $FE

;-- Semifila 1. Teclas: CAPS Z X C V
;-- b4  b3  b2  b1  b0
;--  V  C   X   Z   CAPS
SFILA_CAPS_V EQU $FE
  KEY_Z  EQU  $01

;-- Semifila 2: Teclas: A S D F G
;-- b4  b3  b2  b1 b0
;--  G   F   D  S   A
SFILA_AG EQU $FD
  KEY_A  EQU $00  ;-- Mascara para tecla A

;-- Semifila 5: Teclas: 6 7 8 9 0
;-- b4  b3  b2  b1  b0
;--  6   7   8   9    0
SFILA_6_0 EQU $EF
  KEY_0  EQU $00

;-- Semifila 6: Teclas P O I U Y
;-- b4  b3  b2  b1  b0
;--  Y   U   I   O   P
SFILA_P_Y EQU $DF
  KEY_O EQU $01 

;-- Mascara de los bits en el registro D
;-- Para la lectura de las teclas
BIT_A EQU $00   ;-- Bit para la tecla A
BIT_Z EQU $01   ;-- Bit para la tecla Z
BIT_0 EQU $02   ;-- Bit para la tecla 0
BIT_O EQU $03   ;-- Bit para la tecla O

;----------------------------------------------------------------------------
;-- ScanKeys:
;--
;-- Registro D:
;--  b4 b3 b2 b1 b0
;--           Z   A
;--- Bit a 1: Tecla pulsada
;--  Bit a 0: NO pulsada
;----------------------------------------------------------------------------
ScanKeys:
    ld d, 0  ;-- Registro D a 0

ScanKeys_A:
    ld a, SFILA_AG     ;-- Semifila donde esta la tecla A
    in a, (TECLADO)    ;-- Leer teclado!
    bit KEY_A, a       ;-- Comprobar si Bit tecla A esta a 0
    jr nz, ScanKeys_Z  ;-- Tecla A NO pulsada... pasar a la siguiente

    ;-- Tecla A pulsada
    ;-- Activar el flag de D correspondiente
    set BIT_A, d

    ;-- Continuar el scaneo...
ScanKeys_Z:
    ld a, SFILA_CAPS_V
    in a, (TECLADO)
    bit KEY_Z, a
    jr nz, ScanKeys_0

    ;-- Tecla Z pulsada
    ;-- Activar el flag de D correspondiente
    set BIT_Z, d

    ;-- Comprobacion de las dos teclas A-Z a la vez
    ld a, d
    sub $03
    jr nz, ScanKeys_O  ;-- NO se ha pulsado a la vez
    ld d, a   ;-- Poner D a 0

ScanKeys_0:
    ld a, SFILA_6_0
    in a, (TECLADO)
    bit KEY_0, a
    jr nz, ScanKeys_O

    ;-- Tecla 0 pulsada
    ;-- Activar el flag de D correspondiente
    set BIT_0, d

ScanKeys_O:
    ld a, SFILA_P_Y
    in a, (TECLADO)
    bit KEY_O, a
    ret nz

    ;-- Tecla O pulsada
    ;-- Activar el flag de D correspondiente
    set BIT_O,d

    ;-- Comprobar las dos teclas 0-O
    ld a, d
    and $0c  ;-- Aislar los bits de 0 y O
    cp $0c   ;-- Comprobar si las dos teclas se ha pulsado a la vez
    ret nz
    ld a, d  ;-- Se han pulsado...
    and $03  ;-- Quedarse con los bits de A y Z
    ld d, a 

    ret

