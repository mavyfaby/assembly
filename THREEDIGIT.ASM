jmp start

    nm1     db    3, 4 dup(0)
    nm2     db    3, 4 dup(0)
    quo     db    0
    rmd     db    0
    rs1     db    0
    rs2     db    0
    rsf     db    0
    fnm     db    0
    snm     db    0

    ms1     db    'Enter 1st number: $'
    ms2     db    'Enter 2nd number: $'
    ms3     db    'Sum: $'
    clf     db    13,10,'$'

start:

    ; clear registers
    call clear_r
    call clear_v
    
    ; display message
    lea dx,ms1
    mov ah,9
    int 21h
    
    ; get input
    lea dx,nm1
    mov ah,0ah
    int 21h
    
    ; print line
    call n_line
    
    ; display message
    lea dx,ms2
    mov ah,9
    int 21h
    
    ; get input
    lea dx,nm2
    mov ah,0ah
    int 21h

    ; print line
    call n_line
    
    ; convert inputs to number
    call cnv_nm1
    call cnv_nm2
    
    ; clear registers
    call clear_r
    
    ; add converted input 
    mov al,rs1
    add al,rs2

    mov rsf,al ; store result int result final
    
    ; print sum message
    lea dx,ms3
    mov ah,9
    int 21h
    
    ; clear registers
    call clear_r

    ; if result is greater than 100
    cmp rsf,100
    jae call_d3

    ; if result is greater than 10
    cmp rsf,10
    jae d2
    
    ; if result is less than 10
    jmp d1
    
    ; stop program
    int 20h

cnv_nm1:
    mov al, [nm1+2] ; get the first digit
    sub al, '0'     ; convert to a number
    mov fnm, al     ; store the first digit
    
    ; set result
    mov rs1, al
    call clear_r

    ; check if there is a second digit
    mov al, [nm1+3]
    CMP al, 13
    je fun_ret
    
    ; if there's a second digit
    mov al, [nm1+3] ; get the second digit
    sub al, '0'     ; convert to a number
    mov snm, al     ; store the second digit
    
    ; multiply first digit by 10
    mov al, fnm
    mov bl, 10
    mul bl
    
    ; add second digit to result
    add al, snm
    mov rs1, al

    ret

cnv_nm2:
    mov al, [nm2+2] ; get the first digit
    sub al, '0'     ; convert to a number
    mov fnm, al     ; store the first digit
    
    ; set result
    mov rs2, al
    call clear_r

    ; check if there is a second digit
    mov al, [nm2+3]
    CMP al, 13
    je fun_ret
    
    ; if there's a second digit
    mov al, [nm2+3] ; get the second digit
    sub al, '0'     ; convert to a number
    mov snm, al     ; store the second digit
    
    ; multiply first digit by 10
    mov al, fnm
    mov bl, 10
    mul bl
    
    ; add second digit to result
    add al, snm
    mov rs2, al

    ret

call_d3:
    call d3
    jmp end

fun_ret:
    ret

d1:
    mov dl,rsf
    or dl,30h
    mov ah,2
    int 21h

    int 20h

d2:
    ; divide result by 10
    mov al,rsf
    mov bl,10
    div bl
    
    ; store results
    mov quo,al
    mov rmd,ah
    
    ; print quotient
    mov dl,quo
    or dl,30h
    mov ah,2
    int 21h
    
    ; print remainder
    mov dl,rmd
    or dl,30h
    mov ah,2
    int 21h

    int 20h
    
d3:
    ; divide result by 100
    mov al,rsf
    mov bl,100
    div bl
    
    ; store results
    mov quo,al
    mov rmd,ah

    ; print quotient
    mov dl,quo
    or dl,30h
    mov ah,2
    int 21h
    
    ; divide remainder by 10
    mov al,rmd
    mov bl,10
    div bl

    ; store results
    mov quo,al
    mov rmd,ah

    ; clear registers
    call clear_r

    ; print quotient
    mov dl,quo
    or dl,30h
    mov ah,2
    int 21h

    ; print remainder
    mov dl,rmd
    or dl,30h
    mov ah,2
    int 21h

    int 20h

end:
    int 20h
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
    xor cx,dx
    ret

clear_v:
    mov ax,3
    int 10h
    ret
