.globl estado3
.text
estado3:
#salva o ra e os s0 e s1 do timer q ele criou
addi $sp, $sp, -28
sw $ra, 24($sp)
sw $s0, 20($sp)
sw $s1, 16($sp)
sw $s2, 12($sp)
sw $s3, 8($sp)
sw $s4, 4($sp)

#topo da pilha pro anti clique duplo q a gnt precisa
li $t0, -1
sw $t0, 0($sp)

#garante o L na esquerda
li $a0, 0x38
jal exibeEsquerda

li $v0, 30
syscall
move $s0, $a0
li $s1, 0

lw $s4, senha_len
li $s2, 0
li $s3, 1

loop_infinito:
#verfica se 500 ms ja se passaram
li $v0, 30
syscall
sub $t0, $a0, $s0
li $t1, 500
blt $t0, $t1, check_teclado

#atualiza o tempo pro proximo ciclo
move $s0, $a0

beqz $s1, acende

desliga:
li $s1, 0
#apaga o A
jal apagaDireita
j check_teclado

acende:
li $s1, 1
li $a0, 0x77
#acende o A
jal exibeDireita

check_teclado:
#usa lertecla pra n travar o timer de 500ms
jal lerTecla
move $t2, $v0

#anti clique duplo 
lw $t0, 0($sp)
beq $t2, $t0, loop_infinito
sw $t2, 0($sp)

#ignora se ngm apertou nada ou apertou os sensores
bltz $t2, loop_infinito
bge $t2, 10, loop_infinito

#logica da senha na mao pra n travar
la $t0, senha
add $t0, $t0, $s2
lb $t1, 0($t0)
beq $t2, $t1, e3_continua
li $s3, 0

e3_continua:
addi $s2, $s2, 1
#continua piscando se falta digito
blt $s2, $s4, loop_infinito

#se errou zera a senha
beqz $s3, reset_senha

#se acertou vai pra desativa 
jal apagaDireita
li $v0, 1
j desativa_alarme

reset_senha:
li $s2, 0
li $s3, 1
j loop_infinito

desativa_alarme:
#devolve os s q a gnt usou
lw $ra, 24($sp)
lw $s0, 20($sp)
lw $s1, 16($sp)
lw $s2, 12($sp)
lw $s3, 8($sp)
lw $s4, 4($sp)
addi $sp, $sp, 28
jr $ra