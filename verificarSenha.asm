.globl verificaSenha

.text

verificaSenha:
#abre espaco na pilha pros registradores s
addiu $sp, $sp, -20
sw $ra, 16($sp)
sw $s0, 12($sp)
sw $s1, 8($sp)
sw $s2, 4($sp)
sw $s3, 0($sp)

#pega o tamanho da senha e zera os contadores
lw $s2, senha_len
li $s0, 0
li $s1, 1

vs_loop:
#se ja leu tudo sai do loop
bge $s0, $s2, vs_fim
#espera o cara digitar
jal aguardarTecla
#ignora as letras e pega so numero
bge $v0, 10, vs_loop
move $s3, $v0

#olha na memoria qual era o numero certo
la $t0, senha
add $t0, $t0, $s0
lb $t1, 0($t0)
#se ta certo continua
beq $s3, $t1, vs_ok
#se errou marca a flag como falsa
li $s1, 0

vs_ok:
#vai pro proximo digito
addiu $s0, $s0, 1
j vs_loop

vs_fim:
#devolve 1 se acertou e 0 se errou
move $v0, $s1
#devolve as coisas da pilha e vaza
lw $ra, 16($sp)
lw $s0, 12($sp)
lw $s1, 8($sp)
lw $s2, 4($sp)
lw $s3, 0($sp)
addiu $sp, $sp, 20
jr $ra