;---------------------------------------------------------------------------
;-- Dos partículas confinadas en las celdas (0,0) y (1,0)
;---------------------------------------------------------------------------

;--- Constantes de acceso para las entidades
POSX EQU 0
POSY EQU 1
VX   EQU 2
VY   EQU 3
CXMIN EQU 4
CXMAX EQU 5
CYMIN EQU 6
CYMAX EQU 7 

;-- Puerto para cambiar el color del borde
BORDER: EQU $FE

    org $8000

    ;-- Poner borde amarillo para ver mejor la posicion
    ;-- de los píxeles
    ld a, 6
    out (BORDER), a

bucle:
    ;------ Particula 1
    ld ix, particula1
    call move_particle

    ;------ Particula 2
    ld ix, particula2
    call move_particle

    ;-- Esperar a que termine el frame
    call wait

    ;-- Repetir
    jr bucle


;------------------------------------------
;-- MOVE_PARTICLE: Mover la particula
;--  
;-- ENTRADA:
;--   * IX: Puntero a la particula a mover
;-------------------------------------------
move_particle:

    ;-- Borrar pixel
    ld b, (ix + POSX)
    ld c, (ix + POSY)
    call plot_clear

    ;-- Comprobar colision
    call check_colision

    ;-- Actualizar posicion
    call update_particle

    ;-- Dibujar la particula
    ld b, (ix + POSX)
    ld c, (ix + POSY)
    call plot_set

    ret


;---------------------------------------------------------------------
;-- UPDATE_PARTICLE:  Actualizar la particula indicada por IX
;--   Se actualiza su posicion acorde a la velocidad y se comprueban
;--   las colisiones
;--  
;-- ENTRADAS:
;--   * IX: Puntero a la entidad a comprobar
;---------------------------------------------------------------------
update_particle:
    ld a, (ix + POSX)
    ld b, (ix + VX)
    add a,b   ;-- x = x + vx
    ld (ix + POSX), a

    ld a, (ix + POSY)
    ld b, (ix + VY)
    add a,b   ;-- y = y + vy
    ld (ix + POSY), a
    ret

;-----------------------------------------------------------------
;-- CHECK_COLISION: Comprobar la colision de la particula con los
;--   limites. Si hay colision se cambia el sentido de la velocidad
;--
;-- ENTRADAS:
;--    * IX: Puntero a la entidad a comprobar
;------------------------------------------------------------------
check_colision:

    ;---------- COMPROBAR COLISION EN EJE X -----------------------
    ;-- Comprobar colisión por la derecha
    ld a, (ix + POSX)   ;-- Leer x actual
    ld b, (ix + CXMAX)  ;-- Leer xmax
    cp b  ;-- x==xmax?
    jr z, rebotex

    ;-- Comprobar colision por la izquierda
    ld a, (ix + POSX)
    ld b, (ix + CXMIN)  ;-- Leer xmin
    cp b  ;-- x==xmin?
    jr z, rebotex

    ;---------- COMPROBAR COLISION EN EJE Y -----------------------
    ;--- Comprobar colision por abajo
    ld a, (ix + POSY)   ;-- Leer y actual
    ld b, (ix + CYMAX)  ;-- Leer ymax
    cp b   ;  y==ymax?
    jr z, rebotey

    ;--- Comprobar colision por arriba
    ld a, (ix + POSY)
    ld b, (ix + CYMIN)  ;-- Leer ymin
    cp b   ;  y == ymin?
    jr z, rebotey

    ret

rebotex:
    ;-- Hay colision por la derecha
    ;-- Cambiar el sentido de la velocidad: rebote
    ld a, (ix + VX)
    neg
    ld (ix + VX), a
    ret

rebotey:
    ;-- Hay colision por abajo
    ;-- Cambiar el sentido de la velocidad: rebote
    ld a, (ix + VY)
    neg
    ld (ix + VY), a
    ret


;-- Informacion sobre las particulas
;----------------------------------------------
;-- PARTICULA 1
;----------------------------------------------
particula1:
    defb 1  ; Posicion x
    defb 4  ; Posicion y
    defb 1  ; Velocidad en x 
    defb 1  ; Velocidad en y

;-- Datos de las coliciones
    defb 0  ; xmin
    defb 8  ; xmax
    defb 0  ; ymin
    defb 8  ; ymax

;----------------------------------------------
;-- PARTICULA 2
;----------------------------------------------
particula2:
    defb 10  ; Posicion x
    defb 5  ; Posicion y
    defb -1  ; Velocidad en x 
    defb -1  ; Velocidad en y

;-- Datos de las coliciones
    defb 8  ; xmin
    defb 16  ; xmax
    defb 0  ; ymin
    defb 8  ; ymax

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

