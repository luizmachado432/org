.globl exibeEsquerda
.globl exibeDireita
.globl apagaDireita
.globl lerTecla
.globl aguardarTecla

.text

exibeEsquerda:
#manda o desenho da letra pro display esquerdo
lui $t0, 0xFFFF
sb $a0, 0x0011($t0)
jr $ra

exibeDireita:
#manda pro display direito
lui $t0, 0xFFFF
sb $a0, 0x0010($t0)
jr $ra

apagaDireita:
#zera o display direito
lui $t0, 0xFFFF
sb $zero, 0x0010($t0)
jr $ra

lerTecla:
#prepara a leitura do teclado
lui $t0, 0xFFFF
li $t1, 1
li $t2, 0
li $v0, -1

lt_scan:
#sai se ja olhou todas as linhas
beq $t2, 4, lt_end
#ativa a linha pra ver se tem clique
sb $t1, 0x0012($t0)
nop
nop
#le a resposta
lbu $t3, 0x0014($t0)
#se achou algo vai decodificar
bnez $t3, lt_decode
#testa a proxima linha
sll $t1, $t1, 1
addiu $t2, $t2, 1
j lt_scan

lt_decode:
#pega so a parte da coluna
srl $t4, $t3, 4
    
li $t5, 0
beq $t4, 1, lt_calc
li $t5, 1
beq $t4, 2, lt_calc
li $t5, 2
beq $t4, 4, lt_calc
li $t5, 3

lt_calc:
#calcula qual foi a tecla
sll $t6, $t2, 2
add $v0, $t6, $t5

lt_end:
jr $ra

aguardarTecla:
#salva o retorno na pilha
addiu $sp, $sp, -4
sw $ra, 0($sp)

at_press:
#pausa pra n travar o mars
li $v0, 32
li $a0, 2
syscall

#le o teclado ate achar alguem apertando
jal lerTecla
bltz $v0, at_press
#guarda a tecla apertada
move $v1, $v0

at_release:
#pausa de novo pro mars respirar
li $v0, 32
li $a0, 2
syscall

#espera o cara soltar o botao
jal lerTecla
bgez $v0, at_release

#devolve a tecla certa e sai
move $v0, $v1
lw $ra, 0($sp)
addiu $sp, $sp, 4
jr $ra
