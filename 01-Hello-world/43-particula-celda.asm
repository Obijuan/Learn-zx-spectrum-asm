;---------------------------------------------------------------------------
;-- Pruebas de plot(x,y) en diferentes puntos
;---------------------------------------------------------------------------

;-- Puerto para cambiar el color del borde
BORDER: EQU $FE

    org $8000

    ;-- Poner borde amarillo para ver mejor la posicion
    ;-- de los píxeles
    ld a, 6
    out (BORDER), a

    ld b,0 ;-- x
    ld c,4 ;-- y

    call plot_set

bucle:
    call wait

    ;-- Borrar pixel
    call plot_clear

    ;----------------------------------------
    ;-- Actualizar posicion horizontal (x)
    ;----------------------------------------
    ;-- Calcular la nueva posicion del pixel segun la velocidad vx
    ld a, (vx)
    add a,b

    ;-- Comprobar colision a la derecha
    cp 8
    jr nz, continue

    ;-- Colision!
    ;-- Cambiar el signo de la velocidad
    ld a, (vx)
    neg
    ld (vx), a  ;-- Guardar nueva velocidad
    add a,b     ;-- Calcular nueva posicion

continue:

    ;-- Actualizar a la nueva posicion
    ld b,a  ;--- B = B + vx

    ;-- Comprobar colision a la izquirda
    or a  ; a=0?
    jr nz, continue2
    
    ;-- Colision!
    ;-- Cambiar signo de la velocidad
    ld a, (vx)
    neg
    ld (vx), a
    add a,b

continue2:

    ;----------------------------------------
    ;-- Actualizar posicion vertical (y)
    ;----------------------------------------
     ;-- Calcular la nueva posicion del pixel segun la velocidad vy
    ld a, (vy)
    add a,c

    ;-- Comprobar colision inferior
    cp 8
    jr nz, continue3

    ;-- Colision!
    ;-- Cambiar el signo de la velocidad
    ld a, (vy)
    neg
    ld (vy), a  ;-- Guardar nueva velocidad
    add a,c     ;-- Calcular nueva posicion

continue3:

     ;-- Actualizar a la nueva posicion
    ld c,a  ;--- B = B + vy

    ;-- Comprobar colision a la izquirda
    or a  ; a=0?
    jr nz, continue4
    
    ;-- Colision!
    ;-- Cambiar signo de la velocidad
    ld a, (vy)
    neg
    ld (vy), a
    add a,c

continue4:

    ;-- Dibujar el pixel
    call plot_set

    jr bucle

;-- Velocidad
vx: defb 1 
vy: defb 1

;-----------------------------------------------------------
;-- plot_clear (x,y): Borrar un pixel de la pantalla
;--
;-- ENTRADAS:
;--   * B: Coordenada x (0-255)
;--   * C: Coordenada y (0-192)
;------------------------------------------------------------
plot_clear:
    ;-- Guardar posicion del pixel
    push bc

    ;-- Dejar en HL la direccion de la memoria de video 
    ;-- asociada a la posicion B=x, C=y
    call get_videoRam

    ;-- Recuperar posicion del pixel
    pop bc
    push bc ;-- Volver a guardarla, para luego

    ;-- Obtener la máscara del pixel
    call pixel_mask
    xor $FF

    ;-- Escribir el pixel!!
    ;-- Modo OVER
    ld d,a
    ld a, (hl) ;-- Leer el valor actual de la memoria
    and d       ;-- Restar el nuevo pixel
    ld (hl),a  ;-- Escribirlo!

    ;-- Recuperar coordenadas
    pop bc


    ret

