;---------------------------------------------------------------------------
;-- Reto 2-6: Barra de progreso de 32 bits
;---------------------------------------------------------------------------

    org $8000

    ;-- Sincronizarse con las interrupciones
    halt

start:
    ;-- Puntero a la memoria de video
    ld hl, $4000

    ;-- Puntero a la memoria de atributos
    ld de, $5800

    ;-- Numero de celdas totales de la barra
    ld b, 5

next:
    ;-- Meter atributo
    ld a,$39
    ld (de), a

    ;-- Barra de progreso en una celda
    ;-- Meter primer valor
    ld a,$80

loop;
    ld (hl), a
    call wait

    ;-- Desplazar a la derecha
    sra a

    ;-- Repetir hasta completar el progreso en la celda actual
    jr nc,loop

    ;-- Pasar a la siguiente celda
    inc hl

    ;-- Pasar al siguiente atributo
    inc de

    ;-- Repetir hasta completar el tamaño de la celda
    djnz next

    ;-- Esperar un tiempo hasta re-arrancar la barra de progreso
    ld b,20
wait_loop:
    call wait
    djnz wait_loop

    ;-- Borrar la barra de progreso
    ld b,5
    ld hl, $4000

clear_next:
    ld a,0
    ld (hl), a
    inc hl
    djnz clear_next
    
    jp start

;---------------------------------------------------------------------------------
;-- Wait 
;--
;--  Se espera a que lleguen N frames. Cada frame llega a los 20ms, por lo que
;--  se hace una espera de unos 100ms
;---------------------------------------------------------------------------------
wait:

    halt  ;-- 20ms
    ;halt  ;-- 20ms
    ret 

    end $8000
