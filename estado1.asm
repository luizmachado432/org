.globl estado1

.text
estado1:
#guarda o endereco de retorno
addiu $sp, $sp, -4
sw $ra, 0($sp)

#bota a letra d no painel esquerdo
li $a0, 0x5E
jal exibeEsquerda
#garante q o direito ta apagado
jal apagaDireita

e1_loop:
#chama a validacao da senha
jal verificaSenha
#se a senha ta errada tenta de novo
beqz $v0, e1_loop

#se acertou avisa q vai pro estado 2
li $v0, 2
#restaura a pilha e volta
lw $ra, 0($sp)
addiu $sp, $sp, 4
jr $ra