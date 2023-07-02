;----------------------------------------------------------------------------
;-- Ejemplo de uso de la rutina ATTLOC
;-- Cambio de atributos de varias localizaciones
;----------------------------------------------------------------------------

;--- Puerto para establecer el color del Borde
BORDER: EQU $FE

    org $8000

    ;-- Poner el borde amarillo
    ld a, 6
    out (BORDER), a

    ;-- Establecer ATTR(0,0)
    ld b,0  ;-- Linea
    ld c,0  ;-- Col
    call ATTLOC

    ;-- Fijar el atributo
    ;-- Fondo azul, tinta blanca
    ld a, $0F
    ld (hl),a

    ;-- Establecer ATTR(1,1)
    ld b,1  ;-- Linea
    ld c,1  ;-- Col
    call ATTLOC

    ;-- Fijar el atributo
    ;-- Fondo azul, tinta blanca
    ld a, $0F
    ld (hl),a

    ;-- Establecer ATTR(21,31)
    ld b,21  ;-- Linea
    ld c,31  ;-- Col
    call ATTLOC

    ;-- Fijar el atributo
    ;-- Fondo azul, tinta blanca
    ld a, $0F
    ld (hl),a


    ret

;---------------------------------------------------------------------------
;- ATTLOC: Devolver la memoria de video de atributos asociada a la
;-         posicion (LINEA, COL)
;-
;-- ENTRADAS:
;--    * B = Linea (0-23)
;--    * C = Col (0 - 31)
;--
;-- SALIDA:
;--    * HL: Direccion de video de atributos
;--
;---------------------------------------------------------------------------
ATTLOC:

    ld a,b   ;-- A = Linea (000TTLLL)

    ;-- Obtener los bits asociados al tercio
    sra a      ;-- A = 0000TTLL
    sra a      ;-- A = 00000TTL
    sra a      ;-- A = 000000TT

    ;-- Añadir comienzo de memoria de atributos (0x5800)
    add a,$58  ;-- 58  01011000
               ;-- A = 010110TT

    ;-- Ya tenemos H listo
    ld h,a 

    ;-- Leer la linea de nuevo
    ld a,b   ;-- A = 000TTLLL

    ;-- Aislar el campo LLL
    and $7   ;   7 = 00000111
             ;   A = 00000LLL

    ;-- Colocar LLL en los bits e mayor peso
    rrca     ;   A = L00000LL
    rrca     ;   A = LL00000L
    rrca     ;   A = LLL00000

    ;-- Añadir la columna
    add a,c  ;   A = LLLCCCCC

    ;-- Ya tenemos L listo
    ld l,a

    ;-- Terminar
    ret


    end $8000