;-----------------------------------------------------------
;-- plot_set(x,y): Pintar un pixel en pantalla (modo OVER)
;--
;-- ENTRADAS:
;--   * B: Coordenada x (0-255)
;--   * C: Coordenada y (0-192)
;------------------------------------------------------------
plot_set:
   ;-- Guardar posicion del pixel
    push bc

    ;-- Dejar en HL la direccion de la memoria de video 
    ;-- asociada a la posicion B=x, C=y
    call get_videoRam

    ;-- Recuperar posicion del pixel
    pop bc
    push bc ;-- Volver a guardarla, para luego

    ;-- Obtener la máscara del pixel
    call pixel_mask

    ;-- Escribir el pixel!!
    ;-- Modo OVER
    ld d,a
    ld a, (hl) ;-- Leer el valor actual de la memoria
    or d       ;-- Añdir el nuevo pixel
    ld (hl),a  ;-- Escribirlo!

    ;-- Recuperar coordenadas
    pop bc
    ret

;----------------------------------------------------------------------------
;-- GET_VIDEORAM:  Obtener la memoria de video asociada a una posicion 
;--    de pixel
;--
;-- ENTRADAS:
;--    * B: Coordenada x (0-255)
;--    * C: Coordenada y (0-192)
;-- DEVUELVE:
;--    * HL: Direccio de la memoria de video
;---------------------------------------------------------------------------
get_videoRam:
    ;-- HL = Direccion de video = 010TTSSS LLLCCCCC
    ;-- Convertir B y C a dirección en HL
    ;-- B = Coordenada x = CCCCCPPP
    ;-- C = Coordenada y = TTLLLSSS

    ;--------- Aislar campo CCCCC de B
    ld a,b
    ;-- Desplazar tres bits a la derecha
    sra a  ;-- XCCCCCPP
    sra a  ;-- XXCCCCCP
    sra a  ;-- XXXCCCCC
    and $1F  ;-- 000CCCCC
    ld l,a ;-- L = 000CCCCC

    ;-- Aislar LLL en los bits mas significativos
    ld a,c   ;-- TTLLLSSS
    rlca     ;-- TLLLSSS0
    rlca     ;-- LLLSSS00
    and $E0  ;-- LLL00000

    ;-- Añadir campo CCCCC
    or l     ; A = LLLCCCCC
    ld l,a   ;-- L = LLLCCCCC  (Completado!)

    ;-- Aislar y colocar campo TT
    ld a,c   ; TTLLLSSS
    sra a    ; xTTLLLSS
    sra a    ; xxTTLLLS
    sra a    ; xxxTTLLL
    and $18  ; 000TT000
    ld h,a   ; H = 000TT000

    ;-- Aislar campo SSS
    ld a,c      ; A = TTLLLSSS
    and $07     ;     00000SSS
    or h        ;     000TTSSS
    add a, $40  ;     010TTSSS
    ld h,a      ; H = 010TTSSS (Completado!)

    ;-- HL CONTIENE LA DIRECCION
    ret

;-----------------------------------------------------------
;-- PIXEL_MASK(x): Devolver la máscara de pixel a escribir en la
;--   memoria de video de la posición x (0-7)
;--
;-- ENTRADAS:
;--   * B: Posicion x del pixel (0-7) en el scanline 0 de la celda
;--
;-- DEVUELVE:
;--   * A: Valor a escribir en la memoria de video
;-----------------------------------------------------------------
pixel_mask:
    ;-- Si es la posicion 0, se escribe el valor $80 y se termina
    ld a,b
    or a    ;-- Actualizar flag z para comproar si A es 0
    jr z,pos0  ;-- A=0, es la posicion 0

    ;-- NO es la posicion 0
    ;-- Partimos del valor $80 y lo desplazamos B posiciones
    ;-- a la derecha
    ld a, $80

to_pos
    rrca 
    djnz to_pos

    ;-- En A tenemos el valor a escribir en memoria de video
    ;-- Devolverlo
    ret


pos0:
    ;-- Valor a escribir en memoria video
    ld a, $80
    ret


;----------------------------------
;-- Esperar N frames...
;-- Cada frame son 20ms aprox...
;----------------------------------
wait:
    halt  ;-- 20 ms
    halt  
    halt
    halt
    halt
    halt
    ret

    end $8000

