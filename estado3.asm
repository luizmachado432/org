.globl estado_3
.text
estado_3 :
    # Salva o endereco de retorno
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    li   $v0, 30
    syscall
    move $s0, $a0           # $s0 = tempo_ref (ms do ultimo toggle)
    li   $s1, 0             # $s1 = estado display: 0=apagado, 1=aceso

loop_infinito:

    # verfica se 500 ms ja se passaram
    li   $v0, 30
    syscall                  # $a0 = ms atual
    sub  $t0, $a0, $s0       # elapsed = agora - tempo_ref
    li   $t1, 500
    blt  $t0, $t1, check_teclado   # ainda nao: pula direto pro teclado

    
    move $s0, $a0            # atualiza tempo_ref para proximo ciclo

    beqz $s1, acende
desliga:
    li   $s1, 0
    jal  apagaDireita        # APAGA o "A"
    j    check_teclado

acende:
    li   $s1, 1
    li   $a0, 0x77
    jal  exibeDireita        # ACENDE o "A"

check_teclado:
    jal  aguardarTecla   
    # $v0 = 1 se senha correta, 0 caso contrario
    bnez $v0, desativa_alarme

    j loop_infinito          # nenhuma senha valida: continua piscando

desativa_alarme:
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra
