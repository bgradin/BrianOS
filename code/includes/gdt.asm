;;;; gdt.asm ;;;;
; Defines the global descriptor table

GDTStart:
GDTNull:		; The mandatory null descriptor
dd 0x0			; 'dd' means define double word (4 bytes)
dd 0x0

GDTCode:		; The code segment descriptor
dw 0xffff		; Limit (bits 0-15)
dw 0x0000		; Base (bits 0-15)
db 0x00			; Base (bits 16-23)
db 10011010b		; 1st flags: (present)1 (privilege)00 (descriptor type)1
			; type flags: (code)1 (conforming)0 (readable)1 (accessed)0
db 11001111b		; 2nd flags: (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0
db 0x00			; Base (bits 24-31)

GDTData:		; The data segment descriptor
dw 0xffff		; Limit (bits 0-15)
dw 0x0000		; Base (bits 0-15)
db 0x00			; Base (bits 16-23)
db 10010010b		; type flags: (code)0 (expand down)0 (writable)1 (accessed)0
db 11001111b		; 2nd flags, Limit (bits 16-19)
db 0x00			; Base (bits 24-31)

GDTEnd:			; This label is useful for calculating the size of the GDT

GDTDescriptor:
dw GDTEnd - GDTStart - 1 ; Size of our GDT, always one less
			 ; than the true size
dd GDTStart		; Start address of our GDT

; Define some handy constants for the GDT segment descriptor offsets, which
; are what segment registers must contain when in protected mode. For example,
; when we set DS = 0x10 in PM, the CPU knows that we mean it to use the
; segment described at offset 0x10 (i.e. 16 bytes) in our GDT, which in our
; case is the DATA segment (0x0 -> NULL; 0x08 -> CODE; 0x10 -> DATA)
CODE_SEGMENT equ GDTCode - GDTStart
DATA_SEGMENT equ GDTData - GDTStart