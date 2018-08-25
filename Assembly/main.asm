[org 0x7c00]
[bits 16]

section .text
	global main
	
main:

cli
jmp 0x0000:ZeroSeg
ZeroSeg:
	xor ax, ax ;sets ax equal to boolean ax xor ax. Saves 1 byte compared to 'mov ax, 0'
	mov ss, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov sp, main ;moves stack pointer to main
	cld  		;sets direction flag 0 (left to right aka lowest to highest), controls order from which you read strings
sti

push ax
xox ax, ax
mov dl, 0x80
int 0x13
pop ax
;section .dat 
	;constant
	;VAL equ 0x1234 	
;section .bss
	;mutable variables
	;VAR: resb 8

;mov si, STR_0
;call printf

;mov si, STR_T
;call printf

;mov si, STR_TH
;call printf

mov al, 1
mov cl, 2
call readDisk

call printh
jmp test

jmp $

%include "./printf.asm"
%include "./readDisk.asm"
%include "./printh.asm"
              
;STR_0: db 'Loaded in 16-bit Real Mode to memory location 0x7c00.', 0x0a, 0x0d, 0

;STR_T: db 'The message use BIOS interrupt 0x10 with ah register set to 0x0e.', 0x0a, 0x0d, 0

;STR_TH: db 'Test boot complete.', 0

DISK_ERR_MSG: db 'Error loading disk.', 0x0a, 0x0d, 0 ;0x0a char return, 0x0d reset space on line, 0 indicates end of string
TEST_STR: db 'You are in the second sector.', 0x0a, 0x0d,0

; padding and magic number
times 510-($-$$) db 0 
dw 0xaa55

test:
mov si, TEST_STR
call printf
times 512 db 0
