.globl estado2
.text
estado2:
#salva o endereco de retorno e as variaveis q ele usou
addi $sp, $sp, -20
sw $ra, 16($sp)
sw $s0, 12($sp)
sw $s1, 8($sp)
sw $s2, 4($sp)
sw $s3, 0($sp)

#escreve L no display esquerdo 
li $a0, 0x38
jal exibeEsquerda

#setup pra ler a senha 
lw $s2, senha_len
li $s0, 0
li $s1, 1

leitura:
#ler o teclado
jal aguardarTecla
move $s3, $v0

#verificar as trancas
bge $s3, 10, dispara_alarme

#verificar a senha no lugar do jal verificaSenha
la $t0, senha
add $t0, $t0, $s0
lb $t1, 0($t0)
beq $s3, $t1, e2_continua
li $s1, 0

e2_continua:
addi $s0, $s0, 1
#volta pra leitura se falta digito
blt $s0, $s2, leitura

#se errou zera e vai de novo
beqz $s1, reset_leitura

#se a senha ta certa sai do estado
li $v0, 1
j desativa_alarme_e2

reset_leitura:
li $s0, 0
li $s1, 1
j leitura
	
dispara_alarme: 
li $v0, 3

desativa_alarme_e2:
#devolve a pilha e sai usando a saida padrao 
lw $ra, 16($sp)
lw $s0, 12($sp)
lw $s1, 8($sp)
lw $s2, 4($sp)
lw $s3, 0($sp)
addi $sp, $sp, 20
jr $ra