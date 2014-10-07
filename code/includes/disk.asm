;;;; disk.asm ;;;;
; Requires:
;   io.asm

; DiskLoad
;   Loads sectors to ES:BX from a drive
;   Inputs:
;     al: Number of sectors to read
;     bx: End memory address
;     ch: Read cylinder
;     cl: Read sector
;     dh: Read head
;     dl: Read drive
;     es: Start memory address
DiskLoad:
push dx
push ax			; Store ax on stack so later we can recall
push ax			; how many sectors were requested to be read

mov ah, 0x02		; BIOS read sector function
int 0x13		; BIOS interrupt

jc InterruptError	; Jump if error (if carry flag set)

pop dx			; Restore to dx from the stack
cmp dx, ax		; if al (sectors read) != dh (sectors expected)
jne SectorReadError	;   display error message

pop ax
pop dx
ret

; InterruptError
;   Outputs an interrupt error message
InterruptError:
mov eax, DISK_ERROR_MSG3
mov bl, 0x04
mov dh, 0x00
mov dl, 0x00

jmp $

; SectorReadError
;   Outputs a sector read error message
;     This message also reports how many sectors were read
;   Inputs:
;     eax: Number of sectors read
SectorReadError:
push eax

mov eax, DISK_ERROR_MSG1; Print first part of message
mov bl, 0x04
mov dh, 0x00
mov dl, 0x00
call PrintString

call StringLength

sub eax, eax		; Zero out eax
pop eax
mov dl, cl
call PrintHex		; Print number of sectors read

add cl, 10

mov eax, DISK_ERROR_MSG2; Print second part of message
mov dl, cl
call PrintString

jmp $

DISK_ERROR_MSG1: db 'Disk read error: ',0
DISK_ERROR_MSG2: db ' sectors read',0
DISK_ERROR_MSG3: db 'Interrupt error!',0