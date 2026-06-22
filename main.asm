.globl main
.globl senha
.globl senha_len

.data
#senha do alarme
senha: .byte 1, 2
#tamanho da senha pra ler no loop
senha_len: .word 2

.text
main:
#s0 guarda em qual estado o alarme ta agora
li $s0, 1

fsm:
#ve qual estado e pula pra rotina certa
beq $s0, 1, run1
beq $s0, 2, run2
beq $s0, 3, run3
#se der loucura volta pro comeco apenas redundancia
j fsm

run1:
jal estado1
#atualiza o estado com o retorno
move $s0, $v0
j fsm

run2:
jal estado2
move $s0, $v0
j fsm

run3:
jal estado3
move $s0, $v0
j fsm