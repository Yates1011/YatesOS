
;mov eax, 13
;add eax, 10

;push ax 
;mov ax, 0xa4
;do something
;pop ax

;push bx
;do stuff
;push ax
;do more stuff
;pop ax
;ax must be popped before 
;pop bx

;0x0e ;moves cursor
;0x010
;mov ah, 0x0e
;mov al, 'X'
;int 0x10

[org 0x7c00] ;run from specified memory location (fig 3.4)

mov si, STR
call printf

jmp $

printf:
    pusha
    str_loop:
        mov al, [si] 
        cmp al, 0
        jne print_char ;if not equal to 0, print a character
        popa
        ret ;return
        
    print_char:
        mov ah, 0x0e ;required to print
        int 0x10 ;prints character on screen
        add si, 1
        jmp str_loop

STR: db "Booting YatesOS...", 0
                
;padding and magic number
times 510-($-$$) db 0 ;$ current location, $$ start location
dw 0xaa55


