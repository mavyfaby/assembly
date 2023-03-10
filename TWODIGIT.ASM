jmp start

    n1  db  0
    n2  db  0
    rs  db  0
    qt  db  0
    rm  db  0

    m1 db  'Enter 1st value: $'
    m2 db  'Enter 2nd value: $'
    m3 db  'Sum is: $'
    cr db   13,10,'$'

start:

    ; clear registers
    call clear_r
    call clear_v

    ; print first message
    lea dx,m1
    mov ah,9
    int 21h

    ; get 1st input
    mov ah,1
    int 21h

    ; store to n1
    sub al,30h
    mov n1,al

    ; new line
    call n_line

    ; print second message
    lea dx,m2
    mov ah,9
    int 21h

    ; get 2nd input
    mov ah,1
    int 21h

    ; store to n2
    sub al,30h
    mov n2,al

    ; new line
    call n_line

    ; clear registers
    call clear_r

    ; compute sum
    mov al,n1
    mov bl,n2
    add al,bl

    ; store sum in result variable
    mov rs,al
    
    ; clear registers
    call clear_r

    ; compare results
    mov al,rs
    mov bl,9
    cmp al,bl
    jg twodigit

    ; print sum message
    lea dx,m3
    mov ah,9
    int 21h

    ; print results
    or rs,30h
    mov dl,rs
    mov ah,2
    int 21h

    ; stop program
    int 20h

twodigit:

    ; clear registers
    call clear_r

    ; divide result by 10
    mov al,rs
    mov bl,10
    div bl

    ; move the results to the coresponding variables
    mov qt,ah
    mov rm,al

    ; convert qt and rm back to ascii
    or qt,30h
    or rm,30h

    ; print 3rd message
    lea dx,m3
    mov ah,9
    int 21h

    ; print remainder as 1st digit
    mov dl,rm
    mov ah,2
    int 21h

    ; print qoutient as 2nd digit
    mov dl,qt
    mov ah,2
    int 21h

    ; stop program
    int 20h

n_line:
    lea dx,cr
    mov ah,9
    int 21h
    ret

clear_r:
    xor ax,ax
    xor ax,ax
    xor cx,cx
    xor dx,dx
    ret
    
clear_v:
    mov ax,3
    int 10h
    ret
    