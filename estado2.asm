.text
.globl imprime2
imprime2:

    li $a0, 2
    li $v0, 1
    syscall

    jal imprime1

    jr $ra
