;
; A simple boot sector program that loops forever
;

loop: jmp loop		; Infinite loop

times 510-($-$$) db 0	; When compiled, our program must fit into
			; 512 bytes with the last two bytes being the
			; magic number, so here, tell our assembler
			; to pad out out our program with enough zero
			; bytes (db 0) to bring us to the 510th byte.

dw 0xaa55		; Last two bytes (one word form the magic number
			; so BIOS knows we are a boot sector.