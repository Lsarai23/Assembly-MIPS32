.data
vetor: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
MsgSep: .asciiz ";"

.text
main:
    la $t0, vetor       # Carrega o endere�o base do vetor
    li $t1, 0           # Inicializa o �ndice do vetor

loop_print:
    lw $t2, ($t0)       # Carrega o pr�ximo elemento do vetor
    li $v0, 1           # C�digo da syscall para imprimir inteiro
    move $a0, $t2       # Move o elemento para $a0
    syscall             # Chama a syscall para imprimir o elemento

    addi $t1, $t1, 1    # Incrementa o �ndice do vetor
    addi $t0,$t0,4
    blt $t1, 10, print_separator  # Se n�o for o �ltimo elemento, imprime separador

    j end_print

print_separator:
    li $v0, 4           # C�digo da syscall para imprimir string
    la $a0, MsgSep      # Carrega o endere�o da string de separa��o
    syscall             # Chama a syscall para imprimir o separador
    j loop_print

end_print:
    li $v0, 10          # C�digo da syscall para sair do programa
    syscall             # Chama a syscall para sair
