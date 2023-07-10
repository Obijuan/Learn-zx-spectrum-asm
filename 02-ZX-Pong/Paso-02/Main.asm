
    org $8000

    ;-- HL direccion esquina superior izquierda del video
    ld hl, $4000

bucle:
    call ScanKeys
    ld (hl), d
    jr bucle

    include "Controls.asm"
    end $8000
