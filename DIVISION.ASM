jmp start

    dvs     db      0
    dvn     db      0
    quo     db      0
    rmd     db      0
    
    ms1     db      'Enter dividend: $'
    ms2     db      'Enter divisor: $'
    ms3     db      'Answer: $'
    clf     db      13,10,'$'

start:

    ; clear registers
    call clear_r
    call clear_v
    
    ; print message
    lea dx,ms1
    mov ah,9
    int 21h
    
    ; accept dividend
    mov ah,1
    int 21h
    
    ; store dividend to dvn
    sub al,30h
    mov dvn,al

    ; print line
    call n_line

    ; clear registers
    call clear_r
    
    ; print message
    lea dx,ms2
    mov ah,9
    int 21h
    
    ; accept divisor
    mov ah,1
    int 21h
    
    ; store divisor to dvs
    sub al,30h
    mov dvs,al
    
    ; print line
    call n_line
    call n_line

    ; clear registers
    call clear_r

    ; perform division
    mov al,dvn
    mov bl,dvs
    div bl
    
    ; store quotient and remainder
    or al,30h
    mov quo,al
    
    or ah,30h
    mov rmd,ah
    
    ; print result message
    lea dx,ms3
    mov ah,9
    int 21h
    
    ; print quotient
    mov dl,quo
    mov ah,2
    int 21h
    
    ; print dot
    mov dl,'.'
    mov ah,2
    int 21h
    
    ; set loop counter
    mov cx,5
    
    ; perform division
    call pf_div

    ; stop program
    int 20h
    
pf_div:

    ; clear registers except cx
    xor ax,ax
    xor bx,bx
    xor dx,dx
    
    ; multiply remainder by 10
    sub rmd,30h
    mov al,rmd
    mov bl,10
    mul bl
    
    ; divide it by the divisor
    mov bl,dvs
    div bl
    
    ; store remainder to rmd
    or ah,30h
    mov rmd,ah
    
    ; print qoutient
    or al,30h
    mov dl,al
    mov ah,2
    int 21h
    
    ; loop until cx is 0
    loop pf_div

    ret

n_line:
    lea dx,clf
    mov ah,9
    int 21h
    ret

clear_r:
    xor ax,ax
    xor bx,bx
    xor cx,cx
    xor dx,dx
    ret

clear_v:
    mov ax,3
    int 10h
    ret
