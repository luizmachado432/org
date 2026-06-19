

.globl escreve_esquerdo
.globl escreve_direito
.globl apaga_direito
.globl apaga_esquerdo

.data
    DISP_ESQ: .word 0xFFFF0011
    DISP_DIR: .word 0xFFFF0010

.text

# escreve_esquerdo(valor em $a0)
escreve_esquerdo:
    la   $t0, DISP_ESQ   
    lw   $t0, 0($t0)      # le o valor 0xFFFF0011 que esta la
    sb   $a0, 0($t0)     # escreve no display
    jr   $ra

# escreve_direito(valor em $a0)
escreve_direito:
    la   $t0, DISP_DIR    
    lw   $t0, 0($t0)      # le o valor 0xFFFF0010 que esta la
    sb   $a0, 0($t0)      # escreve no display
    jr   $ra

# mais pratico assim nao acho necessario carregar da memoria
apaga_direito:
    lui  $t0, 0xFFFF
    sb   $zero, 0x0010($t0)
    jr   $ra

apaga_esquerdo:
    lui  $t0, 0xFFFF
    sb   $zero, 0x0011($t0)
    jr   $ra
