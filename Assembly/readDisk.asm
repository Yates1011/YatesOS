readDisk:
    pusha
    mov ah, 0x02 ;indicates that we are reading from disk
    mov dl, 0x80 ; 0x0 emulating floppy disk
    mov ch, 0
    mov dh, 0
    ;mov al, 1 ;read 1 sector
    ;mov cl, 2 ;start reading second sector
    
    push bx
    mov bx, 0 ;move segment register to 0
    mov es, bx ;segment register equal to bx
    pop bx
    mov bx, 0x7c00 + 512 ;mov bx to starting location + 512(size of first sector) loading one sector after boot sector
    
    int 0x13
    
    jc disk_err
    popa
    ret
    
    disk_err:
        mov si, DISK_ERR_MSG
        call printf
        jmp $
