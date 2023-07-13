;----------------------------------------------------------------------------
;-- RUTINAS DE TECLADO
;----------------------------------------------------------------------------

;-----------------------------------------------------------------------
; Wait_key_pressed: Esperar hasta que se pulse una tecla cualquiera
;-----------------------------------------------------------------------
Wait_Key_Pressed:
    xor a             ; A = 0
    in a, (KEY_PORT)  ;-- Leer teclado
    or $E0            ;-- 1110 0000  ;-- Activar resto de bits
    inc a             ;-- Si no pulsado, inc a --> A=0
    jr z, Wait_Key_Pressed  ;-- No hay tecla pulsada. Esperar...

    ;-- Fin: No se devuelve la tecla pulsada...
    ret
 

;-----------------------------------------------------------------------
; Esta rutina espera a que no haya ninguna tecla pulsada para volver,
; consultando las diferentes filas del teclado en un bucle.
;-----------------------------------------------------------------------
Wait_Key_Released:
 XOR A
 IN A, ($FE)
 OR 224
 INC A
 JR NZ, Wait_Key_Released
 RET

;----------------------------------------------------------------------
;-- Esperar a que una tecla se pulse y luego se libere
;----------------------------------------------------------------------
Wait_Key:
    call Wait_Key_Pressed
    call Wait_Key_Released
    ret
