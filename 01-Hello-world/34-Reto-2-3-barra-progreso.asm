;---------------------------------------------------------------------------
;-- Reto 2-3: Animacion Barra de progres de 8 posiciones
;---------------------------------------------------------------------------

    org $8000


    ;-- Esperar a que el frame actual termine
    halt

    ;-- Fijar los atributos de la primera celda
    ;-- Fondo: blanco, tinta: roja
    ld a, $3a
    ld ($5800),a

start:
    ;-- La animación comienza con una barra de progreso nula
    ld a, 0
    ld ($4000),a
    call wait_100ms

    ;-- Para mover la bara usamos un bucle que comienza con el valor 0x80
    ;-- y aplicando desplazamientos aritmeticos a la derecha aparecen
    ;-- el resto de piexeles: 10000000 -> 11000000 -> 11100000 ->...
    ;--    -> 11111110 -> 11111111
    ;-- Si hacemos un desplazamiento más el Flag de C se pone a 1

    ;-- Valor inicial: 0x80
    ld a, $80

bucle:

    ;-- Mostrar pixel en posicion actual
    ld ($4000), a
    call wait_100ms

    ;-- Desplazar A un bit a la derecha 
    ;-- Desplazamiento aritmetico (el bit de signo se conserva)
    sra a

    ;-- Si el desplazamiento se ha completado,
    ;-- lo inicializamos
    jr nc,bucle

    ;-- Proceso completado.
    ;-- Repetimos desde la barra de progreso nula
    ;-- Esperamos un poco mas de tiempo para mostrar que ha finalizado
    call wait_100ms
    call wait_100ms
    call wait_100ms
    jr start

;---------------------------------------------------------------------------------
;-- Wait 100ms
;--
;--  Se espera a que lleguen 5 frames. Cada frame llega a los 20ms, por lo que
;--  se hace una espera de unos 100ms
;---------------------------------------------------------------------------------
wait_100ms:

    halt  ;-- 20ms
    halt  ;-- 20ms
    halt  ;-- 20ms
    halt  ;-- 20ms
    halt  ;-- 20ms
    ret 

    end $8000
