.data
vetor: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
MsgSep: .asciiz ";"

.text
main:
    la $t0, vetor       # Carrega o endereço base do vetor
    li $t1, 0           # Inicializa o índice do vetor

loop_print:
    lw $t2, ($t0)       # Carrega o próximo elemento do vetor
    li $v0, 1           # Código da syscall para imprimir inteiro
    move $a0, $t2       # Move o elemento para $a0
    syscall             # Chama a syscall para imprimir o elemento

    addi $t1, $t1, 1    # Incrementa o índice do vetor
    addi $t0,$t0,4
    blt $t1, 10, print_separator  # Se não for o último elemento, imprime separador

    j end_print

print_separator:
    li $v0, 4           # Código da syscall para imprimir string
    la $a0, MsgSep      # Carrega o endereço da string de separação
    syscall             # Chama a syscall para imprimir o separador
    j loop_print

end_print:
    li $v0, 10          # Código da syscall para sair do programa
    syscall             # Chama a syscall para sair
