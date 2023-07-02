;----------------------------------------------------------------------------
;-- Ejemplo de uso de la rutina LOCATE
;----------------------------------------------------------------------------

;--- Puerto para establecer el color del Borde
BORDER: EQU $FE

    org $8000

    ;-- Poner el borde amarillo
    ld a, 6
    out (BORDER), a

    ;-- Establecer posicion
    ;-- LOCATE(10,15)
    ld b, 10   ;-- Linea
    ld c, 15   ;-- Col
    call LOCATE

    ;-- Atributos
    ld a, $32  ;-- Color rojo, fondo amarillo
    ld (de), a

    ;-- Imprimir un patron
    ld a, $55
    ld (hl), a
 
    ret


;-------------------------------------------------------------------
;-- VARIABLES DEL SISTEMA
;-------------------------------------------------------------------
;-- DFCC: Contiene la direccion de donde imprimir el siguiente 
;--       caracter
;-------------------------------------------------------------------
DFCC: EQU  $5C84

;---------------------------------------------------------------------------
;-- LOCATE: Devolver la localizacion de una celda (LINEA, COL)
;--         la almacena en DFCC, devuelve la dir. de sus atributos
;--         y los atributos 
;-         
;-- ENTRADAS:
;--    * B: Linea (0-21)
;--    * C: Col (0-31)
;--
;-- SALIDA:
;--    * HL: Direccion memoria video
;--    * DE: Direccion de los atributos
;--    * A: Attributos ATTR(B,C)
;---------------------------------------------------------------------------
LOCATE:
    ld a,b   ;  A = 000TTLLL (Linea)

    ;-- Aislar el tercio (TT)
    and $18  ; 18 = 00011000
             ;  A = 000TT000

    ;-- Establecer H para apuntar a la memoria video
    ld h, a
    set 6, h ;  H = 010TT000

    ;-- Establecer D para apuntar a memoria atributos
    rrca     ;  A = 0000TT00
    rrca     ;  A = 00000TT0
    rrca     ;  A = 000000TT
    or $58   ; 58 = 01011000
             ;  A = 010110TT
    ld d,a

    ld a, b   ;  A = 000TTLLL (Linea)
    and 7     ;  7 = 00000111
              ;  A = 00000LLL
    rrca      ;  A = L00000LL
    rrca      ;  A = LL00000L
    rrca      ;  A = LLL00000
    add a,c   ;  A = LLLCCCCC

    ;-- HL Listo
    ld l,a

    ;-- DE Listo
    ld e,a 

    ;-- A = Atributos
    ld a, (de)

    ;-- Guardar HL en variable sistema
    ld (DFCC), hl
    
    ;-- Terminar
    ret


    end $8000
