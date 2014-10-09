;;;; bitmode.asm ;;;;
; Contains subroutines for switching bit modes
; Requires:
;   gdt.asm

[bits 16]

SwitchTo32BitProtectedMode:
cli			; We must switch off interrupts until we have
			; set up the protected mode interrupt vector.
			; Otherwise, interrupts will go crazy

lgdt [GDTDescriptor]	; Load our global descriptor table, which defines
			; the protected mode segments (for code and data)
mov eax, cr0		; To make the switch to protected mode, we set
or eax, 1		; the first bit of cr0, a control register
mov cr0, eax

; Make a far jump (a jump to a new segment) to our 32-bit code. This
; forces the CPU to flush its cache of pre-fetches and read-mode
; instructions, which can cause problems
jmp CODE_SEGMENT:InitializeProtectedMode

[bits 32]

InitializeProtectedMode:
mov ax, DATA_SEGMENT	; Now in protected mode, our old segments are
mov ds, ax		; meaningless, so we point our segment registers
mov ss, ax		; to the data selector we defined in our GDT
mov es, ax
mov fs, ax
mov gs, ax

mov ebp, 0x90000	; Update our stack to point to the top of the
mov esp, ebp		; free space.

call BeginProtectedMode