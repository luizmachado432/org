.text
.globl imprime1
imprime1:

    li $a0, 1
    li $v0, 1
    syscall

    jr $ra
syscall 
