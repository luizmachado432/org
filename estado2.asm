.globl estado_2
.text
estado_2:
	#Salva o endereco de retorno
	addi	$sp, $sp, -4
	sw		$ra, 0($sp)
	# Escreve L no display esquerdo 
	li		$a0, 0x30
	jal		exibeEsquerda
	# 	Apaga o display da direita
	jal		apagaDireita
	#Ler o teclado
leitura:
	jal		aguardarTecla
	#Verificar as trancas
	bge		$v0, 10, dispara_alarme
	# verificar a senha
	jal verificar_a_senha 
	beqz	$v0, leitura
	lw		$ra, 0($sp)
	addi	$sp, $sp, 4
	jr	$ra
	
dispara_alarme: 
	li		$v0, 3
	lw		$ra, 0($sp)
	addi	$sp, $sp, 4
	jr		$ra
