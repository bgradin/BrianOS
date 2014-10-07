;;;; string.asm ;;;;

; StringLength
;   Returns the length of a string
;   Inputs:
;     eax: Address of string
;   Returns:
;     ecx: Length of string
StringLength:
push edi

mov ecx, 0x00
not ecx			; ecx = -1 or 4,294,967,295

lea di, [eax]		; Load the address of the message
mov al, 0x00		; Look for null byte
cld			; Clear the direction flag
repne scasb		; Find value in al (ecx = -strlen - 2)
not ecx			; ecx = strlen + 1
dec ecx			; ecx = strlen

pop edi
ret