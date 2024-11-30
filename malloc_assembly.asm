.data
MsgNos: .asciiz "Insira a quantidade de nós: "
MsgVal: .asciiz "\nInsira um valor: "
MsgErro: .asciiz "ERRO! Quantidade inválida. Repita!\n\n"
MsgSeq: .asciiz "\nSequência: "
MsgSep: .asciiz " -> "
MsgHead: .asciiz "\nHead = "
MsgVHI: .asciiz " ("
MsgVHF: .asciiz ")"


.text
# Regs:
# $t0: Quant nós
# $t1: Valor a armazenar em Data
# $t2: Endereço a armazenar em  Next
# $t3: Auxiliar
# $s0: Endereço Head
# $s1: End. Data
# $s2: End. do Next do nó anterior
# $s3: Índice

j main

erro:
li $v0,4
la $a0,MsgErro
syscall


main:
#Recebendo os nós
li $v0,4
la $a0,MsgNos
syscall

li $v0,5
syscall

move $t0,$v0 # Quant. nós

blt $t0,1,erro

#Aloca memória de um nó
li $v0,9
la $a0,8
syscall

move $s1,$v0 # Endereço do bloco Data
addi $s2,$s1,4  # Endereço do bloco Next (ponteiro para o ponteiro next)

#Recebe o valor
li $v0,4
la $a0,MsgVal
syscall

li $v0,5
syscall

# Armazena o valor recebido em Data
move $t1,$v0 
sw $t1,($s1)

move $s0,$s1 # HEAD

li $s3,1 #i = 1

loop1:
beq $s3,$t0,fimLp1

#Aloca memória de um nó
li $v0,9
la $a0,8
syscall

sw $v0,($s2) #Armazena em next do nó anterior o endereço desse nó

move $s1,$v0 # Endereço do bloco Data
addi $s2,$s1,4  # Endereço do bloco Next (ponteiro para o ponteiro next)

#Recebe o valor
li $v0,4
la $a0,MsgVal
syscall

li $v0,5
syscall

# Armazena o valor recebido em Data
move $t1,$v0 
sw $t1,($s1)

addi $s3,$s3,1  # ++i

j loop1

fimLp1:

# Exibição do resultado
li $v0,4
la $a0,MsgSeq
syscall

addi $t2,$s0,4 #Armazenando o endereço de Head.next
lw $s1,($s0)
li $s3,1

loop2:
beq $s3,$t0,fimLp2

#Exibindo os valores
li $v0,1
move $a0,$s1
syscall

li $v0,4
la $a0,MsgSep
syscall

#Atualizando valores
lw $t3, ($t2) #Acessando o endereço em next
lw $s1, ($t3) #Acessando o valor do próximo "data"
addi $t2,$t3,4 #Armazenando o endereço do próximo "next"

addi $s3,$s3,1
j loop2

fimLp2:

#Exibindo o último valor
li $v0,1
move $a0,$s1
syscall

#Exibindo Head
li $v0,4
la $a0,MsgHead
syscall

li $v0,1
move $a0,$s0
syscall

li $v0,4
la $a0,MsgVHI
syscall

li $v0,1
lw $a0,($s0)
syscall

li $v0,4
la $a0,MsgVHF
syscall

#Finalizando
li $v0,10
syscall




