.data
MsgNos: .asciiz "Insira a quantidade de n�s: "
MsgVal: .asciiz "\nInsira um valor: "
MsgErro: .asciiz "ERRO! Quantidade inv�lida. Repita!\n\n"
MsgSeq: .asciiz "\nSequ�ncia: "
MsgSep: .asciiz " -> "
MsgHead: .asciiz "\nHead = "
MsgVHI: .asciiz " ("
MsgVHF: .asciiz ")"


.text
# Regs:
# $t0: Quant n�s
# $t1: Valor a armazenar em Data
# $t2: Endere�o a armazenar em  Next
# $t3: Auxiliar
# $s0: Endere�o Head
# $s1: End. Data
# $s2: End. do Next do n� anterior
# $s3: �ndice

j main

erro:
li $v0,4
la $a0,MsgErro
syscall


main:
#Recebendo os n�s
li $v0,4
la $a0,MsgNos
syscall

li $v0,5
syscall

move $t0,$v0 # Quant. n�s

blt $t0,1,erro

#Aloca mem�ria de um n�
li $v0,9
la $a0,8
syscall

move $s1,$v0 # Endere�o do bloco Data
addi $s2,$s1,4  # Endere�o do bloco Next (ponteiro para o ponteiro next)

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

#Aloca mem�ria de um n�
li $v0,9
la $a0,8
syscall

sw $v0,($s2) #Armazena em next do n� anterior o endere�o desse n�

move $s1,$v0 # Endere�o do bloco Data
addi $s2,$s1,4  # Endere�o do bloco Next (ponteiro para o ponteiro next)

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

# Exibi��o do resultado
li $v0,4
la $a0,MsgSeq
syscall

addi $t2,$s0,4 #Armazenando o endere�o de Head.next
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
lw $t3, ($t2) #Acessando o endere�o em next
lw $s1, ($t3) #Acessando o valor do pr�ximo "data"
addi $t2,$t3,4 #Armazenando o endere�o do pr�ximo "next"

addi $s3,$s3,1
j loop2

fimLp2:

#Exibindo o �ltimo valor
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




