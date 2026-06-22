.data 
	tamanho_senha: .word 4
	
.text
.globl imprime2
imprime2:
	# Escreve L no display esquerdo 
    	lw	$t0, tamanho_senha
    	li	$t1, 0
#Ler o teclado
leitura:
	li	$v0, 5
	syscall
	#Verificar as trancas
	bge $v0, 10, dispara_alarme
	addi	$t1, $t1, 1
	addi	$sp, $sp, -4
	move	$sp, $v0
	blt   	$t1, $t0, leitura 
	# verificar a senha
	addi	$sp, $sp, -4
    move	$sp, $ra
	jal verificar_a_senha 
	
dispara_alarme: 
	jal estado_3
